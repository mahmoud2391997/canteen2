import 'dart:math';

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

var l;
var f;
int? Count;
int count = 1;
bool boolean = true;
CollectionReference order = FirebaseFirestore.instance.collection('orders');

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
                  int qSnap = (await order.count().get()).count + 1;
                  CollectionReference cartItem =
                      FirebaseFirestore.instance.collection('cart');
                  await cartItem.doc(P.toString()).set({
                    'cart item': '${widget.name}',
                    'price': '${widget.price}',
                    'image': '${widget.image}',
                    'quantity': '${widget.quantity}',
                  });

                  // var documentReference = FirebaseFirestore.instance
                  //     .collection('orders')
                  //     .doc('order')
                  //     .collection('order')
                  //     .doc('order');
                  // FirebaseFirestore.instance
                  //     .runTransaction((transaction) async {
                  //   transaction.set(
                  //     documentReference,
                  //     {
                  //       'order item': '${widget.name}',
                  //       'price': '${widget.price}',
                  //       'image': '${widget.image}',
                  //       'quantity': '${widget.quantity}'
                  //     },
                  //   );
                  // });

                  QuerySnapshot<Map<String, dynamic>> _query =
                      await FirebaseFirestore.instance
                          .collection('orders')
                          .get();
                  QuerySnapshot<Map<String, dynamic>> _queryy =
                      await FirebaseFirestore.instance
                          .collectionGroup('order')
                          .get();
                  if (_query.docs.isNotEmpty && _queryy.docs.isNotEmpty) {
                    final QuerySnapshot Q = await FirebaseFirestore.instance
                        .collection('orders')
                        .get();
                    f = Q.docs.length + 1;
                  } else if (_query.docs.isEmpty) {
                    f = 1;
                  } else {
                    final QuerySnapshot Q = await FirebaseFirestore.instance
                        .collection('orders')
                        .get();
                    f = Q.docs.length;
                  }

                  ;
                  CollectionReference u =
                      FirebaseFirestore.instance.collection('orders');

                  if (boolean == true) {
                    var r = await u.add({'order number': '${f}'});
                    u.doc(r.id).collection('order').add({
                      'order item': '${widget.name}',
                      'price': '${widget.price}',
                      'image': '${widget.image}',
                      'quantity': '${widget.quantity}'
                    });
                    l = r.id;
                    boolean = false;
                  } else {
                    u.doc(l).collection('order').add({
                      'order item': '${widget.name}',
                      'price': '${widget.price}',
                      'image': '${widget.image}',
                      'quantity': '${widget.quantity}'
                    });
                  }

                  // CollectionReference orderedItem = FirebaseFirestore.instance
                  //     .collection('orders')
                  //     .doc()
                  //     .collection('order');
                  // await orderedItem.doc().set({
                  //   'order item': '${widget.name}',
                  //   'price': '${widget.price}',
                  //   'image': '${widget.image}',
                  //   'quantity': '${widget.quantity}',
                  // });
                  // CollectionReference orders =
                  //     FirebaseFirestore.instance.collection('orders');

                  // QuerySnapshot result = await orders.get();
                  // DocumentSnapshot res = result.docs[order].get('order number');
                  // await orders.doc('$order').set({'order number': '$order'});
                  if (mounted) {
                    setState(() {
                      P++;

                      I++;
                      widget.boolian = true;
                    });
                  }
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
