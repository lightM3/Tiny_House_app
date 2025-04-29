import 'package:flutter/material.dart';

class AdminStatisticsPage extends StatefulWidget {
  @override
  _AdminStatisticsPageState createState() => _AdminStatisticsPageState();
}

class _AdminStatisticsPageState extends State<AdminStatisticsPage> {
  // 📌 Temel istatistik verileri
  int totalUsers = 120;
  int activeUsers = 95;
  int newUsers = 10;
  int totalReservations = 340;
  int completedPayments = 280;
  int pendingPayments = 30;
  int totalReviews = 150;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('İstatistik ve Raporlama'), backgroundColor: Colors.blueAccent),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Genel Sistem Durumu',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
              SizedBox(height: 10),

              // 📌 Kullanıcı İstatistikleri
              _buildStatCard('👤 Toplam Kullanıcı', '$totalUsers kişi', Colors.blue),
              _buildStatCard('🟢 Aktif Kullanıcılar', '$activeUsers kişi', Colors.green),
              _buildStatCard('🆕 Yeni Üyeler (Son Ay)', '$newUsers kişi', Colors.orange),

              // 📌 Rezervasyon ve Ödeme İstatistikleri
              _buildStatCard('📅 Toplam Rezervasyon', '$totalReservations rezervasyon', Colors.purple),
              _buildStatCard('💰 Tamamlanan Ödemeler', '$completedPayments ödeme', Colors.green),
              _buildStatCard('⏳ Bekleyen Ödemeler', '$pendingPayments ödeme', Colors.red),

              // 📌 Yorumlar ve Değerlendirme
              _buildStatCard('⭐ Toplam Yorumlar', '$totalReviews yorum', Colors.amber),
            ],
          ),
        ),
      ),
    );
  }

  // 📌 Tek bir kart şablonu oluşturalım
  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color, child: Icon(Icons.analytics, color: Colors.white)),
        title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
      ),
    );
  }
}
