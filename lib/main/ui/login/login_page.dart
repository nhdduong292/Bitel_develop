import 'package:bitel_ventas/main/ui/login/login_logic.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class LoginPage extends GetWidget {
  @override
  LoginLogic controller = Get.put(LoginLogic());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                constraints: const BoxConstraints.expand(),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.bgLogin), fit: BoxFit.cover),
                )),
            ElevatedButton(
                onPressed: () {
                  controller.loginSuccess();
                },
                child: Text(AppLocalizations.of(context)!.btnLogin)),
            Positioned(
              bottom: 15,
                child: Row(
                  children: [
                    Container(
                      child: Row(
                        children: [

                        ],
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
