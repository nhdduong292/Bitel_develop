class UserModel {
  //{sub: NAMPT_VTP, STAFF_CODE: NAMPT_VTP, SHOP_CODE: VTP, NAME: PHAM TIEN NAM, STAFF_ID: 108043763, SHOP_ID: 7282, iss: https://bitel.com.pe, iat: 1678419510, exp: 1678505910}
  String? _sub;
  String? _staffCode;
  String? _shopCode;
  String? _name;
  int? _staffId;
  int? _shopId;
  String? _iss;
  List<dynamic> functions = [];
  int? _iat;
  int? _exp;
  int? _idType;
  String? _idNo;

  UserModel();

  UserModel.fromJson(Map<String, dynamic> json) {
    _sub = json['sub'];
    _staffCode = json['STAFF_CODE'];
    _shopCode = json['SHOP_CODE'];
    _name = json['NAME'];
    _staffId = json['STAFF_ID'];
    _shopId = json['SHOP_ID'];
    _iss = json['iss'];
    _iat = json['iat'];
    _exp = json['exp'];
    _idType = json['ID_TYPE'];
    functions = json['FUNCTIONS'];
    _idNo = json['ID_NO'];
  }

  String get sub => _sub ?? "";

  String get staffCode => _staffCode ?? "";

  int get exp => _exp ?? 0;

  int get iat => _iat ?? 0;

  String get iss => _iss ?? "";

  int get shopId => _shopId ?? 0;

  int get staffId => _staffId ?? 0;

  String get name => _name ?? "";

  String get shopCode => _shopCode ?? "";

  int get idType => _idType ?? 0;

  String get idNo => _idNo ?? "";
}
