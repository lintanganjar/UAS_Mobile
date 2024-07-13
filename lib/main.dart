import 'package:flutter/material.dart';
import 'package:show_list/home_page.dart'; // Mengimpor halaman HomePage dari file home_page.dart

void main() {
  runApp(const MyApp());// Fungsi utama yang menjalankan aplikasi dengan widget MyApp sebagai root
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData( // Mengatur tema aplikasi
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),// Mengatur skema warna dengan seed color biru
        useMaterial3: true,// Menggunakan desain material versi 3
      ),
      home: HomePage(), // Mengatur halaman utama aplikasi ke HomePage
    );
  }
}
