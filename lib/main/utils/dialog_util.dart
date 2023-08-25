import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../res/app_colors.dart';
import '../../res/app_images.dart';
import '../../res/app_styles.dart';
import 'common_widgets.dart';

class SystemErrorDialog extends Dialog {
  String text;

  SystemErrorDialog({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 22,
            ),
            SvgPicture.asset(AppImages.imgNotify),
            const SizedBox(
              height: 15,
            ),
            Text(
              AppLocalizations.of(context)!.textSystemError,
              style: AppStyles.r16,
            ),
            const SizedBox(
              height: 16,
            ),
            const DottedLine(
              dashColor: AppColors.colorLineDash,
              dashGapLength: 3,
              dashLength: 4,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                text,
                style: AppStyles.r15,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: bottomButton(
                        text: AppLocalizations.of(context)!.textCancel,
                        onTap: () {
                          Get.back();
                        })),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class SystemErrorLoginDialog extends Dialog {
  String text;
  Function onOk;

  SystemErrorLoginDialog({super.key, required this.text, required this.onOk});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Đặt hành vi bạn muốn khi người dùng nhấn nút "Back" ở đây
        // Trả về true nếu bạn muốn cho phép quay lại, trả về false nếu muốn chặn
        return false;
      },
      child: Dialog(
        alignment: Alignment.bottomCenter,
        insetPadding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Wrap(children: [
          Column(
            children: [
              const SizedBox(
                height: 22,
              ),
              SvgPicture.asset(AppImages.imgNotify),
              const SizedBox(
                height: 15,
              ),
              Text(
                AppLocalizations.of(context)!.textSystemError,
                style: AppStyles.r16,
              ),
              const SizedBox(
                height: 16,
              ),
              const DottedLine(
                dashColor: AppColors.colorLineDash,
                dashGapLength: 3,
                dashLength: 4,
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  text,
                  style: AppStyles.r15,
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: bottomButton(
                          text: AppLocalizations.of(context)!.textOk,
                          onTap: () {
                            Get.back();
                            onOk();
                          })),
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ]),
      ),
    );
  }
}

class SuccessDialog extends Dialog {
  String text;
  Function onOk;

  SuccessDialog({super.key, required this.text, required this.onOk});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Wrap(children: [
        Column(
          children: [
            const SizedBox(
              height: 22,
            ),
            SvgPicture.asset(AppImages.imgCongratulations),
            const SizedBox(
              height: 15,
            ),
            Text(
              AppLocalizations.of(context)!.textSuccessAPI,
              style: AppStyles.b00A5B1_20_500.copyWith(fontSize: 14),
            ),
            const SizedBox(
              height: 16,
            ),
            const DottedLine(
              dashColor: AppColors.colorLineDash,
              dashGapLength: 3,
              dashLength: 4,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                text,
                style: AppStyles.r15,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: bottomButton(
                        text: AppLocalizations.of(context)!.textOk,
                        onTap: () {
                          Get.back();
                          onOk();
                        })),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ]),
    );
  }
}

class ConnectionErrorDialog extends Dialog {
  String text;

  ConnectionErrorDialog({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 22,
            ),
            Image.asset(
              AppImages.icNoConnection,
              fit: BoxFit.fitHeight,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              AppLocalizations.of(context)!.textConnectionError,
              style: AppStyles.r16,
            ),
            const SizedBox(
              height: 16,
            ),
            const DottedLine(
              dashColor: AppColors.colorLineDash,
              dashGapLength: 3,
              dashLength: 4,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                text,
                style: AppStyles.r15,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: bottomButton(
                        text: AppLocalizations.of(context)!.textCancel,
                        onTap: () {
                          Get.back();
                        })),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class SystemWarningFingerDialog extends Dialog {
  String text;
  Function onContinue;

  SystemWarningFingerDialog(
      {super.key, required this.text, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 22,
            ),
            SvgPicture.asset(AppImages.icWarningNew),
            const SizedBox(
              height: 15,
            ),
            Text(
              AppLocalizations.of(context)!.textWarning,
              style: AppStyles.rF7A55A_13_500,
            ),
            const SizedBox(
              height: 16,
            ),
            const DottedLine(
              dashColor: AppColors.colorLineDash,
              dashGapLength: 3,
              dashLength: 4,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                text,
                style: AppStyles.r15,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: bottomButtonV2(
                        text: AppLocalizations.of(context)!.textCancel,
                        onTap: () {
                          Get.back();
                        })),
                Expanded(
                    child: bottomButton(
                        text: AppLocalizations.of(context)!.textContinue,
                        onTap: () {
                          Get.back();
                          onContinue();
                        })),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class SystemWarningDialog extends Dialog {
  String text;

  SystemWarningDialog({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 22,
            ),
            SvgPicture.asset(AppImages.icWarningNew),
            const SizedBox(
              height: 15,
            ),
            Text(
              AppLocalizations.of(context)!.textWarning,
              style: AppStyles.rF7A55A_13_500,
            ),
            const SizedBox(
              height: 16,
            ),
            const DottedLine(
              dashColor: AppColors.colorLineDash,
              dashGapLength: 3,
              dashLength: 4,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                text,
                style: AppStyles.r15,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: bottomButton(
                        text: AppLocalizations.of(context)!.textCancel,
                        onTap: () {
                          Get.back();
                        })),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
