
import 'package:flutteriap/configs/app_environment.dart';
import 'package:flutteriap/models/models.dart';
import 'package:flutteriap/utils/utils.dart';
import 'package:get/get.dart';

/// this class will load at the time of app start
class PurchasedController extends GetxController {
  bool hasActiveSubscription = false;
  bool hasUpgrade = false;
  List<PastPurchaseModel> purchases = [];
  @override
  void onInit() {
    super.onInit();
    updatePurchases();
  }

  void updatePurchases() {
    /// here from api you need to get your purchased data
    /// purchases =  await http.get('api');
    ///
    ///

    /// here you will assign it that it is active subscryption ot not
    hasActiveSubscription = purchases.any((element) =>
        element.productId == AppEnvironment.storeKeySubscription &&
        element.status != Status.expired);

    /// here if any product user purchased like coins consumable
    hasUpgrade = purchases.any(
      (element) => element.productId == AppEnvironment.storeKeyUpgrade,
    );
    update();
  }
}
