// Definisi kelas Show yang merepresentasikan sebuah acara/show
class Show {
  // Properti kelas Show
  final int id; // ID unik dari show
  final String name; // Nama dari show
  final String desc; // Deskripsi dari show
  final List<String> genres; // Daftar genre dari show
  final Images image; // Gambar dari show

  // Konstruktor konstan untuk kelas Show
  const Show({
    required this.id,
    required this.name,
    required this.desc,
    required this.genres,
    required this.image
  });

  // Factory constructor untuk membuat objek Show dari JSON
  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'], // Mendapatkan ID dari JSON
      name: json['name'], // Mendapatkan nama dari JSON
      desc: json['summary'], // Mendapatkan deskripsi dari JSON
      genres: List<String>.from(json['genres']), // Mengonversi genre menjadi List<String>
      image: Images.fromJson(json['image']) // Membuat objek Images dari JSON
    );
  }
}

// Definisi kelas Images yang merepresentasikan gambar dari sebuah show
class Images {
  // Properti kelas Images
  final String image; // URL gambar dengan ukuran medium

  // Konstruktor konstan untuk kelas Images
  const Images({
    required this.image,
  });

  // Factory constructor untuk membuat objek Images dari JSON
  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      image: json['medium'] // Mendapatkan URL gambar dari JSON
    );
  }
}
