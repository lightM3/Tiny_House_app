import 'package:flutter/material.dart';

class AdminPaymentManagementPage extends StatefulWidget {
  @override
  _AdminPaymentManagementPageState createState() => _AdminPaymentManagementPageState();
}

class _AdminPaymentManagementPageState extends State<AdminPaymentManagementPage> {
  List<Map<String, dynamic>> payments = [
    {'user': 'Ali Yılmaz', 'amount': '₺1500', 'date': '10 Mayıs 2024', 'status': 'Tamamlandı', 'method': 'Kredi Kartı'},
    {'user': 'Ayşe Kaya', 'amount': '₺1200', 'date': '15 Haziran 2024', 'status': 'Beklemede', 'method': 'Banka Havalesi'},
    {'user': 'Mehmet Demir', 'amount': '₺1800', 'date': '5 Temmuz 2024', 'status': 'İptal Edildi', 'method': 'PayPal'},
  ];

  List<Map<String, dynamic>> filteredPayments = [];
  final TextEditingController searchController = TextEditingController();
  String selectedStatus = 'Tümü';

  final List<String> statusOptions = ['Tümü', 'Tamamlandı', 'Beklemede', 'İptal Edildi'];

  @override
  void initState() {
    super.initState();
    filteredPayments = List.from(payments);
    searchController.addListener(_filterPayments);
  }

  void _filterPayments() {
    setState(() {
      filteredPayments = payments.where((payment) {
        final searchTerm = searchController.text.toLowerCase();
        final matchesSearch = payment['user']!.toLowerCase().contains(searchTerm);
        final matchesStatus = selectedStatus == 'Tümü' || payment['status'] == selectedStatus;
        return matchesSearch && matchesStatus;
      }).toList();
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Tamamlandı':
        return Colors.green;
      case 'Beklemede':
        return Colors.orange;
      case 'İptal Edildi':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ödeme Yönetimi'), backgroundColor: Colors.blueAccent),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Finansal Durum',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            SizedBox(height: 10),

            // 📌 Finansal Özet
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Toplam Gelir: ₺4500',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Bekleyen Ödemeler: ₺1200',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // 📌 Arama Kutusu
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Kullanıcı Ara',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),

            // 📌 Durum Filtresi
            DropdownButtonFormField(
              value: selectedStatus,
              items: statusOptions.map((status) {
                return DropdownMenuItem(value: status, child: Text(status));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedStatus = value.toString();
                  _filterPayments();
                });
              },
              decoration: InputDecoration(labelText: 'Ödeme Durumu', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),

            // 📌 Ödeme Geçmişi Listesi
            Expanded(
              child: ListView.builder(
                itemCount: filteredPayments.length,
                itemBuilder: (context, index) {
                  final payment = filteredPayments[index];

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
                            '${payment['user']}',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text('💰 Tutar: ${payment['amount']}'),
                          Text('📅 Tarih: ${payment['date']}'),
                          Text('💳 Ödeme Yöntemi: ${payment['method']}'),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text('🔵 Durum: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(payment['status']).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  payment['status'],
                                  style: TextStyle(
                                      color: _getStatusColor(payment['status']),
                                      fontWeight: FontWeight.bold),
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
    );
  }
}
