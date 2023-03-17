import 'package:canteen2/scanning.dart';
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

int P = 1;

class _productsState extends State<products> {
  @override
  Widget build(BuildContext context) {
    var id = FirebaseFirestore.instance
        .collection('Countries')
        .doc('xXz0mjiHyWyjV4suHCQ4')
        .collection('Schools')
        .doc('iaa3NufaUPhjiRkO5LPK')
        .collection('Canteen')
        .doc('LGLZdZOAf1jpyVUTZxpl')
        .collection('categories')
        .doc(widget.document)
        .collection('products')
        .get();
    // var s = id.where('allergy2', whereNotIn: allergies);
    // var e = s.where('allergy3', whereNotIn: allergies).get();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 5, 3, 85),
          centerTitle: true,
          title: Text(
            'products',
            style: TextStyle(color: Colors.white),
          )),
      body: FutureBuilder(
          future: id,
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
                    doc: widget.document,
                    quantity: 1,
                  );
                });
          }),
    );
  }
}
