import 'package:canteen2/cart.dart';
import 'package:canteen2/shopping.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'shopping.dart';
import 'dart:typed_data';

class addItem extends StatefulWidget {
  const addItem({super.key});

  @override
  State<addItem> createState() => _addItemState();
}

class _addItemState extends State<addItem> {
  Uint8List? _image;
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController category = TextEditingController();
  String profilePicLink = " ";
  int? pricee;
  String? namee;

  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );
    Reference ref = FirebaseStorage.instance.ref().child("profilepic.jpg");
    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) async {
      setState(() {
        profilePicLink = value;
      });
    });
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }

  selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im!;
    });
  }

  //   await ref.putFile(File(image!.path));

  //   ref.getDownloadURL().then((value) async {
  //     setState(() {
  //       profilePicLink = value;
  //     });
  //   });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 5, 3, 85),
          centerTitle: true,
          title: Text(
            'Add product',
            style: TextStyle(color: Colors.white),
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 225, 233, 247),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(20),
                      child: GestureDetector(
                          onTap: pickUploadProfilePic,
                          child: profilePicLink == " "
                              ? const CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage(
                                      'https://www.shutterstock.com/image-vector/outline-add-product-vector-icon-600w-1454270585.jpg'),
                                )
                              : CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage(profilePicLink),
                                )),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'add name',
                    ),
                    controller: name,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'add price',
                    ),
                    controller: price,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'add category',
                    ),
                    controller: category,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 5, 3, 85),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: MaterialButton(
                      onPressed: () {
                        if (profilePicLink == " " ||
                            price.text.isEmpty ||
                            name.text.isEmpty ||
                            category.text.isEmpty) {
                          showToast(
                              text: 'fill in all product info',
                              color: Colors.amberAccent);
                        } else {
                          pricee = int.parse(price.text);
                          Map<String, dynamic> dataToSave = {
                            'product': name.text,
                            'price': pricee,
                            'image': profilePicLink,
                          };
                          FirebaseFirestore.instance
                              .collection('categories')
                              .doc('${category.text}')
                              .collection('products')
                              .add(dataToSave);
                          setState(() {
                            name = TextEditingController();
                            price = TextEditingController();
                            category = TextEditingController();

                            profilePicLink = " ";
                          });
                          showToast(
                              text: 'Added to products',
                              color: Colors.amberAccent);
                        }
                      },
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text('add product',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
