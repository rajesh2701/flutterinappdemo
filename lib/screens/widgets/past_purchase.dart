import 'package:flutter/material.dart';
import 'package:flutteriap/controllers/controllers.dart';
import 'package:get/get.dart';

class PastPurchasesWidget extends StatelessWidget {
  const PastPurchasesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PurchasedController purchasedController = Get.find();
    return ListView.separated(
      shrinkWrap: true,
      itemCount: purchasedController.purchases.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(purchasedController.purchases[index].title),
        subtitle: Text(purchasedController.purchases[index].status.toString()),
      ),
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
