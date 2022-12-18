import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class notify extends StatefulWidget {
  const notify({super.key});

  @override
  State<notify> createState() => _notifyState();
}

class _notifyState extends State<notify> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            border: Border.all(),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width / 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox.fromSize(
                  size: Size.fromRadius(20),
                  child: Image.network(
                    '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 90, top: 25),
              child: Column(
                children: [
                  Text(
                    '',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  Text(
                    '',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100, bottom: 20),
              child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 50,
                  ),
                  onPressed: (() {})),
            )
          ],
        ));
  }
}
