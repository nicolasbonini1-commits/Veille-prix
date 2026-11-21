// Veille de prix — squelette (version 0).
// Lit envies.json (dans ce dépôt) et offres.json (branche « donnees », écrite plus tard par la tâche GitHub).
// L'appli affiche et calcule ; elle ne décide jamais à la place de Nico.
(function () {
  const DEPOT = "nicolasbonini1-commits/veille-prix";
  const OFFRES = `https://raw.githubusercontent.com/${DEPOT}/donnees/offres.json`;
  const $ = s => document.querySelector(s);
  const LS = {
    get: (k, d) => { try { return localStorage.getItem(k) ?? d; } catch (e) { return d; } },
    set: (k, v) => { try { localStorage.setItem(k, v); } catch (e) {} }
  };
  const eur = n => n == null ? "—" : n.toLocaleString("fr-FR", { style: "currency", currency: "EUR", maximumFractionDigits: n % 1 ? 2 : 0 });
  const esc = s => String(s ?? "").replace(/[&<>"]/g, c => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[c]));

  // Thème : Auto suit le mode sombre du téléphone ; un toucher passe à Jour, puis Nuit, puis Auto.
  let mode = LS.get("vp_theme", "auto");
  const sombre = window.matchMedia("(prefers-color-scheme: dark)");
  function theme() { return mode === "auto" ? (sombre.matches ? "nuit" : "jour") : mode; }
  function appliquerTheme() {
    const t = theme();
    document.documentElement.dataset.theme = t;
    $("#themeBtn").textContent = mode === "auto" ? `Auto (${t})` : t === "jour" ? "Jour" : "Nuit";
  }
  $("#themeBtn").addEventListener("click", () => {
    mode = mode === "auto" ? "jour" : mode === "jour" ? "nuit" : "auto";
    LS.set("vp_theme", mode); appliquerTheme();
  });
  sombre.addEventListener?.("change", appliquerTheme);
  appliquerTheme();

  // Seuils : cible = prix souhaité × (1 + 5 %), proche = × (1 + 10 %). Arrondi au centime.
  const seuil = (p, m) => Math.round(p * (1 + m) * 100) / 100;
  function statut(total, e, R) {
    if (total == null) return { cls: "", txt: "Pas encore de relevé" };
    if (total <= seuil(e.prix_souhaite, R.marge_cible)) return { cls: "cible", txt: "Dans la cible" };
    if (total <= seuil(e.prix_souhaite, R.marge_proche)) return { cls: "proche", txt: "Proche" };
    return { cls: "au-dessus", txt: "Au-dessus" };
  }

  // Liens de recherche préparés. Idealo et Leboncoin : forme d'adresse à vérifier en vrai (pas encore testée).
  function liens(e) {
    const q = encodeURIComponent(e.recherche);
    return [
      { nom: "eBay", url: `https://www.ebay.fr/sch/i.html?_nkw=${q}`, verif: false },
      { nom: "Dealabs", url: `https://www.dealabs.com/search?q=${q}`, verif: true },
      { nom: "Idealo", url: `https://www.idealo.fr/prechcat.html?q=${q}`, verif: true },
      { nom: "Leboncoin", url: `https://www.leboncoin.fr/recherche?text=${q}`, verif: true }
    ];
  }

  function carte(e, R, offres) {
    const mien = offres.filter(o => o.envie === e.id && o.total != null).sort((a, b) => a.total - b.total);
    const top = mien[0];
    const st = statut(top?.total, e, R);
    const date = e.date_achat ? new Date(e.date_achat).toLocaleDateString("fr-FR", { month: "long", year: "numeric" }) : "à préciser";
    const offre = top ? `<div class="offre">
        <b>${eur(top.total)}</b> port compris (${eur(top.prix)} + ${top.port ? eur(top.port) : "port offert"}) · ${esc(top.source)}<br>
        ${esc(top.titre)}<br>
        <span class="sub">Vendeur ${esc(top.vendeur?.nom || "?")}${top.vendeur?.pct != null ? ` · ${top.vendeur.pct.toLocaleString("fr-FR")} % d'avis positifs, ${top.vendeur.avis.toLocaleString("fr-FR")} avis` : ""}</span>
        <div class="row"><a class="btn small primary" href="${esc(top.lien)}" target="_blank" rel="noopener">Voir l'offre</a></div>
      </div>` : `<div class="offre sub">Aucune offre relevée pour l'instant : la recherche automatique (eBay, Dealabs) n'est pas encore branchée.</div>`;
    return `<section class="card">
      <div class="card-top"><h2>${esc(e.nom)}</h2><span class="badge ${st.cls}">${st.txt}</span></div>
      <p class="sub">Recherche : « ${esc(e.recherche)} » · achat prévu : ${date}</p>
      <div class="prix">
        <div><small>Souhaité</small><b>${eur(e.prix_souhaite)}</b></div>
        <div><small>Cible +5 %</small><b>${eur(seuil(e.prix_souhaite, R.marge_cible))}</b></div>
        <div><small>Proche +10 %</small><b>${eur(seuil(e.prix_souhaite, R.marge_proche))}</b></div>
      </div>
      ${e.notes ? `<p class="sub">${esc(e.notes)}</p>` : ""}
      ${offre}
      <div class="row">${liens(e).map(l => `<a class="btn small" href="${l.url}" target="_blank" rel="noopener">${l.nom}${l.verif ? ' <span class="verif">à vérifier</span>' : ""}</a>`).join("")}</div>
    </section>`;
  }

  async function charger() {
    let E, O = { offres: [] }, oInfo = "";
    try {
      E = await (await fetch(`envies.json?t=${Date.now()}`)).json();
    } catch (err) {
      $("#maj").textContent = "Impossible de lire la liste d'envies (envies.json)."; return;
    }
    try {
      const r = await fetch(`${OFFRES}?t=${Date.now()}`);
      if (r.ok) { O = await r.json(); oInfo = O.maj ? `Offres relevées le ${new Date(O.maj).toLocaleString("fr-FR")}.` : ""; }
      else oInfo = "Pas encore de relevé automatique.";
    } catch (err) { oInfo = navigator.onLine ? "Relevé automatique illisible." : "Pas de réseau."; }
    $("#maj").textContent = `${E.envies.length} envie${E.envies.length > 1 ? "s" : ""} suivie${E.envies.length > 1 ? "s" : ""}. ${oInfo}`;
    $("#liste").innerHTML = E.envies.map(e => carte(e, E.regles, O.offres || [])).join("");
  }
  charger();
})();
