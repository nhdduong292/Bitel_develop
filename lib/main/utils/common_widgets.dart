// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget drawerItemWidget({required icon, required text}) {
  return InkWell(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),
          Padding(padding: EdgeInsets.only(left: 20)),
          Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ],
      ),
    ),
  );
}