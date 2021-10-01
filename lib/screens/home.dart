import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutteriap/configs/app_environment.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Flutter Demo IAP'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: _bodyWidget(),
        ),
      ),
    );
  }

  Widget _bodyWidget() {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _divider(20),
        const Text(
          'One Time Purchase',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        _divider(30),
        _purchaseIAPButton(
            'Buy Me Coffee One time', AppEnvironment.buyMeCoffee),
        _divider(15),
        _purchaseIAPButton('Buy me Pizza One Time', AppEnvironment.buyMePizza),
        _divider(50),
        const Text(
          'Subscription',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        _divider(15),
        _purchaseIAPButton(
            'Buy Me Coffee Monthly', AppEnvironment.buyMeCoffeeMOnthly),
        _divider(15),
        _purchaseIAPButton(
            'Buy me Pizza Monthly', AppEnvironment.buyMePizzaMonthlyy),
        _divider(50),
        const Text('Restore Purchases',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        _divider(15),
        _restorePurchases('Restore Purhases')
      ],
    );
  }

  Widget _purchaseIAPButton(String buttonName, String productKey) {
    return ElevatedButton(onPressed: () {}, child: Text(buttonName));
  }

  Widget _restorePurchases(String text) {
    return ElevatedButton(onPressed: () {}, child: Text(text));
  }

  Widget _divider(double height) {
    return SizedBox(
      height: height,
    );
  }
}
