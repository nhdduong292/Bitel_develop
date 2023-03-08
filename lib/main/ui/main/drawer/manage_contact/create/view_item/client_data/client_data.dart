// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/client_data/id_card_scanner.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../../../res/app_colors.dart';
import '../../../../../../../router/route_config.dart';
import '../../../../../../../utils/common_widgets.dart';
import 'client_data_logic.dart';

typedef void TouchUpadte();

class ClientDataWidget extends GetView<ClientDataLogic> {
  final TouchUpadte callback;
  ClientDataWidget({required this.callback});
  // final result = Get.to(IDCardScanner());
  var path = ''.obs;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: ClientDataLogic(),
        builder: (controller) {
          return SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  border: Border.all(
                    color: const Color(0xFFE3EAF2),
                    width: 1.0,
                  ),
                  boxShadow: [
                    const BoxShadow(
                      color: Color.fromRGBO(185, 212, 220, 0.2),
                      offset: Offset(0, 2),
                      blurRadius: 7.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Column(children: [
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 30,
                    child: Center(
                      child: Text(
                        'Client data',
                        style: AppStyles.r3,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  DottedLine(
                    dashColor: Color(0xFFE3EAF2),
                    dashGapLength: 3,
                    dashLength: 4,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(26),
                    dashPattern: [2, 2],
                    strokeWidth: 1,
                    color: Color(0xFF9454C9),
                    child: SizedBox(
                      width: 197,
                      height: 39,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'DNI: ',
                                  style: AppStyles.r3,
                                  children: [
                                    TextSpan(
                                      text: '001573053',
                                      style: AppStyles.r1,
                                    )
                                  ]),
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 39,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: infoClientView(
                                lable: 'Last name', content: 'Nguyen Trung'),
                          ),
                          Expanded(
                            flex: 1,
                            child: infoClientView(lable: 'Name', content: 'Ri'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: infoClientView(
                                lable: 'Nationality', content: 'Peru'),
                          ),
                          Expanded(
                            flex: 1,
                            child: infoClientView(
                                lable: 'Sex:', content: 'Female'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: infoClientView(
                                lable: 'Date of birth', content: '06/03/1990'),
                          ),
                          Expanded(
                            flex: 1,
                            child: infoClientView(
                                lable: 'Expired date', content: '15/07/2022'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      inputForm(
                          label: 'Address',
                          hint: 'Enter address',
                          required: false,
                          inputType: TextInputType.text),
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(onTap: () {
                        controller.getScan();
                      },
                      child: Container(
                        height: 48,
                        margin: EdgeInsets.only(left: 15, right: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: RadialGradient(
                            center: const Alignment(-0.3292, 0.3296),
                            radius: 1.2106,
                            colors: [
                              const Color(0xFF0FDDDB),
                              const Color(0xFF00A5B1)
                            ],
                            stops: [0, 1],
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 18,
                            ),
                            Expanded(
                                child: Text('Photo of identity card (front)')),
                            SvgPicture.asset(AppImages.icCameraRound),
                            SizedBox(
                              width: 8,
                            )
                          ],
                        ),
                      ),),
                      SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () async {
                          late List<CameraDescription> _cameras;
                          WidgetsFlutterBinding.ensureInitialized();

                          _cameras = await availableCameras();
                          Get.toNamed(RouteConfig.idCardScanner,
                                  arguments: _cameras)
                              ?.then((result) {
                            print(result);
                            path.value = result;
                          });
                        },
                        child: Stack(children: [
                          Center(
                              child:
                                  SvgPicture.asset(AppImages.icBorderIdentity)),
                          controller.textPathScan.isNotEmpty ? Image.file(File(controller.textPathScan),width: 290,
                            height: 160,) : Container(),
                          // Obx(
                          //   () => Visibility(
                          //     visible: path.value != '',
                          //     child: Center(
                          //         child: Container(
                          //       width: 290,
                          //       height: 160,
                          //       margin: EdgeInsets.all(4),
                          //       child: Image.file(File(path.value)),
                          //     )),
                          //   ),
                          // )
                        ]),
                      ),
                      SizedBox(
                        height: 42,
                      )
                    ],
                  )
                ]),
              ),
              Container(
                width: 310,
                margin:
                    EdgeInsets.only(top: 30, bottom: 36, left: 16, right: 16),
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.colorButton,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: InkWell(
                  onTap: () {
                    if(controller.textPathScan.isEmpty){
                      Common.showToastCenter("Bạn chưa chụp ảnh thẻ");
                    } else {
                      callback();
                    }
                  },
                  child: Center(
                      child: Text(
                    'UPDATE',
                    style: AppStyles.r5.copyWith(fontWeight: FontWeight.w500),
                  )),
                ),
              )
            ]),
          );
        });
  }

  Widget infoClientView({required String lable, required String content}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 17,
            ),
            Text(lable),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 17,
            ),
            Text(content),
          ],
        ),
      ],
    );
  }
}
