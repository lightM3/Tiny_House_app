import 'package:flutter/material.dart';

class HostAddPropertyPage extends StatefulWidget {
  final Function(Map<String, String>) onPropertyAdded;

  HostAddPropertyPage({required this.onPropertyAdded});

  @override
  _HostAddPropertyPageState createState() => _HostAddPropertyPageState();
}

class _HostAddPropertyPageState extends State<HostAddPropertyPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedStatus = 'Aktif';

  void _saveProperty() {
    if (titleController.text.isNotEmpty && priceController.text.isNotEmpty) {
      Map<String, String> newProperty = {
        'title': titleController.text,
        'price': '${priceController.text}₺',
        'status': selectedStatus,
      };
      widget.onPropertyAdded(newProperty);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen tüm alanları doldurun!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Yeni İlan Ekle')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Ev Adı'),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Fiyat (₺)'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Açıklama'),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedStatus,
              items: ['Aktif', 'Pasif'].map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedStatus = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProperty,
              child: Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
