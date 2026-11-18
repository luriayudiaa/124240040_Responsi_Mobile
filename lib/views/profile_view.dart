import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/cart_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final cartC = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(title: const Text('PROFIL', style: TextStyle(letterSpacing: 1.5))),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 2)),
                child: const CircleAvatar(radius: 50, backgroundColor: Colors.white, child: Icon(Icons.person, size: 60, color: Colors.black)),
              ),
              const SizedBox(height: 24),
              Obx(() => Text(auth.email.value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900))),
              const SizedBox(height: 8),
              Obx(() => Text('Keranjang: ${cartC.cartItems.length} Barang', style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity, height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black, width: 2),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => auth.logout(),
                  child: const Text('LOGOUT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}