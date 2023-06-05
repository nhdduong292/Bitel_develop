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
  static final String CONTRACTING = "CONTRACTING";
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

class ContractStatus {
  static final String New = "NEW";
  static final String Change_plan = "CHANGE_PLAN";
}

class ActionType {
  static final String type_00 = "00";
  static final String type_90 = "90";
}

class ValidateFingerStatus {
  static final String STAFF_CANCEL_SERVICE = "STAFF_CANCEL_SERVICE";
  static final String STAFF_CHANGE_PLAN = "STAFF_CHANGE_PLAN";
  static final String CUSTOMER_CHANGE_PLAN = "CUSTOMER_CHANGE_PLAN";
  static final String CUSTOMER_CANCEL_SERVICE = "CUSTOMER_CANCEL_SERVICE";
  static final String MAIN = "MAIN";
  static final String LENDING = "LENDING";
}

class ContractType {
  static final String UNDETERMINED = "UNDETERMINED";
  static final String FORCED_TERM = "FORCED_TERM";
}

class AfterSaleStatus {
  static final String CHANGE_PLAN = "CHANGE_PLAN";
  static final String TRANSFER_SERVICE = "TRANSFER_SERVICE";
  static final String CANCEL_SERVICE = "CANCEL_SERVICE";
}
