# Reprise du projet Veille-prix

À lire au début d'une nouvelle conversation, avec `LECONS.md` du dépôt maison3d (leçons générales), `LECONS.md` du dépôt Carte-peche (architecture qui sert de modèle) et `git log -5`.
Garder ce fichier court (≈ 50 lignes) ; quand il y aura de l'historique, un sujet clos descendra dans `HISTORIQUE.md`, daté.
État au 22 nov. 2026 : **skill « veille-prix » écrit et enregistré par Nico** dans son compte claude.ai (pas de copie dans ce dépôt) ; **essai du skill fait le 22 nov. à 01 h 40** (voir plus bas, rapport dans la branche `essais-skill`). Squelette sur `main` (21 h 44), **en ligne** sur https://nicolasbonini1-commits.github.io/Veille-prix/ (Pages activé par Nico ; contrôle par la tâche `essai-en-ligne` à 21 h 52 : 5 fichiers = `main` en sha256, captures jour/nuit OK dans `essais-en-ligne`) ; essai des sources fait (branche `essai-sources` → résultats dans `essais-sources`, passage de 21 h 25). Aucune clé ni secret créé.

## Le projet
- Outil perso de veille de prix, moitié appli, moitié agent IA. But de Nico : **centraliser** les recherches pour gagner du temps et les **fiabiliser** (mêmes règles à chaque fois). S'il doit tout faire à la main, l'appli ne sert à rien.
- Liste d'envies : pour chaque produit, un prix souhaité et une date d'achat prévue. Premier cas réel : un PC portable vers 300 €, à acheter dans quelques mois.
- Prix comparé = prix + port. Alerte si prix total ≤ prix souhaité + 5 % (« dans la cible ») ; entre + 5 et + 10 % : « proche », sans notification.
- Vendeurs : sites fiables ou vendeurs ≥ 4,5/5 avec ≥ 100 avis ; livraison ≤ 5 jours ouvrés. Valeurs provisoires (exemples du prompt de Nico, ses « [À COMPLÉTER] » pas encore remplis).
- Ordre des choix : neuf, puis occasion Leboncoin (livraison possible, vendeur bien noté, annonce réelle), puis reconditionné.

