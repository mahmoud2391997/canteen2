import 'package:canteen2/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class scanner extends StatelessWidget {
  const scanner({super.key});

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.only(top: 20, bottom: 20),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage()));
                  },
                  child: Text('GO'),
                ),
              ),
            ),
          ],
        ));
  }
}
