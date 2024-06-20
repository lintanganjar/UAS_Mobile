class Show {
  final int id;
  final String name;
  final String desc;
  final List<String> genres;
  final Images image;

  const Show({required this.id,
    required this.name,
    required this.desc,
    required this.genres,
    required this.image});

  factory Show.fromJson(Map<String, dynamic> json){
    return Show(id: json['id'],
        name: json['name'],
        desc: json['summary'],
        genres: List<String>.from(json['genres']),
        image: Images.fromJson(json['image']));
  }
}

class Images {
  final String image;

  const Images({
    required this.image,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(image: json['medium']);
  }
}