## Décisions (21 nov. 2026)
- Format : page GitHub Pages, dépôt **public** `nicolasbonini1-commits/Veille-prix` (V majuscule : `/veille-prix/` → 404 ; raw.githubusercontent accepte les minuscules). Reprendre l'architecture de Carte-peche : page statique + tâche GitHub qui écrit ses résultats dans une branche `donnees`, **lancée par Home Assistant** (les tâches planifiées GitHub sautent des passages).
- Liste d'envies publique (`envies.json`) : accepté par Nico (seulement des noms de produits et des prix).
- L'appli surveille, calcule et affiche ; l'agent IA intervient seulement pour juger (même produit ? notes d'une annonce).
- **Sources automatiques** (aucune alerte à créer) : API eBay Browse (programme développeurs gratuit, recherche par mot-clé ou GTIN, eBay France) ; fil RSS des deals Dealabs **s'il existe et s'il est autorisé** (seul le RSS du magazine a été trouvé).
- **Idealo et Leboncoin** (pas d'API publique, robots interdits) : l'appli prépare les liens déjà remplis, Nico crée l'alerte (≈ 2 min par produit, une fois). Les mails d'alerte arrivent dans une **adresse Gmail dédiée**, lue par la tâche GitHub (mot de passe d'application dans les secrets GitHub). Les notifications natives des applis restent pour l'urgence.
- Écartés : Amazon (API réservée aux affiliés ayant ≥ 10 ventes en 30 jours), flux Fnac/Darty/Boulanger (réservés aux sites affiliés acceptés), Claude in Chrome sur les sites (robot contraire à leurs règles), tâche planifiée Claude pour lire Gmail.
- Occasion : deux notes de 1 à 5 étoiles, **avec raisons et niveau de confiance** (faible, moyen, élevé), via un skill « veille-prix » à partir des **captures** de Nico (pas de robot sur Leboncoin, le lien n'est pas ouvert). Aide à la décision, jamais un verdict.
  - Authenticité : on part de 5 ; plafond à 1 si on demande de quitter la messagerie ou le paiement sécurisé, faux mail ou lien de paiement, vendeur à l'étranger ; − 2 photo retrouvée ailleurs ; − 1 prix très bas, compte récent sans avis, incohérence photos/texte ; − 0,5 description floue ; + 0,5 photo avec pseudo et date, écran « À propos », profil ancien bien noté, facture. Poids = choix de Claude [P], à ajuster.
  - Prix : total = prix + port + frais Leboncoin **5 % du prix hors port + 0,70 €** (CGU leboncoin art. 3.11, lues le 21 nov. ; l'ancien « 4 %, min 0,99 € » venait d'un forum de 2021, périmé). Référence = médiane de ≥ 5 annonces comparables, sinon reconditionné de même config, sinon neuf moins décote [P]. Rapport ≤ 0,80 : 5★ ; 0,80-0,90 : 4★ ; 0,90-1,05 : 3★ ; 1,05-1,15 : 2★ ; au-delà : 1★. Max 2★ si ≥ reconditionné garanti, 1★ si ≥ neuf.
  - Recherche d'image : Google Lens par Nico d'abord ; Cloud Vision (WEB_DETECTION) plus tard, clé dans les secrets GitHub, photos d'annonce dans un dépôt privé, jamais dans la page publique.
- Coûts : version 1 à 0 € en plus (skill dans le chat, compris dans l'abonnement). Plus tard, agent par API : de l'ordre de 0,05 à 0,40 $ par mois aux volumes prévus.

## Essai des sources (21 nov., 21 h 23 et 21 h 25, tâche `essai-sources`)
- **Dealabs** : fils RSS `/rss/hot` (≥ 100°, adresse propre `/rss/tendance`), `/rss/new` = `/rss/nouveaux` : 30 deals chacun, en XML. Pas de fil par mot-clé (`/rss/search` → 404). Chaque deal donne titre (avec la température), catégorie, marchand, prix (pas toujours), lien, date. **Pas le port.**
- Un samedi soir de Black Week, les 30 deals couvrent 1,9 h (hot) et 1,0 h (nouveaux) : il faut lire les fils au moins toutes les 30 min, sinon des deals passent.
- robots.txt : `/rss` autorisé pour tous (`Allow: /`) ; `/search` interdit aux robots ; ClaudeBot, GPTBot et autres robots d'IA interdits sur tout le site.
- CGU (`dealabs.com/page/cgu`, mises à jour le 2 sept. 2026) : rien sur le RSS ni les robots ; interdisent de reproduire le contenu ou de le mettre à disposition de tiers, et son usage sur d'autres sites sans accord (résumé par l'outil de lecture, passage pas relu en entier). Conséquence : ne pas recopier les deals dans le dépôt public. 1er essai (21 h 23) : le fichier de résultats contenait le fil entier par erreur, écrasé à 21 h 25.
- **eBay** : sauté (secrets `EBAY_CLIENT_ID` / `EBAY_CLIENT_SECRET` pas encore créés). Le script est prêt : forme des secrets, jeton, recherche eBay France, tableau prix / port / note du vendeur.

## Skill « veille-prix » (écrit le 21 nov., 22 h 15)
- L'appli ne cherche pas sur tout le net (pas de moyen gratuit et légal). Le skill fait la **recherche à la demande** (« cherche le meilleur prix pour X ») et les **deux notes d'occasion** à partir des captures.
- Contenu : niveaux de preuve [S] [M] [C] [P] [N] comme Carte-peche ; confiance élevé / moyen / faible ; port introuvable = offre jamais « dans la cible » ; vendeur vérifié par mentions légales, siège UE, e-réputation (DGCCRF) ; seuils lus dans `envies.json`, qui prime.
- Signes d'arnaque sourcés : sortir de la messagerie ou du paiement sécurisé, moyens de paiement difficiles à tracer (Cybermalveillance via INC, 2025) ; mail « Leboncoin » hors messagerie (Que Choisir) ; vendeur à l'étranger (police de Fribourg, DGCCRF 2022 : preuve plus faible). Tous les poids restent [P].
- **Règle proposée par Claude, à valider par Nico** : lecture ponctuelle (WebFetch) des pages produit et livraison des marchands ; Dealabs (robots d'IA interdits) et Idealo : résultats du moteur seulement ; Leboncoin : jamais ouvert.

## Essai du skill, partie A (22 nov., 01 h 40 – 01 h 44, tâche planifiée)
- Rapport : `essais-skill/2026-11-22-pc-portable.md` (branche `essais-skill`). Config prise : champ `recherche` (16 Go, SSD 512), config minimale pas validée. 15 recherches et lectures.
- Aucune offre vérifiée ≤ 315 €. Meilleure : HP EliteBook 850 G7 reconditionné, 479,99 € livraison offerte (LDLC, vendeur Refabz), confiance moyenne (vendeur pas vérifié).
- Refusé par l'outil : **Back Market** (4 pages sur 4). Lus : LDLC, leDénicheur, comparez-malin (prix « dès » sans marchand ni port). Le moteur de recherche ne donne pas les prix, seulement titres et liens.
- Corrections du skill **proposées, pas appliquées** : config minimale dans `envies.json` (processeur, écran, AZERTY ; exclure `mini pc`, `qwerty`, `qwertz`) ; Back Market traité comme Idealo (lien + capture) ; comparateur = piste, jamais une offre ; ≈ 3 recherches + 8 à 10 lectures ; garder 2 lectures pour vérifier le vendeur de la meilleure offre ; port non vérifié = « proche » au mieux ; finir par un « prix réaliste observé » par état.

## Non vérifié
- Si le seuil de l'alerte Idealo compte le port, et ce que contiennent les mails d'alerte (prix, port, délai, vendeur) : plus gros risque de la lecture des mails.
- Si l'API eBay donne la note du vendeur et le port (doc : champs `seller.feedbackPercentage`, `shippingOptions.shippingCost`, à confirmer par l'essai).
- Adresses des boutons Idealo, Leboncoin et Dealabs de la page (marquées « à vérifier ») : à toucher une fois sur l'A55.
- Alerte prix chez Back Market ; compte de facturation obligatoire pour Cloud Vision (source : forum Google).
- Seuils vendeur contradictoires : ce fichier dit ≥ 4,5/5 et ≥ 100 avis, `envies.json` dit ≥ 90 % d'avis positifs (eBay) : à trancher par Nico.
- Main propre avec paiement sécurisé Leboncoin : CGU « 1,99 centimes », coquille probable pour 1,99 €.

## Prochaine étape
1. Décision de Nico sur les deals Dealabs dans le dépôt public (recommandé : ne garder que lien, prix, marchand, température ; rien d'autre).
2. Clé eBay (Production) → relancer `essai-sources`.
3. Nico valide ou corrige la config minimale du PC et les corrections proposées du skill (rapport de la branche `essais-skill`, prix et ports à contrôler), puis nouvel essai.

## À faire par Nico (quand on y arrivera, une étape à la fois, jamais de clé dans le chat)
- Compte développeur eBay et sa clé (secret GitHub).
- Adresse Gmail dédiée aux alertes, double authentification et mot de passe d'application (secret GitHub).
- Compléter les « [À COMPLÉTER] » : écart, seuil des vendeurs, délai, autres sites à suivre.
