import 'package:flutter/material.dart';
import 'package:flutteriap/models/models.dart';
import 'package:flutteriap/utils/utils.dart';

class PurchaseWidget extends StatelessWidget {
  final PurchasableProductModel product;
  final VoidCallback onPressed;

  const PurchaseWidget({
    Key? key,
    required this.product,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = product.title;
    if (product.status == ProductStatus.purchased) {
      title += ' (purchased)';
    }
    return InkWell(
        onTap: onPressed,
        child: ListTile(
          title: Text(
            title,
          ),
          subtitle: Text(product.description),
          trailing: Text(_trailing()),
        ));
  }

  String _trailing() {
    switch (product.status) {
      case ProductStatus.purchasable:
        return product.price;
      case ProductStatus.purchased:
        return 'purchased';
      case ProductStatus.pending:
        return 'buying...';
    }
  }
}
