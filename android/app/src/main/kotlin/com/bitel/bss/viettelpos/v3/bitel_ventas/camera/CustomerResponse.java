package com.bitel.bss.viettelpos.v3.bitel_ventas.camera;


public class CustomerResponse {

//    @SerializedName("IsSuccessful")
    private boolean isSuccessful;

//    @SerializedName("Result")
    private String result;

//    @SerializedName("ErrorMessage")
    private String[] errorMessage;

    public boolean isSuccessful() {
        return isSuccessful;
    }

    public void setSuccessful(boolean successful) {
        isSuccessful = successful;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String[] getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String[] errorMessage) {
        this.errorMessage = errorMessage;
    }
}
