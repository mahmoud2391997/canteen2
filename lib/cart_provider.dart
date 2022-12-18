import 'package:canteen2/widget.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  List<ItemModel> myCartItemList = [];
  double cartvalue = 0;
  addToCart(ItemModel itemModel) {
    myCartItemList.add(itemModel);
    notifyListeners();
  }
}
