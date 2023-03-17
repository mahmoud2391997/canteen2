import 'package:canteen2/cart.dart';
import 'package:canteen2/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List? allergies;

class scanner extends StatefulWidget {
  const scanner({super.key});

  @override
  State<scanner> createState() => _scannerState();
}

class _scannerState extends State<scanner> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 5, 3, 85),
          centerTitle: true,
          title: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 6,
                child: Image.asset(
                  'assets/icon.jpg',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text('CANTEEN WORKER'),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: Text(
                'Scan the nfc bracelet',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Image.asset('assets/scan.jpg'),
            Padding(
              padding: const EdgeInsets.only(
                top: 25,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 5, 3, 85),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: MaterialButton(
                  textColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      FirebaseFirestore.instance
                          .collection('Mohamed')
                          .doc('NxfDLEYE0WI7I7Sa3BxS')
                          .collection('L_collection')
                          .get()
                          .then((value) {
                        if (value.docs.isNotEmpty) {
                          var id = FirebaseFirestore.instance
                              .collection('Mohamed')
                              .doc('NxfDLEYE0WI7I7Sa3BxS')
                              .collection('L_collection')
                              .orderBy('time stamp', descending: false);
                          id.snapshots().listen((event) {
                            var q = event.docs.last.id;
                            print(q);
                            // if (event == null) {
                            //   showToast(
                            //       text: 'read nfc first', color: Colors.amberAccent);
                            // }
                            // var k = await id.snapshots().length;
                            FirebaseFirestore.instance
                              ..collection('Countries')
                                  .doc('xXz0mjiHyWyjV4suHCQ4')
                                  .collection('Schools')
                                  .doc('iaa3NufaUPhjiRkO5LPK')
                                  .collection('Students')
                                  .where('uid', isEqualTo: q)
                                  .get()
                                  .then((value) {
                                value.docs.forEach((element) {
                                  allergies = element['allergies'];
                                });
                              });
                            print(allergies);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyHomePage()));
                            showToast(
                                text: 'nfc is readed',
                                color: Colors.amberAccent);
                          });
                        } else {
                          showToast(
                              text: 'Braclet is not scanned',
                              color: Colors.amberAccent);
                        }
                      });
                    });
                  },
                  child: Text('GO'),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 30),
            //   child: Text(
            //     "You'll enter automatically after scanning",
            //     style: TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
          ],
        ));
  }
}
