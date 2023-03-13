package com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner;

import android.os.Handler;
import android.os.SystemClock;

import com.futronictech.Scanner;
import com.futronictech.UsbDeviceDataExchangeImpl;

public class FPScan {
    private final Handler mHandler;
    private UsbDeviceDataExchangeImpl ctx = null;
    private Scanner devScan = null;
    private String strInfo;
    private int mask, flag;
    private int errCode;

    public FPScan(UsbDeviceDataExchangeImpl context, Handler handler) {
        mHandler = handler;
        ctx = context;
        devScan = new Scanner();
    }

    public synchronized void start() {

        boolean bRet;
        if (FutronicFingerPrintScanner.mUsbHostMode)
            bRet = devScan.OpenDeviceOnInterfaceUsbHost(ctx);
        else
            bRet = devScan.OpenDevice();
        if (!bRet) {

            if (FutronicFingerPrintScanner.mUsbHostMode)
                ctx.CloseDevice();
            mHandler.obtainMessage(FutronicFingerPrintScanner.MESSAGE_SHOW_MSG, -1, -1, devScan.GetErrorMessage()).sendToTarget();
            mHandler.obtainMessage(FutronicFingerPrintScanner.MESSAGE_ERROR).sendToTarget();
            return;
        }

        if (!devScan.GetImageSize()) {
            mHandler.obtainMessage(FutronicFingerPrintScanner.MESSAGE_SHOW_MSG, -1, -1, devScan.GetErrorMessage()).sendToTarget();
            if (FutronicFingerPrintScanner.mUsbHostMode)
                devScan.CloseDeviceUsbHost();
            else
                devScan.CloseDevice();
            mHandler.obtainMessage(FutronicFingerPrintScanner.MESSAGE_ERROR).sendToTarget();
            return;
        }

        FutronicFingerPrintScanner.InitFingerPictureParameters(devScan.GetImageWidth(), devScan.GetImaegHeight());

        strInfo = devScan.GetVersionInfo();
        mHandler.obtainMessage(FutronicFingerPrintScanner.MESSAGE_SHOW_SCANNER_INFO, -1, -1, strInfo).sendToTarget();

        //set options
        flag = 0;
        mask = devScan.FTR_OPTIONS_DETECT_FAKE_FINGER | devScan.FTR_OPTIONS_INVERT_IMAGE;
        if (FutronicFingerPrintScanner.mLFD)
            flag |= devScan.FTR_OPTIONS_DETECT_FAKE_FINGER;
        if (FutronicFingerPrintScanner.mInvertImage)
            flag |= devScan.FTR_OPTIONS_INVERT_IMAGE;
        if (!devScan.SetOptions(mask, flag))
            mHandler.obtainMessage(FutronicFingerPrintScanner.MESSAGE_SHOW_MSG, -1, -1, devScan.GetErrorMessage()).sendToTarget();

        // get frame / image2
        long lT1 = SystemClock.uptimeMillis();
        if (FutronicFingerPrintScanner.mFrame)
            bRet = devScan.GetFrame(FutronicFingerPrintScanner.mImageFP);
        else
            bRet = devScan.GetImage2(4, FutronicFingerPrintScanner.mImageFP);
        if (!bRet) {
            mHandler.obtainMessage(FutronicFingerPrintScanner.MESSAGE_SHOW_MSG, -1, -1, devScan.GetErrorMessage()).sendToTarget();
            errCode = devScan.GetErrorCode();
            if (errCode != devScan.FTR_ERROR_EMPTY_FRAME && errCode != devScan.FTR_ERROR_MOVABLE_FINGER && errCode != devScan.FTR_ERROR_NO_FRAME) {
                if (FutronicFingerPrintScanner.mUsbHostMode)
                    devScan.CloseDeviceUsbHost();
                else
                    devScan.CloseDevice();
                mHandler.obtainMessage(FutronicFingerPrintScanner.MESSAGE_ERROR).sendToTarget();
                return;
            }
        } else {
            if (FutronicFingerPrintScanner.mFrame)
                strInfo = String.format("OK. GetFrame time is %d(ms)", SystemClock.uptimeMillis() - lT1);
            else
                strInfo = String.format("OK. GetImage2 time is %d(ms)", SystemClock.uptimeMillis() - lT1);
            mHandler.obtainMessage(FutronicFingerPrintScanner.MESSAGE_SHOW_MSG, -1, -1, strInfo).sendToTarget();
        }
        if (bRet) {
            mHandler.obtainMessage(FutronicFingerPrintScanner.MESSAGE_SHOW_IMAGE).sendToTarget();
        } else {
            mHandler.obtainMessage(FutronicFingerPrintScanner.MESSAGE_SHOW_MSG, -1, -1, "The device is still working. Please try to re-position your finger").sendToTarget();
        }
    }

    public synchronized void stop() {
        //close device
        if (FutronicFingerPrintScanner.mUsbHostMode)
            devScan.CloseDeviceUsbHost();
        else
            devScan.CloseDevice();
    }
}
