import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../models/product_model.dart';
import 'detail_view.dart';
import 'cart_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final prodC = Get.find<ProductController>();
  final TextEditingController searchC = TextEditingController();
   
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    
    ever(prodC.products, (products) {
      setState(() {
        filteredProducts = products;
      });
    });
       
    filteredProducts = prodC.products;
  }
 
  void searchProduct(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProducts = prodC.products;
      } else {
        filteredProducts = prodC.products
            .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SHOPEDIA', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Get.to(() => const CartView()),
          ),
        ],
      ),
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: searchC,
                onChanged: searchProduct, 
                decoration: const InputDecoration(
                  hintText: 'Cari produk...',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
                   
          Expanded(
            child: Obx(() {
              if (prodC.isLoading.value) return const Center(child: CircularProgressIndicator(color: Colors.black));
              
              if (filteredProducts.isEmpty) {
                return const Center(child: Text('Produk tidak ditemukan', style: TextStyle(color: Colors.grey)));
              }

              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (_, i) {
                  final p = filteredProducts[i];
                  return GestureDetector(
                    onTap: () => Get.to(() => DetailView(productId: p.id)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Hero(
                              tag: 'product_${p.id}',
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Image.network(p.image, fit: BoxFit.contain),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, height: 1.2)),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('\$${p.price}', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15)),
                                    Row(
                                      children: [
                                        const Icon(Icons.star, color: Colors.black, size: 14),
                                        Text(' ${p.rating}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}