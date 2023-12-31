class HomeSaleModel {
  int waitingOfflineSurvey = 0;
  int cancelled = 0;
  int waitingDeployment = 0;
  int waitingConnection = 0;
  int completeInstallation = 0;
  int waitingRecovery = 0;
  int waitingChangePlan = 0;
  int waitingTransfer = 0;
  int kpi = 0;
  int performance = 0;
  double commission = 0;
  double anyPayBalance = 0;

  HomeSaleModel();

  HomeSaleModel.fromJson(Map<String, dynamic> json) {
    waitingOfflineSurvey = json['waitingOfflineSurvey'];
    cancelled = json['cancelled'];
    waitingDeployment = json['waitingDeployment'];
    waitingConnection = json['waitingConnection'];
    completeInstallation = json['completeInstallation'];
    waitingRecovery = json['waitingRecovery'];
    waitingChangePlan = json['waitingChangePlan'];
    waitingTransfer = json['waitingTransfer'];
    kpi = json['kpi'];
    performance = json['performance'];
    commission = json['commission'];
    anyPayBalance = json['anyPayBalance'];
  }
}
