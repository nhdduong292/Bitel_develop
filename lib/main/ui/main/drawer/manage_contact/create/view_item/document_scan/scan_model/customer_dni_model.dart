import 'dart:ui';

import 'item_infor.dart';

class CustomerDNIModel {
  InformationCus number = InformationCus(type: 'khong co');
  InformationCus lastname = InformationCus(type: 'rimer');
  InformationCus name = InformationCus(type: 'nombres');
  InformationCus nationality = InformationCus(type: 'acionalid');
  InformationCus sex = InformationCus(type: 'Sexo');
  InformationCus dob = InformationCus(type: 'acimie');
  InformationCus ed = InformationCus(type: 'Emisi');

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
    }
    return null;
  }

  void findInfo(Rect rect, String text) {
    if (lastname.rect != null) {
      if (lastname.rect!.bottom < rect.bottom &&
          rect.bottom < lastname.rect!.bottom + 25.0) {
        lastname.content = text;
        return;
      }
    }
    if (name.rect != null) {
      if (name.rect!.bottom < rect.bottom &&
          rect.bottom < name.rect!.bottom + 25.0) {
        name.content = text;
        return;
      }
    }
    if (nationality.rect != null) {
      if (nationality.rect!.bottom < rect.bottom &&
          rect.bottom < nationality.rect!.bottom + 25.0 &&
          nationality.rect!.left - 10 < rect.left &&
          rect.left < nationality.rect!.right) {
        nationality.content = text;
        return;
      }
    }
    if (sex.rect != null) {
      if (sex.rect!.bottom < rect.bottom &&
          rect.bottom < sex.rect!.bottom + 25.0 &&
          sex.rect!.left - 10 < rect.left &&
          rect.left < sex.rect!.right) {
        sex.content = text;
      }
    }
    if (dob.rect != null) {
      if (dob.rect!.bottom < rect.bottom &&
          rect.bottom < dob.rect!.bottom + 25.0 &&
          rect.right > dob.rect!.left) {
        dob.content = text;
      }
    }
    if (ed.rect != null) {
      if (ed.rect!.bottom < rect.bottom &&
          rect.bottom < ed.rect!.bottom + 25.0 &&
          rect.right > ed.rect!.left) {
        ed.content = text;
      }
    }
  }
}
