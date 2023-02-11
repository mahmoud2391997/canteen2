import 'package:canteen2/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class products extends StatefulWidget {
  products({super.key, required this.document, required this.index});
  String document;
  int index;
  @override
  State<products> createState() => _productsState();
}

class _productsState extends State<products> {
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
          future: FirebaseFirestore.instance
              .collection('categories')
              .doc(widget.document)
              .collection('products')
              .get(),
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

                  return product(
                    name: snap['product'],
                    price: snap['price'],
                    image: snap['image'],
                    boolean: index,
                    boolian: false,
                    doc: widget.document,
                  );
                });
          }),
    );
  }
}
