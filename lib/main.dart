import 'package:flutter/material.dart';
import 'package:my_tiny_house_app/sayfalar/admin/admin_user_management.dart';
import 'sayfalar/admin/admin_dashboard_page.dart';
import 'sayfalar/login_page.dart';
import 'sayfalar/home_page.dart';
import 'sayfalar/admin/admin_reservation_management.dart';
import 'sayfalar/host/host_home_page.dart';
import 'sayfalar/tenant/tenant_home_page.dart';
import 'sayfalar/tenant/house_list_page.dart';
import 'sayfalar/tenant/tenant_reservations_page.dart';
import 'sayfalar/tenant/tenant_reviews_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/adminDashboard': (context) => AdminDashboardPage(),
        '/admin_user_management': (context) => AdminUserManagementPage(),
        '/admin_reservation_management': (context) => AdminReservationManagementPage(),
        '/hostHome': (context) => HostHomePage(),
        '/tenantHome': (context) => TenantHomePage(),
        '/houseList': (context) => HouseListPage(),
        '/tenantReservations': (context) => TenantReservationsPage(),
        '/tenantReviews': (context) => TenantReviewsPage(),
      },
    );
  }
}
