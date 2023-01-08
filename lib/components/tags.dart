import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget tags({required text}) => Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.shade200,
      ),
      child: Text(text),
    );