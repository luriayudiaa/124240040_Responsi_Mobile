import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import 'detail_view.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartC = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(title: const Text('KERANJANG', style: TextStyle(letterSpacing: 1.5))),
      body: Obx(() {
        if (cartC.cartItems.isEmpty) return const Center(child: Text('Keranjang Kosong', style: TextStyle(fontWeight: FontWeight.bold)));
        
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: cartC.cartItems.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) {
            final p = cartC.cartItems[i];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                onTap: () => Get.to(() => DetailView(productId: p.id)),
                leading: Container(
                  width: 50, height: 50,
                  padding: const EdgeInsets.all(4),
                  child: Image.network(p.image, fit: BoxFit.contain),
                ),
                title: Text(p.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                subtitle: Text('\$${p.price}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.black),
                  onPressed: () => cartC.removeFromCart(p.id),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}