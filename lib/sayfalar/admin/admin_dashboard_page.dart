import 'package:flutter/material.dart';
import 'admin_reservation_management.dart';
import 'admin_listing_management.dart';
import 'admin_payment_management.dart';
import 'admin_statistics_page.dart';

class AdminDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Genel Durum',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            SizedBox(height: screenHeight * 0.02),

            // 📊 Responsive İstatistik Kartları
            LayoutBuilder(
              builder: (context, constraints) {
                bool isWide = constraints.maxWidth > 600; // Ekran genişliği 600'den büyükse 2 sütun yap
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildStatCard("Toplam Kullanıcı", "1200", Icons.people, Colors.orange, isWide),
                    _buildStatCard("Toplam Rezervasyon", "350", Icons.calendar_today, Colors.green, isWide),
                    _buildStatCard("Aktif Evler", "220", Icons.home, Colors.blue, isWide),
                    _buildStatCard("Toplam Gelir", "₺150,000", Icons.attach_money, Colors.purple, isWide),
                  ],
                );
              },
            ),
            SizedBox(height: screenHeight * 0.04),

            // 📌 Yönetim Butonları
            _buildActionCard(
              context,
              title: "Kullanıcı Yönetimi",
              subtitle: "Sistemdeki tüm kullanıcıları yönet.",
              icon: Icons.supervised_user_circle,
              route: '/admin_user_management',
            ),
            _buildActionCard(
              context,
              title: "Rezervasyon Yönetimi",
              subtitle: "Rezervasyonları kontrol et ve düzenle.",
              icon: Icons.event_available,
              page: AdminReservationManagementPage(),
            ),
            _buildActionCard(
              context,
              title: "İlan Yönetimi",
              subtitle: "Sistemdeki tüm ilanları kontrol et.",
              icon: Icons.home_work,
              page: AdminListingManagementPage(),
            ),
            _buildActionCard(
              context,
              title: "Ödeme Yönetimi",
              subtitle: "Sistemdeki ödemeleri ve finansal raporları incele.",
              icon: Icons.payment,
              page: AdminPaymentManagementPage(),
            ),
            _buildActionCard(
              context,
              title: "İstatistik ve Raporlama",
              subtitle: "Sistemin genel analizlerini görüntüle.",
              icon: Icons.bar_chart,
              page: AdminStatisticsPage(),
            ),
          ],
        ),
      ),
    );
  }

  // 📊 Responsive İstatistik Kartı Widget'ı
  Widget _buildStatCard(String title, String value, IconData icon, Color color, bool isWide) {
    return SizedBox(
      width: isWide ? 180 : double.infinity, // Geniş ekranlarda yan yana, dar ekranlarda tam genişlik
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        color: color,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 30),
              SizedBox(height: 10),
              Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              Text(title, style: TextStyle(fontSize: 16, color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }

  // 📌 Yönetim Sayfalarına Gitmek İçin Buton Kartları
  Widget _buildActionCard(BuildContext context, {required String title, required String subtitle, required IconData icon, String? route, Widget? page}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent, size: 40),
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
        onTap: () {
          if (route != null) {
            Navigator.pushNamed(context, route);
          } else if (page != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => page));
          }
        },
      ),
    );
  }
}
