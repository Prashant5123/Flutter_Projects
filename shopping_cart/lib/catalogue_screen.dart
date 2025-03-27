import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart/cart_screen.dart';
import 'package:shopping_cart/riverpod.dart';

class CatalogueScreen extends ConsumerStatefulWidget {
  const CatalogueScreen({super.key});

  @override
  ConsumerState<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends ConsumerState<CatalogueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 190, 206),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 239, 190, 206),
        title: Text(
          "Catalogue",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              child: Stack(
                children: [
                  Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                  Positioned(
                    top: 1,
                    right: 1,
                    child: Container(
                      constraints: BoxConstraints(minHeight: 15, minWidth: 15),
                      decoration: BoxDecoration(
                          color: Colors.pink, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Center(
                          child: Text(
                            "${ref.read(riverPodObj).cart.length}",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            GridView.builder(
              itemCount: ref.watch(riverPodObj).products["products"].length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 1200
                    ? 4
                    : MediaQuery.of(context).size.width > 800
                        ? 3
                        : 2,
                mainAxisExtent: 310,
                crossAxisSpacing: 7,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final product =
                    ref.watch(riverPodObj).products["products"][index];

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 0.2),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 2)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Center(
                              child: SizedBox(
                                height: 200,
                                child: Image.network(
                                  product["images"][0],
                                  fit: BoxFit.fill,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.error, color: Colors.red);
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () {
                                  int existingIndex = ref
                                      .read(riverPodObj)
                                      .cart
                                      .indexWhere((item) =>
                                          item["id"] == product["id"]);

                                  if (existingIndex != -1) {
                                    ref.read(riverPodObj).cart[existingIndex]
                                        ["productCount"] += 1;
                                  } else {
                                    Map data = product;
                                    data["productCount"] = 1;
                                    ref.read(riverPodObj).cart.add(data);
                                  }

                                  setState(() {});

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Item added to")));
                                },
                                child: Container(
                                  height: 35,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEDECEC),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Add",
                                      style: TextStyle(
                                        color: Color(0xFFCF4472),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          product["title"],
                          maxLines: 2,
                          overflow: TextOverflow
                              .ellipsis, // Adds '...' if text overflows
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      if (product.containsKey("brand"))
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            product["brand"],
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              "\$${product["price"]}",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 10),
                            ref.watch(riverPodObj).discount(index),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              "${product["discountPercentage"]}%",
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
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
