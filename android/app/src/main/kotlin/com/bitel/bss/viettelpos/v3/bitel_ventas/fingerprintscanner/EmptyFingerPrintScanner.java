package com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner;

import android.content.Context;


public class EmptyFingerPrintScanner extends FingerPrintScannerBase {
    public enum STATUS {
        DEVICE_NOT_FOUND, LOAD_LIBRARY_ERROR
    }

    private STATUS status = STATUS.DEVICE_NOT_FOUND;

    public EmptyFingerPrintScanner(Context context) {
        super(context);
//        FINGER_PRINT.setSerial("TestSerialDevice");
    }

    public EmptyFingerPrintScanner(Context context, STATUS status) {
        super(context);
        this.status = status != null ? status : STATUS.DEVICE_NOT_FOUND;
//        FINGER_PRINT.setSerial("TestSerialDevice");
    }

    public STATUS getStatus() {
        return status;
    }

    @Override
    public void onCapturing() {

    }

    @Override
    public String getSerial() {
        return "TestSerialDevice";
    }
}
