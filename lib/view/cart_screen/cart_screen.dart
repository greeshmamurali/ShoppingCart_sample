import 'package:flutter/material.dart';
import 'package:flutter_16_cart_ui/controller/cart_controller.dart';

import 'package:flutter_16_cart_ui/utils/colorConstants.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_web/razorpay_web.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
       
        await context.read<CartController>().getProduct();
      
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorconstants.iconButton,
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            image: NetworkImage(context
                                .watch<CartController>()
                                .selectedProductList[index]['image']),
                            fit: BoxFit.fill,
                            height: 100,
                            width: 100,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                maxLines: 2,
                                context
                                    .watch<CartController>()
                                    .selectedProductList[index]['name'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                context.watch<CartController>().selectedProductList[index]['price'].toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () => context
                                        .read<CartController>()
                                        .incrementQty(
                                            context
                                                    .read<CartController>()
                                                    .selectedProductList[index]
                                                ['id'],
                                            context
                                                    .read<CartController>()
                                                    .selectedProductList[index]
                                                ['qty']),
                                    child: Container(
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: Colorconstants.iconButton,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 9,vertical: 6),
                                    decoration: BoxDecoration(
                                        color: Colorconstants.iconButton,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      context
                                          .watch<CartController>()
                                          .selectedProductList[index]['qty']
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () => context.read<CartController>().decrementQty(context
                                                    .read<CartController>()
                                                    .selectedProductList[index]
                                                ['id'],
                                            context
                                                    .read<CartController>()
                                                    .selectedProductList[index]
                                                ['qty']),
                                    child: Container(
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: Colorconstants.iconButton,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                      onTap: () async {
                                        await context
                                            .read<CartController>()
                                            .removeProduct(context
                                                    .read<CartController>()
                                                    .selectedProductList[index]
                                                ['id']);
                                      },
                                      child: Icon(
                                        Icons.delete_outline,
                                        color: Colors.grey,
                                      ))
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 8,
                    ),
                itemCount:
                    context.watch<CartController>().selectedProductList.length),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Price :',
                style: TextStyle(
                  color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18
                ),),
                Text(context.watch<CartController>().totalCartValue.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,fontSize: 15
                ),)
              ],
            ),

            InkWell(
              onTap: () {
                Razorpay razorpay = Razorpay();
                var options = {
                  'key': 'rzp_test_1DP5mmOlF5G5ag',
                  'amount': 100,
                  'name': 'Acme Corp.',
                  'description': 'Fine T-Shirt',
                  'retry': {'enabled': false, 'max_count': 1},
                  'send_sms_hash': true,
                  'prefill': {
                    'contact': '8888888888',
                    'email': 'test@razorpay.com'
                  },
                  'external': {
                    'wallets': ['paytm']
                  }
                };
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Text('CheckOut',
                style: TextStyle(
                  color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }

   void handlePaymentErrorResponse(PaymentFailureResponse response) {
    // PaymentFailureResponse contains three values:
    // 1. Error Code
    // 2. Error Description
    // 3. Metadata
    showAlertDialog(
      context,
      'Payment Failed',
      'Code: ${response.code}\n'
          'Description: ${response.message}\n'
          'Metadata: ${response.error.toString()}',
    );
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    // PaymentSuccessResponse contains three values:
    // 1. Order ID
    // 2. Payment ID
    // 3. Signature
    showAlertDialog(
      context,
      'Payment Successful',
      'Payment ID: ${response.paymentId}',
    );
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
      context,
      'External Wallet Selected',
      '${response.walletName}',
    );
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }
}
