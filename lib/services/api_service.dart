import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String url = 'https://dummyjson.com/products';

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List list = data['products'];
      return list.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil data produk');
    }
  }
}
