// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:blog_app_fb/components/single_blog.dart';
import 'package:blog_app_fb/components/user_profile_comp.dart';
import 'package:blog_app_fb/screens/account.dart';
import 'package:blog_app_fb/screens/auth/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 25),
        child: Column(
          children: [
            // topProfile content!!
            Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  width: 1,
                  color: Colors.grey.shade300,
                )),
              ),
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // left content
                    Expanded(
                      child: GestureDetector(
                        child: UserProfileComp(),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AccountPage()));
                        },
                      ),
                    ),
                    // right bell button
                    IconButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                        },
                        icon: Icon(Icons.notifications))
                  ],
                ),
              ),
            ),

            // rest of bottom content

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("allblogs")
                      .snapshots(),
                  builder: (context, snapshot) {
                    // loading data
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    // data content
                    if (snapshot.hasData != null) {
                      return ListView.builder(
                        padding: EdgeInsets.only(top: 10),
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          return SingleBlog();
                        }),
                      );
                    }

                    // no data content
                    return Center(
                      child: Text("No data Till now"),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
