// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:blog_app_fb/components/tags.dart';
import 'package:blog_app_fb/components/user_profile_comp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BlogDetails extends StatefulWidget {
  const BlogDetails({super.key});

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  String img =
      "https://media.istockphoto.com/id/1270067126/photo/smiling-indian-man-looking-at-camera.jpg?s=612x612&w=0&k=20&c=ovIQ5GPurLd3mOUj82jB9v-bjGZ8updgy1ACaHMeEC0=";

  List someItems = [1, 2, 3, 4, 5, 6, 7];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // stack img/backicon/profile/fav etc content
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  img,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // top icon
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5, top: 20),
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
                        onPressed: () {},
                        icon: Icon(Icons.favorite),
                      ),
                    ],
                  ),
                ),

                // profile of writer
                Container(
                  margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UserProfileComp(),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //like/comment/view and date container
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    iconComp(icon: Icons.favorite, count: "2"),
                    SizedBox(width: 7),
                    iconComp(icon: Icons.chat, count: "5"),
                    SizedBox(width: 7),
                    iconComp(icon: Icons.remove_red_eye, count: "5"),
                  ],
                ),
                Text("10/12/22"),
              ],
            ),
          ),

          // tags
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Row(
              children: [
                tags(text: "#laptop"),
                SizedBox(width: 8),
                tags(text: "#hello"),
              ],
            ),
          ),

          // scrolllable content!!!!
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                // Bottom content goes here
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,"),
                    ),

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
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return commentsComp();
                                }),
                          )),
                    ),

                    // user comments
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // bottom flotaing action bi=utton and content
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
                          onPressed: () {},
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

  Widget commentsComp() => Container(
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
                        Text("name"),
                        SizedBox(
                          height: 6,
                        ),
                        Text("comment"),
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
