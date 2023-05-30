class ApiEndPoints {
  static const String DOMAIN = "http://181.176.242.147:9901/ftth";
  static const String DOMAIN_TEST = "http://10.121.14.196:9901";
  static const bool isDev = true; //todo true là test false la that
  static const String API_LIST_REQUEST =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/requests";
  static const String API_CREATE_REQUEST =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/requests";
  static const String API_CHANGE_STATUS_REQUEST =
      "/change-status"; //todo dùng cho cả survey offline
  static const String API_REQUEST_DETAIL =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/requests";
  static const String API_TRANSFER_REQUEST = "/transfer";
  static const String API_REASONS =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/reasons";
  static const String API_SEARCH_CONTACT =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/contacts";
  static const String API_PROVINCES =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/areas/provinces";
  static const String API_PRECINCTS =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/areas/precincts";
  static const String API_DISTRICTS =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/areas/districts";
  static const String API_SURVEY = "${isDev ? DOMAIN_TEST : DOMAIN}/v1/surveys";
  static const String API_SURVEY_ONLINE = "/lock";
  static const String API_HOME_SALE =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/home-page/statistic";
  static const String API_LIST_PRODUCT =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/products";
  static const String API_CUSTOMER =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/customers/registered";
  static const String API_CREATE_CONTRACT =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/contracts";
  static const String API_CONTRACT_PREVIEW =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/contracts/id/preview";
  static const String API_LOGIN = isDev
      ? "http://10.121.14.196:9093/login"
      : "http://181.176.242.147:9901/ftth_auth/login";

  // static const String API_LOGIN = "http://181.176.242.147:9901/ftth_auth/login";

  static const String API_PLAN_REASON =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/plan-reasons";
  static const String API_WALLET =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/wallets/balance";
  static const String API_BEST_FINGER =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/customers/id/best-finger";
  static const String API_SIGN_CONTRACT =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/contracts/id/sign";

  static const String API_DETECT_ID =
      "https://vision.googleapis.com/v1/images:annotate";
  static const String API_CREATE_CUSTOMER =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/customers";
  static const String API_REGISTER_FINGER =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/customers/id/register-finger";
  static const String API_GET_BUY_ANYPAY =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/buy-anypay/general-info";
  static const String API_GET_CAPTCHA =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/captcha";
  static const String API_CREATE_BUY_ANYPAY =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/buy-anypay/create";
  static const String API_CONFIRM_POST_BUY_ANYPAY =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/buy-anypay/confirm";
  static const String API_SEARCH_BUY_ANYPAY =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/buy-anypay";
  static const String API_UPLOAD_FILE =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/file";
  static const String API_LIST_PROMOTION =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/promotions";
  static const String API_LIST_STAFF =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/staffs";
  static const String API_DELETE_BUY_ANYPAY =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/buy-anypay/saleOrderId";
  static const String API_SEARCH_CLEAR_DEBT =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/clear-debt";
  static const String API_POST_CLEAR_DEBT =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/clear-debt";
  static const String API_PUT_CLEAR_DEBT =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/clear-debt/verify";
  static const String API_UPLOAD_IDENTIFY_CARD =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/file/identify-card";
  static const String API_POST_CONTRACT_INFORMATION =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/contracts/information";
  static const String API_CHECK_FINGER_EXIT =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/customers/check-finger-exist";
  static const String API_GET_PACKAGE =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/payment-packages";
  static const String API_CHECK_BALANCE =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/contracts/check-balance";
  static const String API_GET_CUSTOMER_EXIST =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/customers/exist";
  static const String API_SEARCH_AREAS =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/areas/search";
  static const String API_FIND_ACCOUNT =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/cancel-service/find-account";
  static const String API_REQUEST_CANNCEL =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/cancel-service/request-cancel/subId";
  static const String API_CONTRACT_PREVIEW_ORDER_ID =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/cancel-service/request-cancel/preview/orderId";
  static const String API_SIGN_CANCEL_SERVICE =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/cancel-service/request-cancel/sign/orderId";
  static const String API_GET_REASONS_CANCEL_SERVICE =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/reasons/cancel-service";
  static const String API_CHECK_DEBT_WO =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/cancel-service/check-debt-wo";
  static const String API_BEST_FINGER_STAFF =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/cancel-service/get-staff-sample-finger";
  static const String API_VALIDATE_STAFF_FINGER =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/cancel-service/validate-staff-finger";
  static const String API_CHECK_OLD_CANCEL_SERVICE =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/cancel-service/check-old-request/subId";
  static const String API_CHECK_BUY_PASS =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/customers/check-bypass";
  static const String API_UPLOAD_CONTRACT =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/contracts/contractId/upload-contract";
  static const String API_UPLOAD_IDENTITY_NEW =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/file/identify-card-base64";
  static const String API_GET_PRODUCT_CHANGE_PLAN =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/change-plan/get-product";
}
