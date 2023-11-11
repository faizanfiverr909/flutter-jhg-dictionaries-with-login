import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Item {
  Item({
    required this.value,
    required this.dot,
    this.globalKey,
    required this.hasDark,
  });
  GlobalKey? globalKey = GlobalKey();
  final RxInt value;
  RxString dot = ''.obs;

  RxBool? hasDark = false.obs;
}
