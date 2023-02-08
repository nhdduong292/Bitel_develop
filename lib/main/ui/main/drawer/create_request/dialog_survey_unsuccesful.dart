import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../res/app_colors.dart';
import '../../../../../res/app_images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../custom_views/line_dash.dart';
import 'package:get/get.dart';

class DialogSurveyUnsuccessful extends StatelessWidget {
  final Function? onSubmit;

  const DialogSurveyUnsuccessful({super.key, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 22, left: 16, right: 16, bottom: 26),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppImages.icSurveyUnsuccessful),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                AppLocalizations.of(context)!.textTitleSurveyUnsuccessful,
                style: AppStyles.r6.copyWith(
                    color: AppColors.colorTextError,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const LineDash(color: AppColors.colorLineDash),
            ),
            Text(
              AppLocalizations.of(context)!.textContentSurveyUnsuccessful,
              style: AppStyles.r6.copyWith(
                  color: AppColors.colorText4, fontWeight: FontWeight.w500),
            ),
            Container(
              margin: EdgeInsets.only(left: 30),
              child: RadioListTile(
                contentPadding: EdgeInsets.all(0),
                activeColor: AppColors.colorText3,
                value: 1,
                groupValue: 1,
                onChanged: (value) {},
                title: Transform.translate(
                  offset: Offset(-15, 0),
                  child: Text(
                    AppLocalizations.of(context)!.textCreateOfflineSurvey,
                    style: AppStyles.r6.copyWith(
                        color: AppColors.colorText4, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 15),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Center(
                            child: Text(
                          AppLocalizations.of(context)!
                              .textCancel
                              .toUpperCase(),
                          style: AppStyles.r1
                              .copyWith(fontWeight: FontWeight.w500),
                        )),
                      ),
                    )),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 15),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.colorButton,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: InkWell(
                        onTap: () {
                          onSubmit!.call();
                        },
                        child: Center(
                            child: Text(
                          AppLocalizations.of(context)!
                              .textAccept
                              .toUpperCase(),
                          style: AppStyles.r5
                              .copyWith(fontWeight: FontWeight.w500),
                        )),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
