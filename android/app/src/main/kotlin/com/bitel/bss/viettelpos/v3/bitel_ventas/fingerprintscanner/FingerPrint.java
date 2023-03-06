package com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner;

import android.graphics.Bitmap;

/**
 * Created by Apple on 11/22/16.
 */

public class FingerPrint {

    private String      encodeBase64;
    private Bitmap      fingerPrintBmp;
    private int         imageWidth;
    private int         imageHeight;
    private String      serial;
    static public int   IMAGE_QUALITY       = 0;
    private boolean     isHaveFingerImage   = false;
    private byte[]      pk;

    public FingerPrint() {
    }

    public Bitmap getFingerPrintBmp() {
        return fingerPrintBmp;
    }

    public void setFingerPrintBmp(Bitmap fingerPrintBmp) {
        this.fingerPrintBmp = fingerPrintBmp;
    }

    public int getImageWidth() {
        return imageWidth;
    }

    public void setImageWidth(int imageWidth) {
        this.imageWidth = imageWidth;
    }

    public int getImageHeight() {
        return imageHeight;
    }

    public void setImageHeight(int imageHeight) {
        this.imageHeight = imageHeight;
    }

    public String getEncodeBase64() {
        return encodeBase64;
    }

    public void setEncodeBase64(String encodeBase64) {
        this.encodeBase64 = encodeBase64;
    }

    public boolean isHaveFingerImage() {
        return isHaveFingerImage;
    }

    public void setHaveFingerImage(boolean haveFingerImage) {
        isHaveFingerImage = haveFingerImage;
    }

    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    public void reset(){
        setHaveFingerImage(false);
        setFingerPrintBmp(null);
        setEncodeBase64(null);
        setImageHeight(0);
        setImageWidth(0);
    }

    public byte[] getPk() {
        return pk;
    }

    public void setPk(byte[] pk) {
        this.pk = pk;
    }
}
