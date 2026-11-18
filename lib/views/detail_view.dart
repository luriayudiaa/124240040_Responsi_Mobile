import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';
import 'cart_view.dart';

class DetailView extends StatefulWidget {
  final int productId;
  const DetailView({super.key, required this.productId});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  Product? product;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDetail();
  }

  Future<void> fetchDetail() async {
    try {
      product = await ApiService().fetchDetail(widget.productId);
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartC = Get.find<CartController>();

    if (isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator(color: Colors.black)));
    if (product == null) return const Scaffold(body: Center(child: Text('Error')));

    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAIL PRODUK', style: TextStyle(fontSize: 16, letterSpacing: 1.5)),
        actions: [
          IconButton(icon: const Icon(Icons.shopping_cart_outlined), onPressed: () => Get.to(() => const CartView())),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Container(
              width: double.infinity,
              height: 300,
              color: Colors.grey.shade100,
              padding: const EdgeInsets.all(24),
              child: Hero(
                tag: 'product_${product!.id}',
                child: Image.network(product!.image, fit: BoxFit.contain),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product!.category.toUpperCase(), style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  const SizedBox(height: 8),
                  Text(product!.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, height: 1.2)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text('\$${product!.price}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.white, size: 16),
                            const SizedBox(width: 4),
                            Text('${product!.rating} (${product!.ratingCount})', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Divider(height: 48, thickness: 1),
                  const Text('Deskripsi Produk', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(product!.description, style: const TextStyle(color: Colors.black54, height: 1.6)),
                  const SizedBox(height: 48),
                  
                  
                  Obx(() {
                    final isInCart = cartC.isInCart(product!.id);
                    return SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isInCart ? Colors.grey.shade300 : Colors.black,
                          foregroundColor: isInCart ? Colors.black54 : Colors.white,
                        ),
                        onPressed: isInCart ? null : () => cartC.addToCart(product!),
                        child: Text(
                          isInCart ? 'SUDAH DI KERANJANG' : 'TAMBAH KE KERANJANG',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}