import 'package:cached_network_image/cached_network_image.dart';
import 'package:canteen2/cart.dart';
import 'package:canteen2/cart_provider.dart';
import 'package:canteen2/const.dart';
import 'package:canteen2/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_model.dart';

class product extends StatefulWidget {
  final String name;
  final int price;
  final String image;
  int boolean;
  bool boolian;
  String doc;
  static List<dynamic>? global;
  int quantity;

  product({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.boolean,
    required this.boolian,
    required this.doc,
    required this.quantity,
  });

  @override
  State<product> createState() => _productState();
}

int? Count;
int count = 1;
// bool boolean = false;
int order = 1;

class _productState extends State<product> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(
              height: 175,
              width: 200,
              child: FittedBox(
                fit: BoxFit.fill,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox.fromSize(
                      size: Size.fromRadius(20),
                      child: CachedNetworkImage(
                        imageUrl: widget.image,
                        placeholder: (context, url) => Image.network(
                            'https://www.shutterstock.com/image-vector/box-packaging-icon-vector-template-600w-1405633748.jpg'),
                      )),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                widget.name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                '${widget.price} L.E',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                if (widget.boolian == false) {
                  CollectionReference cartItem =
                      FirebaseFirestore.instance.collection('cart');
                  await cartItem.doc(P.toString()).set({
                    'cart item': '${widget.name}',
                    'price': '${widget.price}',
                    'image': '${widget.image}',
                    'quantity': '${widget.quantity}',
                  });
                  CollectionReference orderedItem = FirebaseFirestore.instance
                      .collection('orders')
                      .doc('$order')
                      .collection('order$order');
                  await orderedItem.doc().set({
                    'order item': '${widget.name}',
                    'price': '${widget.price}',
                    'image': '${widget.image}',
                    'quantity': '${widget.quantity}',
                  });
                  setState(() {
                    P++;

                    I++;
                    widget.boolian = true;
                  });
                  showToast(text: 'Added to cart', color: Colors.amberAccent);
                } else {
                  showToast(
                      text: 'Already in cart!', color: Colors.amberAccent);
                }
              },
              color: Color.fromARGB(255, 5, 3, 85),
              child: Text(
                'Add to cart',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
