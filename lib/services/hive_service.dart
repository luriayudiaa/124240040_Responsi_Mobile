import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String cartBoxName = 'cartBox';

  static Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isBoxOpen(cartBoxName)) {
      await Hive.openBox<Map>(cartBoxName);
    }
  }
}