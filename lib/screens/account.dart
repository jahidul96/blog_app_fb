// ignore_for_file: prefer_const_constructors

import 'package:blog_app_fb/screens/blog_related/post_a_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String img =
      "https://media.istockphoto.com/id/1270067126/photo/smiling-indian-man-looking-at-camera.jpg?s=612x612&w=0&k=20&c=ovIQ5GPurLd3mOUj82jB9v-bjGZ8updgy1ACaHMeEC0=";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData.fallback(),
        title: Text(
          "Account",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // profile image and mail/name
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Center(
              child: Column(
                children: [
                  // image content
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      img,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // name
                  Text(
                    "Jahidul islam",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // email
                  Text(
                    "Jahidulislam@gmail.com",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // bottom content
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Colors.grey.shade200,
                ),
              ),
            ),
            child: Column(
              children: [
                clickableTextComp(text: "Update Profile Pic", index: 1),
                clickableTextComp(
                  text: "Profile",
                ),
                GestureDetector(
                  child: clickableTextComp(
                    text: "Post a Blog",
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostBlogScreen()));
                  },
                ),
                clickableTextComp(
                  text: "Favorites",
                ),
                clickableTextComp(
                  text: "Password & Security",
                ),
                clickableTextComp(
                  text: "Logout",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget clickableTextComp({required text, index}) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          top: index == 1
              ? BorderSide.none
              : BorderSide(
                  width: 1,
                  color: Colors.grey.shade200,
                ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 16,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.blueAccent,
            )
          ],
        ),
      ),
    );
  }
}
