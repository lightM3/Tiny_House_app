import 'package:flutter/material.dart';

class HostReviewsPage extends StatefulWidget {
  @override
  _HostReviewsPageState createState() => _HostReviewsPageState();
}

class _HostReviewsPageState extends State<HostReviewsPage> {
  List<Map<String, dynamic>> reviews = [
    {'user': 'Ali Yılmaz', 'house': 'Deniz Manzaralı Tiny House', 'rating': 5, 'comment': 'Mükemmel bir deneyimdi!', 'reply': ''},
    {'user': 'Ayşe Kaya', 'house': 'Orman İçinde Bungalov', 'rating': 4, 'comment': 'Ev çok güzeldi ama biraz soğuktu.', 'reply': ''},
    {'user': 'Mehmet Demir', 'house': 'Göl Kenarı Küçük Ev', 'rating': 3, 'comment': 'Ev fena değildi, ancak beklediğimden küçüktü.', 'reply': ''},
  ];

  void _addReply(int index, String reply) {
    setState(() {
      reviews[index]['reply'] = reply;
    });
  }

  void _showReplyDialog(int index) {
    TextEditingController replyController = TextEditingController(text: reviews[index]['reply']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Yanıt Ekle"),
          content: TextField(
            controller: replyController,
            decoration: InputDecoration(hintText: "Yanıtınızı yazın..."),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("İptal"),
            ),
            ElevatedButton(
              onPressed: () {
                _addReply(index, replyController.text);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              child: Text("Yanıtla"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Yorumlar ve Puanlar'), backgroundColor: Colors.blueAccent),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review['user'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text('🏡 ${review['house']}', style: TextStyle(color: Colors.grey[600])),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text('Puan: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          children: List.generate(review['rating'], (index) => Icon(Icons.star, color: Colors.amber, size: 20)),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(review['comment'], style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    if (review['reply'] != '') ...[
                      Divider(),
                      Text("Ev Sahibi Yanıtı:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                      Text(review['reply'], style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                    ],
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: () => _showReplyDialog(index),
                        icon: Icon(Icons.reply, size: 18, color: Colors.white),
                        label: Text(review['reply'] == '' ? "Yanıtla" : "Yanıtı Düzenle"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
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
