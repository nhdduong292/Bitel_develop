class IdentifyModel {
  String? fristName;
  String? middleName;
  String? lastName;
  String? dateOfBirth;
  String? dateOfExpiry;
  String? dateOfIssue;
  String? gender;
  String? national;
  String? idNumber;

  String getFirstName() {
    return fristName ?? "---";
  }

  String getMiddleName() {
    return middleName ?? "---";
  }

  String getLastName() {
    return lastName ?? "---";
  }

  String getDateOfBirth() {
    if (dateOfBirth != null) {
      if (dateOfBirth!.length == 6) {
        return '${dateOfBirth![0]}${dateOfBirth![1]} ${dateOfBirth![2]}${dateOfBirth![3]} ${dateOfBirth![4]}${dateOfBirth![5]}';
      }
    }
    return "---";
  }

  String getDateOfExpiry() {
    if (dateOfExpiry != null) {
      if (dateOfExpiry!.length == 6) {
        return '${dateOfExpiry![0]}${dateOfExpiry![1]} ${dateOfExpiry![2]}${dateOfExpiry![3]} ${dateOfExpiry![4]}${dateOfExpiry![5]}';
      }
    }
    return "---";
  }

  String getDateOfIssue() {
    if (dateOfIssue != null) {
      if (dateOfIssue!.length == 6) {
        return '${dateOfIssue![0]}${dateOfIssue![1]} ${dateOfIssue![2]}${dateOfIssue![3]} ${dateOfIssue![4]}${dateOfIssue![5]}';
      }
    }
    return "---";
  }

  String getGenderBase() {
    return gender ?? "---";
  }

  String getNational() {
    return national ?? "---";
  }

  String getIdNumber() {
    return idNumber ?? "---";
  }

  bool checkIdentify() {
    int count = 0;
    if (fristName != null) {
      count = count + 1;
    }
    if (middleName != null) {
      count = count + 1;
    }
    if (lastName != null) {
      count = count + 1;
    }
    if (dateOfBirth != null) {
      count = count + 1;
    }
    if (dateOfExpiry != null) {
      count = count + 1;
    }
    if (dateOfIssue != null) {
      count = count + 1;
    }
    if (gender != null) {
      count = count + 1;
    }
    if (national != null) {
      count = count + 1;
    }
    if (idNumber != null) {
      count = count + 1;
    }
    if (count > 5) {
      return true;
    } else {
      return false;
    }
  }
}
