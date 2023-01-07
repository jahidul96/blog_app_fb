import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buttons({required onPress, required btnText}) => ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: MaterialButton(
          color: Colors.blue,
          onPressed: onPress,
          child: Text(
            btnText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
