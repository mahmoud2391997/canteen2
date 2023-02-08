import 'package:canteen2/cart_provider.dart';
import 'package:canteen2/variables.dart';
import 'package:canteen2/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'cart.dart';
import 'cart_model.dart';

class shoppingScreen extends StatefulWidget {
  const shoppingScreen({super.key});

  @override
  State<shoppingScreen> createState() => _shoppingScreenState();
}

bool click = false;
int I = 1;
int a = 1;
int? n;

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

  late int value2;
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
          backgroundColor: Color.fromARGB(255, 5, 3, 85),
          centerTitle: true,
          title: Text(
            'products',
            style: TextStyle(color: Colors.white),
          )),
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
                  // SchedulerBinding.instance.addPostFrameCallback((_) {
                  //   setState(() {
                  //     n = index;
                  //   });
                  // });

                  @override
                  void initState() {
                    cartProvider =
                        Provider.of<CartProvider>(context, listen: false);
                    super.initState();
                  }

                  return product(
                    name: snap['product'],
                    price: snap['price'],
                    image: snap['image'],
                    boolean: index,
                    boolian: false,
                  );
                });
          }),
    );
  }
}
