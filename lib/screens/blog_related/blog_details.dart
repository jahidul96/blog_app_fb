// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:blog_app_fb/components/tags.dart';
import 'package:blog_app_fb/components/user_profile_comp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BlogDetails extends StatefulWidget {
  QueryDocumentSnapshot doc;
  BlogDetails(this.doc, {super.key});

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  // fb auth email
  final myEmail = FirebaseAuth.instance.currentUser!.email;

  // comment textController
  final commentTextController = TextEditingController();

  // local initializer
  List localCommentRef = [];
  List localLikesRef = [];

  // likeUnlikePost
  likeUnlikePost() async {
    if (localLikesRef.contains(myEmail)) {
      localLikesRef.remove(myEmail);
      try {
        await FirebaseFirestore.instance
            .collection("allblogs")
            .doc(widget.doc.id)
            .update({"likes": localLikesRef});
      } on PlatformException catch (e) {
        print(e);
      }
    } else {
      final updatedLikes = [...localLikesRef, myEmail];
      try {
        await FirebaseFirestore.instance
            .collection("allblogs")
            .doc(widget.doc.id)
            .update({"likes": updatedLikes});
      } on PlatformException catch (e) {
        print(e);
      }
    }
  }

  // comment on a post
  commentOnPost() async {
    Map<String, dynamic> comment = {
      "commentedBy": myEmail,
      "commentText": commentTextController.text,
      "commentedAt": DateTime.now(),
    };

    final updatedComments = [...localCommentRef, comment];

    try {
      await FirebaseFirestore.instance
          .collection("allblogs")
          .doc(widget.doc.id)
          .update({"comments": updatedComments});

      print("comment added!");
      Navigator.pop(context);
      commentTextController.clear();
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("allblogs")
            .doc(widget.doc.id)
            .snapshots(),
        builder: (context, snapshot) {
          // loadiing state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // data content
          if (snapshot.hasData != null) {
            final data = snapshot.data;
            localCommentRef = snapshot.data!["comments"];
            localLikesRef = snapshot.data!["likes"];

            return Column(
              children: [
                // stack img/backicon/profile/fav etc content
                Container(
                  alignment: Alignment.topLeft,
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        data!["blogImgUrl"],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // top icon
                  child: Container(
                    margin: EdgeInsets.only(left: 5, right: 5, top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: likeUnlikePost,
                          icon: Icon(Icons.favorite),
                        ),
                      ],
                    ),
                  ),
                ),

                //like/comment/view and date container
                Container(
                  margin:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          iconComp(
                              icon: Icons.favorite,
                              count: data["likes"].length.toString()),
                          SizedBox(width: 7),
                          iconComp(
                              icon: Icons.chat,
                              count: data["comments"].length.toString()),
                          SizedBox(width: 7),
                          iconComp(
                              icon: Icons.remove_red_eye,
                              count: data["clicks"].toString()),
                        ],
                      ),
                      Text("10/12/22"),
                    ],
                  ),
                ),

                // tags
                Container(
                  height: 30,
                  margin: EdgeInsets.only(left: 15, right: 15, bottom: 5),
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: data["tags"].length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            tags(text: data["tags"][index].toString()),
                          ],
                        );
                      }),
                ),

                // profile of writer
                Container(
                  margin:
                      EdgeInsets.only(bottom: 5, left: 15, right: 15, top: 5),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UserProfileComp(),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
                // scrolllable content!!!!
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      // Bottom content goes here
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            child: Text(data["description"]),
                          ),

                          // user comments
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ))),
                            child: Container(
                                margin: EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  top: 20,
                                ),
                                child: Expanded(
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: data["comments"].length,
                                      itemBuilder: (context, index) {
                                        return commentsComp(
                                          commentText: data["comments"][index]
                                              ["commentText"],
                                          commenterName: data["comments"][index]
                                              ["commentedBy"],
                                        );
                                      }),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          // no data content
          return Center(
            child: Text("oops something went wrong!!"),
          );
        },
      ),

      // bottom flotaing action button and content
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Container(
                  width: 300,
                  height: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // comment textfield
                      TextField(
                        controller: commentTextController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: "your comment...",
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          color: Colors.blue,
                          // adding comment

                          onPressed: commentOnPost,
                          child: Text(
                            "Add",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        label: Text(
          "Add comment!",
        ),
        icon: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget iconComp({required IconData icon, required count}) => Row(
        children: [
          Icon(
            icon,
            size: 17,
          ),
          SizedBox(width: 5),
          Text(count),
        ],
      );

  Widget commentsComp({required commentText, required commenterName}) =>
      Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.person),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(commenterName),
                        SizedBox(
                          height: 6,
                        ),
                        Text(commentText),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text("10.12.12")
                ],
              ),
            ),
          ],
        ),
      );
}
