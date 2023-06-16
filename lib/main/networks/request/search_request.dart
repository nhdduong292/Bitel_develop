import 'package:bitel_ventas/main/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchRequest {
  String service = "FTTH";
  String code = "";
  String actionCode = "";
  String status = "";
  String province = "";
  String staffCode = "";
  String fromDate = "";
  String toDate = "";

  List<String> listStatus(BuildContext context) {
    return [
      AppLocalizations.of(context)!.textCreateRequest,
      AppLocalizations.of(context)!.textSucceedSurvey,
      AppLocalizations.of(context)!.textDeploying,
      AppLocalizations.of(context)!.textWaittingRecovery,
      AppLocalizations.of(context)!.textWaitingChangePlan,
      AppLocalizations.of(context)!.textWaitingTransfer,
      AppLocalizations.of(context)!.textComplete,
      AppLocalizations.of(context)!.textCancel
    ];
  }

  List<String> listActionCode(BuildContext context) {
    return [
      AppLocalizations.of(context)!.textNewConnect,
      AppLocalizations.of(context)!.textCancelRequest,
    ];
  }

  SearchRequest();

  int getPositionStatus(BuildContext context) {
    if (status == AppLocalizations.of(context)!.textCreateRequest) {
      return 1;
    } else if (status == AppLocalizations.of(context)!.textSucceedSurvey) {
      return 2;
    } else if (status == AppLocalizations.of(context)!.textDeploying) {
      return 3;
    } else if (status == AppLocalizations.of(context)!.textWaittingRecovery) {
      return 4;
    } else if (status == AppLocalizations.of(context)!.textWaitingChangePlan) {
      return 5;
    } else if (status == AppLocalizations.of(context)!.textWaitingTransfer) {
      return 6;
    } else if (status == AppLocalizations.of(context)!.textComplete) {
      return 7;
    } else if (status == AppLocalizations.of(context)!.textCancel) {
      return 8;
    }
    return 0;
  }

  // int getPositionStatus(BuildContext context) {
  //   if (status == AppLocalizations.of(context)!.textCreateRequest) {
  //     return 0;
  //   } else if (status ==
  //       AppLocalizations.of(context)!.textCreateRequestWithout) {
  //     return 1;
  //   } else if (status ==
  //       AppLocalizations.of(context)!.textSurveyOfflineSuccess) {
  //     return 2;
  //   } else if (status == AppLocalizations.of(context)!.textConnected) {
  //     return 3;
  //   } else if (status == AppLocalizations.of(context)!.textDeploying) {
  //     return 4;
  //   } else if (status == AppLocalizations.of(context)!.textComplete) {
  //     return 5;
  //   } else if (status == AppLocalizations.of(context)!.textCancel) {
  //     return 6;
  //   }
  //   return 7;
  // }

  void reset() {
    service = "FTTH";
    code = "";
    actionCode = "";
    status = "";
    province = "";
    staffCode = "";
    fromDate = "";
    toDate = "";
  }
}
