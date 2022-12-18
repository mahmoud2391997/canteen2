import 'package:canteen2/cart_provider.dart';
import 'package:canteen2/variables.dart';
import 'package:canteen2/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_model.dart';

class shoppingScreen extends StatefulWidget {
  const shoppingScreen({super.key});

  @override
  State<shoppingScreen> createState() => _shoppingScreenState();
}

class _shoppingScreenState extends State<shoppingScreen> {
  // Stream<DocumentSnapshot> result = FirebaseFirestore.instance
  //     .collection('products')
  //     .doc('FJIyTUnyimFj9aNAccUt')
  //     .snapshots();

  // Future<DocumentSnapshot> getLength() async {
  //   FirebaseFirestore.instance
  //       .collection('products')
  //       .get()
  //       .then((value) => {length = value.docs.length});

  // }
  late String value1;
  Future<void> function() async {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    QuerySnapshot allResult = await products.get();
    allResult.docs.forEach((DocumentSnapshot result) {
      value1 = result.get('name');
    });
  }

  late String value2;
  Future<void> function2() async {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    QuerySnapshot allResult = await products.get();
    allResult.docs.forEach((DocumentSnapshot result) {
      @override
      void initState() {
        function2();
        value2 = result.get('price');
        super.initState();
      }
    });
  }

  late String value3;
  Future<void> function3() async {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    QuerySnapshot allResult = await products.get();
    allResult.docs.forEach((DocumentSnapshot result) {
      @override
      void initState() {
        function3();
        value3 = result.get('image');
        super.initState();
      }
    });
  }

  // DocumentSnapshot

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'products',
              style: TextStyle(color: Colors.blue),
            )),
        // body: GridView.builder(
        //   itemCount: length,
        //   shrinkWrap: true,
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     childAspectRatio: 0.68,
        //   ),
        //   itemBuilder: (_, index) {
        //     return buildFeaturedProduct(
        //         Result!['name'], Result!['price'], Result!['image']);
        //   },
        // ),
        body: FutureBuilder(
            future: FirebaseFirestore.instance.collection('products').get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                itemCount: (snapshot.data! as dynamic).docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.68,
                ),
                itemBuilder: (context, index) {
                  DocumentSnapshot snap =
                      (snapshot.data! as dynamic).docs[index];
                  CartProvider? cartProvider;
                  List<ItemModel> mentItemlist = [];

                  prepareMenu() {
                    for (int i = 0;
                        i < (snapshot.data! as dynamic).docs.length;
                        i++) {
                      mentItemlist.add(ItemModel(
                          name: snap[i]['name'],
                          price: snap[i]['price'],
                          image: snap[i]['image']));
                    }
                  }

                  ;
                  @override
                  void initState() {
                    prepareMenu();

                    cartProvider =
                        Provider.of<CartProvider>(context, listen: false);
                    super.initState();
                  }

                  return product(
                    name: snap['name'],
                    price: snap['price'],
                    image: snap['image'],
                    onPressed: () =>
                        Provider.of<CartModel>(context, listen: false)
                            .addItemToCart(index),
                  );
                },
              );
            }));
  }
}
