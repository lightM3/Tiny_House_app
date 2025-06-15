import 'package:flutter/material.dart';
import 'register_page.dart';
import 'package:my_tiny_house_app/sayfalar/admin/admin_dashboard_page.dart';
import 'package:my_tiny_house_app/sayfalar/host/host_home_page.dart';
import 'package:my_tiny_house_app/sayfalar/tenant/tenant_home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  List<Map<String, String>> users = [
    {'email': 'admin', 'password': '1234'},
    {'email': 'host', 'password': '1234'},
    {'email': 'tenant', 'password': '1234'},
  ];

  void _loginUser() {
    String email = emailController.text;
    String password = passwordController.text;

    Map<String, String>? user = users.firstWhere(
      (u) => u['email'] == email && u['password'] == password,
      orElse: () => {},
    );

    if (user.isNotEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Giriş başarılı!')));
      // Basit rol yönlendirme (dummy örnek)
      if (email.contains('admin')) {
        Navigator.pushNamed(context, '/adminDashboard');
      } else if (email.contains('host')) {
        Navigator.pushNamed(context, '/hostHome');
      } else {
        Navigator.pushNamed(context, '/tenantHome');
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Geçersiz e-posta veya şifre')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Giriş Yap')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'E-posta'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Şifre'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _loginUser, child: Text('Giriş Yap')),
            TextButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegisterPage()),
                );

                if (result != null && result is Map<String, String>) {
                  setState(() {
                    users.add(result);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Yeni kullanıcı eklendi!')),
                  );
                }
              },
              child: Text('Kayıt Ol'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/adminDashboard');
              },
              child: Text("Admin Paneline Git"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/hostHome');
              },
              child: Text("Ev Sahibi Paneline Git"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/tenantHome');
              },
              child: Text("Kiracı Paneline Git"),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
