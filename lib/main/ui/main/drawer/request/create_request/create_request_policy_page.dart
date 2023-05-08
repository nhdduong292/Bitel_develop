import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../../utils/common_widgets.dart';

class CreateRequestPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18, bottom: 18, top: 2),
          child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
            child: SvgPicture.asset(AppImages.icBack),
            onTap: () {
              Get.back();
            },
          ),
        ),
        elevation: 0.0,
        title: Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Text(AppLocalizations.of(context)!.textPolicy,
              style: AppStyles.title),
        ),
        toolbarHeight: 100,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: AppColors.colorBackground,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(width / 2, 20),
                  bottomRight: Radius.elliptical(width / 2, 20))),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 10),
              child: Text(AppLocalizations.of(context)!.textTitlePolicy,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 10),
              child: Text(AppLocalizations.of(context)!.textContentPolicy),
            ),
            bottomButton(
              onTap: () {
                Get.back();
              },
              text: AppLocalizations.of(context)!.textContinue.toUpperCase(),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
