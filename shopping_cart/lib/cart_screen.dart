import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart/riverpod.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  int sum = 0;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    log("${ref.watch(riverPodObj).cart}");

    ref.read(riverPodObj).countTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 190, 206),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 239, 190, 206),
        title: Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: ref.watch(riverPodObj).cart.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                width: 150,
                                height: 200,
                                child: Center(
                                  child: SizedBox(
                                    height: 200,
                                    child: Image.network(
                                      ref.watch(riverPodObj).cart[index]
                                          ["images"][0],
                                      fit: BoxFit.fill,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }

                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              ref.watch(riverPodObj).cart[index]
                                                  ["title"],
                                              maxLines: 2,
                                              overflow: TextOverflow
                                                  .ellipsis, // Adds '...' if text overflows
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          if (ref
                                              .watch(riverPodObj)
                                              .cart[index]
                                              .containsKey("brand"))
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                ref
                                                    .watch(riverPodObj)
                                                    .cart[index]["brand"],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          SizedBox(height: 5),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "\$${ref.watch(riverPodObj).cart[index]["price"]}",
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                    "${ref.watch(riverPodObj).cart[index]["discountPrice"].toStringAsFixed(2)}")
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${ref.watch(riverPodObj).cart[index]["discountPercentage"]}%",
                                                  style: TextStyle(
                                                    color: Color(0xFFCF4472),
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  "OFF",
                                                  style: TextStyle(
                                                    color: Color(0xFFCF4472),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 8,
                                      right: 8,
                                      child: Container(
                                        height: 35,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEDECEC),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // increment icon (add)
                                              GestureDetector(
                                                onTap: () {
                                                  ref
                                                      .watch(riverPodObj)
                                                      .addProduct(index);
                                                  ref
                                                      .read(riverPodObj)
                                                      .countTotalPrice();
                                                },
                                                child: Icon(
                                                  Icons.add,
                                                  size: 18,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "${ref.watch(riverPodObj).cart[index]["productCount"]}",
                                                style: TextStyle(
                                                  color: Color(0xFFCF4472),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),

                                              // decrement icon (remove)
                                              GestureDetector(
                                                onTap: () {
                                                  ref
                                                      .watch(riverPodObj)
                                                      .deleteProduct(index);
                                                  ref
                                                      .read(riverPodObj)
                                                      .countTotalPrice();
                                                },
                                                child: Icon(
                                                  Icons.remove,
                                                  size: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  );
                }),
          ),
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text("Amount Price"),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${ref.read(riverPodObj).totalPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Check Out"),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          constraints: BoxConstraints(
                            minHeight: 16,
                            minWidth: 16,
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Center(
                            child: Text(
                              "${ref.read(riverPodObj).productCount}",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
