import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/after_sale_search_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../networks/api_end_point.dart';
import '../../../../../../networks/api_util.dart';
import '../../../../../../networks/model/find_account_model.dart';
import '../../../../../../utils/common.dart';
import '../../../../../../utils/common_widgets.dart';

class FindServiceLogic extends GetxController {
  bool isActive = true;
  List<String> listIdentity = ["DNI", "CE", "PP"];
  String currentStatus = "";
  BuildContext context;
  String currentIdentityType = "";
  TextEditingController textFieldEnter = TextEditingController();
  String currentEnter = "";
  final FocusScopeNode focusScopeNode = FocusScopeNode();
  List<FindAccountModel> listAccount = [];

  AfterSaleSearchLogic afterSaleSearchLogic = Get.find();

  FindServiceLogic(this.context);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    currentStatus = getListStatus()[0];
    currentIdentityType = listIdentity[0];
    update();
  }

  void setStatus(String value) {
    currentStatus = value;
    update();
  }

  String getStatusCode() {
    if (currentStatus == AppLocalizations.of(context)!.textIdentityNumber) {
      return 'ID_NUMBER';
    } else if (currentStatus == AppLocalizations.of(context)!.textFTTHAccount) {
      return 'ACCOUNT';
    } else if (currentStatus == AppLocalizations.of(context)!.textPhoneNumber) {
      return 'PHONE_NUMBER';
    } else if (currentStatus ==
        AppLocalizations.of(context)!.textServiceNumber) {
      return 'SERVICE_CODE';
    }
    return '';
  }

  void setIdentity(String value) {
    currentIdentityType = value;
    update();
  }

  void setActiveButton(bool value) {
    isActive = value;
    update();
  }

  void setEnter(String value) {
    currentEnter = value;
    if (currentStatus == AppLocalizations.of(context)!.textIdentityNumber) {
      if (currentIdentityType == 'DNI' && currentEnter.length == 8) {
        setActiveButton(false);
      } else if (currentIdentityType == 'CE' && currentEnter.length == 9) {
        setActiveButton(false);
      } else if (currentIdentityType == 'PP' && currentEnter.length == 9) {
        setActiveButton(false);
      } else {
        setActiveButton(true);
      }
    } else {
      if (currentEnter.isNotEmpty) {
        setActiveButton(false);
      } else {
        setActiveButton(true);
      }
    }
    update();
  }

  List<String> getListStatus() {
    return [
      AppLocalizations.of(context)!.textIdentityNumber,
      AppLocalizations.of(context)!.textFTTHAccount,
      AppLocalizations.of(context)!.textPhoneNumber,
      AppLocalizations.of(context)!.textServiceNumber
    ];
  }

  int getMaxLengthIdNumber(String value) {
    if (value == listIdentity[0]) {
      return 8;
    } else if (value == listIdentity[2]) {
      return 9;
    } else {
      return 9;
    }
  }

  void getAccounts(var onSuccess) {
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_FIND_ACCOUNT,
      params: {
        'type': getStatusCode(),
        'idType': currentIdentityType,
        'value': currentEnter
      },
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          listAccount = (response.data['data'] as List)
              .map((postJson) => FindAccountModel.fromJson(postJson))
              .toList();
          afterSaleSearchLogic.listAccount = listAccount;
          onSuccess(true);
        } else {
          print("error: ${response.status}");
          onSuccess(false);
        }
        update();
      },
      onError: (error) {
        Get.back();
        onSuccess(false);
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void _onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: LoadingCirculApi(),
        );
      },
    );
  }
}
