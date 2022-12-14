import 'package:flutter/material.dart';

Widget buildFeaturedProduct(String name, String price, String image) {
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
          height: 225,
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
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            price,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
      ],
    ),
  );
}
