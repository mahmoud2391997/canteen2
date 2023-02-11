import 'package:canteen2/cart.dart';
import 'package:canteen2/category.dart';
import 'package:canteen2/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:canteen2/categories.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class CartModel extends ChangeNotifier {
  List _shopItems = [];
  // list of items on sale

  // list of cart items
  List _cartItems = [];

  get cartItems => _cartItems;

  get shopItems => _shopItems;

  // Future fire(int index, String docs) async {
  //   await FirebaseFirestore.instance
  //       .collection('categories')
  //       .doc(docs)
  //       .collection('products')
  //       .get()
  //       .then((QuerySnapshot snapshot) => snapshot.docs
  //           .forEach((document) => {_shopItems.add(document.data())}));
  //   for (int i = 0; i <= index; i++) {
  //     print(_shopItems[i]);
  //   }

  //   return _shopItems;
  // }

  // add item to cart
  Future addItemToCart(int index, String docs) async {
    await FirebaseFirestore.instance
        .collection('categories')
        .doc(docs)
        .collection('products')
        .get()
        .then((QuerySnapshot snapshot) =>
            {_shopItems.add(snapshot.docs[index].data())});
    // await FirebaseFirestore.instance
    //     .collection('categories')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((doc) {
    //     print(doc.id);
    //     FirebaseFirestore.instance
    //         .doc(doc.id)
    //         .collection('products')
    //         .get()
    //         .then((QuerySnapshot snapshot) => snapshot.docs
    //             .forEach((document) => {_shopItems.add(document.data())}));
    //   });
    // });

    // await FirebaseFirestore.instance.collectionGroup('products').get().then(
    //     (QuerySnapshot snapshot) => snapshot.docs
    //         .forEach((document) => {_shopItems.add(document.data())}));

    // print(docs);
    // for (int i = 0; i <= index; i++) {
    //   print(_shopItems[i]);
    // }

    // print(index);
    // notifyListeners();
    // for (int i = 0; i <= index; i++) {
    //   print(_shopItems[i]);
    // }
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
    number[index] = 1;
  }

  // calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }
}
