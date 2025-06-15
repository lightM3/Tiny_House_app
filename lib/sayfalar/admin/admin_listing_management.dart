import 'package:flutter/material.dart';

class AdminListingManagementPage extends StatefulWidget {
  @override
  _AdminListingManagementPageState createState() =>
      _AdminListingManagementPageState();
}

class _AdminListingManagementPageState
    extends State<AdminListingManagementPage> {
  List<Map<String, dynamic>> listings = [
    {
      'title': 'Orman İçinde Manzaralı Tiny House',
      'location': 'Muğla',
      'price': '₺750',
      'status': 'Aktif',
    },
    {
      'title': 'Göl Kenarında Sessiz Tiny House',
      'location': 'Muğla',
      'price': '₺800',
      'status': 'Aktif',
    },
    {
      'title': 'Modern Tasarımlı Tiny House',
      'location': 'Bodrum',
      'price': '₺900',
      'status': 'Pasif',
    },
    {
      'title': 'Plaja 100 Metre Mesafede Tiny House',
      'location': 'Bodrum',
      'price': '₺950',
      'status': 'Pasif',
    },
    {
      'title': 'Minimalist Doğa Evi',
      'location': 'Fethiye',
      'price': '₺700',
      'status': 'Pasif',
    },
    {
      'title': 'Kamp Alanına Yakın Konumda',
      'location': 'Fethitye',
      'price': '₺720',
      'status': 'Aktif',
    },
  ];

  void _addOrEditListing({int? index}) {
    TextEditingController titleController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    String selectedStatus = 'Aktif';

    if (index != null) {
      final listing = listings[index];
      titleController.text = listing['title'];
      locationController.text = listing['location'];
      priceController.text = listing['price'].replaceAll('₺', '');
      selectedStatus = listing['status'];
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(index == null ? 'Yeni İlan Ekle' : 'İlanı Düzenle'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Ev Adı',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: 'Konum',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Fiyat',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField(
                  value: selectedStatus,
                  items:
                      ['Aktif', 'Pasif'].map((status) {
                        return DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                  onChanged: (value) {
                    selectedStatus = value.toString();
                  },
                  decoration: InputDecoration(
                    labelText: 'Durum',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('İptal', style: TextStyle(color: Colors.redAccent)),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    locationController.text.isNotEmpty &&
                    priceController.text.isNotEmpty) {
                  setState(() {
                    if (index == null) {
                      listings.add({
                        'title': titleController.text,
                        'location': locationController.text,
                        'price': '₺${priceController.text}',
                        'status': selectedStatus,
                      });
                    } else {
                      listings[index] = {
                        'title': titleController.text,
                        'location': locationController.text,
                        'price': '₺${priceController.text}',
                        'status': selectedStatus,
                      };
                    }
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text(index == null ? 'Ekle' : 'Güncelle'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteListing(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('İlanı Sil'),
          content: Text('Bu ilanı silmek istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('İptal', style: TextStyle(color: Colors.redAccent)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  listings.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Sil'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İlan Yönetimi'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: listings.length,
          itemBuilder: (context, index) {
            final listing = listings[index];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listing['title'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('📍 Konum: ${listing['location']}'),
                    Text('💰 Fiyat: ${listing['price']}'),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '🔵 Durum: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color:
                                listing['status'] == 'Aktif'
                                    ? Colors.green.withOpacity(0.2)
                                    : Colors.red.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            listing['status'],
                            style: TextStyle(
                              color:
                                  listing['status'] == 'Aktif'
                                      ? Colors.green
                                      : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () => _addOrEditListing(index: index),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          child: Text(
                            'Düzenle',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _deleteListing(index),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Text(
                            'Sil',
                            style: TextStyle(color: Colors.white),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditListing(),
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}
