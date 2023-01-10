// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:blog_app_fb/components/user_profile_comp.dart';
import 'package:blog_app_fb/screens/account.dart';
import 'package:blog_app_fb/screens/auth/register.dart';
import 'package:blog_app_fb/screens/blog_related/blog_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> loggedinUser = {};

  @override
  void initState() {
    final user = FirebaseFirestore.instance
        .collection("blogUsers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    user.then((value) {
      print("username");
      print(value["username"]);
      print("u=id");
      print(value["uid"]);
      print("email");
      print(value["email"]);
    });

    super.initState();
  }

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
                        print(loggedinUser["email"]);
                      },
                      icon: Icon(Icons.notifications),
                    ),
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
                          return blogSingle(
                            snapshot.data!.docs[index],
                            () async {
                              // view or clicks update
                              try {
                                final totalClicks =
                                    snapshot.data!.docs[index]["clicks"] + 1;
                                await FirebaseFirestore.instance
                                    .collection("allblogs")
                                    .doc(snapshot.data!.docs[index].id)
                                    .update({"clicks": totalClicks});
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BlogDetails(snapshot.data!.docs[index]),
                                  ),
                                );
                              } on PlatformException catch (e) {
                                print(e);
                              }
                              ;
                            },
                          );
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

  // single blog!!!
  Widget blogSingle(QueryDocumentSnapshot doc, Function()? onPress) =>
      Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 8),
            child: UserProfileComp(),
          ),
          Image.network(
            doc["blogImgUrl"],
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, top: 8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // details sample text
              Text(doc["description"]),

              // read more button
              TextButton(
                  onPressed: onPress,
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
