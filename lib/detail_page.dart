import 'package:flutter/cupertino.dart'; // Mengimpor paket Flutter untuk cupertino (iOS) widgets
import 'package:flutter/material.dart'; // Mengimpor paket Flutter untuk material design
import 'package:show_list/show.dart'; // Mengimpor file show.dart yang mungkin berisi kelas Show

// Kelas DetailPage yang merupakan StatelessWidget untuk menampilkan detail dari sebuah show
class DetailPage extends StatelessWidget {
  // Konstruktor DetailPage dengan parameter show yang wajib diisi
  const DetailPage({super.key, required this.show});

  // Properti final untuk menyimpan data show
  final Show show;

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar
    var size = MediaQuery.of(context).size;
    // Mengatur gaya teks untuk judul AppBar
    var appBarTitleStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);
    
    // Mengembalikan Scaffold yang merupakan struktur dasar dari halaman
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Mengatur warna latar belakang AppBar
        foregroundColor: Colors.white, // Mengatur warna teks dan ikon di AppBar
        centerTitle: true, // Mengatur judul berada di tengah
        title: Text(
          "Detail Show", style: appBarTitleStyle, // Mengatur teks judul AppBar
        ),
      ),
      body: SingleChildScrollView(
        // SingleChildScrollView memungkinkan halaman untuk di-scroll jika konten melebihi layar
        child: Column(
          children: [
            Container(
              color: Colors.black.withOpacity(0.1), // Mengatur warna latar belakang dengan opasitas 10%
              child: Align(
                alignment: Alignment.center, // Menyelaraskan konten ke tengah
                child: SizedBox(
                  width: size.width / 1.8, // Mengatur lebar gambar
                  child: Image.network(
                    show.image.image, // Menampilkan gambar dari URL
                    fit: BoxFit.cover, // Menyesuaikan gambar dengan kontainer
                  ),
                ),
              ),
            ),
            SizedBox(
              width: size.width, // Mengatur lebar kontainer sesuai lebar layar
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blue // Mengatur warna latar belakang kontainer
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0), // Mengatur padding di dalam kontainer
                  child: Text(
                    show.name, // Menampilkan nama show
                    textAlign: TextAlign.center, // Menyelaraskan teks di tengah
                    style: const TextStyle(
                      color: Colors.white, // Mengatur warna teks
                      fontSize: 18, // Mengatur ukuran teks
                      fontWeight: FontWeight.bold), // Mengatur ketebalan teks
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 10, right: 10), // Mengatur padding di sekitar teks deskripsi
              child: Text(
                removeTags(show.desc), // Menghapus tag HTML dari deskripsi dan menampilkannya
                textAlign: TextAlign.justify, // Menyelaraskan teks deskripsi
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menghapus tag HTML dari teks deskripsi
  String removeTags(String text) {
    final regex = RegExp(r'<[^>]*>', multiLine: true); // Membuat regex untuk mencocokkan tag HTML
    final cleanText = text.replaceAll(regex, ''); // Mengganti semua tag HTML dengan string kosong
    return cleanText; // Mengembalikan teks yang sudah bersih dari tag HTML
  }
}
