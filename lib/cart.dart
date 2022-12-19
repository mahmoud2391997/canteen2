import 'package:canteen2/cart_provider.dart';
import 'package:custom_text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';

class cart extends StatefulWidget {
  const cart({super.key});

  @override
  State<cart> createState() => _cartState();
}

String? NAME;
String? PRICE;
String? IMAGE;
int number = 1;

class _cartState extends State<cart> {
  void _incrementCounter() {
    setState(() {
      number++;
    });
  }

  void _decrementCounter() {
    if (number != 1) {
      setState(() {
        number--;
      });
    }
  }

  void one() {
    setState(() {
      number = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'cart',
              style: TextStyle(color: Colors.blue),
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
                        color: Color.fromARGB(255, 225, 233, 247),
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    // height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width,
                    height: 140,
                    child: Row(
                      children: [
                        Container(
                            width: 140,
                            child: Image.network(
                              data.cartItems[index]['image'],
                              fit: BoxFit.fill,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 20),
                          child: Column(
                            children: [
                              Text(data.cartItems[index]['name']),
                              SizedBox(
                                height: 6,
                              ),
                              Text(data.cartItems[index]['price']),
                              SizedBox(
                                height: 6,
                              ),
                              Container(
                                width: 110,
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
                                      '$number',
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
                              )
                            ],
                          ),
                        ),
                        IconButton(
                          padding: const EdgeInsets.only(left: 80, bottom: 20),
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 50,
                          ),
                          onPressed: (() =>
                              Provider.of<CartModel>(context, listen: false)
                                  .removeItemFromCart(index)),
                        ),
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
            backgroundColor: Colors.blue));
  }
}
