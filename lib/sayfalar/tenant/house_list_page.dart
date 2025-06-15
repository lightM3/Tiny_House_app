import 'package:flutter/material.dart';
import 'house_detail_page.dart';

class HouseListPage extends StatelessWidget {
  final List<Map<String, dynamic>> houses = [
    {
      'title': 'Orman Içınde Manzaralı Tiny House',
      'location': 'Muğla',
      'price': 1200,
      'rating': 4.8,
    },
    {
      'title': 'Minimalist Doğa Evi',
      'location': 'Fethiye',
      'price': 900,
      'rating': 4.5,
    },
    {
      'title': 'Göl Kenarında Sessiz Tiny House',
      'location': 'Bodrum',
      'price': 1100,
      'rating': 4.7,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ev Ara ve Listele'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: houses.length,
          itemBuilder: (context, index) {
            final house = houses[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HouseDetailPage(house: house),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 📌 Ev Başlığı
                      Text(
                        house['title'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),

                      // 📌 Konum ve Fiyat Bilgisi
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '📍 ${house['location']}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          Text(
                            '💰 ${house['price']}₺ / gece',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      // 📌 Puan Bilgisi
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          SizedBox(width: 5),
                          Text(
                            house['rating'].toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
