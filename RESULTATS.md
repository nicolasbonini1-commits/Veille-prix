# Essai des sources — 21/11/2026 21:25 (heure de Paris)

## Dealabs

| Adresse | Code HTTP et type | Nb d'<item> |
|---|---|---|
| `https://www.dealabs.com/robots.txt` | 200 text/plain;charset=UTF-8 | 0 |
| `https://www.dealabs.com/` | 200 text/html; charset=utf-8 | 0 |
| `https://www.dealabs.com/rss/hot` | 200 text/xml; charset=utf-8 | 30 |
| `https://www.dealabs.com/rss/new` | 200 text/xml; charset=utf-8 | 30 |
| `https://www.dealabs.com/rss/all` | 404 text/html; charset=UTF-8 | 0 |
| `https://www.dealabs.com/rss/nouveaux` | 200 text/xml; charset=utf-8 | 30 |
| `https://www.dealabs.com/rss/search?q=pc+portable` | 404 text/html; charset=UTF-8 | 0 |
| `https://www.dealabs.com/magazine/feed` | 200 text/html; charset=UTF-8 | 0 |

### robots.txt : lignes sur rss, search, User-agent
```
1:User-agent: *
41:Disallow: /*?search_fields=*
42:Disallow: /*&search_fields=*
49:Disallow: /search
52:User-agent: ChatGPT-User
66:User-agent: GPTBot
80:User-agent: Applebot-Extended
83:User-agent: Bytespider
86:User-agent: CCBot
89:User-agent: ClaudeBot
92:User-agent: Diffbot
95:User-agent: FacebookBot
109:User-agent: Mediapartners-Google
112:User-agent: Google-Extended
126:User-agent: omgili
129:User-agent: Amazonbot
132:User-agent: Applebot
146:User-agent: PerplexityBot
149:User-agent: anthropic-ai
152:User-agent: OAI-SearchBot
166:User-agent: cohere-ai
169:User-agent: Seekbot
172:User-agent: Seekr
175:User-agent: omgilibot
178:User-agent: FirecrawlAgent
181:User-agent: Meta-ExternalAgent
184:User-agent: NovaAct
187:User-agent: Operator
```

### Liens « conditions » trouvés sur la page d'accueil
```
```

### Liens RSS annoncés dans la page d'accueil (balises alternate)
```
```

Lien des conditions d'utilisation non trouvé dans la page d'accueil : à chercher à la main.

### Premier élément de rss_hot
```xml
<item><category><![CDATA[Maison & Habitat]]></category><pepper:merchant name="Lidl"/><media:content medium="image" url="https://static-pepper.dealabs.com/threads/raw/VEcfG/3464254_1/re/150x150/qt/55/3464254_1.jpg" width="100" height="100"/><media:thumbnail url="https://static-pepper.dealabs.com/threads/raw/VEcfG/3464254_1/re/150x150/qt/55/3464254_1.jpg" width="100" height="100"/><title><![CDATA[100° - [Megathread] Sélection de produits Black Week avec 10 % de remise en plus ce week-end. Ex : Coupe-branches sans fil 12 V]]></title><description>(retirée)</description><link>https://www.dealabs.com/bons-plans/megathread-selection-de-produits-black-week-avec-10-de-remise-en-plus-ce-week-end-3464254</link><pubDate>Sat, 21 Nov 2026 21:20:19 +0100</pubDate><guid>https://www.dealabs.com/bons-plans/
```

### Premier élément de rss_new
```xml
<item><category><![CDATA[Mode & Accessoires]]></category><pepper:merchant name="Histoire d'Or" price="70€"/><media:content medium="image" url="https://static-pepper.dealabs.com/threads/raw/fdVgT/3464762_1/re/150x150/qt/55/3464762_1.jpg" width="100" height="100"/><media:thumbnail url="https://static-pepper.dealabs.com/threads/raw/fdVgT/3464762_1/re/150x150/qt/55/3464762_1.jpg" width="100" height="100"/><title><![CDATA[Montre Casio G-Shock GMA-S2100-1AER - Bracelet résine noire (Via retrait magasin)]]></title><description>(retirée)</description><link>https://www.dealabs.com/bons-plans/montre-casio-g-shock-gma-s2100-1aer-bracelet-resine-noire-via-retrait-magasin-3464762</link><pubDate>Sat, 21 Nov 2026 21:23:17 +0100</pubDate><guid>https://www.dealabs.com/bons-plans/montre-casio-g-shock-gma-s2
```

### Premier élément de rss_nouveaux
```xml
<item><category><![CDATA[Mode & Accessoires]]></category><pepper:merchant name="Histoire d'Or" price="70€"/><media:content medium="image" url="https://static-pepper.dealabs.com/threads/raw/fdVgT/3464762_1/re/150x150/qt/55/3464762_1.jpg" width="100" height="100"/><media:thumbnail url="https://static-pepper.dealabs.com/threads/raw/fdVgT/3464762_1/re/150x150/qt/55/3464762_1.jpg" width="100" height="100"/><title><![CDATA[Montre Casio G-Shock GMA-S2100-1AER - Bracelet résine noire (Via retrait magasin)]]></title><description>(retirée)</description><link>https://www.dealabs.com/bons-plans/montre-casio-g-shock-gma-s2100-1aer-bracelet-resine-noire-via-retrait-magasin-3464762</link><pubDate>Sat, 21 Nov 2026 21:23:17 +0100</pubDate><guid>https://www.dealabs.com/bons-plans/montre-casio-g-shock-gma-s2
```

### Durée couverte par les 30 deals de chaque fil

- rss_hot : 30 deals, du 21/11 19:29 au 21/11 21:20, soit 1.9 h
- rss_new : 30 deals, du 21/11 20:23 au 21/11 21:23, soit 1.0 h
- rss_nouveaux : 30 deals, du 21/11 20:23 au 21/11 21:23, soit 1.0 h

## eBay Browse

Secrets EBAY_CLIENT_ID / EBAY_CLIENT_SECRET absents : essai eBay sauté (normal tant que la clé n'est pas créée).
