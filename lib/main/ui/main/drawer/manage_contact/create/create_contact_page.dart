import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/cretate_contact_page_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../res/app_colors.dart';
import '../../../../../../res/app_images.dart';
import '../../../../../../res/app_styles.dart';

class CreateContactPage extends GetView<CreateContactPageLogic> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF8FBFB),
                ),
                width: width,
                height: 148,
              ),
              SvgPicture.asset(
                AppImages.bgAppbar,
                width: width,
              ),
              Positioned(
                top: 40,
                left: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.textActivatePrepaid,
                        style: AppStyles.title),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        SvgPicture.asset(AppImages.icTimeBar),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("28/12/2020 07:30 - V1.1", style: AppStyles.b1),
                        const SizedBox(
                          width: 20,
                        ),
                        SvgPicture.asset(AppImages.icAccountBar),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("GUADALUPECC-LI4", style: AppStyles.b1)
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                  top: 35,
                  left: 20,
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13)),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 15,
                          color: AppColors.colorTitle,
                        ),
                      ),
                    ),
                  )),
              Positioned(
                  top: 113,
                  width: width,
                  height: 28,
                  child: SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
