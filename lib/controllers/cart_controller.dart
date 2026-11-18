import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/product_model.dart';
import '../services/hive_service.dart';

class CartController extends GetxController {
  Box<Map> get _box => Hive.box<Map>(HiveService.cartBoxName);
  var cartItems = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void loadCart() {
    cartItems.assignAll(_box.values.map((map) => Product.fromJson(Map<String, dynamic>.from(map))).toList());
  }

  bool isInCart(int id) => cartItems.any((e) => e.id == id);

  Future<void> addToCart(Product product) async {
    if (!isInCart(product.id)) {
      await _box.add({
        'id': product.id,
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'category': product.category,
        'image': product.image,
        'rating': {'rate': product.rating, 'count': product.ratingCount},
      });
      loadCart();
      Get.snackbar('Sukses', 'Masuk ke keranjang', backgroundColor: Colors.black, colorText: Colors.white);
    }
  }

  Future<void> removeFromCart(int id) async {
    final index = _box.values.toList().indexWhere((map) => map['id'] == id);
    if (index != -1) {
      await _box.deleteAt(index);
      loadCart();
    }
  }
}