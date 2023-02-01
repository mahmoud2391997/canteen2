import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class history extends StatefulWidget {
  const history({super.key});

  @override
  State<history> createState() => _historyState();
}

int totalPiecies = 0;
int totalCash = 0;

class _historyState extends State<history> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 3, 85),
        title: Text('Dashboard'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            // border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 169, 166, 179),
                offset: Offset(2, 8),
                blurRadius: 10,
              ),
              BoxShadow(color: Color.fromARGB(255, 255, 255, 255))
            ]),
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 0.75,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                    // border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 169, 166, 179),
                        offset: Offset(2, 8),
                        blurRadius: 10,
                      ),
                      BoxShadow(color: Color.fromARGB(255, 255, 255, 255))
                    ]),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 5,
                child: Column(children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      // height: 190,
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.store_mall_directory,
                                color: Color.fromARGB(255, 5, 3, 85),
                              ),
                              Text(
                                " NUMBERS OF SALES",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 5, 3, 85),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Color.fromARGB(255, 5, 3, 85),
                            thickness: 5,
                            height: 10,
                            endIndent: 95,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              '$totalPiecies',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 5, 3, 85),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                    // border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 169, 166, 179),
                        offset: Offset(2, 8),
                        blurRadius: 10,
                      ),
                      BoxShadow(color: Color.fromARGB(255, 255, 255, 255))
                    ]),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 5,
                child: Column(children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      // height: 190,
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.attach_money_rounded,
                                color: Color.fromARGB(255, 5, 3, 85),
                              ),
                              Text(
                                " TOTAL CASH",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 5, 3, 85),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Color.fromARGB(255, 5, 3, 85),
                            thickness: 5,
                            height: 10,
                            endIndent: 160,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              '${totalCash} L.E',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 5, 3, 85),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Text(
                'History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 5, 3, 85),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
