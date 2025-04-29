import 'package:flutter/material.dart';
import 'package:my_tiny_house_app/sayfalar/tenant/tenant_reservation_page.dart';

class HouseDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ev Detaylari')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ev Başligi', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Konum: İzmir'),
            SizedBox(height: 10),
            Text('Fiyat: 1200 ₺'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/reservation');
              },
              child: Text('Rezervasyon Yap'),
            ),
            ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TenantReservationPage(houseName: 'Deniz Manzaralı Tiny House')),
    );
  },
  child: Text('Rezervasyon Yap'),
),

          ],
        ),
      ),
    );
  }
}
