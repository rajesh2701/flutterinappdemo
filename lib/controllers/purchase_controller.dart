import 'dart:async';

import '../models/models.dart';

import '../configs/app_environment.dart';

import 'package:in_app_purchase/in_app_purchase.dart';
import '../utils/utils.dart';
import 'package:get/get.dart';

import 'controllers.dart';

/// controller for in app purchase
class PurchaseController extends GetxController {
  /// we will use this class to know that user purchased or not
  final PurchasedController _purchasedController = Get.find();

  StoreState storeState = StoreState.loading;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<PurchasableProductModel> products = [];
  final iapConnection = InAppPurchase.instance;

  //// method get check coins count purchase able, bcz if user has coins we will not say him to purchase
  bool get conisCount => _conisCountUpgrade;
  bool _conisCountUpgrade = false;

  @override
  void onInit() {
    super.onInit();
    final purchaseUpdated = iapConnection.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _onPurchaseUpdate,
      onDone: _updateStreamOnDone,
      onError: _updateStreamOnError,
    );
    loadPurchases();
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }

  Future<void> buy(PurchasableProductModel product) async {
    final purchaseParam = PurchaseParam(productDetails: product.productDetails);
    switch (product.id) {
      case AppEnvironment.storeKeySubscription:
        await iapConnection.buyNonConsumable(purchaseParam: purchaseParam);
        break;
      case AppEnvironment.storeKeyConsumable:
        await iapConnection.buyConsumable(purchaseParam: purchaseParam);
        break;
      default:
        throw ArgumentError.value(
            product.productDetails, '${product.id} is not a known product');
    }
  }

  void _updateStreamOnDone() {
    _subscription.cancel();
  }

  void _updateStreamOnError(dynamic error) {
    // ignore: avoid_print
    print(error);
  }

  void purchasesUpdate() {
    var subscriptions = <PurchasableProductModel>[];
    var upgrades = <PurchasableProductModel>[];
    // Get a list of purchasable products for the subscription and upgrade.
    // This should be 1 per type.
    if (products.isNotEmpty) {
      subscriptions = products
          .where((element) =>
              element.productDetails.id == AppEnvironment.storeKeySubscription)
          .toList();
      upgrades = products
          .where((element) =>
              element.productDetails.id == AppEnvironment.storeKeyUpgrade)
          .toList();
    }

    if (_purchasedController.hasActiveSubscription) {
      for (final element in subscriptions) {
        _updateStatus(element, ProductStatus.purchased);
      }
    } else {
      for (final element in subscriptions) {
        _updateStatus(element, ProductStatus.purchasable);
      }
    }

    // Set the dash beautifier and show/hide purchased on
    // the purchases page.
    if (_purchasedController.hasUpgrade != _conisCountUpgrade) {
      _conisCountUpgrade = _purchasedController.hasUpgrade;
      for (final element in upgrades) {
        _updateStatus(
            element,
            _conisCountUpgrade
                ? ProductStatus.purchased
                : ProductStatus.purchasable);
      }
      update();
    }
  }

  Future<void> _onPurchaseUpdate(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      await _handlePurchase(purchaseDetails);
    }
    update();
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.purchased) {
      // Send to server
      var validPurchase = await _verifyPurchase(purchaseDetails);

      if (validPurchase) {
        // Apply changes locally
        _purchasedController.updatePurchases();
      }
    }

    if (purchaseDetails.pendingCompletePurchase) {
      await iapConnection.completePurchase(purchaseDetails);
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    /// api to update purchase on server
    return true;
  }

  Future<void> loadPurchases() async {
    final available = await iapConnection.isAvailable();
    if (!available) {
      storeState = StoreState.notAvailable;
      update();
      return;
    }

    try {
      // api to load ids
      // await functions;
    } catch (e) {
      storeState = StoreState.notAvailable;
      update();
      return;
    }

    const ids = <String>{
      AppEnvironment.storeKeySubscription,
    };
    final response = await iapConnection.queryProductDetails(ids);
    products =
        response.productDetails.map((e) => PurchasableProductModel(e)).toList();
    storeState = StoreState.available;
    update();
  }

  void _updateStatus(PurchasableProductModel product, ProductStatus purchased) {
    if (product.status != ProductStatus.purchased) {
      product.status = ProductStatus.purchased;
      update();
    }
  }
}
