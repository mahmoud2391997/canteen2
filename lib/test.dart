import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (() async {
        CollectionReference products =
            FirebaseFirestore.instance.collection('products');
        QuerySnapshot allResult = await products.get();
        allResult.docs.forEach((DocumentSnapshot result) {
          print(result.get('name'));
        });
      }),
      child: Text('read data'),
    );
  }
}
