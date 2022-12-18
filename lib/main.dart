import 'package:canteen2/addItem.dart';
import 'package:canteen2/cart.dart';
import 'package:canteen2/cart_provider.dart';
import 'package:canteen2/home.dart';
import 'package:canteen2/notification.dart';
import 'package:canteen2/shopping.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => CartProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CartModel(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

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
        children: const [
          homeScreen(),
          shoppingScreen(),
          addItem(),
          cart(),
          notification(),
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
                color: (_page == 0) ? Colors.blue : Colors.black,
                size: 45,
              ),
              label: '',
              backgroundColor: Colors.blueAccent,
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_shopping_cart_outlined,
                  color: (_page == 1) ? Colors.blue : Colors.black,
                  size: 45,
                ),
                label: '',
                backgroundColor: Colors.blueAccent),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle,
                  color: (_page == 2) ? Colors.blue : Colors.black,
                  size: 45,
                ),
                label: '',
                backgroundColor: Colors.blueAccent),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_basket_outlined,
                color: (_page == 3) ? Colors.blue : Colors.black,
                size: 45,
              ),
              label: '',
              backgroundColor: Colors.blueAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notification_add_sharp,
                color: (_page == 4) ? Colors.blue : Colors.black,
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
