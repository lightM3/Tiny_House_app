import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String selectedRole = 'Kiracı';

  void _registerUser() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen tüm alanları doldurun!')),
      );
      return;
    }

    // Kullanıcıyı kaydetme işlemi (geçici olarak hafızada tutuyoruz)
    Map<String, String> newUser = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'role': selectedRole,
    };

    // Kayıt başarılı mesajı
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Kayıt başarılı! Giriş yapabilirsiniz.')),
    );

    // Giriş ekranına yönlendir
    Navigator.pop(context, newUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kayıt Ol'), backgroundColor: Colors.blueAccent),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Ad Soyad', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
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
            SizedBox(height: 10),
            DropdownButtonFormField(
              value: selectedRole,
              items: ['Kiracı', 'Ev Sahibi'].map((role) {
                return DropdownMenuItem(value: role, child: Text(role));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRole = value.toString();
                });
              },
              decoration: InputDecoration(labelText: 'Rol', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _registerUser,
                child: Text('Kayıt Ol'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
