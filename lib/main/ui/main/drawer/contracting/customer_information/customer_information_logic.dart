import 'dart:async';
import 'dart:io';

import 'package:bitel_ventas/main/networks/model/contract_model.dart';
import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/networks/model/request_ott_service_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/product/product_payment_method_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/change_plan/information/infor_change_plan_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/request_detail/request_detail_logic.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../../networks/model/address_model.dart';
import '../../../../../services/connection_service.dart';
import '../../utilitis/info_bussiness.dart';

class CustomerInformationLogic extends GetxController {
  late BuildContext context;
  var checkItem1 = true.obs;
  var checkItem2 = false.obs;
  var checkItem3 = false.obs;
  var titleScreen = ''.obs;
  var isUpdate = false.obs;
  var signDate = ''.obs;
  var path = ''.obs;
  var checkOption = true.obs;
  var checkMainContract = true.obs;
  var checkLendingContract = false.obs;
  var billCycle = '';
  var checkConfirmContract = true.obs;
  int productId = 0;
  int reasonId = 0;
  List<int> listPromotionId = [];
  int packageId = 0;
  bool isForcedTerm = false;
  String phone = '';
  String email = '';
  String address = '';
  String billAddress = '';
  CustomerModel customer = CustomerModel();
  ContractModel contract = ContractModel();
  CustomerInformationLogic({required this.context});

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  AddressModel currentArea = AddressModel();
  List<AddressModel> listArea = [];

  AddressModel billArea = AddressModel();
  String billAddressSelect = "";

  String currentAddress = "";
  bool isAddContact = true;

  TextEditingController textFieldArea = TextEditingController();
  TextEditingController textFieldAddress = TextEditingController();

  FocusNode focusArea = FocusNode();
  FocusNode focusAddress = FocusNode();

  bool isValidateAddress = false;
  bool isActiveUpdate = true;
  bool isActiveContinue = false;

  RequestDetailModel requestModel = RequestDetailModel();

  final ItemScrollController scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  final FocusScopeNode focusScopeNode = FocusScopeNode();

  bool valueCheckBypass = false;
  bool isShowBypass = false;

  List<File> listFileMainContract = [];
  List<File> listFileLendingContract = [];
  File? pdfMainContract;
  File? pdfLendingContract;
  var pdf = pw.Document();
  var loadSuccess = false.obs;
  bool valueCheckBox = false;
  bool isCameraMain = true;
  bool isCameraLending = true;
  bool isLoadingConvertBase64 = false;
  String statusRequest = '';
  int contractRequestId = 0;

  String statusContract = '';
  int subId = 0;

  bool isLoadingMain = false;
  bool isLoadingLending = false;

  String paymentMethod = "";
  bool isVoiceContract = false;
  String voiceContractCallId = "";

  RxDouble progessValue = 0.0.obs;
  Uint8List? bytesPDF;
  String appointmentDate = '';
  String appointmentReason = '';
  TextEditingController tfNote = TextEditingController();
  FocusNode appointmenFocusNode = FocusNode();
  DateTime? datePicker;
  var fromDate = "".obs;
  var toDate = "".obs;
  var checkAppointmentDate = false.obs;

  List<RequestOTTServiceModel>? listRequestOTT;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    customer = data[0];
    requestModel = data[1];
    productId = data[2];
    reasonId = data[3];
    isForcedTerm = data[4];
    if (data[5] != null) {
      listPromotionId = data[5];
    } else {
      listPromotionId = [];
    }
    packageId = data[6];
    statusContract = data[7];

    if (statusContract == ContractStatus.Change_plan) {
      bool isExit = Get.isRegistered<InforChangePlanLogic>();
      if (isExit) {
        InforChangePlanLogic inforChangePlanLogic = Get.find();
        subId = inforChangePlanLogic.subId;
      }
    }
    phone = customer.telFax;
    email = customer.email;
    if (customer.address.isNotEmpty ||
        customer.province.isNotEmpty ||
        customer.district.isNotEmpty ||
        customer.precinct.isNotEmpty) {
      address = customer.getInstalAddress();
    } else {
      address = requestModel.getInstalAddress();
    }

