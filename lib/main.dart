import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'configs/bindings/bindings.dart';
import 'screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (GetPlatform.isAndroid) {
    InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
      initialBinding: InitialBinding(),
    );
  }
}
