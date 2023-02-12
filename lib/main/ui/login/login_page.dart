
import 'package:bitel_ventas/main/ui/login/login_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginPage extends GetWidget {
  FocusNode focusNode  = FocusNode ();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder(
      init: LoginLogic(),
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              SvgPicture.asset(
                AppImages.bgLogin,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 56),
                      child: Image.asset(
                        AppImages.icLogoSplash,
                        fit: BoxFit.cover,
                        width: 155,
                        height: 102,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Image.asset(
                        AppImages.icConceptLogin,
                        height: 240,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                      child: Container()),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          onTap: () {
                            FocusScope.of(context).requestFocus(focusNode);
                          },
                          autofocus:true,
                          controller: controller.controller,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            hintText: "Enter user name",
                            labelText: "Username",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 19, right: 10, bottom: 8),
                              child: SvgPicture.asset(AppImages.icLoginUser),
                            ),
                            border: InputBorder.none,
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 28,
                              minHeight: 28,
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1,
                          color: AppColors.colorLineDash,
                        ),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Enter password",
                            labelText: "Password",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 19, right: 10, bottom: 8),
                              child: SvgPicture.asset(AppImages.icLoginPass),
                            ),
                            // filled: true,
                            // fillColor: Colors.white,
                            border: InputBorder.none,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(left: 12, right: 18, top: 14),
                              child: SvgPicture.asset(AppImages.icLoginShowPass),
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 28,
                              minHeight: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        Expanded(
                            child: Row(
                          children: [
                            const SizedBox(
                              width: 31,
                            ),
                            iconChecked(),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Remember account",
                              style: AppStyles.r2
                                  .copyWith(color: AppColors.colorText1),
                            )
                          ],
                        )),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            "Forgot your password?",
                            style: AppStyles.r2
                                .copyWith(color: AppColors.colorContent),
                          ),
                        ))
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 30, left: 25, right: 25),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.colorButton,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: InkWell(
                      onTap: () {
                        controller.loginSuccess();
                      },
                      child:  Center(
                          child: Text(
                            AppLocalizations.of(context)!.btnLogin.toUpperCase(),
                            style: AppStyles.r5,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 12),
                    child: RichText(
                      text: TextSpan(
                        text: 'Copyright@Bitel: '.toUpperCase(),
                        style: AppStyles.r4,
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'V 1.7.2',
                              style: TextStyle(color: AppColors.colorContent)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
