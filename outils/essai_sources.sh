#!/usr/bin/env bash
# Essai des sources automatiques (lancé par la tâche essai-sources, jamais sur main).
# 1) Dealabs : existe-t-il un fil RSS des deals ? Est-il autorisé (robots.txt, conditions d'utilisation) ?
# 2) eBay Browse : la clé marche-t-elle, et l'API donne-t-elle le port et la note du vendeur ?
# Une requête toutes les 3 s, un User-Agent qui dit qui on est, un délai d'attente sur chaque requête.
set -u
OUT=${1:-/tmp/res}; mkdir -p "$OUT/dealabs" "$OUT/ebay"
UA="veille-prix-perso/0.1 (+https://github.com/nicolasbonini1-commits/veille-prix)"
R="$OUT/RESULTATS.md"
get() { # get <nom> <url> : enregistre corps + code HTTP + type
  local n=$1 u=$2
  local info; info=$(curl -sS -m 30 -A "$UA" -L -o "$OUT/dealabs/$n" -w '%{http_code} %{content_type}' "$u" 2>&1) || info="échec $info"
  local items; items=$(grep -o '<item>' "$OUT/dealabs/$n" 2>/dev/null | wc -l)
  echo "| \`$u\` | $info | $items |" >> "$R"
  sleep 3
}

echo "# Essai des sources — $(date '+%d/%m/%Y %H:%M') (heure de Paris)" > "$R"
echo >> "$R"; echo "## Dealabs" >> "$R"; echo >> "$R"
echo "| Adresse | Code HTTP et type | Nb d'<item> |" >> "$R"; echo "|---|---|---|" >> "$R"
get robots.txt     "https://www.dealabs.com/robots.txt"
get accueil.html   "https://www.dealabs.com/"
get rss_hot        "https://www.dealabs.com/rss/hot"
get rss_new        "https://www.dealabs.com/rss/new"
get rss_all        "https://www.dealabs.com/rss/all"
get rss_nouveaux   "https://www.dealabs.com/rss/nouveaux"
get rss_recherche  "https://www.dealabs.com/rss/search?q=pc+portable"
get rss_magazine   "https://www.dealabs.com/magazine/feed"

{
  echo; echo "### robots.txt : lignes sur rss, search, User-agent"; echo '```'
  grep -inE 'rss|search|recherche|user-agent|crawl-delay' "$OUT/dealabs/robots.txt" | head -60
  echo '```'
  echo; echo "### Liens « conditions » trouvés sur la page d'accueil"; echo '```'
  grep -oiE 'href="[^"]*(condition|cgu|mentions|regles|rules)[^"]*"' "$OUT/dealabs/accueil.html" | sort -u | head -20
  echo '```'
  echo; echo "### Liens RSS annoncés dans la page d'accueil (balises alternate)"; echo '```'
  grep -oiE '<link[^>]*(rss|atom)[^>]*>' "$OUT/dealabs/accueil.html" | head -10
  echo '```'
} >> "$R"

# Conditions d'utilisation : on suit le premier lien trouvé et on cherche les passages utiles.
CGU=$(grep -oiE 'href="[^"]*(conditions-generales|cgu)[^"]*"' "$OUT/dealabs/accueil.html" | head -1 | sed -E 's/href="//; s/"$//')
if [ -n "$CGU" ]; then
  case "$CGU" in http*) ;; *) CGU="https://www.dealabs.com$CGU" ;; esac
  get cgu.html "$CGU"
  python3 - "$OUT/dealabs/cgu.html" >> "$R" <<'P'
import re, sys, html
t = html.unescape(re.sub(r"<[^>]+>", " ", open(sys.argv[1], errors="ignore").read()))
t = re.sub(r"\s+", " ", t)
print("\n### Passages des conditions d'utilisation (mots : rss, robot, automat, extraction, aspir, scrap, crawl)\n")
seen = 0
for m in re.finditer(r"(?i)(rss|robot|automati|extraction|aspir|scrap|crawl)", t):
    a = max(0, m.start() - 220); print("> …" + t[a:m.end() + 220] + "…\n"); seen += 1
    if seen >= 5: break
if not seen: print("Aucun de ces mots trouvés (page peut-être chargée en JavaScript : à lire à la main).")
P
else
  printf "\n%s\n" "Lien des conditions d'utilisation non trouvé dans la page d'accueil : à chercher à la main." >> "$R"
