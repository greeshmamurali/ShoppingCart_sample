import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_16_cart_ui/model/shop_model.dart';
import 'package:http/http.dart' as http;

class ProductdetailsController with ChangeNotifier {
  bool isProductLoading = false;
  ShopModel? product;

  Future getProduct(int id) async {
    
    isProductLoading = true;
    notifyListeners();
    final url = Uri.parse('https://fakestoreapi.com/products/$id');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        product = ShopModel.fromJson(jsonDecode(response.body));
      } else {
        print('Not loaded');
      }
    } catch (e) {
      print(e);
    }
    isProductLoading = false;
    notifyListeners();
  }
}
