class ApiEndPoints {
  static final String DOMAIN = "http://10.121.14.196:9092";
  static final String DOMAIN_TEST = "http://10.121.14.196:9092";
  static final bool isDev = true;
  static final String API_LIST_REQUEST =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/requests";
  static final String API_CREATE_REQUEST =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/requests";
  static final String API_CHANGE_STATUS_REQUEST =
      "/change-status"; //todo dùng cho cả survey offline
  static final String API_REQUEST_DETAIL =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/requests";
  static final String API_TRANSFER_REQUEST = "/transfer";
  static final String API_REASONS =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/reasons";
  static final String API_SEARCH_CONTACT =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/contacts";
  static final String API_PROVINCES =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/areas/provinces";
  static final String API_PRECINCTS =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/areas/precincts";
  static final String API_DISTRICTS =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/areas/districts";
  static final String API_SURVEY = "${isDev ? DOMAIN_TEST : DOMAIN}/v1/surveys";
  static final String API_SURVEY_ONLINE = "/lock";
  static final String API_HOME_SALE =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/home-page/statistic";
  static final String API_LIST_PRODUCT =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/products";
  static final String API_CUSTOMER =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/customers/registered";
  static final String API_CREATE_CONTRACT =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/contracts";
  static final String API_CONTRACT_PREVIEW =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/contracts/id/preview";
  static final String API_LOGIN = "http://10.121.14.196:9093/login";

  static final String API_PLAN_REASON =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/plan-reasons";
  static final String API_WALLET =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/wallets/balance";
  static final String API_BEST_FINGER =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/customers/id/best-finger";
  static final String API_SIGN_CONTRACT =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/contracts/id/sign";
  static final String API_CREATE_CUSTOMER =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/customers";
  static final String API_REGISTER_FINGER =
      "${isDev ? DOMAIN_TEST : DOMAIN}/v1/customers/id/register-finger";
}
