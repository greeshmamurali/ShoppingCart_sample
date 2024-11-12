import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_16_cart_ui/model/shop_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class CartController with ChangeNotifier {
  late Database database;
  List selectedProductList = [];
  double totalCartValue = 0.00;

  Future<void> initDb() async {
    print('db initialized');
    if (kIsWeb) {
      // Change default factory on the web
      databaseFactory = databaseFactoryFfiWeb;
    }
    database = await openDatabase('cart3.db', version: 2,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Cart (id INTEGER PRIMARY KEY, name TEXT, qty INTEGER, image TEXT,productid INTEGER, price REAL )');
      print('Db Created');
    });
  }

  Future addProduct(ShopModel selectedProduct) async {
    print('Entered addproduct');

    await getProduct(); //bcoz after restaring selectedProductList is empty (My own)

    bool alreadyInCart = selectedProductList.any(
      (element) => selectedProduct.id == element['productid'],
    );
    // print(alreadyInCart);
    if (!alreadyInCart) {
      await database.rawInsert(
          'INSERT INTO Cart(name, qty, image,price,productid) VALUES(?,?,?,?,?)',
          [
            selectedProduct.title,
            1,
            selectedProduct.image,
            selectedProduct.price,
            selectedProduct.id
          ]);
      await getProduct();
    }
  }

  Future getProduct() async {
    selectedProductList = await database.rawQuery('SELECT * FROM Cart');
    log(selectedProductList.toString());
    calculateAmount();
    notifyListeners();
  }

  Future removeProduct(int productId) async {
    await database.rawDelete('DELETE FROM Cart WHERE id = ?', [productId]);
    await getProduct();
  }

  incrementQty(int productId, int productQty) async {
    productQty++;
    await database.rawUpdate(
        'UPDATE Cart SET qty = ? WHERE id = ?', [productQty, productId]);
    await getProduct();
  }

  decrementQty(int productId, int productQty) async {
    if (productQty > 1) {
      productQty--;
    }
    await database.rawUpdate(
        'UPDATE Cart SET qty = ? WHERE id = ?', [productQty, productId]);
    await getProduct();
  }

  void calculateAmount() {
    totalCartValue = 0.00;

    for (var element in selectedProductList) {
      totalCartValue += element['qty'] * element['price'];
    }
    totalCartValue = double.parse(totalCartValue.toStringAsFixed(2));
  }

  //to remove items from db after successfull payment
  Future clearTable() async {
    await database.delete('Cart');
  }
}
