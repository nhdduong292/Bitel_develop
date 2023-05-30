class Values {
  static final String KEY_GOOGLE_DETECT =
      "931E36A11718B4CB29813F343916B97EBE28982C0B5EB8B2E9CB4A1803738F1A4B0D7F2D5254079D47FD707F1500795B";
}

class Reason {
  static final String REASON_REQUEST = "REQUEST";
  static final String REASON_REQUEST_CANCEL = "CANCEL";
  static final String REASON_REQUEST_TRANSFER = "TRANSFER";
  static final String REASON_SURVEY = "SURVEY";
  static final String REASON_DEPLOYMENT = "DEPLOYMENT";
}

class RequestStatus {
  static final String CREATE_REQUEST = "CREATE_REQUEST";
  static final String CREATE_REQUEST_WITHOUT_SURVEY =
      "CREATE_REQUEST_WITHOUT_SURVEY";
  static final String SURVEY_OFFLINE_SUCCESSFULLY =
      "SURVEY_OFFLINE_SUCCESSFULLY";
  static final String SUCCEED_SURVEY = "SUCCEED_SURVEY";
  static final String CONNECTED = "CONNECTED";
  static final String DEPLOYING = "DEPLOYING";
  static final String COMPLETE = "COMPLETE";
  static final String CANCEL = "CANCEL";
  static final String ALL = "";
}

class ProductStatus {
  static final String Create = "CREATE";
  static final String ReSelect = "RESELECT";
  static final String Change = "CHANGE";
}
