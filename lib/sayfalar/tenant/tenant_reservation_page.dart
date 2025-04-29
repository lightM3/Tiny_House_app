import 'package:flutter/material.dart';

class TenantReservationPage extends StatefulWidget {
  final String houseName;

  TenantReservationPage({required this.houseName});

  @override
  _TenantReservationPageState createState() => _TenantReservationPageState();
}

class _TenantReservationPageState extends State<TenantReservationPage> {
  DateTime? startDate;
  DateTime? endDate;
  int pricePerNight = 1200; // Örnek fiyat, ileride dinamik yapılabilir.

  void _selectDate(BuildContext context, bool isStartDate) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime.now();
    DateTime lastDate = DateTime.now().add(Duration(days: 365));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
          if (endDate != null && picked.isAfter(endDate!)) {
            endDate = null;
          }
        } else {
          endDate = picked;
        }
      });
    }
  }

  int _calculateTotalPrice() {
    if (startDate != null && endDate != null) {
      int nights = endDate!.difference(startDate!).inDays;
      return nights * pricePerNight;
    }
    return 0;
  }

  void _confirmReservation() {
    if (startDate == null || endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen geçerli bir tarih seçin!')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Rezervasyon başarılı!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rezervasyon Yap'), backgroundColor: Colors.blueAccent),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📌 Ev Adı
            Text(
              '🏡 ${widget.houseName}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // 📌 Başlangıç Tarihi Seçimi
            Text('📅 Başlangıç Tarihi:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            ElevatedButton.icon(
              onPressed: () => _selectDate(context, true),
              icon: Icon(Icons.date_range),
              label: Text(startDate == null ? 'Tarih Seç' : '${startDate!.toLocal()}'.split(' ')[0]),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
            ),
            SizedBox(height: 10),

            // 📌 Bitiş Tarihi Seçimi
            Text('📅 Bitiş Tarihi:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            ElevatedButton.icon(
              onPressed: () => _selectDate(context, false),
              icon: Icon(Icons.date_range),
              label: Text(endDate == null ? 'Tarih Seç' : '${endDate!.toLocal()}'.split(' ')[0]),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
            ),
            SizedBox(height: 20),

            // 📌 Toplam Ücret
            if (startDate != null && endDate != null)
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '💵 Toplam Ücret:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    Text(
                      '${_calculateTotalPrice()}₺',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 20),

            // 📌 Rezervasyon Butonu
            Center(
              child: ElevatedButton.icon(
                onPressed: _confirmReservation,
                icon: Icon(Icons.check_circle, color: Colors.white),
                label: Text('Rezervasyonu Tamamla'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
