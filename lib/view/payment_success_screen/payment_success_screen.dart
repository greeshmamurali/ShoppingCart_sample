import 'package:flutter/material.dart';
import 'package:flutter_16_cart_ui/view/homescreen/homescreen.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  void initState() {
    
    super.initState();

    Future.delayed(Duration(seconds: 2),).then((value) => Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => Homescreen(),),(route) => false,),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Payment SuccessFull',
        style: TextStyle(
          color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20
        ),),
      ),
    );
  }
}