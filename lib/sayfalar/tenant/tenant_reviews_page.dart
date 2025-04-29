import 'package:flutter/material.dart';

class TenantReviewsPage extends StatefulWidget {
  @override
  _TenantReviewsPageState createState() => _TenantReviewsPageState();
}

class _TenantReviewsPageState extends State<TenantReviewsPage> {
  List<Map<String, dynamic>> reservations = [
    {'house': 'Deniz Manzaralı Tiny House', 'date': '10-12 Mayıs', 'status': 'Tamamlandı', 'rating': 0, 'comment': ''},
    {'house': 'Orman İçinde Bungalov', 'date': '15-18 Haziran', 'status': 'Tamamlandı', 'rating': 0, 'comment': ''},
    {'house': 'Göl Kenarı Küçük Ev', 'date': '5-7 Temmuz', 'status': 'Tamamlandı', 'rating': 0, 'comment': ''},
  ];

  void _showReviewDialog(int index) {
    TextEditingController commentController = TextEditingController();
    int selectedRating = reservations[index]['rating'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Yorum ve Puan Ekle"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Puan Verin"),
              Wrap(  // 📌 Yıldızları taşmasını engellemek için Wrap kullandık
                spacing: 5.0,
                children: List.generate(5, (starIndex) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        reservations[index]['rating'] = starIndex + 1;
                      });
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.star,
                      size: 30, // 📌 İkon boyutunu küçük tuttuk
                      color: starIndex < selectedRating ? Colors.amber : Colors.grey,
                    ),
                  );
                }),
              ),
              TextField(
                controller: commentController,
                decoration: InputDecoration(hintText: "Yorumunuzu yazın..."),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("İptal"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  reservations[index]['comment'] = commentController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text("Kaydet"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Yorum ve Puanlama')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: reservations.length,
          itemBuilder: (context, index) {
            final reservation = reservations[index];

            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(reservation['house'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text('📅 Tarih: ${reservation['date']}'),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(  // 📌 Yıldızların taşmasını engellemek için Wrap kullanıldı
                          spacing: 3.0,
                          children: List.generate(5, (starIndex) {
                            return Icon(
                              Icons.star,
                              size: 20, // 📌 Yıldız boyutunu küçülttük
                              color: starIndex < reservation['rating'] ? Colors.amber : Colors.grey,
                            );
                          }),
                        ),
                        TextButton(
                          onPressed: () => _showReviewDialog(index),
                          child: Text(reservation['comment'].isEmpty ? "Yorum Yap" : "Yorumu Düzenle"),
                        ),
                      ],
                    ),
                    if (reservation['comment'].isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text("📝 ${reservation['comment']}", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
