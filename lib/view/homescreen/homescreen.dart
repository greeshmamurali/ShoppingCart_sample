import 'package:flutter/material.dart';
import 'package:flutter_16_cart_ui/controller/cart_controller.dart';
import 'package:flutter_16_cart_ui/controller/home_controller.dart';
import 'package:flutter_16_cart_ui/view/cart_screen/cart_screen.dart';

import 'package:flutter_16_cart_ui/view/productdetails/productdetails.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<CartController>().initDb();
      await context.read<HomeController>().getCategories();
      await context.read<HomeController>().getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Discover',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 27),
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => CartScreen(),)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart,color: Colors.black,),
            )),
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
      body: context.watch<HomeController>().isCategoryLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              // padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Column(
                children: [
                  searchAnything(),

                  SizedBox(
                    height: 15,
                  ),
                  
                  categorySection(context),
                  SizedBox(
                    height: 15,
                  ),
                  productGrid(context)
                ],
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Home',
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Expanded(
              child: Column(
                children: [
                  Icon(
                    Icons.favorite_outline,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Saved',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Expanded(
              child: Column(
                children: [
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Cart',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Expanded(
              child: Column(
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded productGrid(BuildContext context) {
    return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: context.watch<HomeController>().isloading
                        ? Center(child: CircularProgressIndicator())
                        : GridView.builder(
                            itemCount: context
                                .watch<HomeController>()
                                .shopObj
                                .length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisExtent: 300,
                                    mainAxisSpacing: 10),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                if (context
                                        .read<HomeController>()
                                        .shopObj[index]
                                        .id !=
                                    null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Productdetails(
                                            productId: context
                                                .read<HomeController>()
                                                .shopObj[index]
                                                .id!),
                                      ));
                                }
                              },
                              child: Container(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(9),
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                                height: 250,
                                                width: double.infinity,
                                                child: Image(
                                                  image: NetworkImage(context
                                                      .watch<HomeController>()
                                                      .shopObj[index]
                                                      .image
                                                      .toString()),
                                                  fit: BoxFit.fill,
                                                )),
                                            Positioned(
                                                top: 8,
                                                right: 8,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(5)),
                                                  child: Icon(
                                                    Icons
                                                        .favorite_border_outlined,
                                                    color: Colors.black,
                                                  ),
                                                ))
                                          ],
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        context
                                            .watch<HomeController>()
                                            .shopObj[index]
                                            .title
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Expanded(
                                      child: Text(
                                        context
                                            .watch<HomeController>()
                                            .shopObj[index]
                                            .price
                                            .toString(),
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ),
                );
  }

  SizedBox categorySection(BuildContext context) {
    return SizedBox(
                  height: 35,
                  child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            context
                                .read<HomeController>()
                                .onCategorySelection(index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            decoration: BoxDecoration(
                                color: context
                                            .watch<HomeController>()
                                            .selectedCategoryIndex ==
                                        index
                                    ? Colors.black
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              context
                                  .watch<HomeController>()
                                  .catgories[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: context
                                            .watch<HomeController>()
                                            .selectedCategoryIndex ==
                                        index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                      itemCount:
                          context.watch<HomeController>().catgories.length),
                );
  }

  Container searchAnything() {
    return Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 240, 231, 231)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 35,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Search anything',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          Icons.filter_list,
                          color: Colors.white,
                          size: 40,
                        ),
                      )
                    ],
                  ),
                );
  }
}
