import 'package:flutter/material.dart';

class ReservationDetailPage extends StatefulWidget {
  final Map<String, String> reservation;

  ReservationDetailPage({required this.reservation});

  @override
  _ReservationDetailPageState createState() => _ReservationDetailPageState();
}

class _ReservationDetailPageState extends State<ReservationDetailPage> {
  final List<String> statusOptions = ['Onaylandı', 'Beklemede', 'Reddedildi'];
  late String selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.reservation['status']!;
  }

  void _updateStatus(String newStatus) {
    setState(() {
      selectedStatus = newStatus;
      widget.reservation['status'] = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rezervasyon Detayları'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Güncellenmiş veriyi geri gönderiyoruz
            Navigator.pop(context, widget.reservation);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('👤 Kiracı: ${widget.reservation['guest']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('🏡 Ev: ${widget.reservation['house']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('📅 Tarih: ${widget.reservation['date']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('🔵 Durum:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedStatus,
              items: statusOptions.map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _updateStatus(newValue);
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Güncellenmiş durumu geri döndür
                Navigator.pop(context, widget.reservation);
              },
              child: Text('Kaydet ve Geri Dön'),
            ),
          ],
        ),
      ),
    );
  }
}
