# Essai du skill « veille-prix », partie A — envie `pc-portable`

**Essai réel : dimanche 22 nov. 2026, de 01 h 40 à 01 h 44 (heure de Paris), soit 00 h 40 – 00 h 44 UTC.**
Tâche planifiée de nuit, sans Nico. C'est un essai de la méthode, pas un achat.

## Lecture choisie (Nico dormait, aucune question posée)
- Produit : config minimale **pas encore validée par Nico**. J'ai pris le champ `recherche` de `envies.json` : « pc portable 16 go ssd 512 », c'est-à-dire **portable, 16 Go de RAM, SSD 512 Go**, processeur, écran et clavier libres. Exclusions : `pièces`, `hs`, `pour pièces`, `écran cassé`.
- Prix souhaité 300 € port compris. Seuils lus dans `envies.json` (`marge_cible` 0,05, `marge_proche` 0,10) :
  **dans la cible ≤ 315,00 €** ; **proche ≤ 330,00 €** (calcul refait en Python : 300 × 1,05 et 300 × 1,10).
- États acceptés : neuf, occasion, reconditionné. Leboncoin : jamais ouvert (règle du skill).
- Budget : 15 recherches et lectures de pages au total (6 recherches, 9 lectures demandées). Atteint.

## Résultat en une phrase
**Aucune offre vérifiée dans la cible ni « proche ».** La seule offre avec prix et port relevés sur la page est à 479,99 €, soit 1,60 × le prix souhaité. Le reconditionné, là où les prix vers 300 € ont le plus de chances d'exister, n'a pas pu être lu (Back Market refusé par l'outil).

## Tableau du skill

| Rang | Offre | Total (prix + port) | Délai | Vendeur | Statut | Confiance | Lien |
|---|---|---|---|---|---|---|---|
| 1 | HP EliteBook 850 G7, i5-10210U, 16 Go, SSD 512 Go, 15,6" FHD, Windows 11, **reconditionné** (état « correct » : écran avec défauts visibles, coque marquée) | **479,99 €** = 479,99 + 0 (livraison offerte) | non affiché | Refabz (vendeur tiers de la place de marché LDLC), 111 avis, note non relevée | au-dessus (× 1,60) | moyen | https://www.ldlc.com/fiche/PB00715420.html |
| 2 | Blackview MP20, Ryzen 3 3300U, 16 Go, SSD 512 Go — **probablement un mini-PC, pas un portable** (la page ne le précise pas) | « dès 319,99 € » + port non vérifié | non affiché | non affiché (comparateur) | hors critère probable ; sinon « proche » au mieux, jamais « dans la cible » (port non vérifié) | faible | https://ledenicheur.fr/s/pc-portable-16go-512/ |
| 3 | BEASTCOM Q3 Q3-415, 16 Go, SSD 512 Go (autres specs non relevées) | « dès 399,99 € » + port non vérifié | non affiché | non affiché (comparateur) | au-dessus (× 1,33) | faible | https://ledenicheur.fr/s/pc-portable-16go-512/ |
| 4 | Deal Dealabs « Dell 16, Intel Core 5 120U, 16 Go, 512 Go » | non relevé (règle : lien seulement) | — | — | non évalué | faible | https://www.dealabs.com/bons-plans/ordinateur-portable-dell-16-intel-core-5-120u-16gb-ram-512gb-ssd-16-2k-ecran-antireflet-300-nits-intel-uhd-graphics-3418623 |
| 5 | Reconditionnés Back Market 16 Go / 512 Go, clavier AZERTY (HP ProBook 450 G5, Dell Vostro 5590, Acer Aspire 5 A514-55, HP 15-eg2000nf) | **inconnu** : pages refusées par l'outil | — | — | non évalué | faible | https://www.backmarket.fr/fr-fr/p/hp-probook-450-g5-15-core-i5-16-ghz-ssd-512-go-16-go-azerty-francais/14d85ddd-b4d1-4586-af6d-e63c1b14e005 |

Ordre de préférence de Nico (neuf, puis occasion, puis reconditionné) : non applicable, aucune offre neuve sous 360 € trouvée (sur LDLC, les plus bas prix neufs affichés étaient à 599,95 €, config non vérifiée).

## Chaque relevé, avec sa preuve et son heure
Toutes les lectures de pages ont été faites par un agent de lecture (WebFetch), pas par moi directement : je n'ai que son compte rendu. Heures en heure de Paris.

| Offre | Valeur | Preuve | Heure |
|---|---|---|---|
| EliteBook 850 G7 | prix 479,99 € (promo − 11 %, ancien prix 544,00 €) | [M] page LDLC | 01 h 42 |
| EliteBook 850 G7 | port 0 € (« Livraison offerte », « Livraison gratuite » dans le commentaire du vendeur) | [M] page LDLC | 01 h 42 |
| EliteBook 850 G7 | vendu et expédié par Refabz, 111 avis ; garantie : durée non affichée | [M] page LDLC | 01 h 42 |
| EliteBook 850 G7 | délai | non affiché | 01 h 42 |
| Blackview MP20 | « dès 319,99 € » | [M] mais comparateur : prix d'appel, sans marchand ni port | 01 h 42 |
| Blackview MP20 | « c'est un mini-PC » | [P] souvenir de Claude, **pas vérifié** | — |
| BEASTCOM Q3 | « dès 399,99 € » | [M] comparateur, sans marchand ni port | 01 h 42 |
| Deal Dealabs | aucun prix relevé | lien issu des résultats du moteur seulement | 01 h 41 |
| Back Market (4 fiches) | aucun | refusé (voir plus bas) | 01 h 43 |

Calculs (Python) : 479,99 ÷ 300 = 1,600 ; 319,99 ÷ 300 = 1,067 ; 399,99 ÷ 300 = 1,333.

Pages lues sans offre utile : comparez-malin Dell 15 DC15250 (référence archivée, plus vendue, prix de référence 949 €) ; comparez-malin Lenovo IdeaPad Slim 3 15AMN8 (8 Go / 128 Go, hors config, plus en vente) ; liste LDLC « SSD 512 Go » (aucun prix sur les fiches de la liste, filtre 16 Go pas appliqué, bannière « Une erreur est survenue »).

**Fraîcheur** : semaine avant le Black Friday (27 nov. 2026) : un prix peut changer dans l'heure. Ces relevés de 01 h 42 sont à refaire avant toute décision.

## Sites refusés par l'outil de lecture (WebFetch)
- **backmarket.fr** : 4 fiches produit sur 4 refusées, erreur « client_error », rien récupéré. Pas de contournement (ni curl, ni cache, ni miroir).
- Non ouverts par règle (pas des refus) : Leboncoin, Dealabs, Idealo.
- Lus sans refus : ldlc.com, comparez-malin.fr, ledenicheur.fr.

**Nombre de sites refusés : 1 (Back Market).**

## Pas vérifié
- Délai de livraison de l'EliteBook (non affiché), note en % ou sur 5 de Refabz (seulement 111 avis vus), durée de la garantie, mentions légales et siège de Refabz, recherche « Refabz avis / arnaque » (budget épuisé).
- Que le Blackview MP20 est un mini-PC (souvenir [P]) ; son marchand, son port.
- Le prix du deal Dealabs Dell 16 (Core 5 120U), et s'il est encore actif.
- Tous les prix Back Market (refusés) ; Cdiscount, Rakuten, Fnac, Boulanger, Amazon : pas regardés (budget).
- Clavier AZERTY : pour l'EliteBook, la désignation ne le dit pas (« W11 OF »). Plusieurs fiches Back Market trouvées sont en QWERTY espagnol, anglais, grec ou QWERTZ.
- Idealo : la recherche « … idealo » n'a renvoyé **aucun** résultat idealo.fr.
- Une partie du contenu de 3 pages (comparez-malin ×2, liste LDLC) vient d'un résumé de page tronquée, pas du texte complet.

## Autocritique du skill (propositions seulement, rien n'a été changé)
1. **Étape 1 impossible à faire proprement sans Nico.** « 16 Go, SSD 512 » ne fixe ni le processeur ni l'écran : on compare un i5 de 10e génération d'occasion à des PC neufs, et un probable mini-PC passe le filtre. *Proposition :* dans `envies.json`, ajouter une config minimale (ex. processeur ≥ i5 10e gén. / Ryzen 5 4000, écran 14–16" FHD, **clavier AZERTY**, Windows 11) et des exclusions `mini pc`, `qwerty`, `qwertz`.
2. **Le moteur de recherche ne donne que des titres et des liens, sans prix.** Le niveau de confiance « moyen = donnée vue dans un extrait de moteur » est donc inapplicable ici, et tous les prix demandent une lecture de page. *Proposition :* le dire dans le skill, et compter plutôt 3 recherches + 8 à 10 lectures par recherche à la demande.
3. **Le reconditionné est presque inaccessible** : Back Market refuse l'outil. Or c'est là que se trouvent les PC 16 Go / 512 Go vers 300 €. *Proposition :* pour Back Market, faire comme pour Idealo : lien de recherche préparé par l'appli + capture de Nico, ou une alerte de prix (non vérifié qu'elle existe, voir REPRISE.md).
4. **Les comparateurs (leDénicheur, comparez-malin) ne sont pas cités dans le skill.** Je les ai lus comme des sites marchands ; leur robots.txt n'a pas été vérifié. Leur prix « dès » n'a ni marchand ni port : ils ne servent qu'à trouver des pistes. *Proposition :* une règle explicite (« comparateur = piste, jamais une offre ; vérifier le robots.txt une fois et le noter en section 6 »).
5. **Lecture par un agent intermédiaire** : dans cette session, WebFetch n'était disponible qu'à travers un agent qui résume la page. Un [M] obtenu ainsi est de seconde main, et parfois tiré d'un résumé de page tronquée. *Proposition :* un niveau ou une mention « [M] lu par agent » et, pour le prix et le port retenus, exiger le passage cité mot pour mot.
6. **Seuils vendeur contradictoires** (déjà noté dans REPRISE.md) : skill/REPRISE ≥ 4,5/5 et ≥ 100 avis ; `envies.json` ≥ 90 %. LDLC n'a montré que le nombre d'avis (111), donc impossible de trancher même avec un seuil choisi. *Proposition :* règle « note non affichée → vendeur non vérifié → confiance au plus moyen ».
7. **Statut d'une offre au port non vérifié** : le skill dit seulement « jamais dans la cible ». Il ne dit pas si elle peut être « proche ». J'ai mis « proche au mieux ». *Proposition :* l'écrire.
8. **Garde-fou budget** : la limite de 15 a été atteinte sans vérification de vendeur (mentions légales, « avis / arnaque ») pour la seule offre relevée. *Proposition :* réserver 2 lectures à la vérification du vendeur de l'offre n° 1 avant d'élargir la recherche.
9. **Pas d'étape « prix de référence du marché »** dans la partie A : sans elle, on ne sait pas si 300 € pour 16 Go / 512 Go est réaliste en neuf (ici : rien de neuf sous 360 € trouvé). *Proposition :* finir le rapport par « prix réaliste observé » par état (neuf / reconditionné), pour aider Nico à ajuster son prix souhaité.

Autocritique de mon propre essai : l'outil de « rattachement » du dépôt (`add_repo`) n'existait pas dans cette session, mais les deux dépôts étaient déjà clonés et accessibles. J'ai dépensé 3 lectures sur des pages sans offre (deux fiches comparez-malin archivées, une liste LDLC sans prix) : choisies sur leur titre, sans savoir. Rien de ce rapport n'est assez sûr pour acheter.

## Sources (lues le 22 nov. 2026, 01 h 41 – 01 h 43)
- LDLC, HP EliteBook 850 G7 reconditionné : https://www.ldlc.com/fiche/PB00715420.html
- LDLC, liste PC portables SSD 512 Go : https://www.ldlc.com/informatique/ordinateur-portable/pc-portable/c4265/+fv374-7329.html
- leDénicheur, recherche « pc portable 16go 512 » : https://ledenicheur.fr/s/pc-portable-16go-512/
- comparez-malin, Dell 15 DC15250 : https://www.comparez-malin.fr/informatique/pc-portable/dell-15-dc15250-core-i5-16-go-512-go-bndc1525015sb-noac.html
- comparez-malin, Lenovo IdeaPad Slim 3 15AMN8 : https://www.comparez-malin.fr/informatique/pc-portable/lenovo-ideapad-slim-3-15amn8-82xq017sfr.html
- Back Market (refusées) : HP ProBook 450 G5, Dell Vostro 5590, Acer Aspire 5 A514-55, HP 15-eg2000nf (liens trouvés par le moteur de recherche).
