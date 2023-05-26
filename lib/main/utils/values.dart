class Values {
  static const String KEY_GOOGLE_DETECT =
      "931E36A11718B4CB29813F343916B97EBE28982C0B5EB8B2E9CB4A1803738F1A4B0D7F2D5254079D47FD707F1500795B";
}

class Reason {
  static const String REASON_REQUEST = "REQUEST";
  static const String REASON_REQUEST_CANCEL = "CANCEL";
  static const String REASON_REQUEST_TRANSFER = "TRANSFER";
  static const String REASON_SURVEY = "SURVEY";
  static const String REASON_DEPLOYMENT = "DEPLOYMENT";
}

class Permission {
  static const String CONTRACTING = "CONTRACTING";
  static const String TRANSFER_REQUEST = "TRANSFER_REQUEST";
  static const String MBCCS_FTTH_REQUEST = "MBCCS_FTTH.REQUEST";
  static const String CREATE_REQUEST = "CREATE_REQUEST";
  static const String MBCCS_FTTH_SURVEY = "MBCCS_FTTH.SURVEY";
  static const String SURVEY_ONLINE = "SURVEY_ONLINE";
  static const String MBCCS_FTTH_CONTRACT = "MBCCS_FTTH.CONTRACT";
}

class RequestStatus {
  static const String CREATE_REQUEST = "CREATE_REQUEST";
  static const String CREATE_REQUEST_WITHOUT_SURVEY =
      "CREATE_REQUEST_WITHOUT_SURVEY";
  static const String SURVEY_OFFLINE_SUCCESSFULLY =
      "SURVEY_OFFLINE_SUCCESSFULLY";
  static const String SUCCEED_SURVEY = "SUCCEED_SURVEY";
  static const String CONNECTED = "CONNECTED";
  static const String DEPLOYING = "DEPLOYING";
  static const String COMPLETE = "COMPLETE";
  static const String CANCEL = "CANCEL";
  static const String ALL = "";
}
