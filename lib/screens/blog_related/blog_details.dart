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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
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
                        onPressed: () {},
                        icon: Icon(Icons.chevron_left),
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
        ],
      )),
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
}
