import 'package:flutter/material.dart';
import 'host_add_property.dart';
import 'host_edit_property.dart';

class HostPropertyManagementPage extends StatefulWidget {
  @override
  _HostPropertyManagementPageState createState() =>
      _HostPropertyManagementPageState();
}

class _HostPropertyManagementPageState
    extends State<HostPropertyManagementPage> {
  List<Map<String, String>> properties = [
    {
      'title': 'Orman İçinde Manzaralı Tiny House',
      'status': 'Aktif',
      'price': '₺750',
    },
    {
      'title': 'Göl Kenarında Sessiz Tiny House',
      'status': 'Aktif',
      'price': '₺800',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İlan Yönetimi'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'İlanlarım',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: properties.length,
                itemBuilder: (context, index) {
                  final property = properties[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            property['title']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '💰 Fiyat: ${property['price']}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '📌 Durum: ${property['status']}',
                            style: TextStyle(
                              color:
                                  property['status'] == 'Aktif'
                                      ? Colors.green
                                      : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => HostEditPropertyPage(
                                            property: properties[index],
                                            onUpdate: (updatedProperty) {
                                              setState(() {
                                                properties[index] =
                                                    updatedProperty;
                                              });
                                            },
                                          ),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.edit, color: Colors.white),
                                label: Text('Düzenle'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _deleteProperty(index);
                                },
                                icon: Icon(Icons.delete, color: Colors.white),
                                label: Text('Sil'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => HostAddPropertyPage(
                    onPropertyAdded: (newProperty) {
                      setState(() {
                        properties.add(newProperty);
                      });
                    },
                  ),
            ),
          );
        },
        backgroundColor: Colors.blueAccent,
        icon: Icon(Icons.add),
        label: Text("Yeni İlan Ekle"),
      ),
    );
  }

  void _deleteProperty(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("İlanı Sil"),
          content: Text("Bu ilanı silmek istediğinize emin misiniz?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Hayır"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  properties.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text("Evet"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
            ),
          ],
        );
      },
    );
  }
}
