// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:blog_app_fb/components/single_blog.dart';
import 'package:blog_app_fb/components/user_profile_comp.dart';
import 'package:blog_app_fb/screens/account.dart';
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
              height: 70,
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
                        onPressed: () {}, icon: Icon(Icons.notifications))
                  ],
                ),
              ),
            ),

            // rest of bottom content

            Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: ((context, index) {
                      return SingleBlog();
                    })))
          ],
        ),
      ),
    );
  }
}
