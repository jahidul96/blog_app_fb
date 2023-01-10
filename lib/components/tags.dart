import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget tags({required text}) => Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 15, right: 15),
      margin: EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.shade200,
      ),
      child: Text(text),
    );
