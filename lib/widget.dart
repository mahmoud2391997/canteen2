import 'package:canteen2/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget document = StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('products').snapshots(),
    builder: ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //\\ document =snapshot.data.docs[Index].data();
      return GridView.builder(
        shrinkWrap: true,
        // itemCount: snapshot.data!.documents.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 1.5,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return buildFeaturedProduct('ddd', 'ddd', 'ddd');
        },
      );
    }));
