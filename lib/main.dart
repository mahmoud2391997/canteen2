import 'package:canteen2/addItem.dart';
import 'package:canteen2/cart.dart';
import 'package:canteen2/cart_provider.dart';
import 'package:canteen2/home.dart';
import 'package:canteen2/notification.dart';
import 'package:canteen2/scanning.dart';
import 'package:canteen2/test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';
import 'categories.dart';
import 'category.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'notification.dart';
import 'history.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[300],
        primarySwatch: Colors.blue,
      ),
      home: const scanner(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          history(),
          categories(),
          // shoppingScreen(),
          addItem(),
          cart(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: Container(
        height: 100,
        margin: EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 24,
        ),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(2, 2),
              )
            ]),
        child: CupertinoTabBar(
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard,
                color:
                    (_page == 0) ? Color.fromARGB(255, 5, 3, 85) : Colors.black,
                size: 45,
              ),
              label: '',
              backgroundColor: Colors.blueAccent,
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_shopping_cart_outlined,
                  color: (_page == 1)
                      ? Color.fromARGB(255, 5, 3, 85)
                      : Colors.black,
                  size: 45,
                ),
                label: '',
                backgroundColor: Colors.blueAccent),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle,
                  color: (_page == 2)
                      ? Color.fromARGB(255, 5, 3, 85)
                      : Colors.black,
                  size: 45,
                ),
                label: '',
                backgroundColor: Colors.blueAccent),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_basket_outlined,
                color:
                    (_page == 3) ? Color.fromARGB(255, 5, 3, 85) : Colors.black,
                size: 45,
              ),
              label: '',
              backgroundColor: Colors.blueAccent,
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }
}
