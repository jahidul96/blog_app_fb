import 'package:flutter/cupertino.dart';

Widget UserProfileComp(String username, String categorie) {
  String img =
      "https://media.istockphoto.com/id/1270067126/photo/smiling-indian-man-looking-at-camera.jpg?s=612x612&w=0&k=20&c=ovIQ5GPurLd3mOUj82jB9v-bjGZ8updgy1ACaHMeEC0=";
  return Row(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          img,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            username.toUpperCase(),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(categorie),
        ],
      )
    ],
  );
}
