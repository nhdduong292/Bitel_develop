class ApiEndPoints {
  static const String DOMAIN = "http://10.121.14.196:9092";
  static const String DOMAIN_TEST = "http://10.121.14.196:9092";
  static const bool isDev = true;
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
  static const String API_LOGIN = "http://10.121.14.196:9093/login";

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
  static const String API_UPLOAD_FILE =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/file";
}
