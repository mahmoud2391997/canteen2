import 'package:canteen2/cart.dart';
import 'package:canteen2/cart_provider.dart';
import 'package:canteen2/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class product extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  void Function()? onPressed;
  product(
      {super.key,
      required this.name,
      required this.price,
      required this.image,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 225, 233, 247),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            height: 175,
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox.fromSize(
                  size: Size.fromRadius(20), child: Image.network('$image')),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              price,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          MaterialButton(
            onPressed: onPressed,
            color: Colors.blueAccent,
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
    );
  }
}
