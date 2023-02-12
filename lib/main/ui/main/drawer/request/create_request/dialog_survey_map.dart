import 'dart:async';

import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';

class DialogSurveyMap extends StatelessWidget {
  final Function? onSubmit;
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  DialogSurveyMap({super.key, this.onSubmit});

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

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
            Container(
                alignment: Alignment.centerRight,
                child: SvgPicture.asset(AppImages.icClose)),
            Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                initialCameraPosition: _kGooglePlex,
                mapType: MapType.hybrid,
              ),
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 30),
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
                        child:  Center(
                            child: Text(
                              AppLocalizations.of(context)!.textConnect.toUpperCase(),
                              style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),
                            )),
                      ),
                    )),
                SizedBox(width: 15,),
                Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.colorButton,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          onSubmit!.call();
                        },
                        child:  Center(
                            child: Text(
                              AppLocalizations.of(context)!.textSurvey.toUpperCase(),
                              style: AppStyles.r5.copyWith(fontWeight: FontWeight.w500),
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
