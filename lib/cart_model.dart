import 'package:canteen2/cart.dart';
import 'package:canteen2/category.dart';
import 'package:canteen2/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:canteen2/categories.dart';

class orderModel extends ChangeNotifier {
  List _order = [];
  // list of items on sale

  // list of cart items
  List _ordered = [];

  get ordered => _ordered;

  get order => _order;

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
            {_order.add(snapshot.docs[index].data())});
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
    _ordered.add(_order[index]);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(int index) {
    _order.removeAt(index);
    notifyListeners();
    number[index] = 1;
  }

  // calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < order.length; i++) {
      totalPrice += double.parse(order[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }
}
