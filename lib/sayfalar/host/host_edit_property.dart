import 'package:flutter/material.dart';

class HostEditPropertyPage extends StatefulWidget {
  final Map<String, String> property;
  final Function(Map<String, String>) onUpdate;

  HostEditPropertyPage({required this.property, required this.onUpdate});

  @override
  _HostEditPropertyPageState createState() => _HostEditPropertyPageState();
}

class _HostEditPropertyPageState extends State<HostEditPropertyPage> {
  late TextEditingController titleController;
  late TextEditingController priceController;
  String selectedStatus = 'Aktif';

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.property['title']);
    priceController = TextEditingController(text: widget.property['price']!.replaceAll('₺', ''));
    selectedStatus = widget.property['status']!;
  }

  void _saveChanges() {
    if (titleController.text.isNotEmpty && priceController.text.isNotEmpty) {
      Map<String, String> updatedProperty = {
        'title': titleController.text,
        'price': '${priceController.text}₺',
        'status': selectedStatus,
      };
      widget.onUpdate(updatedProperty);
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
      appBar: AppBar(title: Text('İlanı Düzenle')),
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
              onPressed: _saveChanges,
              child: Text('Güncelle'),
            ),
          ],
        ),
      ),
    );
  }
}
