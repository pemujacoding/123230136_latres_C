import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String boxName = 'cartBox';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  static Box getBox() {
    return Hive.box(boxName);
  }

  // Menyimpan item cart unik berdasarkan gabungan username dan id produk
  static Future<void> addToCart({
    required String username,
    required int productId,
    required String title,
    required double price,
    required String thumbnail,
    required int qty,
  }) async {
    var box = getBox();
    String key = '${username}_$productId';

    Map<String, dynamic> cartItem = {
      'username': username,
      'productId': productId,
      'title': title,
      'price': price,
      'thumbnail': thumbnail,
      'qty': qty,
    };

    await box.put(key, cartItem);
  }

  // Mengambil item keranjang khusus user yang sedang login
  static List<Map<String, dynamic>> getCartByUser(String username) {
    var box = getBox();
    List<Map<String, dynamic>> userCart = [];

    for (var key in box.keys) {
      if (key.toString().startsWith('${username}_')) {
        var item = box.get(key);
        if (item != null) {
          userCart.add(Map<String, dynamic>.from(item));
        }
      }
    }
    return userCart;
  }

  static Future<void> deleteCartItem(String username, int productId) async {
    var box = getBox();
    await box.delete('${username}_$productId');
  }
}
