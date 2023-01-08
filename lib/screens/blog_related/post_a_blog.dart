// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:blog_app_fb/components/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PostBlogScreen extends StatefulWidget {
  const PostBlogScreen({super.key});

  @override
  State<PostBlogScreen> createState() => _PostBlogScreenState();
}

class _PostBlogScreenState extends State<PostBlogScreen> {
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
              // image adding placeholder!!
              Container(
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

              // select categories
              Container(
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
                      "Select Categories",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    Icon(Icons.create),
                  ],
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
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      hintText: "Tags.."),
                ),
              ),

              // buttons
              buttons(onPress: () {}, btnText: "Preview"),
              SizedBox(
                height: 20,
              ),
              buttons(onPress: () {}, btnText: "Post"),
            ],
          ),
        ),
      ),
    );
  }
}
