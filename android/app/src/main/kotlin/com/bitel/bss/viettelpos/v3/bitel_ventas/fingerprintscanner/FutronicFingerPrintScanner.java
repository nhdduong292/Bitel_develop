package com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner;


import static com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner.FingerScannerFactory.createEmptyFingerPrint;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.ColorMatrix;
import android.graphics.ColorMatrixColorFilter;
import android.graphics.Paint;
import android.os.Handler;
import android.os.Message;
import android.util.Base64;

import com.futronictech.Scanner;
import com.futronictech.UsbDeviceDataExchangeImpl;
import com.futronictech.ftrWsqAndroidHelper;

/**
 * Created by letheson on 12/26/16.
 */

public class FutronicFingerPrintScanner extends FingerPrintScannerBase {
    public static final int MESSAGE_SHOW_MSG = 1;
    public static final int MESSAGE_SHOW_SCANNER_INFO = 2;
    public static final int MESSAGE_SHOW_IMAGE = 3;
    public static final int MESSAGE_ERROR = 4;
    public static final int MESSAGE_TRACE = 5;
    private static final int WSQ_WIDTH = 512;
    private static final int WSQ_HEIGHT = 512;

    public static byte[] mImageFP = null;
    public static boolean mUsbHostMode = true;
    public static boolean mFrame = true;
    public static boolean mLFD = false;
    public static boolean mInvertImage = true;
    public static int mImageWidth = 0;
    public static int mImageHeight = 0;
    private static int[] mPixels = null;
    private static Bitmap mBitmapFP = null;
    private static byte[] wsqImg = null;
    private static Canvas mCanvas = null;
    private static Paint mPaint = null;
    private UsbDeviceDataExchangeImpl usb_host_ctx = null;
    private FPScan mFPScan = null;
    private String serial = null;

    protected FutronicFingerPrintScanner(Context context) {
        super(context);
    }

    @Override
    public void onCapturing() {
        FINGER_PRINT.reset();
        mFPScan.start();
    }

    @Override
    protected String getSerial() {
        return serial;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        usb_host_ctx = new UsbDeviceDataExchangeImpl(context, mHandler);
        mFPScan = new FPScan(usb_host_ctx, mHandler);
        if (mUsbHostMode) {
            if (usb_host_ctx.OpenDevice(0, true)) {
            } else {
                if (!usb_host_ctx.IsPendingOpen()) {
                }
            }
        }
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        if (usb_host_ctx != null) {
            usb_host_ctx.Destroy();
        }
        if (mFPScan != null) {
            mFPScan.stop();
        }
        usb_host_ctx = null;
        mFPScan = null;
    }

    public static void InitFingerPictureParameters(int wight, int height) {
        mImageWidth = wight;
        mImageHeight = height;

        mImageFP = new byte[mImageWidth * mImageHeight];
        mPixels = new int[mImageWidth * mImageHeight];

        mBitmapFP = Bitmap.createBitmap(wight, height, Bitmap.Config.RGB_565);

        mCanvas = new Canvas(mBitmapFP);
        mPaint = new Paint();

        ColorMatrix cm = new ColorMatrix();
        cm.setSaturation(0);
        ColorMatrixColorFilter f = new ColorMatrixColorFilter(cm);
        mPaint.setColorFilter(f);
    }

    private void onCaptureSuccess() {
        for (int i = 0; i < mImageWidth * mImageHeight; i++) {
            mPixels[i] = Color.rgb(mImageFP[i], mImageFP[i], mImageFP[i]);
        }
        mCanvas.drawBitmap(mPixels, 0, mImageWidth, 0, 0, mImageWidth, mImageHeight, false, mPaint);

        FINGER_PRINT.setFingerPrintBmp(mBitmapFP);
        if (convertToWSQFormat()) {
            FINGER_PRINT.setEncodeBase64(Base64.encodeToString(wsqImg, Base64.NO_WRAP));
        }
        FINGER_PRINT.setHaveFingerImage(true);

        serial = usb_host_ctx.getSerial();

        FINGER_PRINT.setSerial(getSerial());
        captureFingerListener.onPostExecute(FINGER_PRINT);
    }

    // The Handler that gets information back from the FPScan
    private final Handler mHandler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            switch (msg.what) {
                case MESSAGE_SHOW_MSG:
                    String showMsg = (String) msg.obj;
                    e(showMsg);
                    break;
                case MESSAGE_SHOW_SCANNER_INFO:
                    String showInfo = (String) msg.obj;
                    e(showInfo);
                    break;
                case MESSAGE_SHOW_IMAGE:
                    onCaptureSuccess();
                    break;
                case MESSAGE_ERROR:
                    e("unexpected error");
                    break;
                case UsbDeviceDataExchangeImpl.MESSAGE_ALLOW_DEVICE:
                    e("MESSAGE_ALLOW_DEVICE - do not scan automatically...");
                    break;
                case UsbDeviceDataExchangeImpl.MESSAGE_DENY_DEVICE:
                    String errorMessage = "User deny scanner device";
                    e(errorMessage);

                    createEmptyFingerPrint();

                    break;
            }
        }
    };

    private boolean convertToWSQFormat() {
        // convert to fixed size image with white as background color
        byte[] fixedSizeFpImage = new byte[WSQ_WIDTH * WSQ_HEIGHT];
        for (int i = 0; i < WSQ_HEIGHT; i++) {
            for (int j = 0; j < WSQ_WIDTH; j++) {
                if (i >= mImageHeight || j >= mImageWidth) {
                    fixedSizeFpImage[i * WSQ_WIDTH + j] = (byte) 255;   // fill white as background color
                } else {
                    fixedSizeFpImage[i * WSQ_WIDTH + j] = mImageFP[i * mImageWidth + j];
                }
            }
        }

        // convert to WSQ format
        Scanner devScan = new Scanner();
        boolean bRet;
        if (mUsbHostMode)
            bRet = devScan.OpenDeviceOnInterfaceUsbHost(usb_host_ctx);
        else
            bRet = devScan.OpenDevice();
        if (!bRet) {
            e(devScan.GetErrorMessage());
            return false;
        }
        wsqImg = new byte[WSQ_WIDTH * WSQ_HEIGHT];
        long hDevice = devScan.GetDeviceHandle();
        ftrWsqAndroidHelper wsqHelper = new ftrWsqAndroidHelper();
        boolean isSuccessful;
        if (wsqHelper.ConvertRawToWsq(hDevice, WSQ_WIDTH, WSQ_HEIGHT, 2.25f, fixedSizeFpImage, wsqImg)) {
            e("converted to WSQ format successfully");
            wsqImg = removeUnusedBytes(wsqImg, wsqHelper.mWSQ_size);
            writeLogToFile("ftr.wsq", null, wsqImg);
            isSuccessful = true;
        } else {
            e("Failed to convert the image!");
            isSuccessful = false;
        }
        if (mUsbHostMode)
            devScan.CloseDeviceUsbHost();
        else
            devScan.CloseDevice();
        return isSuccessful;
    }
}
