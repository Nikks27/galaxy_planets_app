class SolarModal {
  String position, name, image, velocity, distance, description, color,img;
  bool like;

  SolarModal(
      {required this.like,
        required this.position,
        required this.name,
        required this.image,
        required this.velocity,
        required this.distance,
        required this.description,
        required this.img,
        required this.color});

  factory SolarModal.fromJson(Map json) {
    return SolarModal(
      like: json['like'],
      position: json['position'],
      color: json['color'],
      name: json['name'],
      image: json['image'],
      velocity: json['velocity'],
      distance: json['distance'],
      img: json['img'],
      description: json['description'],
    );
  }
}
