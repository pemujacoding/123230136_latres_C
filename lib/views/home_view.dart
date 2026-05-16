import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/product_controller.dart';
import 'detail_view.dart';
import 'cart_view.dart';

class HomeView extends StatelessWidget {
  final AuthController authCtrl = Get.find<AuthController>();
  final ProductController productCtrl = Get.put(ProductController());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. MODIFIKASI APP BAR: Blue Accent dengan Konten Putih
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 2,
        title: Obx(
          () => Text(
            'Halo, ${authCtrl.currentUsername.value}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // Memutihkan tombol bawaan appbar jika ada
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_rounded,
              color: Colors.white,
            ), // Ikon Keranjang Putih
            onPressed: () => Get.to(() => CartView()),
          ),
        ],
      ),

      // 2. MODIFIKASI BODY & LIST PRODUK
      body: Obx(() {
        if (productCtrl.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.blueAccent,
              ), // Loading biru
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          itemCount: productCtrl.productList.length,
          itemBuilder: (context, index) {
            final product = productCtrl.productList[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  15,
                ), // Membuat sudut card melengkung modern
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                // Efek warna highlight Blue Accent saat item list di-klik/select
                splashColor: Colors.blueAccent.withOpacity(0.1),
                highlightColor: Colors.blueAccent.withOpacity(0.05),
                onTap: () => Get.to(() => DetailView(product: product)),

                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      // Sesi Gambar Produk melengkung rapi
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          product.thumbnail,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey.shade200,
                            child: const Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Sesi Informasi Teks Produk
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product.category.toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Harga dengan aksen warna Blue Accent
                                Text(
                                  '\$${product.price}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                // Badge informasi sisa stok kecil di pojok kanan bawah
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Stok: ${product.stock}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
