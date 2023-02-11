import 'package:canteen2/cart_provider.dart';
import 'package:canteen2/history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';
import 'dart:convert';

class cart extends StatefulWidget {
  late Map<String, dynamic> fire;
  cart({super.key, fire});

  @override
  State<cart> createState() => _cartState();
}

bool click = false;
int I = 1;
int a = 1;
int? n;

showToast({
  required String text,
  required color,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16,
  );
}

int X = 0;
int? Indexxx;
int? indexx;
int? Indexx;
String? NAME;
String? PRICE;
String? IMAGE;
List<int> number = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
List<int> cash = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
List<String> productName = [
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  ''
];
List<int> productNum = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];

class _cartState extends State<cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 5, 3, 85),
            centerTitle: true,
            title: Text(
              'cart',
              style: TextStyle(color: Colors.white),
            )),
        body: FutureBuilder(
            future: FirebaseFirestore.instance.collection('cart').get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('cart is empty'),
                );
              }
              return ListView.separated(
                itemBuilder: ((context, index) {
                  DocumentSnapshot snappp =
                      (snapshot.data as dynamic).docs[index];
                  void _incrementCounter() {
                    setState(() {
                      number[index]++;
                      Indexx = index;
                    });
                  }

                  void _decrementCounter() {
                    if (number != 1) {
                      setState(() {
                        number[index]--;
                        Indexx = index;
                      });
                    }
                  }

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() {
                        Indexx = index;
                        cash[Indexx!] = int.parse(snappp['price']);
                        productName[Indexx!] = snappp['cart item'];
                      });
                    }
                  });

                  return Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 80, 65, 219),
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    // height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width,
                    height: 140,
                    child: Row(
                      children: [
                        Container(
                            width: 140,
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                child: Image.network(
                                  snappp['image'],
                                  fit: BoxFit.fill,
                                ))),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 20),
                          child: Column(
                            children: [
                              Text(
                                snappp['cart item'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text('${snappp['price']} L.E'),
                              SizedBox(
                                height: 6,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  width: 120,
                                  color: Colors.grey.shade200,
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.only(bottom: 10),
                                        icon: Icon(
                                          Icons.minimize,
                                          color: Colors.black,
                                        ),
                                        onPressed: _decrementCounter,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '${number[index]}',
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                        onPressed: _incrementCounter,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        IconButton(
                            padding:
                                const EdgeInsets.only(left: 80, bottom: 20),
                            icon: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 50,
                            ),
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection("cart")
                                  .doc((snapshot.data!.docs[index].reference.id
                                      .toString()))
                                  .delete();
                            })
                      ],
                    ),
                  );
                }),
                itemCount: (snapshot.data! as dynamic).docs.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 15,
                  );
                },
              );
            }),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if (Indexx != null) {
                for (int i = Indexx!; i >= 0; i--) {
                  setState(() {
                    totalPiecies = totalPiecies + number[i];
                    totalCash = totalCash + (cash[i]) * (number[i]);
                    Indexxx = Indexx;

                    productNum[i] = number[i];
                    Indexx = null;
                    X++;
                    a++;
                  });

                  await FirebaseFirestore.instance
                      .collection("cart")
                      .get()
                      .then((value) => {
                            for (DocumentSnapshot ds in value.docs)
                              {ds.reference.delete()}
                          });
                }

                showToast(text: 'Sold successfully', color: Colors.amberAccent);
              } else {
                showToast(
                    text: 'Nothing in the cart!', color: Colors.amberAccent);
              }
            },
            child: Text('sell'),
            backgroundColor: Color.fromARGB(255, 5, 3, 85)));
  }
}
