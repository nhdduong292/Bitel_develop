class ApiEndPoints{
   static final String DOMAIN = "http://10.121.14.196:9092";
   static final String DOMAIN_TEST = "http://10.121.14.196:9092";
   static final bool isDev = true;
   static final String API_LIST_REQUEST = "${isDev ? DOMAIN_TEST: DOMAIN}/v1/requests";
   static final String API_CREATE_REQUEST = "${isDev ? DOMAIN_TEST: DOMAIN}/v1/requests";
   static final String API_REQUEST_DETAIL = "${isDev ? DOMAIN_TEST: DOMAIN}/v1/requests";
   static final String API_CHANGE_STATUS_REQUEST = "/change-status";
   static final String API_TRANSFER_REQUEST = "/transfer";
   static final String API_REASONS = "${isDev ? DOMAIN_TEST: DOMAIN}/v1/reasons";
}