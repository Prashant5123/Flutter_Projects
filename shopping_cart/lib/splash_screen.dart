import 'dart:developer';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart/catalogue_screen.dart';
import 'package:shopping_cart/riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreentState();
}

class _SplashScreentState extends ConsumerState<SplashScreen> {
  @override
  void didChangeDependencies() {
    
    super.didChangeDependencies();
    ref.read(riverPodObj).getData();

    log("${ MediaQuery.of(context).size.width}");
     log("${ MediaQuery.of(context).size.height}");
    log("${ref.watch(riverPodObj).products}");


  }
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: const Color.fromARGB(255, 254, 227, 236),
      duration: 3000
      ,
      splash: Icon(Icons.shopping_cart,
      size: 50,
      ),
      nextScreen: CatalogueScreen(),
    );
  }
}
