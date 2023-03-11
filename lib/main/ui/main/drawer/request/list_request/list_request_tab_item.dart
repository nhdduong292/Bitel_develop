import 'package:bitel_ventas/main/custom_views/line_dash.dart';
import 'package:bitel_ventas/main/networks/model/request_model.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListRequestTabItem extends StatelessWidget{
  RequestModel requestModel;

  ListRequestTabItem(this.requestModel, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 16,bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const LineDash(color: AppColors.colorLineDash),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16,top: 16),
            child: Row(
              children: [
                Text(AppLocalizations.of(context)!.textRequestCode, style: AppStyles.r8.copyWith(fontWeight: FontWeight.w400, color: AppColors.colorText2.withOpacity(0.85)),),
                Expanded(child: Text(requestModel.code.toString(), style: AppStyles.r8.copyWith(fontWeight: FontWeight.w500, color: AppColors.colorText4,),textAlign: TextAlign.right,))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16,top: 12),
            child: Row(
              children: [
                Text(AppLocalizations.of(context)!.textCustomerInformation, style: AppStyles.r8.copyWith(fontWeight: FontWeight.w400, color: AppColors.colorText2.withOpacity(0.85)),),
                Expanded(child: Text("${requestModel.name}, ${requestModel.phone}", style: AppStyles.r8.copyWith(fontWeight: FontWeight.w500, color: AppColors.colorText4),textAlign: TextAlign.right))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16,top: 12),
            child: Row(
              children: [
                Text(AppLocalizations.of(context)!.textSurveyAddress, style: AppStyles.r8.copyWith(fontWeight: FontWeight.w400, color: AppColors.colorText2.withOpacity(0.85)),),
                Expanded(child: Text(requestModel.getInstalAddress(), style: AppStyles.r8.copyWith(fontWeight: FontWeight.w500, color: AppColors.colorText4),textAlign: TextAlign.right))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16,top: 12),
            child: Row(
              children: [
                Text(AppLocalizations.of(context)!.textStatus, style: AppStyles.r8.copyWith(fontWeight: FontWeight.w400, color: AppColors.colorText2.withOpacity(0.85)),),
                Expanded(child: Text(requestModel.getStatus(context), style: AppStyles.r8.copyWith(fontWeight: FontWeight.w500, color: AppColors.colorContent),textAlign: TextAlign.right))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16,top: 12),
            child: Row(
              children: [
                Text(AppLocalizations.of(context)!.textInstallationAddress, style: AppStyles.r8.copyWith(fontWeight: FontWeight.w400, color: AppColors.colorText2.withOpacity(0.85)),),
                Expanded(child: Text(requestModel.getInstalAddress(), style: AppStyles.r8.copyWith(fontWeight: FontWeight.w500, color: AppColors.colorText4),textAlign: TextAlign.right))
              ],
            ),
          ),
        ],
      ),
    );
  }
}