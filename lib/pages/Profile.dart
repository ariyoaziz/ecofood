// ignore_for_file: file_names, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ecofood/controllers/profile_controller.dart'; // Import ProfileController
import 'package:ecofood/services/api_service.dart'; // Import ApiService
import 'package:shared_preferences/shared_preferences.dart'; // Untuk SharedPreferences

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late ProfileController _profileController;
  late Future<Map<String, String>> _profileData;

  @override
  void initState() {
    super.initState();
    // Inisialisasi ProfileController
    _profileController = ProfileController(apiService: ApiService());
    // Memanggil fungsi untuk mengambil data profil
    _profileData = _getProfileData();
  }

  // Fungsi untuk mendapatkan data profil
  Future<Map<String, String>> _getProfileData() async {
    try {
      // Mengambil data profil dengan ProfileController
      await _profileController.getProfileData(context: context);

      // Mengambil data dari SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String name = prefs.getString('user_name') ?? 'Guest User';
      String email = prefs.getString('user_email') ?? 'Tidak ada email';
      String phone = prefs.getString('user_phone') ?? 'Tidak ada nomor';

      return {'name': name, 'email': email, 'phone': phone};
    } catch (e) {
      debugPrint('Error fetching profile data: $e');
      return {'name': 'Error', 'email': 'Error', 'phone': 'Error'};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0XFF00712D),
        title: const Text(
          'Profile',
          style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black87,
              fontWeight: FontWeight.w500),
        ),
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, String>>(
        future: _profileData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Menampilkan loading indicator
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            // Menampilkan error jika ada
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return Center(child: Text('No profile data available'));
          }

          // Data profil berhasil dimuat
          var profile = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                // Bagian Header
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.05,
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Foto Profil
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
                      ),
                      const SizedBox(height: 16),

                      // Nama
                      Text(
                        profile['name']!,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),

                // Bagian Informasi Akun
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Informasi Akun',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Nama
                      _buildProfileInfo('Nama', profile['name']!),
                      const SizedBox(height: 16),

                      // Email
                      _buildProfileInfo('Email', profile['email']!),
                      const SizedBox(height: 16),

                      // Nomor HP
                      _buildProfileInfo('Nomor HP', profile['phone']!),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Bagian Pengaturan Akun
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pengaturan Akun',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Tombol Ubah Akun
                      _buildProfileOption(
                        context,
                        'Ubah Akun',
                        Icons.person_outline,
                        Colors.blue,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Navigasi ke halaman Ubah Akun')),
                          );
                        },
                      ),

                      // Tombol Ubah Password
                      _buildProfileOption(
                        context,
                        'Ubah Password',
                        Icons.lock_outline,
                        Colors.green,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Navigasi ke halaman Ubah Password')),
                          );
                        },
                      ),
                      const SizedBox(height: 16),

                      // Tombol Hapus Akun
                      _buildProfileOption(
                        context,
                        'Hapus Akun',
                        Icons.delete_outline,
                        Colors.red,
                        onTap: () {
                          _showDeleteAccountDialog(context);
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget Informasi Akun
  Widget _buildProfileInfo(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  // Widget Opsi Pengaturan
  Widget _buildProfileOption(
      BuildContext context, String title, IconData icon, Color color,
      {required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor: Colors.grey[200],
      leading: Icon(
        icon,
        color: color,
        size: 30,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.black45,
        size: 18,
      ),
    );
  }

  // Dialog Konfirmasi Hapus Akun
  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Hapus Akun',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text('Apakah Anda yakin ingin menghapus akun?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Akun berhasil dihapus')),
                );
                // Tambahkan logika untuk menghapus akun
              },
              child: const Text(
                'Hapus',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
