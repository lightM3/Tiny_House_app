import 'package:flutter/material.dart';

class TenantHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kiracı Paneli')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('🏡 Kiracı Ana Sayfası', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/houseList');
              },
              child: Text('Ev Ara ve Rezervasyon Yap'),
            ),
            ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/tenantReservations');
  },
  child: Text('Rezervasyonlarım'),
),
ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/tenantReviews');
  },
  child: Text('Yorum ve Puanlama'),
),

          ],
        ),
      ),
    );
  }
}
