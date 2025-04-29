import 'package:flutter/material.dart';

class ReservationDetailPage extends StatefulWidget {
  final Map<String, String> reservation;

  ReservationDetailPage({required this.reservation});

  @override
  _ReservationDetailPageState createState() => _ReservationDetailPageState();
}

class _ReservationDetailPageState extends State<ReservationDetailPage> {
  final List<String> statusOptions = ['Onaylandı', 'Beklemede', 'İptal Edildi'];
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

    // Geri dönerken güncellenmiş rezervasyon verisini Navigator.pop ile gönderiyoruz
    Navigator.pop(context, widget.reservation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rezervasyon Detayları')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kullanıcı: ${widget.reservation['user']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Ev: ${widget.reservation['house']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Tarih: ${widget.reservation['date']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Ödeme Durumu: ${widget.reservation['payment']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Durum:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
          ],
        ),
      ),
    );
  }
}
