// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/res/app_images.dart';
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

Widget inputLogin({required icon, required String label, required String hint}) {
  return Container(
    padding: EdgeInsets.all(20),
    child: Row(
      children: [
        Icon(Icons.person),
      ],
    ),
  );
}