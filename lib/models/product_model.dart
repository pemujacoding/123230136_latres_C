class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final int stock;
  final String thumbnail;
  final String category;
  final String brand; // Tetap String, tapi kita beri default value jika null

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.stock,
    required this.thumbnail,
    required this.category,
    required this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      // Amankan double casting untuk price dan rating
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rating:
          (json['rating'] as num?)?.toDouble() ??
          0.0, // <-- Diperbaiki dari json['price'] ke json['rating']
      stock: json['stock'] ?? 0,
      thumbnail: json['thumbnail'] ?? '',
      category: json['category'] ?? '',
      // SOLUSI UTAMA: Jika brand bernilai null di API, ubah jadi teks kosongi atau 'No Brand'
      brand: json['brand'] ?? 'No Brand',
    );
  }
}
