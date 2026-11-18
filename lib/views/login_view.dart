import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailC = TextEditingController();
    final passC = TextEditingController();
    final auth = Get.find<AuthController>();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                child: const Icon(Icons.shopping_bag, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 24),
              const Text('Shopedia', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
              const SizedBox(height: 48),
              TextField(
                controller: emailC, 
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined),
                )
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passC, 
                obscureText: true, 
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline),
                )
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity, height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    final err = await auth.login(emailC.text, passC.text);
                    if (err != null) Get.snackbar('Gagal', err, backgroundColor: Colors.red, colorText: Colors.white);
                  },
                  child: const Text('LOGIN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}