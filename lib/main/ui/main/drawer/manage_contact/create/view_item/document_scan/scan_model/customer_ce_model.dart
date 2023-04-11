import 'dart:ui';

import 'item_infor.dart';

class CustomerCEModel {
  InformationCus number = InformationCus(type: 'N°');
  InformationCus lastname = InformationCus(type: 'pellidos');
  InformationCus midelname = InformationCus(type: 'ombres');
  InformationCus name = InformationCus(type: 'ombres');
  InformationCus nationality = InformationCus(type: 'acionalid');
  InformationCus sex = InformationCus(type: 'exo');
  InformationCus dob = InformationCus(type: 'echa');
  InformationCus issue = InformationCus(type: 'Emisi');
  InformationCus ed = InformationCus(type: 'aducida');

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
    } else if (text.contains(issue.type)) {
      return issue;
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
          rect.left - 30 < lastname.rect!.left) {
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
              rect.bottom < name.rect!.bottom + 35.0) &&
          rect.left < name.rect!.right) {
        var arrName = text.split(' ');
        if (arrName.length >= 2) {
          midelname.content = arrName[0];
          name.content = arrName[1];
        } else {
          name.content = text;
        }
        return;
      }
    }
    if (nationality.rect != null) {
      if (nationality.rect!.bottom < rect.bottom &&
          rect.bottom < nationality.rect!.bottom + 35.0 &&
          nationality.rect!.left - 30 < rect.left &&
          rect.left - 30 < nationality.rect!.right) {
        nationality.content = text;
        return;
      }
    }
    if (sex.rect != null) {
      if (sex.rect!.bottom < rect.bottom &&
          rect.bottom < sex.rect!.bottom + 35.0 &&
          sex.rect!.left - 15 < rect.left &&
          rect.left < sex.rect!.right) {
        sex.content = text;
      }
    }
    if (dob.rect != null) {
      if (dob.rect!.bottom < rect.bottom &&
          rect.bottom < dob.rect!.bottom + 35.0 &&
          dob.rect!.left - 15 < rect.left &&
          rect.left < dob.rect!.right) {
        dob.content = convertText(text);
      }
    }
    if (issue.rect != null) {
      if (issue.rect!.bottom < rect.bottom &&
          rect.bottom < issue.rect!.bottom + 35.0 &&
          issue.rect!.left - 15 < rect.left &&
          rect.left < issue.rect!.right) {
        issue.content = convertText(text);
      }
    }
    if (ed.rect != null) {
      if (ed.rect!.bottom < rect.bottom &&
          rect.bottom < ed.rect!.bottom + 35.0 &&
          ed.rect!.left - 15 < rect.left &&
          rect.left < ed.rect!.right) {
        ed.content = convertText(text);
      }
    }

    if (number.rect != null) {
      if (number.rect!.bottom - 20 < rect.bottom &&
          rect.bottom - 20 < number.rect!.bottom) {
        if (num.tryParse(text) != null) {
          number.content = text;
        }
      }
    }
  }

  String convertText(String text) {
    text = text.toUpperCase().replaceAll('JAN', '1');
    text = text.toUpperCase().replaceAll('FEB', '2');
    text = text.toUpperCase().replaceAll('MAR', '3');
    text = text.toUpperCase().replaceAll('APR', '4');
    text = text.toUpperCase().replaceAll('MAY', '5');
    text = text.toUpperCase().replaceAll('JUN', '6');
    text = text.toUpperCase().replaceAll('JUL', '7');
    text = text.toUpperCase().replaceAll('AUG', '8');
    text = text.toUpperCase().replaceAll('SEP', '9');
    text = text.toUpperCase().replaceAll('OCT', '10');
    text = text.toUpperCase().replaceAll('NOV', '11');
    text = text.toUpperCase().replaceAll('DEC', '12');
    return text;
  }

  bool isCardIdentity() {
    int count = 0;
    if (number.rect == null) {
      count++;
    }
    if (lastname.rect == null) {
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
