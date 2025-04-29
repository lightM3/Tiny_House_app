import 'package:flutter/material.dart';
import 'register_page.dart';
import 'package:my_tiny_house_app/sayfalar/host/host_home_page.dart';
import 'package:my_tiny_house_app/sayfalar/tenant/tenant_home_page.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  List<Map<String, String>> users = []; // Geçici olarak kullanıcıları burada tutuyoruz

  void _loginUser() {
    String email = emailController.text;
    String password = passwordController.text;

    // Kullanıcıyı listede arıyoruz
    Map<String, String>? user = users.firstWhere(
      (u) => u['email'] == email && u['password'] == password,
      orElse: () => {},
    );

    if (user.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Giriş başarılı!')),
      );

      // Rolüne göre yönlendirme
      if (user['role'] == 'Ev Sahibi') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HostHomePage()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TenantHomePage()));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Geçersiz e-posta veya şifre!')),
      );
    }
  }

  void _navigateToRegister() async {
    final newUser = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );

    if (newUser != null) {
      setState(() {
        users.add(newUser);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kayıt başarılı! Şimdi giriş yapabilirsiniz.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Giriş Yap'), backgroundColor: Colors.blueAccent),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'E-posta', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Şifre', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loginUser,
              child: Text('Giriş Yap'),
            ),
            TextButton(
              onPressed: _navigateToRegister,
              child: Text('Kayıt Ol'),
            ),
          ],
        ),
      ),
    );
  }
}
