import 'dart:convert'; // Mengimpor paket untuk melakukan konversi JSON
import 'package:flutter/foundation.dart'; // Mengimpor paket Flutter untuk debugging
import 'package:http/http.dart' as http; // Mengimpor paket HTTP untuk melakukan permintaan HTTP
import 'package:show_list/show.dart'; // Mengimpor kelas Show dari file show.dart

// Kelas ShowService untuk mengambil data show dari API
class ShowService {
  // Metode static untuk mengambil semua show dari API
  static Future<List<Show>> getAllShows() async {
    const baseUrl = 'https://api.tvmaze.com/shows'; // URL API untuk mendapatkan semua show
    final response = await http.get(Uri.parse(baseUrl)); // Melakukan permintaan GET ke API

    if (response.statusCode == 200) { // Memeriksa apakah permintaan berhasil
      List<dynamic> data = jsonDecode(response.body); // Menguraikan JSON dari respons API
      List<Show> shows = data.map((showsData) => Show.fromJson(showsData)).toList(); // Mengonversi setiap item data menjadi objek Show
      return shows; // Mengembalikan daftar objek Show
    } else {
      // Jika permintaan gagal, mencetak pesan kesalahan jika dalam mode debug
      if (kDebugMode) {
        print('Error: ${response.body}');
        print('Status Code: ${response.statusCode}');
      }
      // Melempar exception jika data tidak dapat diambil dari API
      throw Exception('Could not retrieve data from API');
    }
  }
}
