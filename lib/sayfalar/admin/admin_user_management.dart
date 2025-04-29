import 'package:flutter/material.dart';

class AdminUserManagementPage extends StatefulWidget {
  @override
  _AdminUserManagementPageState createState() => _AdminUserManagementPageState();
}

class _AdminUserManagementPageState extends State<AdminUserManagementPage> {
  final List<Map<String, String>> users = [
    {'name': 'Ali Yılmaz', 'email': 'ali@mail.com', 'role': 'Ev Sahibi', 'status': 'Aktif'},
    {'name': 'Ayşe Kaya', 'email': 'ayse@mail.com', 'role': 'Kiracı', 'status': 'Pasif'},
    {'name': 'Mehmet Demir', 'email': 'mehmet@mail.com', 'role': 'Admin', 'status': 'Aktif'},
    {'name': 'Zeynep Çelik', 'email': 'zeynep@mail.com', 'role': 'Ev Sahibi', 'status': 'Aktif'},
  ];

  List<Map<String, String>> filteredUsers = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredUsers = List.from(users);
    searchController.addListener(() => _filterUsers());
  }

  void _filterUsers() {
    setState(() {
      filteredUsers = users.where((user) {
        final searchTerm = searchController.text.toLowerCase();
        return user['name']!.toLowerCase().contains(searchTerm) ||
            user['email']!.toLowerCase().contains(searchTerm) ||
            user['role']!.toLowerCase().contains(searchTerm);
      }).toList();
    });
  }

  void _deleteUser(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Kullanıcıyı Sil'),
          content: Text('Bu kullanıcıyı silmek istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('İptal', style: TextStyle(color: Colors.redAccent)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  users.removeAt(index);
                  _filterUsers();
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

  Color _getStatusColor(String status) {
    return status == 'Aktif' ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kullanıcı Yönetimi'), backgroundColor: Colors.blueAccent),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Kullanıcı Ara',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];

                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user['name']!,
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                SizedBox(height: 5),
                                Text('📧 ${user['email']}',
                                    style: TextStyle(color: Colors.grey[600])),
                                Text('🎭 Rol: ${user['role']}',
                                    style: TextStyle(color: Colors.grey[600])),
                                SizedBox(height: 5),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(user['status']!).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    user['status']!,
                                    style: TextStyle(
                                        color: _getStatusColor(user['status']!),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.orange),
                                onPressed: () => _showEditDialog(index),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteUser(index),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEditDialog(null),
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showEditDialog(int? index) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    String selectedRole = 'Kiracı';

    if (index != null) {
      final user = filteredUsers[index];
      nameController.text = user['name']!;
      emailController.text = user['email']!;
      selectedRole = user['role']!;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(index == null ? 'Kullanıcı Ekle' : 'Kullanıcı Düzenle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
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
              DropdownButtonFormField(
                value: selectedRole,
                items: ['Kiracı', 'Ev Sahibi'].map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRole = value.toString();
                  });
                },
                decoration: InputDecoration(labelText: 'Rol', border: OutlineInputBorder()),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('İptal', style: TextStyle(color: Colors.redAccent)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (index == null) {
                    users.add({'name': nameController.text, 'email': emailController.text, 'role': selectedRole, 'status': 'Aktif'});
                  } else {
                    users[index] = {'name': nameController.text, 'email': emailController.text, 'role': selectedRole, 'status': users[index]['status']!};
                  }
                  _filterUsers();
                });
                Navigator.of(context).pop();
              },
              child: Text(index == null ? 'Ekle' : 'Güncelle'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
            ),
          ],
        );
      },
    );
  }
}
