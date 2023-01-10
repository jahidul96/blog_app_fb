// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:blog_app_fb/screens/auth/login.dart';
import 'package:blog_app_fb/screens/home.dart';
import 'package:blog_app_fb/utils/needed_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  // initialized category
  String categorie = "";

  // loadder indicator
  bool loadding = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  // selectCategories func
  Future selectCategories() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
                width: double.infinity,
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: AppNeededData.categories.map((category) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          categorie = category;
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        alignment: Alignment.center,
                        color: Colors.grey.shade300,
                        margin: EdgeInsets.only(bottom: 6),
                        child: Text(category),
                      ),
                    );
                  }).toList(),
                )),
          );
        });
  }

// signin func
  Future signIn() async {
    setState(() {
      loadding = true;
    });
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      Map<String, dynamic> userData = {
        "username": usernameController.text,
        "email": emailController.text,
        "uid": credential.user!.uid,
        "categorie": categorie,
        "profilePic": "",
        "createdAt": DateTime.now(),
      };

      if (credential.user != null) {
        FirebaseFirestore.instance
            .collection("blogUsers")
            .doc(credential.user!.uid)
            .set(userData)
            .then((value) {
          print("data added in firestore!!");
        });

        setState(() {
          loadding = false;
        });

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
      ;
    } on PlatformException catch (e) {
      setState(() {
        loadding = false;
      });
      print("some problem occuerd $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // lodder show when signin happening!!
      body: loadding
          ? Center(
              child: CircularProgressIndicator(),
            )

          // content
          : Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Username",
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Email",
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Password",
                    ),
                  ),
                  // select categories
                  GestureDetector(
                    onTap: selectCategories,
                    child: Container(
                      margin: EdgeInsets.only(top: 15, bottom: 20),
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            categorie.isNotEmpty
                                ? categorie
                                : "Select Categories",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),

                          // check button
                          categorie.isNotEmpty
                              ? Icon(Icons.check)
                              : Icon(Icons.create),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: MaterialButton(
                        color: Colors.amber,
                        onPressed: signIn,
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an Account ?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                        },
                        child: Text(
                          "Login here!",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
