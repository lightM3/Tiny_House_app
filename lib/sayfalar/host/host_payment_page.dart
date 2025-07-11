import 'package:flutter/material.dart';

class HostPaymentPage extends StatefulWidget {
  @override
  _HostPaymentPageState createState() => _HostPaymentPageState();
}

class _HostPaymentPageState extends State<HostPaymentPage> {
  List<Map<String, dynamic>> payments = [
    {
      'guest': 'tenant1',
      'house': 'Orman Içınde Manzaralı Tiny House',
      'amount': 1800,
      'status': 'Tamamlandı',
      'date': '12 Haziran 2025',
    },
    {
      'guest': 'tenant3',
      'house': 'Göl Kenarında Sessiz Tiny House',
      'amount': 1900,
      'status': 'Tamamlandı',
      'date': '18 Kasım 2025',
    },
    {
      'guest': 'tenant2',
      'house': 'Minimalist Doğa Evi',
      'amount': 1400,
      'status': 'Beklemede',
      'date': '7 Temmuz 2024',
    },
    {
      'guest': 'tenant3',
      'house': 'Minimalist Doğa Evi',
      'amount': 1400,
      'status': 'İptal Edildi',
      'date': '5 Ağustos 20118',
    },
  ];

  double getTotalEarnings() {
    return payments
        .where((p) => p['status'] == 'Tamamlandı')
        .fold(0, (sum, payment) => sum + payment['amount']);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Tamamlandı':
        return Colors.green;
      case 'Beklemede':
        return Colors.orange;
      case 'İptal Edildi':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ödeme Bilgileri'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📌 Toplam Kazanç Kartı
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              color: Colors.green.withOpacity(0.2),
              child: ListTile(
                leading: Icon(
                  Icons.attach_money,
                  color: Colors.green,
                  size: 40,
                ),
                title: Text(
                  'Toplam Kazanç',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                subtitle: Text(
                  '${getTotalEarnings()}₺',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // 📌 Ödeme Geçmişi Başlığı
            Text(
              'Ödeme Geçmişi',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 10),

            // 📌 Ödeme Kartları
            Expanded(
              child: ListView.builder(
                itemCount: payments.length,
                itemBuilder: (context, index) {
                  final payment = payments[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${payment['guest']}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '🏡 ${payment['house']}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text('📅 Tarih: ${payment['date']}'),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '💵 ${payment['amount']}₺',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(
                                    payment['status']!,
                                  ).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  payment['status']!,
                                  style: TextStyle(
                                    color: _getStatusColor(payment['status']!),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
