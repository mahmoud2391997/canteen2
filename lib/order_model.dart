import 'package:canteen2/cart.dart';
import 'package:canteen2/category.dart';
import 'package:canteen2/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class orderModel extends ChangeNotifier {
  List _orderItems = [];
  // list of items on sale

  // list of cart items
  List _orderedItems = [];

  get orderdItems => _orderedItems;

  get orderItems => _orderItems;

  // add item to cart
  void addItemToOrder(int index) async {
    await FirebaseFirestore.instance.collection('orders').get().then(
        (QuerySnapshot snapshot) => snapshot.docs
            .forEach((document) => {_orderItems.add(document.data())}));
    notifyListeners();
    _orderedItems.add(_orderItems[index]);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromOrder(int index) {
    _orderedItems.removeAt(index);
    notifyListeners();
    number[index] = 1;
  }

  // calculate total price
}
