// ignore_for_file: deprecated_member_use, prefer_const_constructors, duplicate_ignore

import 'package:ecofood/controllers/midtrans_controller.dart';
import 'package:flutter/material.dart';
import 'package:ecofood/services/api_service.dart';
import 'package:ecofood/controllers/profile_controller.dart'; // Pastikan path ini benar
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String _userName = 'Loading...';

  // Instance ProfileController
  late final ProfileController _profileController;

  // List item makanan
  final List<Map<String, dynamic>> _foodItems = [
    {
      "name": "Veggie Burgers",
      "price": "Rp30.000",
      "image": "assets/images/bener2.jpg",
      "rating": 4.5,
    },
    {
      "name": "French Toast",
      "price": "Rp30.000",
      "image": "assets/images/bener2.jpg",
      "rating": 4.2,
    },
    {
      "name": "Salad",
      "price": "Rp25.000",
      "image": "assets/images/bener2.jpg",
      "rating": 4.7,
    },
    {
      "name": "Sandwich",
      "price": "Rp28.000",
      "image": "assets/images/bener2.jpg",
      "rating": 4.3,
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize ProfileController
    _profileController = ProfileController(apiService: ApiService());

    // Get user profile when the page loads
    _getUserProfile();
  }

  // Fungsi untuk mendapatkan profil pengguna
  Future<void> _getUserProfile() async {
    try {
      // Memanggil ProfileController untuk mendapatkan data profil
      String name = await _profileController.getProfilehome(context: context);

      // Memperbarui UI dengan nama pengguna
      setState(() {
        _userName = name; // Update nama pengguna
      });
    } catch (e) {
      setState(() {
        _userName = 'Failed to load profile'; // Menangani kesalahan
      });

      // Optional: Menampilkan log atau snackbar untuk kesalahan
      debugPrint('Error loading user profile: $e');
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: height * 0.25,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/bc_appbar.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.05,
                        top: height * 0.1,
                        right: width * 0.05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildUserGreeting(),
                          SizedBox(height: height * 0.05),
                          _buildSearchField(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(width * 0.05),
              child: Column(
                children: [
                  _buildImageCarousel(),
                  SizedBox(height: height * 0.02),
                  _buildPromotionButton(),
                  SizedBox(height: height * 0.03),
                  _buildFoodGrid(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer),
              label: 'Promo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              label: 'Transaksi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
          ],
          currentIndex: _currentPage,
          selectedItemColor: const Color(0XFF00712D),
          unselectedItemColor: Colors.black,
          onTap: _onItemTapped,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  // Menampilkan salam pengguna dengan nama yang diambil dari API
  Widget _buildUserGreeting() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, $_userName", // Menampilkan nama pengguna
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0XFF1C1C1C),
              ),
            ),
            SizedBox(height: 3),
            Text(
              "Selamat siang",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Color(0XFFFFFBE6),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed('/profile'); // Navigasi ke halaman profil
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black38,
                width: 2,
              ),
              image: const DecorationImage(
                image: AssetImage('assets/images/profile.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Field pencarian
  Widget _buildSearchField() {
    return Center(
      child: SizedBox(
        width:
            MediaQuery.of(context).size.width * 0.85, // Lebar lebih fleksibel
        height: MediaQuery.of(context).size.height *
            0.05, // Menyesuaikan tinggi berdasarkan tinggi layar
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Cari',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height *
                  0.01, // Padding lebih responsif
              horizontal: MediaQuery.of(context).size.width *
                  0.03, // Padding horizontal dinamis
            ),
          ),
        ),
      ),
    );
  }

  // Carousel gambar
  Widget _buildImageCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 150,
          width: double.infinity,
          child: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              _buildCarouselImage('assets/images/bener2.jpg'),
              _buildCarouselImage('assets/images/bener1.jpg'),
              _buildCarouselImage('assets/images/bener3.jpg'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _buildPageIndicator(),
      ],
    );
  }

  // Menampilkan gambar carousel
  Widget _buildCarouselImage(String imagePath) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }

  // Indikator halaman carousel
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage == index ? Colors.black : Colors.black54,
            ),
          );
        },
      ),
    );
  }

  // Tombol promo
  Widget _buildPromotionButton() {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0XFF00712D),
          foregroundColor: const Color(0XFFFFFBE6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                'Get up to IDR 12K off per transaction.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  // Grid item makanan
  Widget _buildFoodGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _foodItems.length,
      itemBuilder: (context, index) {
        return _buildFoodItem(_foodItems[index]);
      },
    );
  }

  // Menambahkan tombol bayar pada setiap item makanan di GridView
  Widget _buildFoodItem(Map<String, dynamic> foodItem) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.asset(
                foodItem['image'],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              foodItem['name'],
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              foodItem['price'],
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow,
                size: 20,
              ),
              Text(
                foodItem['rating'].toString(),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                ),
              ),
            ],
          ),
          // Tombol Bayar untuk melakukan transaksi
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                // Inisialisasi API Midtrans dengan harga item makanan yang dipilih
                double totalPrice = double.parse(
                    foodItem['price'].replaceAll('Rp', '').replaceAll('.', ''));
                String userName =
                    _userName; // Menggunakan nama pengguna yang sudah diambil
                String userEmail =
                    "email@example.com"; // Gantilah dengan email pengguna yang sebenarnya
                String userPhone =
                    "081234567890"; // Gantilah dengan nomor telepon pengguna yang sebenarnya

                // Menggunakan MidtransController untuk membuat transaksi
                MidtransController midtransController = MidtransController();
                try {
                  // Mengambil Snap Token dari Midtrans
                  String token = await midtransController.createTransaction(
                    totalPrice,
                    userName,
                    userEmail,
                    userPhone,
                  );

                  // Navigasi ke halaman pembayaran atau menampilkan Snap Token untuk proses pembayaran lebih lanjut
                  Get.toNamed('/payment', arguments: {'token': token});
                } catch (e) {
                  print('Terjadi kesalahan saat melakukan transaksi: $e');
                }
              },
              child: const Text('Bayar Sekarang'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Warna tombol bayar
                foregroundColor: Colors.white, // Warna teks tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
