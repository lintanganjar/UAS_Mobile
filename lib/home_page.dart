import 'package:flutter/material.dart'; // Mengimpor paket Flutter untuk material design
import 'package:show_list/show.dart'; // Mengimpor kelas Show dari file show.dart
import 'package:show_list/show_service.dart'; // Mengimpor layanan ShowService dari file show_service.dart

import 'detail_page.dart'; // Mengimpor halaman DetailPage dari file detail_page.dart

// Kelas HomePage yang merupakan StatefulWidget untuk menampilkan daftar show
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// State dari HomePage yang bertanggung jawab untuk menampilkan dan mengelola state dari HomePage
class _HomePageState extends State<HomePage> {

  @override
  void initState(){
    // Memanggil metode getAllShows() dari ShowService saat inisialisasi state
    ShowService.getAllShows();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appBarTitleStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);
    final orientation = MediaQuery.of(context).orientation; // Mendapatkan orientasi layar
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Show List", style: appBarTitleStyle),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: ShowService.getAllShows(), // Mengambil data show dari ShowService
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Menampilkan indikator loading saat data sedang diambil
          }
          if (snapshot.data != null) {
            final shows = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(6),
                  sliver: SliverGrid.count(
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 4, // Mengatur jumlah kolom berdasarkan orientasi layar
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    childAspectRatio: 0.75,
                    children: List.generate(shows.length, (index) {
                      return ItemShow(show: shows[index]); // Membuat widget ItemShow untuk setiap show dalam data
                    }),
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Text(
              snapshot.error.toString(), // Menampilkan pesan error jika terjadi kesalahan
            ),
          );
        },
      ),
    );
  }
}

// Kelas ItemShow yang merupakan StatelessWidget untuk menampilkan informasi singkat tentang sebuah show
class ItemShow extends StatelessWidget {
  const ItemShow({super.key, required this.show});

  final Show show;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; // Mendapatkan ukuran layar
    var orientation = MediaQuery.of(context).orientation; // Mendapatkan orientasi layar
    var nameStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16);
    var genreStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 12);
    
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0) // Mengatur sudut border card menjadi melingkar
      ),
      child: InkWell(
        onTap: () {
          // Navigasi ke halaman DetailPage saat card ditekan
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailPage(show: show)));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0), // Mengatur sudut border gambar menjadi melingkar
          child: Stack(
            children: [
              SizedBox(
                width: size.width,
                height: size.height,
                child: Image.network(
                  show.image.image, // Menampilkan gambar show dari URL
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: orientation == Orientation.portrait ? size.width / 2.1 : size.width / 4.2,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.5) // Mengatur warna latar belakang dengan opasitas 50%
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 4),
                          child: Text(show.name, style: nameStyle), // Menampilkan nama show
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(show.genres.join(', '), style: genreStyle), // Menampilkan genre show
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
