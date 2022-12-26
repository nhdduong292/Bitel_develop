// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/res/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

import '../../res/app_colors.dart';

Widget drawerItemWidget(
    {required String imageUnselected,
    required text,
    required String imageSelected}) {
  var imagePath = imageUnselected.obs;
  var textColor = Colors.white.obs;
  return GestureDetector(
    onTap: () {
      imagePath = imageSelected.obs;
      textColor = AppColors.colorBackground.obs;
    },
    child: Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Obx(
        () => Row(
          children: [
            Image(
              image: Svg(imagePath.value),
              width: 34,
              height: 34,
            ),
            Padding(padding: EdgeInsets.only(left: 20)),
            Text(
              text,
              style: TextStyle(
                  color: textColor.value, fontSize: 20, fontFamily: AppFonts.Barlow),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget inputLogin(
    {required icon, required String label, required String hint}) {
  return Container(
    padding: EdgeInsets.all(20),
    child: Row(
      children: [
        Icon(Icons.person),
      ],
    ),
  );
}
