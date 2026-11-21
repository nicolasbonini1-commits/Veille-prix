# Reprise du projet Veille-prix

À lire au début d'une nouvelle conversation, avec `LECONS.md` du dépôt maison3d (leçons générales), `LECONS.md` du dépôt Carte-peche (architecture qui sert de modèle) et `git log -5`.
Garder ce fichier court (≈ 50 lignes) ; quand il y aura de l'historique, un sujet clos descendra dans `HISTORIQUE.md`, daté.
État au 21 nov. 2026, 21 h 15 : dépôt créé par Nico (README seul), accès donné à Claude ; **rien de construit**. Aucune clé ni secret créé.

## Le projet
- Outil perso de veille de prix, moitié appli, moitié agent IA. But de Nico : **centraliser** les recherches pour gagner du temps et les **fiabiliser** (mêmes règles à chaque fois). S'il doit tout faire à la main, l'appli ne sert à rien.
- Liste d'envies : pour chaque produit, un prix souhaité et une date d'achat prévue. Premier cas réel : un PC portable vers 300 €, à acheter dans quelques mois.
- Prix comparé = prix + port. Alerte si prix total ≤ prix souhaité + 5 % (« dans la cible ») ; entre + 5 et + 10 % : « proche », sans notification.
- Vendeurs : sites fiables ou vendeurs ≥ 4,5/5 avec ≥ 100 avis ; livraison ≤ 5 jours ouvrés. Valeurs provisoires (exemples du prompt de Nico, ses « [À COMPLÉTER] » pas encore remplis).
- Ordre des choix : neuf, puis occasion Leboncoin (livraison possible, vendeur bien noté, annonce réelle), puis reconditionné.

## Décisions (21 nov. 2026)
- Format : page GitHub Pages, dépôt **public** `nicolasbonini1-commits/veille-prix` (adresse en minuscules). Reprendre l'architecture de Carte-peche : page statique + tâche GitHub qui écrit ses résultats dans une branche `donnees`, **lancée par Home Assistant** (les tâches planifiées GitHub sautent des passages).
- Liste d'envies publique (`envies.json`) : accepté par Nico (seulement des noms de produits et des prix).
- L'appli surveille, calcule et affiche ; l'agent IA intervient seulement pour juger (même produit ? notes d'une annonce).
- **Sources automatiques** (aucune alerte à créer) : API eBay Browse (programme développeurs gratuit, recherche par mot-clé ou GTIN, eBay France) ; fil RSS des deals Dealabs **s'il existe et s'il est autorisé** (seul le RSS du magazine a été trouvé).
- **Idealo et Leboncoin** (pas d'API publique, robots interdits) : l'appli prépare les liens déjà remplis, Nico crée l'alerte (≈ 2 min par produit, une fois). Les mails d'alerte arrivent dans une **adresse Gmail dédiée**, lue par la tâche GitHub (mot de passe d'application dans les secrets GitHub). Les notifications natives des applis restent pour l'urgence.
- Écartés : Amazon (API réservée aux affiliés ayant ≥ 10 ventes en 30 jours), flux Fnac/Darty/Boulanger (réservés aux sites affiliés acceptés), Claude in Chrome sur les sites (robot contraire à leurs règles), tâche planifiée Claude pour lire Gmail.
- Occasion : deux notes de 1 à 5 étoiles, **avec raisons et niveau de confiance** (faible, moyen, élevé), via un skill « veille-prix » à partir des **captures** de Nico (pas de robot sur Leboncoin, le lien n'est pas ouvert). Aide à la décision, jamais un verdict.
  - Authenticité : on part de 5 ; plafond à 1 si on demande de quitter la messagerie ou le paiement sécurisé, faux mail ou lien de paiement, vendeur à l'étranger ; − 2 photo retrouvée ailleurs ; − 1 prix très bas, compte récent sans avis, incohérence photos/texte ; − 0,5 description floue ; + 0,5 photo avec pseudo et date, écran « À propos », profil ancien bien noté, facture. Poids = choix de Claude [P], à ajuster.
  - Prix : total = prix + port + frais Leboncoin 4 % (min 0,99 €, à relire sur l'aide officielle). Référence = médiane de ≥ 5 annonces comparables, sinon reconditionné de même config, sinon neuf moins décote [P]. Rapport ≤ 0,80 : 5★ ; 0,80-0,90 : 4★ ; 0,90-1,05 : 3★ ; 1,05-1,15 : 2★ ; au-delà : 1★. Max 2★ si ≥ reconditionné garanti, 1★ si ≥ neuf.
  - Recherche d'image : Google Lens par Nico d'abord ; Cloud Vision (WEB_DETECTION) plus tard, clé dans les secrets GitHub, photos d'annonce dans un dépôt privé, jamais dans la page publique.
- Coûts : version 1 à 0 € en plus (skill dans le chat, compris dans l'abonnement). Plus tard, agent par API : de l'ordre de 0,05 à 0,40 $ par mois aux volumes prévus.

## Non vérifié
- Si le seuil de l'alerte Idealo compte le port, et ce que contiennent les mails d'alerte (prix, port, délai, vendeur) : plus gros risque de la lecture des mails.
- Si l'API eBay donne la note du vendeur et le port ; existence et autorisation d'un fil RSS des deals Dealabs.
- Alerte prix chez Back Market ; compte de facturation obligatoire pour Cloud Vision (source : forum Google).

## Prochaine étape
Squelette de la page (thème jour/nuit comme Carte-peche) + `envies.json` + essais de l'API eBay et du fil Dealabs par une tâche GitHub sur une branche d'essai. Une étape à la fois, avec l'accord de Nico.

## À faire par Nico (quand on y arrivera, une étape à la fois, jamais de clé dans le chat)
- Compte développeur eBay et sa clé (secret GitHub).
- Adresse Gmail dédiée aux alertes, double authentification et mot de passe d'application (secret GitHub).
- Compléter les « [À COMPLÉTER] » : écart, seuil des vendeurs, délai, autres sites à suivre.
