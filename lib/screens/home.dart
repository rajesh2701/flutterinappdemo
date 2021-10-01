import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutteriap/configs/app_environment.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _coffeePurchased = false;
  bool _pizzaPurchased = false;
  bool _coffeeMonthlyPurchased = false;
  bool _pizzaMonthlyPurchased = false;

  @override
  void initState() {
    super.initState();
    //checking only coffee
    productsCheck(AppEnvironment.buyMeCoffee);
  }

  // HERE WE CHECK PRODCUTS PURCHASEORNOT
  Future<void> productsCheck(String productKey) async {
    // the code goes here
    setState(() {
      // if user purchase the product
      _coffeePurchased = false;
      _pizzaPurchased = true;
      _coffeeMonthlyPurchased = true;
      _pizzaMonthlyPurchased = false;
    });
  }

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
            'Coffee', _coffeePurchased, AppEnvironment.buyMeCoffee),
        _divider(15),
        _purchaseIAPButton('Pizza', _pizzaPurchased, AppEnvironment.buyMePizza),
        _divider(50),
        const Text(
          'Subscription',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        _divider(15),
        _coffeeMonthlyPurchased
            ? _subscripeIAPButton(
                'Buy Me Coffee Monthly', AppEnvironment.buyMeCoffeeMOnthly)
            : _cancelIAPSubscription(
                'Coffee', AppEnvironment.buyMeCoffeeMOnthly),
        _divider(15),
        _pizzaMonthlyPurchased
            ? _subscripeIAPButton(
                'Buy Me Pizza Monthly', AppEnvironment.buyMePizzaMonthlyy)
            : _cancelIAPSubscription(
                'Pizza', AppEnvironment.buyMePizzaMonthlyy),
        _divider(50),
        const Text('Restore Purchases',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        _divider(15),
        _restorePurchases('Restore Purhases')
      ],
    );
  }

  Widget _purchaseIAPButton(
      String buttonName, bool purchaseStatus, String productKey) {
    return ElevatedButton(
        onPressed: () {
          // here we subscripe or buy products
          if (purchaseStatus) {
            // button click wont do anything
          } else {
            // purchase flow goes here
          }
        },
        // teXT NAEM CHANE ACCORIDING TO PURCHASE
        child: Text(purchaseStatus
            ? 'Thank You for $buttonName'
            : 'Buy Me $buttonName One Time'));
  }

  Widget _subscripeIAPButton(String buttonName, String productKey) {
    return ElevatedButton(
        onPressed: () {
          // here we subscripe
        },
        child: Text(buttonName));
  }

  Widget _cancelIAPSubscription(String title, String key) {
    return ElevatedButton(
        onPressed: () {
          // cancel subscribe code goes here
        },
        child: Text('Cancel $title Subsription'));
  }

  Widget _restorePurchases(String text) {
    return ElevatedButton(
        onPressed: () {
          // here are restored products
        },
        child: Text(text));
  }

  Widget _divider(double height) {
    return SizedBox(
      height: height,
    );
  }
}
