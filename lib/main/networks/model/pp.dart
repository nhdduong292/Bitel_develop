import 'package:bitel_ventas/main/networks/model/identify_base_model.dart';

class PP extends IdentifyModel {
  int nationalOffset = 0;
  List<String> documentItems = [];

  void getDocumentItems(String text) {
    var data = text.split("\n");
    documentItems = getItemContains(data);
    startDetect(documentItems);
  }

  List<String> getItemContains(List<String> list) {
    List<String> items = [];

    for (String item in list) {
      if (item.contains("<")) {
        item = item.replaceAll(" ", "").toUpperCase();
        items.add(item);
      }
    }
    return items;
  }

  void startDetect(List<String> documentItems) {
    if (documentItems.length > 1) {
      omitRedundantItems(documentItems);
      if (checkForCorrectType(documentItems[0], documentItems[1])) {
        setupDocumentTwoLine(documentItems, 0);
      } else {}
    }
  }

  void omitRedundantItems(List<String> firstDocument) {
    String first = firstDocument[0];
    String second = firstDocument[1];

    if (checkForCorrectType(first, second)) return;

    String PP = "P<USA";
    int start = first.indexOf(PP);

    if (start != -1) {
      String stringOfNational = first.substring(start);

      firstDocument[0] = stringOfNational;
    }
  }

  bool checkForCorrectType(String? first, String? second) {
    if (first != null && second != null) {
      return first.startsWith("P") &&
          second.contains(getNationalOfFirst(first, 0));
    } else
      return false;
  }

  void setupDocumentThreeLine(List<String> items, int nationalOffset) {
    if (items.length == 3) {
      String firstText = items[0];
      String secondText = items[1];
      String thirdText = items[2];

      String national = getNationalOfFirst(firstText, nationalOffset);

      // Set national
      this.national = national;

      // Set name
      getNameOfFirst(thirdText, (first, second, three) {
        this.fristName = first;
        this.middleName = second;
        this.lastName = three;
      });

      // Set document number
      String documentNumber = firstText.substring(5, 14);
      documentNumber = preEditNumber(documentNumber);
      this.idNumber = documentNumber;

      // Set birth day
      this.dateOfBirth = secondText.substring(0, 6);

      // Set gender
      this.gender = secondText.substring(7, 8);

      // Set expire date
      this.dateOfExpiry = secondText.substring(8, 14);
    }
  }

  String getNationalOfFirst(String first, int offset) {
    if (first.length > 5)
      return first.substring(2 - offset, 5 - offset);
    else
      return "";
  }

  void getNameOfFirst(String first, var onResulf) {
    String output = first.replaceAll('<', '\n').replaceAll('く', '\n').trim();
    List<String> FNSP = output.split("\n");
    List<String> names = getEmptyListName(FNSP);
    clearText(names, ["K", "KK", "E", "EE", "S", "SS", "I", "II"]);
    // if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
    //     try {
    //         names.removeIf(s -> s.length() == 1);
    //     }catch (Exception ex) {}
    // }

    if (names.length == 0) {
      onResulf("", "", "");
    }

    switch (names.length) {
      case 1:
        onResulf(formatName(names[0]), "", "");
        break;
      case 2:
        onResulf(formatName(names[1]), "", formatName(names[0]));
        break;
      case 3:
        onResulf(
            formatName(names[0]), formatName(names[1]), formatName(names[2]));
        break;
      default:
        int lastPos = names.length - 1;
        List<String> s = names.sublist(1, lastPos).toList();
        onResulf(
            formatName(names[0]), mergeString(s), formatName(names[lastPos]));
    }
  }

  List<String> getEmptyListName(List<String> FNSP) {
    List<String> names = [];

    for (String s in FNSP) {
      if (!s.isEmpty) {
        s = s.replaceAll("[^a-zA-Z0-9]", "").replaceAll("0", "O");
        names.add(s);
      }
    }

    return names;
  }

  void clearText(List<String> input, List<String> texts) {
    for (String s in texts) {
      input.remove(s);
    }
  }

  String formatName(String name) {
    name = name.replaceAll("0", "O");
    return name;
  }

  String mergeString(var strings) {
    String r = '';
    int length = strings.length;
    for (int i = 0; i < length; i++) {
      r += (strings[i]) + (i != (length - 1) ? " " : "");
    }

    return formatName(r.toString());
  }

  String preEditNumber(String number) {
    return number
        .replaceAll("O", "0")
        .replaceAll("S", "5")
        .replaceAll("-", "4")
        .replaceAll("<", "");
  }

  void setupDocumentTwoLine(List<String> items, int nationalOffset) {
    if (items.length == 2) {
      String firstText = items[0];
      String secondText = items[1];
      String national = getNationalOfFirst(firstText, nationalOffset);

      // Set name
      int sN = firstText.indexOf(national) + national.length;
      String FNS = firstText.substring(sN);
      getNameOfFirst(FNS, (first, second, three) {
        this.fristName = first;
        this.middleName = second;
        this.lastName = three;
      });

      // Set national
      this.national = national;

      // Set document number
      String documentNumber = getDocumentNumber(secondText);
      documentNumber = preEditNumber(documentNumber);
      this.idNumber = documentNumber;

      // Set birth day
      this.dateOfBirth = getBirthDay(national, secondText);

      // Set gender
      this.gender = getGender(national, secondText);

      // Set expire date

      this.dateOfExpiry = getExpireDate(national, secondText, gender!);
    }
  }

  String getDocumentNumber(String second) {
    return second.substring(0, 9);
  }

  String getBirthDay(String national, String second) {
    int bS = second.indexOf(national) + national.length;
    String bd = second.substring(bS, bS + 6);
    bd = preEditNumber(bd);
    return bd;
  }

  String getGender(String national, String second) {
    String endText = getEndText(national, second);
    if (endText.contains("M"))
      return "M";
    else
      return "F";
  }

  String getEndText(String national, String second) {
    int start = second.indexOf(national) + national.length;
    return second.substring(start);
  }

  String getExpireDate(String national, String second, String gender) {
    String endText = getEndText(national, second);
    int iG = endText.indexOf(gender) + 1;
    String ed = endText.substring(iG, iG + 6);
    ed = preEditNumber(ed);
    return ed;
  }
}
