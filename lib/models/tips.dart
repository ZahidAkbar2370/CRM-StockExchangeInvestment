class Tips {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Map<String, dynamic> rating;

  Tips({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Tips.fromJson(Map<String, dynamic> json) {
    return Tips(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: json['rating'],
    );
  }
}
