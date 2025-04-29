import 'package:flutter/material.dart';
import 'host_property_management.dart';
import 'host_reservation_management.dart';
import 'host_reviews_page.dart';
import 'host_payment_page.dart';

class HostHomePage extends StatefulWidget {
  @override
  _HostHomePageState createState() => _HostHomePageState();
}

class _HostHomePageState extends State<HostHomePage> {
  List<Map<String, String>> properties = [
    {'title': 'Deniz Manzaralı Tiny House', 'status': 'Aktif'},
    {'title': 'Orman İçinde Bungalov', 'status': 'Pasif'},
  ];

  List<Map<String, String>> reservations = [
    {'guest': 'Ali Yılmaz', 'house': 'Deniz Manzaralı Tiny House', 'date': '10-12 Mayıs'},
    {'guest': 'Ayşe Kaya', 'house': 'Orman İçinde Bungalov', 'date': '15-18 Haziran'},
  ];

  List<Map<String, dynamic>> reviews = [
    {'user': 'Mehmet Demir', 'comment': 'Harika bir konaklama deneyimi yaşadık!', 'rating': 5},
    {'user': 'Zeynep Çelik', 'comment': 'Ev çok güzeldi ama internet biraz yavaştı.', 'rating': 4},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ev Sahibi Ana Ekranı'), backgroundColor: Colors.blueAccent),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 📌 Yönetim Butonları
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildActionCard(context, 'İlan Yönetimi', Icons.home, Colors.blueAccent, HostPropertyManagementPage()),
                  _buildActionCard(context, 'Rezervasyon Yönetimi', Icons.calendar_today, Colors.green, HostReservationManagementPage()),
                  _buildActionCard(context, 'Yorumlar ve Puanlar', Icons.comment, Colors.orange, HostReviewsPage()),
                  _buildActionCard(context, 'Ödeme Bilgileri', Icons.payment, Colors.redAccent, HostPaymentPage()),
                ],
              ),
              SizedBox(height: 20),

              // 📌 İlanlarım
              _buildSectionTitle('İlanlarım'),
              _buildPropertyList(),

              // 📌 Gelen Rezervasyonlar
              _buildSectionTitle('Gelen Rezervasyonlar'),
              _buildReservationList(),

              // 📌 Son Yorumlar
              _buildSectionTitle('Son Yorumlar'),
              _buildReviewList(),
            ],
          ),
        ),
      ),
    );
  }

  // 📌 Yönetim Butonları İçin Kart Tasarımı
  Widget _buildActionCard(BuildContext context, String title, IconData icon, Color color, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: 1.5),
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 40),
            SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  // 📌 Bölüm Başlıkları
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
    );
  }

  // 📌 İlan Kartları
  Widget _buildPropertyList() {
    return Column(
      children: properties.map((property) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            title: Text(property['title']!, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
              'Durum: ${property['status']}',
              style: TextStyle(color: property['status'] == 'Aktif' ? Colors.green : Colors.red),
            ),
            trailing: Icon(Icons.edit, color: Colors.orange),
            onTap: () {
              // Düzenleme sayfasına yönlendirme burada yapılacak
            },
          ),
        );
      }).toList(),
    );
  }

  // 📌 Rezervasyon Kartları
  Widget _buildReservationList() {
    return Column(
      children: reservations.map((reservation) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            title: Text('${reservation['guest']}', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Ev: ${reservation['house']}\nTarih: ${reservation['date']}'),
            trailing: Icon(Icons.calendar_today, color: Colors.blueAccent),
          ),
        );
      }).toList(),
    );
  }

  // 📌 Yorum Kartları
  Widget _buildReviewList() {
    return Column(
      children: reviews.map((review) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            title: Text(review['user'], style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(review['comment']),
                Row(
                  children: List.generate(review['rating'], (index) => Icon(Icons.star, color: Colors.amber)),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
