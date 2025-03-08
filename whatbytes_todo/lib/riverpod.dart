import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatbytes_todo/riverpod_model.dart';

final riverPodHard=ChangeNotifierProvider<RiverpodModel>((ref){
  return RiverpodModel(date: "1",firebasData: [],name: "");
});