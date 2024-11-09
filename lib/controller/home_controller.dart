import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_16_cart_ui/model/shop_model.dart';
import 'package:http/http.dart' as http;

class HomeController with ChangeNotifier {
  List<ShopModel> shopObj = [];
  List catgories = [];
  bool isloading = false;
  int selectedCategoryIndex = 0;
  bool isCategoryLoading = false;

  Future getAllProducts() async {
    
    isloading = true; // gridview loading
    notifyListeners();

    final allProductsUrl = Uri.parse('https://fakestoreapi.com/products');
    final categoryUrl = Uri.parse(
        'https://fakestoreapi.com/products/category/${catgories[selectedCategoryIndex]}');
    try {
      
      var response = await http
          .get(selectedCategoryIndex == 0 ? allProductsUrl : categoryUrl);
      if (response.statusCode == 200) {
        shopObj = shopModelFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
    isloading = false;
    notifyListeners();
  }

  Future getCategories() async {
    isCategoryLoading = true;//whole body loading
    notifyListeners();
    final url = Uri.parse('https://fakestoreapi.com/products/categories');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
    

        catgories = jsonDecode(response.body);
        catgories.insert(0, 'All');
        
      }
    } catch (e) {
      print(e);
    }
    isCategoryLoading = false;
    notifyListeners();
  }

  onCategorySelection(int index) {
    //avoid rebuilding if the selectedindex is selected && avoid loading when another page is loading
    if(selectedCategoryIndex!=index && isloading==false) {
      //to change colors based on the selected index
    selectedCategoryIndex = index;
    notifyListeners();
    getAllProducts();
    }
    
  }
}
