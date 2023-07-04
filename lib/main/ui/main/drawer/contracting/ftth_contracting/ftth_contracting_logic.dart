import 'package:bitel_ventas/main/networks/model/contract_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';
import '../../../../../services/connection_service.dart';
import '../../../../../utils/common.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../utils/common_widgets.dart';

class FTTHContractingLogic extends GetxController {
  late BuildContext context;

  FTTHContractingLogic({required this.context});

  int contractId = 0;
  ContractModel contractModel = ContractModel();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    contractId = data[0];
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getContract();
  }

  void getContract() async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: '${ApiEndPoints.API_CREATE_CONTRACT}/${contractId.toString()}',
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          contractModel = ContractModel.fromJson(response.data['data']);
          update();
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        Get.back();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  String getTextBillCycle() {
    if (contractModel.billCycleFrom == 'CYCLE6') {
      return '${AppLocalizations.of(context)!.textCiclo} 6';
    } else if (contractModel.billCycleFrom == 'CYCLE16') {
      return '${AppLocalizations.of(context)!.textCiclo} 16';
    } else {
      return '${AppLocalizations.of(context)!.textCiclo} 26';
    }
  }

  String getOTTServiesName() {
    List<String> names = [];
    if (contractModel.subOtts.isEmpty) {
      return '---';
    } else {
      for (var item in contractModel.subOtts) {
        names.add(item.description);
      }
      return names.join(',');
    }
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
