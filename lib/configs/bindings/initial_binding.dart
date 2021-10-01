import 'package:get/get.dart';
import '../../controllers/controllers.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PurchasedController>(
      PurchasedController(),
      permanent: true,
    );
  }
}
