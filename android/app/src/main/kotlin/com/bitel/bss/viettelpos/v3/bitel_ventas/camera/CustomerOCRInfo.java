package com.bitel.bss.viettelpos.v3.bitel_ventas.camera;


import android.os.Parcel;
import android.os.Parcelable;
import android.text.format.DateUtils;


import java.io.File;
import java.util.List;

public class CustomerOCRInfo implements Parcelable {

    private static final String DATE_FORMAT_yyyyMMdd = "yyyy-MM-dd";
    private static final String DATE_FORMAT_yyMMdd = "yyMMdd";
    public static final String LIMITED_EXPIRED_DATE = "0000-01-01";

    private long customerId;
    private long documentType;

//    @Expose
//    @SerializedName("DocumentNumber")
    private String documentNumber;

//    @Expose
//    @SerializedName("LastName")
    private String lastName;

//    @Expose
//    @SerializedName("GivenName")
    private String firstName;

//    @Expose
//    @SerializedName("Nationality")
    private String national;

//    @Expose
//    @SerializedName("Sex")
    private String gender;

//    @Expose
//    @SerializedName("BirthDate")
    private String birthday;

//    @Expose
//    @SerializedName("ExpiryDate")
    private String expirationDate;
//    @Expose
    private String imageBase;
//    @Expose
    private File imageFile;
//    @Expose
    private String status;
//    @Expose
    private String imageName;
//    @Expose
    private String documentCode;
//    @Expose
    private int checkCustType;


    public static String getDATE_FORMAT_yyyyMMdd() {
        return DATE_FORMAT_yyyyMMdd;
    }

    public static String getDATE_FORMAT_yyMMdd() {
        return DATE_FORMAT_yyMMdd;
    }

    public static String getLimitedExpiredDate() {
        return LIMITED_EXPIRED_DATE;
    }

    public static Creator<CustomerOCRInfo> getCREATOR() {
        return CREATOR;
    }

    public CustomerOCRInfo() {
    }

    protected CustomerOCRInfo(Parcel in) {
        customerId = in.readLong();
        documentType = in.readLong();
        documentNumber = in.readString();
        lastName = in.readString();
        firstName = in.readString();
        national = in.readString();
        gender = in.readString();
        birthday = in.readString();
        expirationDate = in.readString();
        imageBase = in.readString();
        status = in.readString();
        imageName = in.readString();
        documentCode = in.readString();
        checkCustType = in.readInt();
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeLong(customerId);
        dest.writeLong(documentType);
        dest.writeString(documentNumber);
        dest.writeString(lastName);
        dest.writeString(firstName);
        dest.writeString(national);
        dest.writeString(gender);
        dest.writeString(birthday);
        dest.writeString(expirationDate);
        dest.writeString(imageBase);
        dest.writeString(status);
        dest.writeString(imageName);
        dest.writeString(documentCode);
        dest.writeInt(checkCustType);
    }

    @Override
    public int describeContents() {
        return 0;
    }

    public static final Creator<CustomerOCRInfo> CREATOR = new Creator<CustomerOCRInfo>() {
        @Override
        public CustomerOCRInfo createFromParcel(Parcel in) {
            return new CustomerOCRInfo(in);
        }

        @Override
        public CustomerOCRInfo[] newArray(int size) {
            return new CustomerOCRInfo[size];
        }
    };

    public long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(long customerId) {
        this.customerId = customerId;
    }

    public long getDocumentType() {
        return documentType;
    }

    public void setDocumentType(long documentType) {
        this.documentType = documentType;
    }

    public String getDocumentNumber() {
        return documentNumber;
    }

    public void setDocumentNumber(String documentNumber) {
        this.documentNumber = documentNumber;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getNational() {
        return national;
    }

    public void setNational(String national) {
        this.national = national;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getBirthday() {
        if (birthday != null && !birthday.contains("-")) {
//            birthday = DateUtils.formatData(birthday,
//                    DATE_FORMAT_yyMMdd, DATE_FORMAT_yyyyMMdd);
        }
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getExpirationDate() {
        if (expirationDate != null && !expirationDate.contains("-")) {
            if (expirationDate.equals("000101")) {
                return LIMITED_EXPIRED_DATE;
            }
//            expirationDate = DateUtils.formatData(expirationDate,
//                    DATE_FORMAT_yyMMdd, DATE_FORMAT_yyyyMMdd);
        }
        return expirationDate;
    }

    public void setExpirationDate(String expirationDate) {
        this.expirationDate = expirationDate;
    }

    public String getImageBase() {
        return imageBase;
    }

    public void setImageBase(String imageBase) {
        this.imageBase = imageBase;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public File getImageFile() {
        return imageFile;
    }

    public void setImageFile(File imageFile) {
        this.imageFile = imageFile;
    }

    public String getImageName() {
        return imageName;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    public int getCheckCustType() {
        return checkCustType;
    }

    public void setCheckCustType(int checkCustType) {
        this.checkCustType = checkCustType;
    }

    public String getDocumentCode() {
        return documentCode;
    }

    public void setDocumentCode(String documentCode) {
        this.documentCode = documentCode;
    }

//    public static CustomerOCRInfo parseCustomerInfoDNI(List<String> listInfo) {
//        CustomerOCRInfo customerInfo = new CustomerOCRInfo();
//        customerInfo.setNational("PER");
//        for (int i = 0; i < listInfo.size(); i++) {
//            String data = listInfo.get(i)
//                    .replaceAll("\\s+", "");
//            if (i == 0) {
//                data = data.replaceAll("O", "0");
//                if (data.length() > 12) {
//                    String idNo = data.substring(5, 13);
//                    customerInfo.setDocumentNumber(idNo);
//                }
//            } else if (i == 1) {
//                data = data.replaceAll("O", "0");
//                if (data.length() > 5) {
//                    String birthday = data.substring(0, 6);
//                    customerInfo.setBirthday(birthday);
//                    String gender = data.substring(7, 8);
//                    customerInfo.setGender(gender);
//                    String expireDate = data.substring(8, 14);
//                    customerInfo.setExpirationDate(expireDate);
//                }
//            } else if (i == 2) {
//                String firstName = "";
//                String lastName = "";
//                String[] arrName = data.split("<");
//                for (String item : arrName) {
//                    if (!StringUtils.validString(item)) {
//                        continue;
//                    }
//                    if (StringUtils.validString(firstName) && StringUtils.validString(lastName)) {
//                        break;
//                    }
//                    if (!StringUtils.validString(firstName)) {
//                        firstName = item;
//                    } else if (!StringUtils.validString(lastName)) {
//                        lastName = item;
//                    }
//                }
//                customerInfo.setFirstName(lastName.trim());
//                customerInfo.setLastName(firstName.trim());
//            }
//        }
//        return customerInfo;
//    }

}
