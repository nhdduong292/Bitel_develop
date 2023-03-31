import 'dart:ui';

import 'item_infor.dart';

class CustomerPPModel {
  InformationCus number = InformationCus(type: 'GCMND');
  InformationCus lastname = InformationCus(type: 'pellidos');
  InformationCus midelname = InformationCus(type: 'ombres');
  InformationCus name = InformationCus(type: 'Họ');
  InformationCus nationality = InformationCus(type: 'uốc');
  InformationCus sex = InformationCus(type: 'iới');
  InformationCus dob = InformationCus(type: 'Ngày sinh');
  InformationCus ed = InformationCus(type: 'giá');

  InformationCus? getInformationCus(String text) {
    if (text.contains(lastname.type)) {
      return lastname;
    } else if (text.contains(name.type)) {
      return name;
    } else if (text.contains(nationality.type)) {
      return nationality;
    } else if (text.contains(sex.type)) {
      return sex;
    } else if (text.contains(dob.type)) {
      return dob;
    } else if (text.contains(ed.type)) {
      return ed;
    } else if (text.contains(number.type)) {
      return number;
    }
    return null;
  }

  void findInfo(Rect rect, String text) {
    if (lastname.rect != null) {
      if (lastname.rect!.bottom < rect.bottom &&
          rect.bottom < lastname.rect!.bottom + 35.0 &&
          rect.left < lastname.rect!.right) {
        var arrName = text.split(' ');
        if (arrName.length >= 2) {
          lastname.content = arrName[0];
          midelname.content = arrName[1];
        } else {
          lastname.content = text;
        }
        return;
      }
    }
    if (name.rect != null) {
      if ((name.rect!.bottom < rect.bottom &&
              rect.bottom < name.rect!.bottom + 50) &&
          rect.left < name.rect!.right) {
        var arrName = text.split(' ');
        if (arrName.length == 3) {
          lastname.content = arrName[0];
          midelname.content = arrName[1];
          name.content = arrName[2];
        } else if (arrName.length > 3) {
          lastname.content = arrName[0];
          midelname.content = arrName[1];
          name.content = '${arrName[2]} ${arrName[3]}';
        } else {
          name.content = text;
        }
        return;
      }
    }
    if (nationality.rect != null) {
      if (nationality.rect!.bottom - 10 < rect.bottom &&
          rect.bottom < nationality.rect!.bottom + 10 &&
          nationality.rect!.right + 60 < rect.left) {
        var arrNationality = text.split('/');
        if (arrNationality.length > 1) {
          nationality.content = arrNationality[1].trim();
        } else {
          nationality.content = text;
        }
        return;
      }
    }
    if (sex.rect != null) {
      if (sex.rect!.bottom < rect.bottom &&
          rect.bottom < sex.rect!.bottom + 50.0 &&
          sex.rect!.left - 15 < rect.left &&
          rect.left < sex.rect!.right) {
        if (text.contains('Nam')) {
          sex.content = 'M';
        } else if (text.contains('Nữ')) {
          sex.content = 'N';
        } else {
          sex.content = 'M';
        }
      }
    }
    if (dob.rect != null) {
      if (dob.rect!.bottom < rect.bottom &&
          rect.bottom < dob.rect!.bottom + 50 &&
          dob.rect!.left - 100 < rect.left &&
          rect.left < dob.rect!.right) {
        dob.content = text.replaceAll("/", " ").replaceAll(RegExp(r'\s+'), ' ');
      }
    }
    if (ed.rect != null) {
      if (ed.rect!.bottom < rect.bottom &&
          rect.bottom < ed.rect!.bottom + 50 &&
          ed.rect!.left - 100 < rect.left &&
          rect.left < ed.rect!.right) {
        ed.content = text.replaceAll("/", " ").replaceAll(RegExp(r'\s+'), ' ');
      }
    }

    if (number.rect != null) {
      if (number.rect!.bottom < rect.bottom &&
          rect.bottom < number.rect!.bottom + 50.0 &&
          number.rect!.left - 40 < rect.left &&
          rect.left < number.rect!.right) {
        if (num.tryParse(text) != null) {
          number.content = text;
        }
      }
    }
  }

  bool isCardIdentity() {
    int count = 0;
    if (number.rect == null) {
      count++;
    }
    if (name.rect == null) {
      count++;
    }
    if (nationality.rect == null) {
      count++;
    }
    if (sex.rect == null) {
      count++;
    }
    if (dob.rect == null) {
      count++;
    }
    if (ed.rect == null) {
      count++;
    }
    if (count > 3) {
      return false;
    }
    return true;
  }
}
