import 'dart:ui';

import 'package:bitel_ventas/main/ui/login/login_binding.dart';
import 'package:bitel_ventas/main/ui/login/login_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/clear_debt_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/buy_anypay/buy_anypay_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/buy_anypay/create_order/create_oder_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/buy_anypay/order_management/order_management_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/product/product_payment_method_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/after_sale_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/after_sale_search_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/cancel_service_pdf/cancel_service_pdf_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/cancel_service_success/cancel_service_success.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/clear_penalty/clear_penalty_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/date_cancel_service/date_cancel_service.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/dialog_cancel_service/dialog_cancel_service.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/manage_wo/manage_wo_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/client_data/id_card_scanner.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/sale/sale_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/create_request_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/list_request_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/request_detail/request_detail_page.dart';
import 'package:bitel_ventas/main/ui/main/main_binding.dart';
import 'package:bitel_ventas/main/ui/main/setting/my_info/my_info_page.dart';
import 'package:bitel_ventas/main/ui/main/setting/sync_data/sync_data_page.dart';
import 'package:get/get.dart';
import 'package:bitel_ventas/main/ui/forgotPassword/forgot_password.dart';

import '../ui/main/drawer/contracting/customer_information/customer_information_page.dart';
import '../ui/main/drawer/contracting/ftth_contracting/ftth_contracting_page.dart';
import '../ui/main/drawer/manage_contact/create/view_item/register_finger_print/register_finger_print_page.dart';
import '../ui/main/drawer/contracting/validate_fingerprint/validate_fingerprint.dart';
import '../ui/main/drawer/manage_contact/create/create_contact_page.dart';
import '../ui/main/drawer/manage_contact/manage/manage_contact_page.dart';
import '../ui/main/main_page.dart';
import '../ui/main/setting/regiester_finger/register_finger_page.dart';

class RouteConfig {
  ///name page
  static const String login = "/login";
  static const String main = "/main";
  static const String myInfo = "/setting/myInfo";
  static const String syncData = "/setting/syncData";
  static const String registerFinger = "/setting/registerFinger";
  static const String manageContact = "/menu/manageContact";
  static const String forgotPassword = "/forgotPassword";
  static const String createRequest = "/menu/CreaetRequest";
  static const String listRequest = "/menu/ListRequest";
  static const String requestDetail = "/menu/RequestDetail";
  static const String createContact = "/menu/createContact";
  static const String manageWO = "/menu/manageWO";
  static const String idCardScanner = "/createManage/idCardScanner";
  static const String afterSale = "/menu/ftth/aftersale";
  static const String sale = "/menu/ftth/sale";
  static const String productPayment = "/menu/contract/productandpayment";
  static const String customerInformation =
      "/menu/contracting/customerInformation";
  static const String validateFingerprint =
      "/menu/contracting/validateFingerprint";
  static const String ftthContracting = "/menu/contracting/ftthContracting";
  static const String registerFingerPrint =
      "/menu/contracting/registerFingerPrint";
  static const String clearDebt = "/sale/clearDebt";
  static const String afterSaleSearch = "/menu/afterSale/search";
  static const String buyAnyPay = "/menu/buyAnyPay";
  static const String createOrder = "/menu/buyAnyPay/createOrder";
  static const String orderManagement = "/menu/buyAnyPay/orderManagement";
  static const String clearPenalty =
      "/menu/ftth/aftersale/cancelService/clearPenalty";
  static const String cancelServicePDF =
      "/menu/ftth/aftersale/cancelService/pdf";
  static const String dateCancelService =
      "/menu/ftth/aftersale/dateCancelService";
  static const String cancelServiceInfor =
      "/menu/ftth/aftersale/cancelServiceInfor";

  ///page
  static final List<GetPage> getPages = [
    GetPage(name: login, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: main, page: () => MainPage(), binding: MainBinding()),
    GetPage(name: myInfo, page: () => MyInfoPage()),
    GetPage(name: syncData, page: () => SyncDataPage()),
    GetPage(name: registerFinger, page: () => RegisterFingerPage()),
    GetPage(name: manageContact, page: () => ManageContactPage()),
    GetPage(name: forgotPassword, page: () => ForgotPassword()),
    GetPage(name: createRequest, page: () => CreateRequestPage()),
    GetPage(name: listRequest, page: () => ListRequestPage()),
    GetPage(name: requestDetail, page: () => RequestDetailPage()),
    GetPage(name: createContact, page: () => CreateContactPage()),
    GetPage(name: manageWO, page: () => ManageWOPage()),
    GetPage(name: idCardScanner, page: () => IDCardScanner()),
    GetPage(name: afterSale, page: () => AfterSalePage()),
    GetPage(name: sale, page: () => SalePage()),
    GetPage(name: customerInformation, page: () => CustommerInformationPage()),
    GetPage(name: validateFingerprint, page: () => ValidateFingerprintPage()),
    GetPage(name: ftthContracting, page: () => FTTHContractingPage()),
    GetPage(name: registerFingerPrint, page: () => RegisterFingerPrintPage()),
    GetPage(name: productPayment, page: () => ProductPaymentMethodPage()),
    GetPage(name: clearDebt, page: () => ClearDebtPage()),
    GetPage(name: afterSaleSearch, page: () => AfterSaleSearchPage("", "")),
    GetPage(name: buyAnyPay, page: () => BuyAnyPayPage()),
    GetPage(name: createOrder, page: () => CreateOrderPage()),
    GetPage(name: orderManagement, page: () => OrderManagementPage()),
    GetPage(name: clearPenalty, page: () => ClearPenaltyPage()),
    GetPage(name: cancelServicePDF, page: () => CancelServicePDFPage()),
    GetPage(name: dateCancelService, page: () => DateCancelService()),
    GetPage(name: cancelServiceInfor, page: () => CancelServiceSuccess()),
  ];

  ///language
  static final List<Locale> listLanguage = [
    Locale('en', ''), // English, no country code
    Locale('vi', ''), // vn, no country code
    Locale('es', ''), // TBN, no country code
  ];
}
