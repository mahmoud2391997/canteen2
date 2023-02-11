import 'package:canteen2/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class category extends StatelessWidget {
  String imagURL;
  String categoryy;
  void Function() onTap;
  category(
      {super.key,
      required this.imagURL,
      required this.categoryy,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(2),
        height: MediaQuery.of(context).size.height / 3,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color.fromARGB(255, 5, 3, 85))),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 10),
                child: Image.network(imagURL)),
            Center(
              child: DefaultTextStyle(
                style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 5, 3, 85),
                    fontWeight: FontWeight.bold),
                child: Text(
                  categoryy,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
