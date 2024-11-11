import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_16_cart_ui/model/shop_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class CartController with ChangeNotifier {
  late Database database;
  List selectedProductList = [];

  Future<void> initDb() async {
    print('db initialized');
    if (kIsWeb) {
      // Change default factory on the web
      databaseFactory = databaseFactoryFfiWeb;
    }
    database = await openDatabase('cart.db', version: 2,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Cart (id INTEGER PRIMARY KEY, name TEXT, qty INTEGER, image TEXT )');
      print('Db Created');
    });
  }

  Future addProduct(ShopModel selectedProduct) async {
    print('Entered addproduct');
    await database.rawInsert('INSERT INTO Cart(name, qty, image) VALUES(?,?,?)',
        [selectedProduct.title, 1, selectedProduct.image]);
    await getProduct();
  }

  Future getProduct() async {
    selectedProductList = await database.rawQuery('SELECT * FROM Cart');
    log(selectedProductList.toString());
    notifyListeners();
  }

  Future removeProduct(int productId) async {
    await database.rawDelete('DELETE FROM Cart WHERE id = ?', [productId]);
    await getProduct();
  }

  incrementQty() {}

  decrementQty() {}
}