    billAddress = requestModel.getInstalAddress();

    phoneController.text = phone;
    phoneController.selection =
        TextSelection.fromPosition(TextPosition(offset: phone.length));

    emailController.text = email;
    emailController.selection =
        TextSelection.fromPosition(TextPosition(offset: email.length));

    bool isExit = Get.isRegistered<RequestDetailLogic>();
    if (isExit) {
      RequestDetailLogic requestDetailLogic = Get.find();
      statusRequest = requestDetailLogic.requestModel.status;
      contractRequestId =
          requestDetailLogic.requestModel.contractModel.contractId;
      paymentMethod = requestDetailLogic.requestModel.paymentMethod;
      isVoiceContract = requestDetailLogic.requestModel.isVoiceContract;
      voiceContractCallId = requestDetailLogic.requestModel.callId.toString();
      if (isVoiceContract) {
        paymentMethod = PaymentType.BANK_CODE;
      }
    }
    bool isExitChooseProduct = Get.isRegistered<ProductPaymentMethodLogic>();
    if (isExitChooseProduct) {
      ProductPaymentMethodLogic productPaymentMethodLogic = Get.find();
      listRequestOTT = productPaymentMethodLogic.getJsonOTTService();
      paymentMethod = productPaymentMethodLogic.isPayBankCode
          ? PaymentType.BANK_CODE
          : PaymentType.CASH;
      isVoiceContract = productPaymentMethodLogic.checkVoiceContract.value;
      voiceContractCallId =
          productPaymentMethodLogic.voiceContractTextController.text.trim();
    }

