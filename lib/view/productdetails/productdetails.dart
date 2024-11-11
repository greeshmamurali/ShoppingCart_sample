import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_16_cart_ui/controller/cart_controller.dart';
import 'package:flutter_16_cart_ui/controller/productdetails_controller.dart';
import 'package:flutter_16_cart_ui/view/cart_screen/cart_screen.dart';
import 'package:provider/provider.dart';

class Productdetails extends StatefulWidget {
  final int productId;
  const Productdetails({super.key, required this.productId});

  @override
  State<Productdetails> createState() => _ProductdetailsState();
}

class _ProductdetailsState extends State<Productdetails> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context
          .read<ProductdetailsController>()
          .getProduct(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Center(
          child: Text(
            'Details',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Stack(
            children: [
              Icon(
                Icons.notifications_none_outlined,
                size: 27,
              ),
              Positioned(
                  right: 1,
                  top: 2,
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor: Colors.black,
                    child: Text(
                      '1',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ))
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 5))
        ],
      ),
      body: context.watch<ProductdetailsController>().isProductLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    context.watch<ProductdetailsController>().product != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 400,
                                  child: Image(
                                    image: NetworkImage(context
                                        .watch<ProductdetailsController>()
                                        .product!
                                        .image
                                        .toString()),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.black,
                                      ),
                                    ))
                              ],
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      context
                              .watch<ProductdetailsController>()
                              .product
                              ?.title
                              .toString() ??
                          "",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 27),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        RatingBar.readOnly(
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          initialRating: context
                                  .watch<ProductdetailsController>()
                                  .product
                                  ?.rating
                                  ?.rate ??
                              0,
                          maxRating: 5,
                        ),
                        Text(
                            '( ${context.watch<ProductdetailsController>().product?.rating?.count} Ratings)')
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      context
                              .watch<ProductdetailsController>()
                              .product
                              ?.description
                              .toString() ??
                          "",
                      //  'The name says it all,the right size slightly snugs the bodt leaving enough room for comfort in the sleeves and waist.',
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Choose size',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text(
                              'S',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text(
                              'M',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text(
                              'L',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  context
                          .watch<ProductdetailsController>()
                          .product
                          ?.price
                          .toString() ??
                      "",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )
              ],
            ),
            SizedBox(
              width: 25,
            ),
            Expanded(
              child: InkWell(
                onTap: () async {
                  final selectedProduct =
                      context.read<ProductdetailsController>().product!;
                  
                     await context.read<CartController>().addProduct(selectedProduct);
                    
                  
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ));
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
