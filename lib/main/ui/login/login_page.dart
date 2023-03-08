import 'package:bitel_ventas/main/ui/login/login_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginPage extends GetWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder(
      init: LoginLogic(),
      builder: (controller) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              constraints: BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImages.bgLogin), fit: BoxFit.cover),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
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
                  KeyboardVisibilityBuilder(builder: (context, visible) {
                    if (!visible) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Image.asset(
                            AppImages.icConceptLogin,
                            height: 240,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                  // const SizedBox(
                  //   height: 100,
                  // ),
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
                          autofocus: true,
                          controller: controller.controllerUser,
                          focusNode: controller.focusUser,
                          onChanged: (value) {
                            controller.setStateUser(false);
                          },
                          cursorColor: AppColors.colorText1,
                          decoration: InputDecoration(
                            errorText: controller.isSubmitUser
                                ? (controller.controllerPass.value.text.length <
                                        6
                                    ? ""
                                    : null)
                                : null,
                            hintText: "Enter user name",
                            labelText: "Username",
                            labelStyle:
                                const TextStyle(color: AppColors.colorText1),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                  left: 19, right: 10, bottom: 8),
                              child: SvgPicture.asset(AppImages.icLoginUser),
                            ),
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.transparent)),
                            errorBorder: const UnderlineInputBorder(
                              //<-- SEE HERE
                              borderSide:
                                  BorderSide(width: 1, color: Colors.redAccent),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              //<-- SEE HERE
                              borderSide: BorderSide(
                                  width: 1, color: Colors.transparent),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.transparent),
                            ),
                            prefixIconConstraints: const BoxConstraints(
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
                          obscureText: controller.isShowPass.value,
                          focusNode: controller.focusPass,
                          controller: controller.controllerPass,
                          cursorColor: AppColors.colorText1,
                          onChanged: (value) {
                            controller.setStatePass(false);
                          },
                          decoration: InputDecoration(
                            errorText: controller.isSubmitPass
                                ? (controller.controllerPass.value.text.length <
                                        6
                                    ? ""
                                    : null)
                                : null,
                            hintText: "Enter password",
                            labelText: "Password",
                            labelStyle:
                                const TextStyle(color: AppColors.colorText1),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                  left: 19, right: 10, bottom: 8),
                              child: SvgPicture.asset(AppImages.icLoginPass),
                            ),
                            // filled: true,
                            // fillColor: Colors.white,
                            // border: InputBorder.none,
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.transparent)),
                            errorBorder: const UnderlineInputBorder(
                              //<-- SEE HERE
                              borderSide:
                                  BorderSide(width: 1, color: Colors.redAccent),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              //<-- SEE HERE
                              borderSide: BorderSide(
                                  width: 1, color: Colors.transparent),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.transparent),
                            ),
                            suffixIcon: InkWell(
                              onTap: () {
                                controller
                                    .setShowPass(!controller.isShowPass.value);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 18, top: 14),
                                child: controller.isShowPass.value
                                    ? SvgPicture.asset(
                                        AppImages.icLoginShowPass)
                                    : SvgPicture.asset(
                                        AppImages.icLoginOffPass),
                              ),
                            ),
                            prefixIconConstraints: const BoxConstraints(
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
                            child: InkWell(
                          onTap: () {
                            controller.setRememberAccount(
                                !controller.isRememberAccount);
                          },
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 31,
                              ),
                              controller.isRememberAccount
                                  ? iconChecked()
                                  : iconUnchecked(),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Remember account",
                                style: AppStyles.r2
                                    .copyWith(color: AppColors.colorText1),
                              )
                            ],
                          ),
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
                      child: Center(
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
            ));
      },
    );
  }
}
