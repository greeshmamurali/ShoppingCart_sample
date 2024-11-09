import 'package:flutter/material.dart';
import 'package:flutter_16_cart_ui/controller/home_controller.dart';
import 'package:flutter_16_cart_ui/controller/productdetails_controller.dart';
import 'package:flutter_16_cart_ui/view/getstart/getstart.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeController(),),
        ChangeNotifierProvider(create: (context) => ProductdetailsController(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Getstart(),
      ),
    );
  }
}
