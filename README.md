# 🏡 Tiny House Rezervasyon ve Yönetim Sistemi

Bu proje, kullanıcıların tiny house tarzı konaklamaları görüntüleyip rezervasyon yapabildiği, ev sahiplerinin ilan yönetimi ve rezervasyon takibi yapabildiği, adminin ise tüm sistemi denetleyebildiği çok katmanlı bir uygulamadır.

---

## 🚀 Kullanılan Teknolojiler

| Katman       | Teknoloji     |
|--------------|---------------|
| Mobil Arayüz | Flutter       |
| Backend      | C# (.NET Core)|
| Veritabanı   | MSSQL         |
| IDE          | Visual Studio / VS Code |

---

## 👥 Roller ve Yetkiler

### 🔐 Admin
- Kullanıcı yönetimi (ekle/düzenle/sil)
- Rezervasyonları görüntüleme ve iptal
- İlanları denetleme
- Ödeme kontrolü
- İstatistik ve raporlar

### 🏠 Ev Sahibi
- İlan ekleme, düzenleme, pasif/aktif hale getirme
- Gelen rezervasyonları onaylama veya reddetme
- Kiracı yorumlarını görüntüleme ve yanıt verme
- Ödeme bilgilerini görme

### 🧳 Kiracı
- İlanları filtreleyip görüntüleme
- Tarih seçerek rezervasyon yapma
- Tamamlanan rezervasyonlara puan ve yorum ekleme
- Geçmiş rezervasyonları görüntüleme ve iptal

---

## 🧩 Proje Mimarisi

- **Flutter UI**: Tüm arayüzler kullanıcı rolüne özel olacak şekilde yapılandırılmıştır.
- **C# API**: RESTful servisler JWT authentication ile korunur.
- **MSSQL**: Normalize edilmiş veritabanı yapısı, güçlü ilişkilerle desteklenmiştir.

---

## 📸 Ekran Görüntüleri
- [x] Giriş Yapma Ekranı-
-
![login](https://github.com/user-attachments/assets/ff8d2a97-a97d-422e-821a-3e4e0a611721)
-
- [x] Kayıt Olma Ekranı-
-
![register](https://github.com/user-attachments/assets/35a9b34b-d19c-4bc6-83e1-882144c892fc)
-
- [x] Admin Dashboard-  
-
![IMG-20250429-WA0013](https://github.com/user-attachments/assets/d0cfd27f-0ff4-4931-8cda-46be19a1c9e0)
-
- [x] Ev Sahibi İlan Yönetimi- 
-
![IMG-20250429-WA0015](https://github.com/user-attachments/assets/d74570f5-a8e5-49f2-9668-4778ae197835)
-
![IMG-20250429-WA0014](https://github.com/user-attachments/assets/69811cfe-01b8-44bd-b2c5-dc950dbf5472)
-
- [x] Kiracı Ev Detay Sayfası-
-
![Ekran görüntüsü 2025-04-29 190419](https://github.com/user-attachments/assets/463951f3-11d4-44a4-bba6-46ed66565f2d)
-
![Ekran görüntüsü 2025-04-29 190502](https://github.com/user-attachments/assets/14d20daa-5e38-4a92-bb49-e9753b9c125e)
-
![Ekran görüntüsü 2025-04-29 190606](https://github.com/user-attachments/assets/bd22e41d-8310-4f34-b2f7-6973b89bf080)
-
- [x] DataBase ER Diagram-
![ER_Diagram_TinyHouseDb](https://github.com/user-attachments/assets/261ae3f7-29c1-4357-9d23-296f254d203b)
-

---

## 🛠 Kurulum


```bash
# Flutter için
git clone https://github.com/kullaniciAdi/tiny-house-app.git
cd tiny-house-app
flutter pub get
flutter run