    showButtonContinue();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    titleScreen.value = AppLocalizations.of(context)!.textCustomerInformation;
  }

  String getSex() {
    if (customer.sex == 'M') {
      return AppLocalizations.of(context)!.textMale;
    } else if (customer.sex == 'F') {
      return AppLocalizations.of(context)!.textFemale;
    }
    return '';
  }

  void getCurrentTime() {
    DateTime now = DateTime.now();
    if (now.day >= 6 && now.day < 16) {
      billCycle = 'CYCLE6';
    } else if (now.day >= 16 && now.day < 26) {
      billCycle = 'CYCLE16';
    } else {
      billCycle = 'CYCLE26';
    }
    signDate.value = DateFormat("yyyy-MM-ddTHH:mm:ss").format(now);
    update();
  }

  String getBillCycle() {
    if (statusContract == ContractStatus.Change_plan) {
      billCycle = contract.billCycleFrom;
    }
    if (billCycle.isEmpty) {
      return '---';
    }
    if (billCycle == 'CYCLE6') {
      return '${AppLocalizations.of(context)!.textCircle} 6';
    } else if (billCycle == 'CYCLE16') {
      return '${AppLocalizations.of(context)!.textCircle} 16';
    } else {
      return '${AppLocalizations.of(context)!.textCircle} 26';
    }
  }

  String getTypeCustomer() {
    // var type = customer.type;
    // if (type == 1) {
    //   return 'DNI';
    // } else if (type == 2) {
    //   return 'CE';
    // } else if (type == 3) {
    //   return 'RUC';
    // } else if (type == 4) {
    //   return 'PP';
    // } else if (type == 7) {
    //   return 'PTP';
    // } else if (type == 8) {
    //   return 'CPP';
    // }
    // return '';
    return customer.type;
  }

  var checkOption1 = true.obs;
  var checkOption2 = true.obs;
  var checkOption3 = true.obs;
  var checkOption4 = true.obs;

  Rx<String> contractLanguagetValue = 'SPANISH'.toUpperCase().obs;
  final contractLanguages = [
    'SHIPIBO_KONIBO',
    'ASHANINKA',
    'AYMARA',
    'SPANISH',
    'QUECHUA'
  ];

  void createContract(BuildContext context, Function(bool) isSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    Map<String, dynamic> body = {
      "requestId": requestModel.id,
      "productId": productId,
      "reasonId": reasonId,
      "packageId": packageId,
      "promotionId": listPromotionId,
      "contractType": isForcedTerm ? "FORCED_TERM" : "UNDETERMINED",
      "numOfSubscriber": 1,
      "signDate": signDate.value.trim(),
      "billCycle": billCycle,
      "changeNotification": "Email",
      "printBill": "Email",
      "currency": "SOL",
      "language": contractLanguagetValue.value.toUpperCase(),
      "province": billArea.province.isNotEmpty
          ? billArea.province
          : requestModel.province,
      "district": billArea.district.isNotEmpty
          ? billArea.district
          : requestModel.district,
      "precinct": billArea.precinct.isNotEmpty
          ? billArea.precinct
          : requestModel.precinct,
      "address": billAddressSelect.isNotEmpty
          ? billAddressSelect
          : requestModel.address,
      "phone": customer.telFax.trim(),
      "email": emailController.text.trim(),
      "protectionFilter": checkOption1.value,
      "receiveInfoByMail": checkOption2.value,
      "receiveFromThirdParty": checkOption3.value,
      "receiveFromBitel": checkOption4.value,
      "ottServices": listRequestOTT,
      "appointmentTime":
          checkAppointmentDate.value ? Common.formatDatePeru(datePicker) : null,
      "appointmentReason":
          checkAppointmentDate.value ? appointmentReason.trim() : null,
      "isVoiceContract": isVoiceContract
    };
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_CREATE_CONTRACT,
      body: body,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          print(response.data['data']);
          contract = ContractModel.fromJson(response.data['data']);
          isSuccess.call(true);
        } else {
          print("error: ${response.status}");
          isSuccess.call(false);
        }
      },
      onError: (error) {
        isSuccess.call(false);
        Get.back();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void updateContract(BuildContext context, Function(bool) isSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    Map<String, dynamic> body = {
      "requestId": requestModel.id,
      "productId": productId,
      "reasonId": reasonId,
      "packageId": packageId,
      "promotionId": listPromotionId,
      "contractType": isForcedTerm ? "FORCED_TERM" : "UNDETERMINED",
      "numOfSubscriber": 1,
      "signDate": signDate.value.trim(),
      "billCycle": billCycle,
      "changeNotification": "Email",
      "printBill": "Email",
      "currency": "SOL",
      "language": contractLanguagetValue.value.toUpperCase(),
      "province": billArea.province.isNotEmpty
          ? billArea.province
          : requestModel.province,
      "district": billArea.district.isNotEmpty
          ? billArea.district
          : requestModel.district,
      "precinct": billArea.precinct.isNotEmpty
          ? billArea.precinct
          : requestModel.precinct,
      "address": billAddressSelect.isNotEmpty
          ? billAddressSelect
          : requestModel.address,
      "phone": customer.telFax.trim(),
      "email": emailController.text.trim(),
      "protectionFilter": checkOption1.value,
      "receiveInfoByMail": checkOption2.value,
      "receiveFromThirdParty": checkOption3.value,
      "receiveFromBitel": checkOption4.value,
      "ottServices": listRequestOTT,
      "appointmentTime":
          checkAppointmentDate.value ? Common.formatDatePeru(datePicker) : null,
      "appointmentReason":
          checkAppointmentDate.value ? appointmentReason.trim() : null
    };
    ApiUtil.getInstance()!.put(
      url: "${ApiEndPoints.API_CREATE_CONTRACT}/$contractRequestId",
      params: {"id": contractRequestId},
      body: body,
      onSuccess: (response) {
        print('bxloc create contract success');
        Get.back();
        if (response.isSuccess) {
          print(response.data['data']);
          contract = ContractModel.fromJson(response.data['data']);
          isSuccess.call(true);
        } else {
          print("error: ${response.status}");
          isSuccess.call(false);
        }
      },
      onError: (error) {
        print('bxloc create contract false');
        isSuccess.call(false);
        Get.back();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void updateContractChangePlan(
      BuildContext context, Function(bool) isSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    Map<String, dynamic> body = {
      // "language": contractLanguagetValue.value.toUpperCase(),
      "province":
          billArea.province.isNotEmpty ? billArea.province : contract.province,
      "district":
          billArea.district.isNotEmpty ? billArea.district : contract.district,
      "precinct":
          billArea.precinct.isNotEmpty ? billArea.precinct : contract.precinct,
      "address": billAddressSelect.isNotEmpty && billArea.fullName.isNotEmpty
          ? '$billAddressSelect, ${billArea.fullName}'
          : contract.address,
      "protectionFilter": checkOption1.value,
      "receiveInfoByMail": checkOption2.value,
      "receiveFromThirdParty": checkOption3.value,
      "receiveFromBitel": checkOption4.value
    };
    ApiUtil.getInstance()!.put(
      url:
          "${ApiEndPoints.API_UPADTE_CONTRACT_CHANGE_PLAN}/${contract.contractId}",
      params: {"id": contract.contractId},
      body: body,
      onSuccess: (response) {
        print('bxloc create contract success');
        Get.back();
        if (response.isSuccess) {
          isSuccess.call(true);
        } else {
          print("error: ${response.status}");
          isSuccess.call(false);
        }
      },
      onError: (error) {
        print('bxloc create contract false');
        isSuccess.call(false);
        Get.back();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  bool checkValidateAddInfo() {
    if (phone.isEmpty) {
      Common.showToastCenter(
          AppLocalizations.of(context)!.textNotEmptyPhone, context);
      return true;
    } else if (email.isEmpty) {
      Common.showToastCenter(
          AppLocalizations.of(context)!.textNotEmptyEmail, context);
      return true;
    } else if (address.isEmpty) {
      Common.showToastCenter(
          AppLocalizations.of(context)!.textNotEmptyAddress, context);
      return true;
    } else if (checkAppointmentDate.value) {
      if (appointmentDate.isEmpty) {
        Common.showToastCenter(
            AppLocalizations.of(context)!.textCannotBeBlank, context);
        return true;
      } else if (appointmentReason.trim().isEmpty) {
        appointmenFocusNode.requestFocus();
        Common.showToastCenter(
            AppLocalizations.of(context)!.textCannotBeBlank, context);
        return true;
      }
    }
    return false;
  }

  bool checkValidateContractInfo() {
    // if(phone.isEmpty || email.isEmpty || address.isEmpty) {
    //   Common.showToastCenter("Vui lòng nhập đầy đủ thông tin!");
    //   return true;
    // }
    return false;
  }

  void _onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: LoadingCirculApi(),
        );
      },
    );
  }

  bool checkValidate() {
    if (!Common.validatePhone(phone)) {
      Common.showToastCenter(
          AppLocalizations.of(context)!.textValidatePhoneNumber, context);
      return false;
    } else if (!Common.validateEmail(email)) {
      Common.showToastCenter(
          AppLocalizations.of(context)!.textValidateEmail, context);
      return false;
    }
    return true;
  }

  void setAddress(String value) {
    currentAddress = value;
    update();
  }

  void setBillPrecinct(AddressModel value) {
    // if(value.areaCode == currentPrecinct.areaCode) return;
    billArea = value;
    textFieldArea.text = value.name;
    update();
  }

  void setBillAddress(String value) {
    billAddressSelect = value;
    update();
  }

  bool validateAddress() {
    if (currentArea.province.isNotEmpty &&
        currentArea.district.isNotEmpty &&
        currentArea.precinct.isNotEmpty &&
        textFieldAddress.text.isNotEmpty) {
      return true;
    }
    Common.showToastCenter(
        AppLocalizations.of(context)!.textInputInfo, context);
    return false;
  }

  bool validateBillAddress() {
    if (billArea.province.isNotEmpty &&
        billArea.district.isNotEmpty &&
        billArea.precinct.isNotEmpty &&
        textFieldAddress.text.isNotEmpty) {
      return true;
    }
    Common.showToastCenter(
        AppLocalizations.of(context)!.textInputInfo, context);
    return false;
  }

  bool checkChangeAdditionalInformation() {
    if (phoneController.text != customer.telFax) {
      return true;
    } else if (emailController.text != customer.email) {
      return true;
    } else if (currentArea.precinct != customer.precinct &&
        currentArea.precinct.isNotEmpty) {
      return true;
    } else if (currentAddress != customer.address &&
        currentAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void resetAdress() {
    textFieldArea.text = '';
    textFieldAddress.text = '';
    listArea.clear();
  }

  void resetBillAdress() {
    textFieldArea.text = '';
    textFieldAddress.text = '';
    listArea.clear();
  }

  void updateCustomer(Function(bool isSuccess) callBack) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    Map<String, dynamic> body = {
      "type": customer.type,
      "idNumber": customer.idNumber,
      "name": customer.name,
      "fullName": customer.fullName,
      "nationality": customer.type == 'DNI' && customer.nationality.isEmpty
          ? 'Peru'
          : customer.nationality,
      "sex": 'M',
      "dateOfBirth": customer.birthDate,
      "expiredDate": customer.idExpireDate,
      "address": currentAddress.isEmpty
          ? (customer.address.isNotEmpty
              ? customer.address
              : requestModel.address)
          : currentAddress,
      "province": currentArea.province.isEmpty
          ? (customer.province.isNotEmpty
              ? customer.province
              : requestModel.province)
          : currentArea.province,
      "district": currentArea.district.isEmpty
          ? (customer.district.isNotEmpty
              ? customer.district
              : requestModel.district)
          : currentArea.district,
      "precinct": currentArea.precinct.isEmpty
          ? (customer.precinct.isNotEmpty
              ? customer.precinct
              : requestModel.precinct)
          : currentArea.precinct,
      "phone": phoneController.text,
      "email": emailController.text,
      "image": [],
      "left": null,
      "leftImage": null,
      "right": null,
      "rightImage": null
    };
    ApiUtil.getInstance()!.put(
      url:
          '${statusContract == ContractStatus.Change_plan ? ApiEndPoints.API_UPADTE_CUSTOMER_CHANGE_PLAN : ApiEndPoints.API_CREATE_CUSTOMER}/${customer.custId}',
      body: body,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          if (statusContract != ContractStatus.Change_plan) {
            customer = CustomerModel.fromJson(response.data['data']);
          }
          callBack.call(true);
        } else {
          callBack.call(false);
        }
      },
      onError: (error) {
        Get.back();
        callBack.call(false);
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  Future<bool> onWillPop() async {
    if (itemPositionsListener.itemPositions.value.elementAt(0).index == 1) {
      checkItem1.value = true;
      checkItem2.value = false;
      titleScreen.value = AppLocalizations.of(context)!.textCustomerInformation;
      scrollController.scrollTo(
        index: 0,
        duration: const Duration(milliseconds: 200),
      );
      return false;
    } else if (itemPositionsListener.itemPositions.value.elementAt(0).index ==
        2) {
      checkItem2.value = true;
      checkItem3.value = false;
      scrollController.scrollTo(
        index: 1,
        duration: const Duration(milliseconds: 200),
      );
      return false;
    }
    Get.back();
    return false; //<-- SEE HERE
  }

  void showButtonContinue() {
    if (phoneController.text.isNotEmpty && emailController.text.isNotEmpty) {
      isActiveContinue = true;
      update();
    } else {
      isActiveContinue = false;
      update();
    }
  }

  Future<List<AddressModel>> getAreas(String query) async {
    Completer<List<AddressModel>> completer = Completer();
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      FocusScope.of(context).requestFocus(FocusNode());
      return completer.future;
    }
    ApiUtil.getInstance()!.get(
        url: ApiEndPoints.API_SEARCH_AREAS,
        params: {'key': query},
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            listArea = (response.data['data'] as List)
                .map((postJson) => AddressModel.fromJson(postJson))
                .toList();
            completer.complete(listArea);
          } else {
            print("error: ${response.status}");
            completer.complete([]);
          }
        },
        onError: (error) {
          Common.showMessageError(error: error, context: context);
          completer.complete([]);
          // callBack.call(false);
        });
    return completer.future;
  }

  void checkBypass(var onSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    Map<String, dynamic> params = {
      "idType": customer.type,
      "idNo": customer.idNumber
    };
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_CHECK_BUY_PASS,
      params: params,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          isShowBypass = true;
          // update();
          onSuccess(true);
        } else {}
      },
      onError: (error) {
        Get.back();
        onSuccess(false);
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  uploadImage(BuildContext context, bool isMain) async {
    if (isLoadingMain || isLoadingLending) {
      return;
    }
    if (isMain) {
      isLoadingMain = true;
      isCameraMain = false;
      listFileMainContract.clear();
      update();
    } else {
      isLoadingLending = true;
      isCameraLending = false;
      listFileLendingContract.clear();
      update();
    }
    try {
      final List<XFile> selectedImages = await ImagePicker().pickMultiImage();
      if (selectedImages.isNotEmpty) {
        for (var image in selectedImages) {
          if (isMain) {
            listFileMainContract.add(File(image.path));
          } else {
            listFileLendingContract.add(File(image.path));
          }
        }
      }
      isLoadingMain = false;
      isLoadingLending = false;
      update();
    } on Exception catch (e) {
      // TODO
      print(e.toString());
      Common.showToastCenter(e.toString(), context);
    }
  }

  getFromGallery(BuildContext context, bool isMain) async {
    if (!isCameraMain || !isCameraLending) {
      if (isMain && !isCameraMain) {
        isCameraMain = true;
        listFileMainContract.clear();
        update();
      } else {
        isCameraLending = true;
        listFileLendingContract.clear();
        update();
      }
    }

    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (isMain) {
        listFileMainContract.add(File(pickedFile!.path));
      } else {
        listFileLendingContract.add(File(pickedFile!.path));
      }
    } catch (e) {}
    update();
  }

  void showLoading() {
    _onLoading(context);
  }

  createPDF(bool isMain) async {
    pdf = pw.Document();
    List<File> list = [];
    if (isMain) {
      list = listFileMainContract;
    } else {
      list = listFileLendingContract;
    }
    for (var img in list) {
      final image = pw.MemoryImage(img.readAsBytesSync());
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context contex) {
            return pw.Center(child: pw.Image(image));
          }));
    }
  }

  savePDF(bool isMain, var onSuccess) async {
    try {
      final dir = Platform.isAndroid
          ? await getExternalStorageDirectory() //FOR ANDROID
          : await getApplicationSupportDirectory(); //FOR iOS
      if (isMain) {
        final file = File('${dir?.path}/main_contract.pdf');
        await file.writeAsBytes(await pdf.save());
        pdfMainContract = file;
      } else {
        final file = File('${dir?.path}/lending_contract.pdf');
        await file.writeAsBytes(await pdf.save());
        pdfLendingContract = file;
      }
      onSuccess(true);
    } catch (e) {
      isLoadingConvertBase64 = false;
      Get.back();
      Common.showMessageError(context: context, error: "");
      onSuccess(false);
      print(e.toString());
    }
  }

  void uploadContract(var onSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    Map<String, dynamic> body = {
      "mainContract": Common.convertImageFileToBase64(pdfMainContract!),
      "lendingContract": Common.convertImageFileToBase64(pdfLendingContract!)
    };
    ApiUtil.getInstance()!.put(
      url: ApiEndPoints.API_UPLOAD_CONTRACT
          .replaceAll('contractId', contract.contractId.toString()),
      body: body,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          onSuccess(true);
        } else {}
      },
      onError: (error) {
        Get.back();
        onSuccess(false);
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void signContract(Function(bool) isSuccess, String type) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    try {
      _onLoading(context);
      Completer<bool> completer = Completer();
      Map<String, dynamic> body = {
        "isBypass": true,
        "isUploadContractLate": valueCheckBox
      };
      Map<String, dynamic> params = {"type": type};
      ApiUtil.getInstance()!.put(
        url: ApiEndPoints.API_SIGN_CONTRACT
            .replaceAll('id', contract.contractId.toString()),
        body: body,
        params: params,
        onSuccess: (response) {
          Get.back();
          if (response.isSuccess) {
            isSuccess.call(true);
          } else {
            isSuccess.call(false);
            print("error: ${response.status}");
          }
        },
        onError: (error) {
          Get.back();
          isSuccess.call(false);
          Common.showMessageError(error: error, context: context);
        },
      );
    } catch (e) {
      Get.back();
      Common.showToastCenter(e.toString(), context);
    }
  }

  void getContractInfor() async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_GET_CONTRACT_INFO,
      params: {"subId": subId},
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          contract = ContractModel.fromJson(response.data['data']);
          contractLanguagetValue.value = contract.language;
          billAddress = contract.address;
          billAddressSelect = contract.address;
          billArea.province = contract.province;
          billArea.district = contract.district;
          billArea.precinct = contract.precinct;
          update();
        } else {}
      },
      onError: (error) {
        Get.back();

        Common.showMessageError(error: error, context: context);
      },
    );
  }

  String getSignDate() {
    String date = '---';
    if (statusContract == ContractStatus.Change_plan) {
      signDate.value = contract.signDate;
    }
    if (signDate.value.isNotEmpty) {
      date = Common.fromDate(DateTime.parse(signDate.value), 'dd/MM/yyyy');
    }
    return date;
  }

  String getQuantitySubscriber() {
    if (statusContract == ContractStatus.Change_plan) {
      if (contract.numOfSubscriber != 0) {
        return contract.numOfSubscriber.toString();
      } else {
        return '---';
      }
    } else {
      return '1';
    }
  }

  String getChangeNotification() {
    if (statusContract == ContractStatus.Change_plan) {
      return contract.changeNotification;
    } else {
      return AppLocalizations.of(context)!.textEmail;
    }
  }

  String getPrintBillDetail() {
    if (statusContract == ContractStatus.Change_plan) {
      return contract.printBill;
    } else {
      return AppLocalizations.of(context)!.textEmail;
    }
  }

  String getCurrency() {
    if (statusContract == ContractStatus.Change_plan) {
      return contract.currency;
    } else {
      return 'SOL';
    }
  }

  bool showBypass() {
    if (statusContract == ContractStatus.Change_plan) {
      return false;
    } else {
      if (customer.type == 'DNI' ||
          customer.type == 'CE' ||
          customer.type == 'PP') {
        var listPermission = InfoBusiness.getInstance()!.getUser().functions;
        if (listPermission.contains(UserPermission.BYPASS_FINGER)) {
          return true;
        }
        return false;
      }
    }
    return false;
  }

  void backToCustomerInfor() {
    checkItem1.value = true;
    checkItem2.value = false;
    titleScreen.value = AppLocalizations.of(context)!.textCustomerInformation;
    scrollController.scrollTo(
      index: 0,
      duration: const Duration(milliseconds: 200),
    );
  }

  bool isShowContinue() {
    if ((listFileMainContract.isNotEmpty &&
            listFileLendingContract.isNotEmpty) ||
        valueCheckBox) {
      return true;
    } else {
      return false;
    }
  }

  void signContractVoiceContract(String type, Function(bool) isSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    try {
      _onLoading(context);
      Map<String, dynamic> body = {
        "paymentMethod": paymentMethod,
        "isVoiceContract": isVoiceContract,
        "voiceContractCallId": voiceContractCallId
      };
      Map<String, dynamic> params = {"type": type};
      ApiUtil.getInstance()!.put(
        url: ApiEndPoints.API_SIGN_CONTRACT.replaceAll(
            'id',
            contractRequestId != 0
                ? contractRequestId.toString()
                : contract.contractId.toString()),
        body: body,
        params: params,
        onSuccess: (response) {
          Get.back();
          if (response.isSuccess) {
            isSuccess.call(true);
          } else {
            isSuccess.call(false);
            print("error: ${response.status}");
          }
        },
        onError: (error) {
          Get.back();
          isSuccess.call(false);
          Common.showMessageError(error: error, context: context);
        },
      );
    } catch (e) {
      Get.back();
      Common.showToastCenter(e.toString(), context);
    }
  }

  void _onLoadingDownload(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var height = MediaQuery.of(context).size.height;
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Column(
            children: [
              const Expanded(child: SizedBox()),
              LoadingCirculApi(),
              const SizedBox(
                height: 10,
              ),
              Obx(() => Text(
                    "${progessValue.value.toInt()}%",
                    style: const TextStyle(color: Colors.yellow),
                  )),
              const Expanded(child: SizedBox()),
            ],
          ),
        );
      },
    );
  }

  downloadPDF(var onSuccess) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt < 30) {
      PermissionStatus statusStorage = await Permission.storage.request();
      // Kiểm tra xem quyền đã được cấp hay chưa
      if (statusStorage.isGranted) {
        // Quyền đã được cấp, bạn có thể thực hiện các hành động liên quan đến bộ nhớ ngoài ở đây
        print('Quyền truy cập bộ nhớ ngoài đã được cấp!');
      } else {
        // Quyền không được cấp, bạn có thể hiển thị thông báo hoặc xử lý trường hợp khi không có quyền truy cập
        print('Quyền truy cập bộ nhớ ngoài không được cấp!');
        onSuccess(false);
        return;
      }
    } else {
      PermissionStatus status =
          await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        // Quyền đã được cấp, bạn có thể thực hiện các hành động liên quan đến bộ nhớ ngoài ở đây
        print('Quyền truy cập bộ nhớ ngoài đã được cấp!');
      } else {
        // Quyền không được cấp, bạn có thể hiển thị thông báo hoặc xử lý trường hợp khi không có quyền truy cập
        print('Quyền truy cập bộ nhớ ngoài không được cấp!');
        onSuccess(false);
        return;
      }
    }
    String type = "";
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    if (checkMainContract.value) {
      type = PDFType.MAIN;
    } else {
      type = PDFType.LENDING;
    }
    _onLoadingDownload(context);
    progessValue.value = 0;
    try {
      ApiUtil.getInstance()!.downloadPDF(
        url: ApiEndPoints.API_CONTRACT_PREVIEW
            .replaceAll("id", contract.contractId.toString()),
        params: {"type": type},
        onProgress: (value) {
          progessValue.value = value * 100;
        },
        onSuccess: (response) async {
          Get.back();
          bytesPDF = response.data;
          writeLogToFile(bytesPDF!, (isSuccess) {
            if (isSuccess) {
              onSuccess(true);
            }
          });
        },
        onError: (error) {
          onSuccess(false);
          Get.back();
        },
      );
    } catch (e) {
      Get.back();
      onSuccess(false);
      throw Exception('Error parsing asset file!');
    }
  }

  void writeLogToFile(Uint8List bytes, var onSuccess) async {
    try {
      String type = "";
      if (checkMainContract.value) {
        type = PDFType.MAIN;
      } else {
        type = PDFType.LENDING;
      }
      final directory = Platform.isAndroid
          ? Directory("/storage/emulated/0/Download") //FOR ANDROID
          : await getApplicationDocumentsDirectory(); //FOR iOS
      final file = File(
          '${directory.path}/${type == PDFType.MAIN ? AppLocalizations.of(context)!.textMainContract : AppLocalizations.of(context)!.textLendingContract}_${customer.fullName}.pdf');
      await file.writeAsBytes(bytes.toList());
      // ignore: use_build_context_synchronously
      onSuccess(true);
    } catch (e) {
      onSuccess(false);
    }
  }

  void setNote(String note) {
    appointmentReason = note;
    update();
  }

  void setFromDate(DateTime picked) {
    fromDate.value = DateFormat('dd/MM/yyyy HH:mm:ss').format(picked);
    update();
  }

  void setToDate(DateTime picked) {
    appointmentDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(picked);
    datePicker = picked;
    update();
  }

  bool isShowAppointment() {
    if (statusContract == ContractStatus.Change_plan) {
      return false;
    }
    return true;
  }

  bool isShowDownload() {
    if (statusContract == ContractStatus.Change_plan) {
      return false;
    }
    return true;
  }

  void validateEmailFromServer(var isSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    Map<String, dynamic> body = {
      "email": emailController.text.trim(),
    };
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_VALIDATE_EMAIL,
      params: body,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          isSuccess(true);
        } else {
          isSuccess(false);
        }
      },
      onError: (error) {
        Get.back();
        isSuccess(false);
        Common.showMessageError(error: error, context: context);
      },
    );
  }
}
