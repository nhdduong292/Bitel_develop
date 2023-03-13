import 'package:bitel_ventas/main/networks/model/address_model.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DialogAddressPage extends StatelessWidget{
  List<AddressModel> list;
  Function(AddressModel model) onSubmit;


  DialogAddressPage(this.list, this.onSubmit);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 2.0,
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(AppImages.icClose),
                )),
          ),
          Container(
            height: 300,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.back();
                    onSubmit.call(list[index]);
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Center(child: Text(list[index].name, style: AppStyles.r2.copyWith(
                          color: AppColors.colorTitle, fontWeight: FontWeight.w500)))),
                );
              },),
          ),
        ],
      ),
    );
  }

}