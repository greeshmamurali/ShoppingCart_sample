import 'package:flutter/material.dart';
import 'package:flutter_16_cart_ui/controller/cart_controller.dart';

import 'package:flutter_16_cart_ui/utils/colorConstants.dart';
import 'package:provider/provider.dart';

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
                                'price',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Container(
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
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(6),
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
                                  Container(
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
    );
  }
}
