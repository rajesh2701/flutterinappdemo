import 'package:flutteriap/utils/utils.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PurchasableProductModel {
  String get id => productDetails.id;
  String get title => productDetails.title;
  String get description => productDetails.description;
  String get price => productDetails.price;
  ProductStatus status;
  ProductDetails productDetails;

  PurchasableProductModel(this.productDetails)
      : status = ProductStatus.purchasable;
}
