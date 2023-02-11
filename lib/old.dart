import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import 'cart_model.dart';

class old extends StatefulWidget {
  const old({super.key});

  @override
  State<old> createState() => _oldState();
}

class _oldState extends State<old> {
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
        body: Consumer<CartModel>(
          builder: ((context, data, child) {
            if (data.cartItems.isEmpty) {
              return const Center(
                  child: Text(
                'Your Cart is Empty',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ));
            } else {
              return ListView.separated(
                itemBuilder: ((context, index) {
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
                                data.cartItems[index]['image'],
                                fit: BoxFit.fill,
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 20),
                          child: Column(
                            children: [
                              Text(
                                data.cartItems[index]['product'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text('${data.cartItems[index]['price']} L.E'),
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
                                        onPressed: () {},
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {},
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
                            onPressed: () {
                              Provider.of<CartModel>(context, listen: false)
                                  .removeItemFromCart(index);
                            }),
                      ],
                    ),
                  );
                }),
                itemCount: data.cartItems.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 15,
                  );
                },
              );
            }
          }),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Text('sell'),
            backgroundColor: Color.fromARGB(255, 5, 3, 85)));
  }
}
