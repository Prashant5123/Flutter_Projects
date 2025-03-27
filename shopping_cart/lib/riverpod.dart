import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart/riverpod_Model.dart';


final riverPodObj=ChangeNotifierProvider<RiverpodModel>((ref){
  return RiverpodModel(products: {},cart: [], count: 0, totalPrice: 0, productCount: 0);
});