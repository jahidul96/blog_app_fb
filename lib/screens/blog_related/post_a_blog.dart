// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:math';

import 'package:blog_app_fb/components/button_widget.dart';
import 'package:blog_app_fb/components/single_blog.dart';
import 'package:blog_app_fb/components/tags.dart';
import 'package:blog_app_fb/components/user_profile_comp.dart';
import 'package:blog_app_fb/utils/needed_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class PostBlogScreen extends StatefulWidget {
  const PostBlogScreen({super.key});

  @override
  State<PostBlogScreen> createState() => _PostBlogScreenState();
}

class _PostBlogScreenState extends State<PostBlogScreen> {
  // initialized image placeholder
  File? _image;

  // initialized category
  String categorie = "";

  // initialized desc/tags controller

  final descController = TextEditingController();
  final tagsController = TextEditingController();

  // from gallery
  Future pickFromGallery() async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (img == null) return;
      final tempImg = File(img.path);

      setState(() {
        _image = tempImg;
      });
    } on PlatformException catch (e) {
      print("error occuer's");
    }
  }

  // selectCategories func
  Future selectCategories() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
                width: double.infinity,
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: AppNeededData.categories.map((category) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          categorie = category;
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        alignment: Alignment.center,
                        color: Colors.grey.shade300,
                        margin: EdgeInsets.only(bottom: 6),
                        child: Text(category),
                      ),
                    );
                  }).toList(),
                )),
          );
        });
  }

// postDataFunc
  Future postDataFunc() async {
    final tagArray = tagsController.text.split(' ');
    Map<String, dynamic> postData = {
      "postImg": _image,
      "categorie": categorie,
      "description": descController.text,
      "tags": tagArray,
      "createdAt": DateTime.now(),
    };

    print("ALL USER TYPED DATA!!");
    print(postData);
  }

  // previewPost func

  previewPost() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: previewPostWidget(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        iconTheme: IconThemeData.fallback(),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              // after img pic img show!!
              _image != null
                  ? GestureDetector(
                      onTap: pickFromGallery,
                      child: Image.file(
                        _image!,
                        width: 200,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    )
                  :
                  // image adding placeholder!!
                  GestureDetector(
                      onTap: pickFromGallery,
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        child: Center(
                            child: Column(
                          children: [
                            Icon(Icons.image),
                            SizedBox(height: 7),
                            Text(
                              "Add a Featured Image",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )),
                      ),
                    ),

              // select categories
              GestureDetector(
                onTap: selectCategories,
                child: Container(
                  margin: EdgeInsets.only(top: 30, bottom: 20),
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        categorie.isNotEmpty ? categorie : "Select Categories",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),

                      // check button
                      categorie.isNotEmpty
                          ? Icon(Icons.check)
                          : Icon(Icons.create),
                    ],
                  ),
                ),
              ),

              // decriptionbox
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 160,
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    controller: descController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Description...",
                    ),
                  ),
                ),
              ),

              // tags container
              Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: tagsController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      hintText: "Tags.."),
                ),
              ),

              // buttons
              buttons(onPress: previewPost, btnText: "Preview"),
              SizedBox(
                height: 20,
              ),
              buttons(onPress: postDataFunc, btnText: "Post"),
            ],
          ),
        ),
      ),
    );
  }

  // previewPostWidget content
  Widget previewPostWidget() => Container(
        margin: EdgeInsets.only(top: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 8),
            child: UserProfileComp(),
          ),
          Image.file(
            _image!,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, top: 8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // details sample text
              Text(descController.text.toString()),

              // tags
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: tagsController.text
                      .split(' ')
                      .map((tag) => tags(text: tag))
                      .toList(),
                ),
              ),
              // read more button
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Read more",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ))
            ]),
          ),

          // post button
          Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: buttons(onPress: postDataFunc, btnText: "Post")),
        ]),
      );
}