fi

# Premier élément de chaque fil qui répond, pour voir s'il donne prix, marchand, port.
for f in rss_hot rss_new rss_all rss_nouveaux rss_recherche; do
  if grep -q '<item>' "$OUT/dealabs/$f" 2>/dev/null; then
    echo; echo "### Premier élément de $f"; echo '```xml'
    # Le fil tient sur une seule ligne : on coupe le premier <item>, sans sa description, 800 caractères au plus.
    python3 -c 'import re,sys; t=open(sys.argv[1],errors="ignore").read(); m=re.search(r"<item>.*?</item>",t,re.S); i=re.sub(r"<description>.*?</description>","<description>(retirée)</description>",m.group(0),flags=re.S) if m else "(aucun)"; print(i[:800])' "$OUT/dealabs/$f"
    echo '```'
  fi
done >> "$R"

# ---------- eBay ----------
printf "\n%s\n" "## eBay Browse" >> "$R"
forme() { printf '%s' "$1" | sed -E 's/[A-Za-z0-9]/x/g'; }
if [ -z "${EBAY_CLIENT_ID:-}" ] || [ -z "${EBAY_CLIENT_SECRET:-}" ]; then
  printf "\n%s\n" "Secrets EBAY_CLIENT_ID / EBAY_CLIENT_SECRET absents : essai eBay sauté (normal tant que la clé n'est pas créée)." >> "$R"
  exit 0
fi
{
  echo; echo "Forme des secrets (jamais la valeur) :"
  echo "- EBAY_CLIENT_ID : ${#EBAY_CLIENT_ID} caractères, \`$(forme "$EBAY_CLIENT_ID")\`"
  echo "- EBAY_CLIENT_SECRET : ${#EBAY_CLIENT_SECRET} caractères, \`$(forme "$EBAY_CLIENT_SECRET")\`"
} >> "$R"
TOK=$(curl -sS -m 30 -A "$UA" -u "$EBAY_CLIENT_ID:$EBAY_CLIENT_SECRET" \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'grant_type=client_credentials&scope=https%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope' \
  https://api.ebay.com/identity/v1/oauth2/token | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("access_token",""))' 2>/dev/null)
if [ -z "$TOK" ]; then printf "\n%s\n" "Jeton eBay refusé (clé fausse, ou clé « Sandbox » au lieu de « Production »)." >> "$R"; exit 0; fi
printf "\n%s\n" "Jeton eBay obtenu (longueur ${#TOK})." >> "$R"
Q="pc+portable+16+go+ssd+512"
CODE=$(curl -sS -m 30 -A "$UA" -o "$OUT/ebay/recherche.json" -w '%{http_code}' \
  -H "Authorization: Bearer $TOK" -H 'X-EBAY-C-MARKETPLACE-ID: EBAY_FR' \
  -H 'X-EBAY-C-ENDUSERCTX: contextualLocation=country%3DFR' \
  "https://api.ebay.com/buy/browse/v1/item_summary/search?q=$Q&limit=10&filter=priceCurrency:EUR,deliveryCountry:FR")
python3 - "$OUT/ebay/recherche.json" "$CODE" >> "$R" <<'P'
import json, sys
code = sys.argv[2]; print(f"\nRecherche : code HTTP {code}\n")
try: d = json.load(open(sys.argv[1]))
except Exception as e: print("Réponse illisible :", e); sys.exit()
items = d.get("itemSummaries", [])
print(f"{d.get('total', '?')} annonces au total, {len(items)} reçues.\n")
print("| Titre | Prix | Port | Vendeur : % positifs / nb avis | État | Lieu |\n|---|---|---|---|---|---|")
for it in items:
    s = it.get("seller", {}); sh = (it.get("shippingOptions") or [{}])[0].get("shippingCost", {})
    print(f"| {it.get('title','')[:60]} | {it.get('price',{}).get('value')} | {sh.get('value','absent')} | "
          f"{s.get('feedbackPercentage','absent')} / {s.get('feedbackScore','absent')} | {it.get('condition','')} | "
          f"{it.get('itemLocation',{}).get('country','')} |")
champs = sorted({k for it in items for k in it})
print("\nChamps présents dans les annonces : " + ", ".join(champs))
P
