// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:blog_app_fb/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool loadding = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Future login() async {
    setState(() {
      loadding = true;
    });
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) {
        print("login done");

        setState(() {
          loadding = false;
        });

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    } on PlatformException catch (e) {
      print("some problem occuerd");
      setState(() {
        loadding = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loadding
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Email",
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Password",
                    ),
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: MaterialButton(
                        color: Colors.amber,
                        onPressed: login,
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
                        "Don't have an Account ?",
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
                          Navigator.pop(context);
                        },
                        child: Text(
                          "SignUp here!",
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
