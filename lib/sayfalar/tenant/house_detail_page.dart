import 'package:flutter/material.dart';
import 'tenant_reservation_page.dart'; // Rezervasyon sayfasını içe aktarıyoruz

class HouseDetailPage extends StatelessWidget {
  final Map<String, dynamic> house;

  HouseDetailPage({required this.house});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(house['title']), backgroundColor: Colors.blueAccent),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 📌 Ev Fotoğrafı Alanı
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Şimdilik gri bir alan, ileride resim eklenecek
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Icon(Icons.image, size: 80, color: Colors.black54),
                ),
              ),
              SizedBox(height: 16),

              // 📌 Ev Başlığı
              Text(
                house['title'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),

              // 📌 Konum ve Puan Bilgisi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '📍 ${house['location']}',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 22),
                      SizedBox(width: 5),
                      Text(
                        house['rating'].toString(),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),

              // 📌 Fiyat Bilgisi
              Text(
                '💰 ${house['price']}₺ / gece',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              SizedBox(height: 16),

              // 📌 Açıklama Başlığı
              Text(
                '🏡 Ev Açıklaması:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
              SizedBox(height: 5),

              // 📌 Açıklama Metni
              Text(
                'Bu harika tiny house, doğayla iç içe, huzurlu bir konaklama deneyimi sunar. '
                'Tam donanımlı mutfağı, konforlu yatakları ve harika manzarasıyla sizi bekliyor!',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 20),

              // 📌 Rezervasyon Butonu
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TenantReservationPage(houseName: house['title']),
                      ),
                    );
                  },
                  icon: Icon(Icons.calendar_today, color: Colors.white),
                  label: Text('Rezervasyon Yap'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
