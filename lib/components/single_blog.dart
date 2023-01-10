// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:blog_app_fb/components/user_profile_comp.dart';
import 'package:blog_app_fb/screens/blog_related/blog_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SingleBlog extends StatelessWidget {
  SingleBlog({super.key});

  String img =
      "https://media.istockphoto.com/id/1270067126/photo/smiling-indian-man-looking-at-camera.jpg?s=612x612&w=0&k=20&c=ovIQ5GPurLd3mOUj82jB9v-bjGZ8updgy1ACaHMeEC0=";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: EdgeInsets.only(left: 12, right: 12, bottom: 8),
          child: UserProfileComp(),
        ),
        Image.network(
          img,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
        Container(
          margin: EdgeInsets.only(left: 12, right: 12, top: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // details sample text
            Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry it to make a type specimen book. It has survived not only five centuries,"),

            // read more button
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BlogDetails()));
                },
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
        )
      ]),
    );
  }
}
