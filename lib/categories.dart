import 'package:canteen2/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'category.dart';

class categories extends StatefulWidget {
  const categories({super.key});

  @override
  State<categories> createState() => _categoriesState();
}

class _categoriesState extends State<categories> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 5, 3, 85),
            centerTitle: true,
            title: Text(
              'products',
              style: TextStyle(color: Colors.white),
            )),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                      fontSize: 40,
                      color: Color.fromARGB(255, 5, 3, 85),
                      fontWeight: FontWeight.bold),
                ),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('categories')
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return GridView.builder(
                          itemCount: (snapshot.data! as dynamic).docs.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.6,
                          ),
                          itemBuilder: (context, index) {
                            DocumentSnapshot snap =
                                (snapshot.data as dynamic).docs[index];
                            return category(
                              imagURL: snap['image'],
                              categoryy: snap['Category'],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                              appBar: AppBar(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 5, 3, 85),
                                                  centerTitle: true,
                                                  title: Text(
                                                    'products',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              body: FutureBuilder(
                                                  future: FirebaseFirestore
                                                      .instance
                                                      .collection('categories')
                                                      .doc(snap['Category'])
                                                      .collection('products')
                                                      .get(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    }

                                                    return GridView.builder(
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            (snapshot.data!
                                                                    as dynamic)
                                                                .docs
                                                                .length,
                                                        gridDelegate:
                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          childAspectRatio:
                                                              0.68,
                                                        ),
                                                        itemBuilder:
                                                            (context, index) {
                                                          DocumentSnapshot
                                                              snap =
                                                              (snapshot.data!
                                                                      as dynamic)
                                                                  .docs[index];

                                                          return product(
                                                            name:
                                                                snap['product'],
                                                            price:
                                                                snap['price'],
                                                            image:
                                                                snap['image'],
                                                            boolean: index,
                                                            boolian: false,
                                                          );
                                                        });
                                                  }),
                                            )));
                              },
                            );
                          });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}