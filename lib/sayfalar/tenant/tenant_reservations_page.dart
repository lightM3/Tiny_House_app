import 'package:flutter/material.dart';
import 'tenant_reservation_detail_page.dart'; // Rezervasyon Detay Sayfasını içe aktarıyoruz

class TenantReservationsPage extends StatefulWidget {
  @override
  _TenantReservationsPageState createState() => _TenantReservationsPageState();
}

class _TenantReservationsPageState extends State<TenantReservationsPage> {
  List<Map<String, String>> reservations = [
    {
      'house': 'Orman Içınde Manzaralı Tiny House',
      'date': '10-12 Mayıs',
      'status': 'Onaylandı',
    },
    {
      'house': 'Minimalist Doğa Evi',
      'date': '15-18 Haziran',
      'status': 'Beklemede',
    },
    {
      'house': 'Göl Kenarı Sessiz Tiny House',
      'date': '5-7 Temmuz',
      'status': 'Reddedildi',
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Onaylandı':
        return Colors.green;
      case 'Beklemede':
        return Colors.orange;
      case 'Reddedildi':
        return Colors.red;
      case 'İptal Edildi':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  void _cancelReservation(int index) {
    setState(() {
      reservations[index]['status'] = 'İptal Edildi';
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Rezervasyon iptal edildi!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rezervasyonlarım'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: reservations.length,
          itemBuilder: (context, index) {
            final reservation = reservations[index];

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
                    // 📌 Ev Başlığı
                    Text(
                      reservation['house']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),

                    // 📌 Tarih Bilgisi
                    Text(
                      '📅 Tarih: ${reservation['date']}',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    SizedBox(height: 10),

                    // 📌 Durum Bilgisi
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Durum: ${reservation['status']}',
                          style: TextStyle(
                            color: _getStatusColor(reservation['status']!),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // 📌 Durum "Onaylandı" veya "Beklemede" ise iptal butonu göster
                        if (reservation['status'] == 'Onaylandı' ||
                            reservation['status'] == 'Beklemede')
                          ElevatedButton(
                            onPressed: () => _cancelReservation(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            child: Text(
                              'İptal Et',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                      ],
                    ),

                    SizedBox(height: 10),

                    // 📌 Detay Sayfasına Git Butonu
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () async {
                          final updatedReservation = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => TenantReservationDetailPage(
                                    reservation: reservation,
                                  ),
                            ),
                          );

                          if (updatedReservation != null) {
                            setState(() {
                              reservations[index] = updatedReservation;
                            });
                          }
                        },
                        child: Text(
                          'Detayları Gör',
                          style: TextStyle(color: Colors.blueAccent),
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
