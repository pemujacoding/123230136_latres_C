import 'package:get/get.dart';
import '../services/hive_service.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;
  var detailQty = 1.obs; // State qty temporer di Halaman Detail

  void loadCart(String username) {
    cartItems.value = HiveService.getCartByUser(username);
  }

  void incrementQty(int maxStock) {
    if (detailQty.value < maxStock) {
      detailQty.value++;
    }
  }

  void decrementQty() {
    if (detailQty.value > 1) {
      detailQty.value--;
    }
  }

  void addItemToCart({
    required String username,
    required int productId,
    required String title,
    required double price,
    required String thumbnail,
  }) async {
    await HiveService.addToCart(
      username: username,
      productId: productId,
      title: title,
      price: price,
      thumbnail: thumbnail,
      qty: detailQty.value,
    );
    loadCart(username);
    Get.snackbar("Sukses", "Produk dimasukkan ke keranjang!");
  }

  void removeFromCart(String username, int productId) async {
    await HiveService.deleteCartItem(username, productId);
    loadCart(username);
    Get.snackbar("Terhapus", "Produk dihapus dari keranjang!");
  }
}
