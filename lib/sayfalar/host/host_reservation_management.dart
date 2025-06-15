import 'package:flutter/material.dart';
import 'reservation_detail_page.dart';

class HostReservationManagementPage extends StatefulWidget {
  @override
  _HostReservationManagementPageState createState() =>
      _HostReservationManagementPageState();
}

class _HostReservationManagementPageState
    extends State<HostReservationManagementPage> {
  List<Map<String, String>> reservations = [
    {
      'guest': 'tenant1',
      'house': 'Orman Içinde Manzaralı Tiny House',
      'date': '01-05 Haziran',
      'status': 'Beklemede',
      'payment': 'Ödendi',
    },
    {
      'guest': 'tenant1',
      'house': 'Göl Kenarında Sessiz Tiny House',
      'date': '07 Ekim - 07 Aralık',
      'status': 'Reddedildi',
      'payment': 'Bekleniyor',
    },
    {
      'guest': 'tenant2',
      'house': 'Minimalist Doğa Evi',
      'date': '5-12 Temmuz',
      'status': 'Onaylandı',
      'payment': 'Ödendi',
    },
    {
      'guest': 'tenant3',
      'house': 'Orman Içinde Manzaralı Tiny House',
      'date': '23-30 Eylül',
      'status': 'Beklemede',
      'payment': 'Ödendi',
    },
    {
      'guest': 'tenant1',
      'house': 'Plaja 100 metre mesafede ev',
      'date': '12-18 Temmuz',
      'status': 'Beklemede',
      'payment': 'Bekleniyor',
    },
    {
      'guest': 'tenant2',
      'house': 'Minimalist Doğa Evi',
      'date': '18-21 Kasım',
      'status': 'Onaylandı',
      'payment': 'Ödendi',
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
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rezervasyon Yönetimi'),
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
                    Text(
                      '${reservation['guest']}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('🏡 Ev: ${reservation['house']}'),
                    Text('📅 Tarih: ${reservation['date']}'),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '🔵 Durum: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(
                                  reservation['status']!,
                                ).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                reservation['status']!,
                                style: TextStyle(
                                  color: _getStatusColor(
                                    reservation['status']!,
                                  ),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () async {
                            final updatedReservation = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => ReservationDetailPage(
                                      reservation: reservations[index],
                                    ),
                              ),
                            );

                            if (updatedReservation != null) {
                              setState(() {
                                reservations[index] = updatedReservation;
                              });
                            }
                          },
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
    );
  }
}
