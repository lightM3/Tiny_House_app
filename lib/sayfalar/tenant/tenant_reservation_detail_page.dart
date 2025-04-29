import 'package:flutter/material.dart';

class TenantReservationDetailPage extends StatefulWidget {
  final Map<String, String> reservation;

  TenantReservationDetailPage({required this.reservation});

  @override
  _TenantReservationDetailPageState createState() => _TenantReservationDetailPageState();
}

class _TenantReservationDetailPageState extends State<TenantReservationDetailPage> {
  void _cancelReservation() {
    // Yeni bir Map oluşturup, Navigator.pop() ile geri döndürüyoruz
    Map<String, String> updatedReservation = Map.from(widget.reservation);
    updatedReservation['status'] = 'İptal Edildi';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Rezervasyon iptal edildi!')),
    );

    Navigator.pop(context, updatedReservation); // Güncellenmiş rezervasyonu geri döndür
  }

  @override
  Widget build(BuildContext context) {
    bool canCancel = widget.reservation['status'] == 'Onaylandı' || widget.reservation['status'] == 'Beklemede';

    return Scaffold(
      appBar: AppBar(title: Text('Rezervasyon Detayı')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🏡 ${widget.reservation['house']}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('📅 Tarih: ${widget.reservation['date']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text(
              '🔵 Durum: ${widget.reservation['status']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 20),
            if (canCancel)
              Center(
                child: ElevatedButton(
                  onPressed: _cancelReservation,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Rezervasyonu İptal Et', style: TextStyle(color: Colors.white)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
