import 'package:flutter/material.dart';
import 'reservation_detail_page.dart';

class AdminReservationManagementPage extends StatefulWidget {
  @override
  _AdminReservationManagementPageState createState() =>
      _AdminReservationManagementPageState();
}

class _AdminReservationManagementPageState
    extends State<AdminReservationManagementPage> {
  List<Map<String, String>> reservations = [
    {
      'user': 'tenant1',
      'house': 'Orman Içinde Manzaralı Tiny House',
      'date': '01-05 Haziran',
      'status': 'Bekleniyor',
      'payment': 'Ödendi',
    },
    {
      'user': 'tenant1',
      'house': 'Göl Kenarında Sessiz Tiny House',
      'date': '07 Ekim - 07 Aralık',
      'status': 'İptal Edildi',
      'payment': 'Bekleniyor',
    },
    {
      'user': 'tenant2',
      'house': 'Minimalist Doğa Evi',
      'date': '5-12 Temmuz',
      'status': 'Onaylandı',
      'payment': 'Ödendi',
    },
    {
      'user': 'tenant3',
      'house': 'Orman Içinde Manzaralı Tiny House',
      'date': '23-30 Eylül',
      'status': 'Bekleniyor',
      'payment': 'Ödendi',
    },
    {
      'user': 'tenant1',
      'house': 'Plaja 100 metre mesafede ev',
      'date': '12-18 Temmuz',
      'status': 'Bekleniyor',
      'payment': 'Bekleniyor',
    },
    {
      'user': 'tenant2',
      'house': 'Minimalist Doğa Evi',
      'date': '18-21 Kasım',
      'status': 'Onaylandı',
      'payment': 'Ödendi',
    },
  ];

  List<Map<String, String>> filteredReservations = [];
  final TextEditingController searchController = TextEditingController();
  String selectedStatus = 'Tümü';

  final List<String> statusOptions = [
    'Tümü',
    'Onaylandı',
    'Beklemede',
    'İptal Edildi',
  ];

  @override
  void initState() {
    super.initState();
    filteredReservations = List.from(reservations);
    searchController.addListener(_filterReservations);
  }

  void _filterReservations() {
    setState(() {
      filteredReservations =
          reservations.where((reservation) {
            final searchTerm = searchController.text.toLowerCase();
            final matchesSearch =
                reservation['user']!.toLowerCase().contains(searchTerm) ||
                reservation['house']!.toLowerCase().contains(searchTerm);
            final matchesStatus =
                selectedStatus == 'Tümü' ||
                reservation['status'] == selectedStatus;
            return matchesSearch && matchesStatus;
          }).toList();
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Onaylandı':
        return Colors.green;
      case 'Beklemede':
        return Colors.orange;
      case 'İptal Edildi':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // ignore: unused_element
  void _updateStatus(int index, String newStatus) {
    setState(() {
      reservations[index]['status'] = newStatus;
      _filterReservations();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Rezervasyon $newStatus olarak güncellendi!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rezervasyon Yönetimi'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Arama Kutusu
            _buildSearchBox(),

            SizedBox(height: 15),

            // Durum Filtresi
            _buildStatusFilter(),

            SizedBox(height: 20),

            // Rezervasyon Kartları
            Expanded(
              child: ListView.builder(
                itemCount: filteredReservations.length,
                itemBuilder: (context, index) {
                  final reservation = filteredReservations[index];
                  return _buildReservationCard(reservation, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 📌 Arama Kutusu
  Widget _buildSearchBox() {
    return Container(
      decoration: _boxDecoration(),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Kullanıcı veya Ev Ara',
          prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }

  // 📌 Durum Filtresi
  Widget _buildStatusFilter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: _boxDecoration(),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedStatus,
          icon: Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
          items:
              statusOptions.map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedStatus = newValue!;
              _filterReservations();
            });
          },
        ),
      ),
    );
  }

  // 📌 Rezervasyon Kartı
  Widget _buildReservationCard(Map<String, String> reservation, int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${reservation['user']} - ${reservation['house']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text('📅 Tarih: ${reservation['date']}'),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusLabel(reservation['status']!),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
                  onPressed: () async {
                    final updatedReservation = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                ReservationDetailPage(reservation: reservation),
                      ),
                    );
                    if (updatedReservation != null) {
                      setState(() {
                        reservations[index] = updatedReservation;
                        _filterReservations();
                      });
                    }
                  },
                ),
              ],
            ),
            //if (reservation['status'] == 'Beklemede') _buildActionButtons(index),
          ],
        ),
      ),
    );
  }

  // 📌 Durum Etiketi
  Widget _buildStatusLabel(String status) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: _getStatusColor(status),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /*
  // 📌 Onayla/Reddet Butonları (Sadece "Beklemede" olanlar için)
  Widget _buildActionButtons(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => _updateStatus(index, 'Onaylandı'),
          style: TextButton.styleFrom(foregroundColor: Colors.green),
          child: Text('Onayla'),
        ),
        TextButton(
          onPressed: () => _updateStatus(index, 'İptal Edildi'),
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: Text('Reddet'),
        ),
      ],
    );
  }*/

  // 📌 Kutu Gölgelendirme (Arama ve Filtre Kutuları İçin)
  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
    );
  }
}
