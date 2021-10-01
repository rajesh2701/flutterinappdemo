import 'package:flutter/material.dart';
import 'package:flutteriap/controllers/controllers.dart';
import 'package:get/get.dart';

import 'purchase_widget.dart';

class PurchaseList extends StatelessWidget {
  const PurchaseList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PurchaseController purchases = Get.find();
    var products = purchases.products;
    return Column(
      children: products
          .map((product) => PurchaseWidget(
              product: product,
              onPressed: () {
                purchases.buy(product);
              }))
          .toList(),
    );
  }
}
