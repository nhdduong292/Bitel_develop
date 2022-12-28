import 'package:bitel_ventas/main/ui/main/home/home_logic.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_styles.dart';

class HomePage extends GetView<HomeLogic> {
  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        6,
        (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 1,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(horizontal: 5,vertical: 4),
              child: Container(
                child: Center(
                    child: Text(
                  "Page $index",
                  style: TextStyle(color: Colors.indigo),
                )),
              ),
            ));
    return GetBuilder(
      init: HomeLogic(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            flexibleSpace: Container(
                child: FittedBox(
              fit: BoxFit.cover,
              child: SvgPicture.asset(AppImages.bgHome),
            )),
            toolbarHeight: 280,
            leading: GestureDetector(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: SvgPicture.asset(AppImages.icMenu),
                  )
                ],
              ),
              onTap: () {
                controller.openDrawer();
              },
            ),
            actions: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20, top: 20),
                    child: SvgPicture.asset(AppImages.icNotification),
                  )
                ],
              )
            ],
            title: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppImages.icAvatarDefault),
                  SizedBox(height: 10),
                  Text("Hola, Diego Guadalupe", style: AppStyles.b2),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("USUARIO", style: AppStyles.b3),
                          Text("GUADALUPECC-LI4", style: AppStyles.b1)
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                        child: VerticalDivider(
                          color: AppColors.colorLineVertical,
                          thickness: 1,
                          indent: 5,
                          endIndent: 0,
                          width: 38,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("USUARIO", style: AppStyles.b3),
                          Text("GUADALUPECC-LI4", style: AppStyles.b1)
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          body:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 17, bottom: 24),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text("Hola, Diego Guadalupe", style: AppStyles.b2),
                ),
              ),
              SizedBox(
                height: 240,
                child: PageView.builder(
                  controller: controller.controllerPage,
                  // itemCount: pages.length,
                  itemBuilder: (_, index) {
                    return pages[index % pages.length];
                  },
                ),
              ),
              const SizedBox(height: 20,),
              SmoothPageIndicator(
                controller: controller.controllerPage,
                count: pages.length,

                effect: const WormEffect(
                  dotHeight: 8,
                  dotWidth: 16,
                  spacing: 10,
                  activeDotColor: AppColors.colorSelectBottomBar,
                  dotColor: AppColors.colorDotIndicator,
                  type: WormType.thin,
                  // strokeWidth: 5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

