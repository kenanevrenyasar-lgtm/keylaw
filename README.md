# KeyLaw

Avukatlar için anonimleştirme, prompt kurma ve atıf denetleme aracı.
*Yapay Zekâ Çağında Avukatlık* kitabındaki protokolün uygulama hâlidir.

**Araç tamamen tarayıcıda çalışır.** Yüklediğiniz belge, yazdığınız metin ve
üretilen anahtar hiçbir sunucuya gönderilmez, hiçbir yere kaydedilmez. Sekmeyi
kapattığınızda ikisi de silinir. Bu bir tercih değil, bir zorunluluktur:
bulut tabanlı bir yapay zekâ hizmetine müvekkil verisi girmek, sunucular yurt
dışındaysa KVKK (6698) m.9 anlamında yurt dışına aktarımdır — araç, kendi
öğrettiği kuralı ihlal etmeyecek biçimde kurulmuştur.

## Ne yapar

| Sekme | İş |
|---|---|
| **Anonimleştir** | Belgeyi yükleyin ya da yapıştırın; kişi adı, şirket unvanı, T.C. kimlik, vergi/MERSİS, IBAN, esas/karar no, e-posta, telefon, plaka ve adres yer tutucuya çevrilir. Denetim görünümünde yakalananları tek tek gözden geçirir, yanlış olanı düşürürsünüz. |
| **Prompt Kur** | Kitabın BRGKB yöntemiyle (Bağlam, Rol, Görev, Kısıt, Biçim) prompt kurar. İş türüne göre zorunlu güvenlik kısıtlarını kendiliğinden ekler. |
| **Atıfları Doğrula** | Yapay zekânın ürettiği metindeki madde ve karar atıflarını kaynağından sorgular. *Yalnızca claude.ai sürümünde çalışır.* |
| **Geri Çevir** | Modelden dönen metindeki yer tutucuları gerçek değerlere döndürür. |
| **Protokol** | Aracın yaptığı ve yapmadığı işlerin dürüst dökümü. |

## Okunan dosya biçimleri

`.docx` · `.udf` (UYAP) · `.odt` · `.txt` · `.md` · `.html` · `.xml`

Word ve UYAP dosyaları birer ZIP arşividir; içlerindeki XML tarayıcının yerleşik
`DecompressionStream` motoruyla açılır. Dış kütüphane yoktur.

**PDF okunmaz.** Metin çıkarımı font kodlamalarına kadar inen bir iştir ve yarı
doğru çalışan bir ayrıştırıcı sessizce eksik metin verip yanıltır. PDF'i
görüntüleyicide açıp metni kopyalayın; belge taranmışsa metin katmanı yoktur ve
önce OCR gerekir. Eski `.doc` de okunmaz — Word'de açıp `.docx` kaydedin.

## Sınırları

- **Otomatik tespit hiçbir koşulda tam değildir.** Araç kalıp tanır, bağlam
  tanımaz. "Ülkedeki tek üretici" ya da basına yansımış bir olay, hiçbir isim
  geçmese de dosyayı tanınır kılar. Bu adımı yalnızca dosyayı bilen kişi yapabilir.
- **Doğrulama, atfın var olup olmadığını denetler; ne dediğini denetlemez.**
  Var olan bir maddeyi yanlış anlatmak da halüsinasyondur ve makine bunu yakalayamaz.
- **"Bulunamadı" mutlak değildir.** EK ve GEÇİCİ maddeler ile mükerrer numaralar
  sayısal madde numarasıyla sorgulanamaz.
- Araç hukuki danışmanlık vermez. Ürettiği hiçbir çıktı, avukatın kendi
  denetiminden geçmeden kullanılamaz. Nihai sorumluluk kullanıcıya aittir.

## Geliştirme

```
keylaw.html        kaynak (claude.ai artifact sürümü)
build-site.sh      kaynaktan bağımsız siteyi üretir → docs/
docs/              GitHub Pages'in yayımladığı klasör
```

Kaynağı düzenledikten sonra `./build-site.sh` çalıştırın.
