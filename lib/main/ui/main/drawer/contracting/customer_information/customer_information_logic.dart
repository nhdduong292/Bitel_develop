import 'dart:async';
import 'dart:io';

import 'package:bitel_ventas/main/networks/model/contract_model.dart';
import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../../networks/model/address_model.dart';

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
  bool isCamera = true;

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
    listPromotionId = data[5];
    packageId = data[6];
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

    showButtonContinue();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    titleScreen.value = AppLocalizations.of(context)!.textCustomerInformation;
    checkBypass();
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

  String getBillCycle(String billCycle) {
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

  var checkOption1 = false.obs;
  var checkOption2 = false.obs;
  var checkOption3 = false.obs;
  var checkOption4 = false.obs;

  Rx<String> contractLanguagetValue = 'SPANISH'.toUpperCase().obs;
  final contractLanguages = [
    'SHIPIBO_KONIBO',
    'ASHANINKA',
    'AYMARA',
    'SPANISH',
    'QUECHUA'
  ];

  void createContract(BuildContext context, Function(bool) isSuccess) {
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
      "email": customer.email.trim(),
      "protectionFilter": checkOption1.value,
      "receiveInfoByMail": checkOption2.value,
      "receiveFromThirdParty": checkOption3.value,
      "receiveFromBitel": checkOption4.value
    };
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_CREATE_CONTRACT,
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

  bool checkValidateAddInfo() {
    if (phone.isEmpty) {
      Common.showToastCenter(AppLocalizations.of(context)!.textNotEmptyPhone);
      return true;
    } else if (email.isEmpty) {
      Common.showToastCenter(AppLocalizations.of(context)!.textNotEmptyEmail);
      return true;
    } else if (address.isEmpty) {
      Common.showToastCenter(AppLocalizations.of(context)!.textNotEmptyAddress);
      return true;
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
          AppLocalizations.of(context)!.textValidatePhoneNumber);
      return false;
    } else if (!Common.validateEmail(email)) {
      Common.showToastCenter(AppLocalizations.of(context)!.textValidateEmail);
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
        currentArea.precinct.isNotEmpty) {
      return true;
    }
    Common.showToastCenter(AppLocalizations.of(context)!.textInputInfo);
    return false;
  }

  bool validateBillAddress() {
    if (billArea.province.isNotEmpty &&
        billArea.district.isNotEmpty &&
        billArea.precinct.isNotEmpty) {
      return true;
    }
    Common.showToastCenter(AppLocalizations.of(context)!.textInputInfo);
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

  void updateCustomer(Function(bool isSuccess) callBack) {
    _onLoading(context);
    Map<String, dynamic> body = {
      "type": customer.type,
      "idNumber": customer.idNumber,
      "name": customer.name,
      "fullName": customer.fullName,
      "nationality": customer.nationality,
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
      url: '${ApiEndPoints.API_CREATE_CUSTOMER}/${customer.custId}',
      body: body,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          customer = CustomerModel.fromJson(response.data['data']);
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

  Future<List<AddressModel>> getAreas(String query) {
    Completer<List<AddressModel>> completer = Completer();
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
          Get.back();
          Common.showMessageError(error: error, context: context);
          completer.complete([]);
          // callBack.call(false);
        });
    return completer.future;
  }

  void checkBypass() {
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
          update();
        } else {}
      },
      onError: (error) {
        Get.back();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  uploadImage(BuildContext context, bool isMain) async {
    isCamera = false;
    if (isMain) {
      listFileMainContract.clear();
    } else {
      listFileLendingContract.clear();
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
        update();
      }
    } on Exception catch (e) {
      // TODO
      print(e.toString());
      Common.showToastCenter(e.toString());
    }
  }

  getFromGallery(BuildContext context, bool isMain) async {
    if (!isCamera) {
      if (isMain) {
        listFileMainContract.clear();
      } else {
        listFileLendingContract.clear();
      }
    }
    isCamera = true;
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
      onSuccess(false);
      print(e.toString());
    }
  }

  void uploadContract(var onSuccess) {
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

  void signContract(Function(bool) isSuccess, String type) {
    try {
      _onLoading(context);
      Completer<bool> completer = Completer();
      Map<String, dynamic> body = {
        "isBypass": true,
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
      Common.showToastCenter(e.toString());
    }
  }
}
