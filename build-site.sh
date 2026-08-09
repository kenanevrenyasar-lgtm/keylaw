#!/bin/bash
# keylaw.html (artifact kaynağı) → site/ (kendi başına ayakta duran web sitesi)
#
# Artifact sürümü claude.ai tarafından bir <html><head><body> iskeletine
# sarılır. Kendi sunucumuzda böyle bir sarmalayıcı olmadığı için burada
# tam bir HTML belgesi üretiyoruz ve PWA manifestini ekliyoruz.
set -euo pipefail
cd "$(dirname "$0")"

SRC="keylaw.html"
OUT="docs"
[[ -f "$SRC" ]] || { echo "$SRC yok" >&2; exit 1; }

mkdir -p "$OUT"

python3 - <<'PY'
import re, pathlib

src = pathlib.Path('keylaw.html').read_text(encoding='utf-8')

# İlk </style> etiketine kadar olan kısım <head> malzemesidir.
i = src.find('</style>')
if i == -1:
    raise SystemExit('style bloğu bulunamadı')
head = src[:i + len('</style>')]
body = src[i + len('</style>'):]

# Manifest bağlantısı yalnızca kendi sunucumuzdaki sürüme eklenir;
# artifact sürümünde CSP dış istekleri engellediği için oraya konmaz.
head = head.replace(
    '<link rel="apple-touch-icon"',
    '<link rel="manifest" href="manifest.webmanifest">\n'
    '<link rel="icon" type="image/png" sizes="512x512" href="icon-512.png">\n'
    '<link rel="apple-touch-icon"',
    1)

doc = ('<!doctype html>\n<html lang="tr">\n<head>\n'
       + head.strip()
       + '\n</head>\n<body>\n'
       + body.strip()
       + '\n</body>\n</html>\n')

pathlib.Path('docs/index.html').write_text(doc, encoding='utf-8')
print('  ✓ docs/index.html (%d bayt)' % len(doc.encode()))
PY

cat > "$OUT/manifest.webmanifest" <<'JSON'
{
  "name": "KeyLaw — Anonimleştirme ve Anahtar Yönetimi",
  "short_name": "KeyLaw",
  "description": "Avukatlar için anonimleştirme, anahtar yönetimi ve prompt kurma aracı. Tamamen tarayıcıda çalışır.",
  "lang": "tr",
  "start_url": ".",
  "scope": ".",
  "display": "standalone",
  "orientation": "any",
  "background_color": "#EAEBE6",
  "theme_color": "#6E1F2B",
  "icons": [
    { "src": "icon-180.png", "sizes": "180x180", "type": "image/png" },
    { "src": "icon-512.png", "sizes": "512x512", "type": "image/png" },
    { "src": "icon-512.png", "sizes": "512x512", "type": "image/png", "purpose": "maskable" }
  ]
}
JSON
echo "  ✓ docs/manifest.webmanifest"

touch "$OUT/.nojekyll"
echo "  ✓ docs/.nojekyll"

echo "→ Bitti."
ls -1 "$OUT"
