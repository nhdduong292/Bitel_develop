package com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner;

import static com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner.FingerScannerFactory.createEmptyFingerPrint;

import android.app.Activity;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbManager;
import android.util.Base64;

import com.android.biomini.BioMiniAndroid;
import com.android.biomini.IBioMiniCallback;

import java.nio.ByteBuffer;
import java.util.HashMap;

import SecuGen.FDxSDKPro.SGWSQLib;
import rx.Observable;
import rx.Subscriber;
import rx.Subscription;
import rx.functions.Action1;
import rx.schedulers.Schedulers;

/**
 * Created by Apple on 12/22/16.
 */

public class SupremiaFingerPrintScanner extends FingerPrintScannerBase {
    private static BioMiniAndroid mBioMiniHandle = null;
    private final boolean mUseUsbManager = true;
    private static UsbManager mUsbManager = null;
    private int ufa_res;
    private String errmsg = "Hi";
    private static final int MAX_DEVICES = 4;
    private int mNumDevices = 0;
    private UsbDevice [] mDeviceList = new UsbDevice[MAX_DEVICES];
    private enum ECurrentTemplateType {SUPREMA, ISO, ANSI}
    protected static final String ACTION_USB_PERMISSION = "com.android.biomini.USB_PERMISSION";
    private int nsensitivity;
    private int ntimeout;
    private int nsecuritylevel;
    private int bfastmode;
    ECurrentTemplateType g_curTemplateType = ECurrentTemplateType.SUPREMA;
    private byte[] pImage = new byte[320 * 480];

    private boolean isFingerPrintSafe = false;
    private Subscription subscription;
    private interface IPermissionListener {
        void onPermissionDenied(UsbDevice d);
    }

    private PermissionReceiver mPermissionReceiver = new PermissionReceiver(
            new IPermissionListener() {
                @Override
                public void onPermissionDenied(UsbDevice d) {
                    l("Permission denied on " + d.getDeviceId());
                    createEmptyFingerPrint();
                }
            });


    private class PermissionReceiver extends BroadcastReceiver {
        private final IPermissionListener mPermissionListener;

        public PermissionReceiver(IPermissionListener permissionListener) {
            mPermissionListener = permissionListener;
        }

        @Override
        public void onReceive(Context context, Intent intent) {
            l("onReceive");
            if (context != null) {
                context.unregisterReceiver(this);
                if (intent.getAction().equals(ACTION_USB_PERMISSION)) {
                    if (!intent.getBooleanExtra(UsbManager.EXTRA_PERMISSION_GRANTED, false)) {
                        mPermissionListener.onPermissionDenied((UsbDevice) intent.getParcelableExtra(UsbManager.EXTRA_DEVICE));
                    } else {
                        l("Permission granted");
                        UsbDevice dev = intent.getParcelableExtra(UsbManager.EXTRA_DEVICE);
                        if (dev != null) {
                            int pid = dev.getProductId();
                            if (dev.getVendorId() == 0x16d1 && (pid == 0x0407 || pid == 0x0406)) {
                                l("startHandler_onReceive");
                                mBioMiniHandle.UFA_SetDevice(dev);
                                initBio();
                            }
                        } else {
                            l("device not present!");
                        }
                    }
                }
            }
        }
    }

    // Callback
    private final IBioMiniCallback mBioMiniCallbackHandler = new IBioMiniCallback() {
        private int mWidth = 0;
        private int mHeight = 0;
        @Override
        public void onCaptureCallback(final byte[] capturedimage, final int width,final  int height, final int resolution, final boolean bfingeron) {
            if(!isFingerPrintSafe){
                return;
            }
            mWidth = width;
            mHeight = height;
            //e(String.valueOf("onCaptureCallback called!" + " width:" + width + " height:" + height + " fingerOn:" + bfingeron));
            ((Activity)context).runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    int width = mWidth;
                    int height = mHeight;
                    FINGER_PRINT.setImageWidth(width);
                    FINGER_PRINT.setImageHeight(height);
                    final Bitmap bm = toGrayscale(capturedimage);
                    FINGER_PRINT.setFingerPrintBmp(bm);
                    FINGER_PRINT.setHaveFingerImage(true);
                    FINGER_PRINT.setSerial(getSerial());
                    captureFingerListener.onPostExecute(FINGER_PRINT);

                    if(bfingeron){
                        subscription = Observable.create(new Observable.OnSubscribe<Object>() {
                            @Override
                            public void call(Subscriber<? super Object> subscriber) {
                                getEncodeBase64FingerPrintBySecugen(bm);
                                subscriber.onCompleted();
                            }
                        }).observeOn(Schedulers.io()).subscribeOn(Schedulers.io()).subscribe(new Action1<Object>() {
                            @Override
                            public void call(Object o) {
                                //captureFingerListener.onPostExecute(FINGER_PRINT);
                            }
                        });
                    }
                }
            });
        }

        @Override
        public void onErrorOccurred(String msg) {

        }
    };

    public SupremiaFingerPrintScanner(Context context) {
        super(context);
    }

    @Override
    public void onCreate() {
        super.onCreate();
        initHandler();
        findDevices();
        initBio();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        destroy();
        if(subscription != null){
            subscription.unsubscribe();
        }
        subscription = null;
    }

    @Override
    public void onCapturing() {
        isFingerPrintSafe = false;
        FINGER_PRINT.reset();
        if (mBioMiniHandle == null) {
            e(String.valueOf("BioMini SDK Handler with NULL!"));
        } else {
            ufa_res = mBioMiniHandle.UFA_CaptureSingle(pImage);
            errmsg = mBioMiniHandle.UFA_GetErrorString(ufa_res);

            if (ufa_res == 0) {
                int pid = mBioMiniHandle.getProductId();
                int width = 0, height = 0;
                if (pid == 0x0406) {
                    width = 288; height = 320;
                } else if (pid == 0x0407) {
                    width = 320; height = 480;
                }

                int[] quality = new int[1];
                ufa_res = mBioMiniHandle.UFA_GetFPQuality(pImage, width, height, quality, 1);
                if (ufa_res == mBioMiniHandle.UFA_OK) {
                    compareQuality(quality[0]);
                    l("Fingerprintf quality: " + quality[0]+";issafe= "+isFingerPrintSafe+";dbquality = "+FingerPrint.IMAGE_QUALITY);
                    if(isFingerPrintSafe){
                        mBioMiniCallbackHandler.onCaptureCallback(pImage, width, height, 500, true);
                    }else{
                        ((Activity)context).runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                FINGER_PRINT.reset();
                                captureFingerListener.onPostExecute(FINGER_PRINT);
                                l("Fingerprintf quality: " +"compare_fingerprint_quality_warning");
//                                CommonActivity.createAlertDialog((Activity)context, context.getString(R.string.compare_fingerprint_quality_warning), context.getString(R.string.error)).show();
                                captureFingerListener.onPostExecute(FINGER_PRINT);
                            }
                        });
                    }
                } else {
                    FINGER_PRINT.reset();
                    isFingerPrintSafe = false;
                    l("UFA_GetFPQuality failed (" + ufa_res + ")");
                    captureFingerListener.onPostExecute(FINGER_PRINT);
                }
            }else{
                FINGER_PRINT.reset();
                isFingerPrintSafe = false;
                l("UFA_GetFPQuality failed (" + ufa_res + ")");
                captureFingerListener.onPostExecute(FINGER_PRINT);
            }
        }
    }

    @Override
    protected String getSerial() {
        return mBioMiniHandle.UFA_GetSerialNumber();
    }

    private void destroy(){
        mBioMiniHandle.UFA_AbortCapturing();
        ufa_res = mBioMiniHandle.UFA_Uninit();
        String errmsg1 = mBioMiniHandle.UFA_GetErrorString(ufa_res);
    }

    private void initHandler(){
        // allocate SDK instance
        if (mBioMiniHandle == null) {
            //mUseUsbManager is always true
            if(!mUseUsbManager) {
                //New mBioMiniHandle
                mBioMiniHandle = new BioMiniAndroid((Activity)context);
            }
            else {//Always go to this code
                //Get usb manager instance from system service
                mUsbManager = (UsbManager) context.getSystemService(Context.USB_SERVICE);

                //New mBioMiniHandle
                mBioMiniHandle = new BioMiniAndroid(mUsbManager);
            }
        }
    }

    private void initBio(){
        if (mBioMiniHandle == null) {
            e(String.valueOf("BioMini SDK Handler with NULL!"));
        } else {
            // SDK initialization
            ufa_res = mBioMiniHandle.UFA_Init();
            String errmsg1 = mBioMiniHandle.UFA_GetErrorString(ufa_res);
            String Serial = null;

            if (ufa_res == 0) {
                nsensitivity = 7;
                ntimeout = 10;
                nsecuritylevel = 4;
                bfastmode = 1;

                mBioMiniHandle.UFA_SetParameter(mBioMiniHandle.UFA_PARAM_SENSITIVITY, nsensitivity);
                mBioMiniHandle.UFA_SetParameter(mBioMiniHandle.UFA_PARAM_TIMEOUT, ntimeout * 1000);
                mBioMiniHandle.UFA_SetParameter(mBioMiniHandle.UFA_PARAM_SECURITY_LEVEL, nsecuritylevel);
                mBioMiniHandle.UFA_SetParameter(mBioMiniHandle.UFA_PARAM_FAST_MODE, bfastmode);
                if (g_curTemplateType == ECurrentTemplateType.SUPREMA) {
                    ufa_res = mBioMiniHandle.UFA_SetTemplateType(mBioMiniHandle.UFA_TEMPLATE_TYPE_SUPREMA);
                } else if (g_curTemplateType == ECurrentTemplateType.ISO) {
                    ufa_res = mBioMiniHandle.UFA_SetTemplateType(mBioMiniHandle.UFA_TEMPLATE_TYPE_ISO19794_2);
                } else if (g_curTemplateType == ECurrentTemplateType.ANSI) {
                    ufa_res = mBioMiniHandle.UFA_SetTemplateType(mBioMiniHandle.UFA_TEMPLATE_TYPE_ANSI378);

                }
                // set callback
                mBioMiniHandle.UFA_SetCallback(mBioMiniCallbackHandler);
                Serial = mBioMiniHandle.UFA_GetSerialNumber();
                // version
                String sdkversion = mBioMiniHandle.UFA_GetVersionString();
            }
        }
    }

    private void findDevices(){
        if (mBioMiniHandle == null) {
            e(String.valueOf("BioMini SDK Handler with NULL!"));

        } else {
            if(!mUseUsbManager) {
                // find BioMini device and request permission
                ufa_res = mBioMiniHandle.UFA_FindDevice();

                errmsg = mBioMiniHandle.UFA_GetErrorString(ufa_res);

            }
            else {//Always goto this code
                enumerate(new IPermissionListener() {
                    @Override
                    public void onPermissionDenied(UsbDevice d) {
                        e("onPermission Denied");
                        if(context != null && mUsbManager != null) {
                            PendingIntent pi = null;

                            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.S) {
                                 pi = PendingIntent.getBroadcast(context, 0, new Intent(ACTION_USB_PERMISSION), PendingIntent.FLAG_MUTABLE);
                            } else {
                                 pi = PendingIntent.getBroadcast(context, 0, new Intent(ACTION_USB_PERMISSION), 0);
                            }

                            context.registerReceiver(mPermissionReceiver, new IntentFilter(ACTION_USB_PERMISSION));
                            mUsbManager.requestPermission(d, pi);
                        }
                    }
                });
            }
        }
    }

    /**
     * List all usb devices
     * @param listener
     */
    private void enumerate(IPermissionListener listener) {
        l("enumerating");
        if(mUsbManager == null) {
            l("mUsbManager null!!");
        }

        mNumDevices = 0;
        if(mUsbManager != null) {
            HashMap<String, UsbDevice> devlist = mUsbManager.getDeviceList();
            for (UsbDevice d : devlist.values()) {
                l("Found device: "
                        + String.format("%04X:%04X", d.getVendorId(),
                        d.getProductId()));

                int pid = d.getProductId();
                if (d.getVendorId() == 0x16d1 && (pid == 0x0407 || pid == 0x0406)) {
                    l("Device under: " + d.getDeviceName());
                    if (!mUsbManager.hasPermission(d)) {
                        l("onPermissionDenied");
                        listener.onPermissionDenied(d);
                    } else {
                        if(mNumDevices > MAX_DEVICES) {
                            l("Too many devices attached (max:4)");
                            break;
                        }
                        mDeviceList[mNumDevices] = d;
                        mNumDevices ++;
                        //l("UFA_SetDevice");
                        //mBioMiniHandle.UFA_SetDevice(d);
                        //return;
                    }
                    //break;
                }
            }
        }

        if(mNumDevices != 0) {
            l("UFA_SetDevice" + mDeviceList[0]);
            mBioMiniHandle.UFA_SetDevice(mDeviceList[0]);
        }
    }

    private byte[] convertBitmapToFixedSize(Bitmap bitmap, int fixedWidth, int fixedHeight){

        Bitmap largeBitmap = Bitmap.createBitmap(fixedWidth, fixedHeight, bitmap.getConfig());
        Canvas canvas = new Canvas(largeBitmap);
        canvas.drawColor(Color.WHITE);
        canvas.drawBitmap(bitmap, 0, 0, null);

        writeBitmapToFile("1.png", largeBitmap);

        //calculate how many bytes our image consists of.
        int bytes = largeBitmap.getByteCount();

        ByteBuffer buffer = ByteBuffer.allocate(bytes); //Create a new buffer
        largeBitmap.copyPixelsToBuffer(buffer); //Move the byte data to the buffer

        byte[] array = buffer.array(); //Get the underlying array containing the data.

        //create a byte buffer that is 1/4 length of normal bitmap buffer
        //Secugen lib only understand this special 1/4-length byte buffer
        byte[] newBuffer = new byte[array.length/4];

        for(int i=0; i< array.length/4;i++)
        {
            newBuffer[i]= array[i*4];
        }

        return newBuffer;
    }

    private void getEncodeBase64FingerPrintBySecugen(Bitmap displayBitmap){
        SGWSQLib sgwsqLib = new SGWSQLib();
        int[] wsqImageOutSize = new int[1];
        byte[] mRegisterImage512 = convertBitmapToFixedSize(displayBitmap, 512, 512);
        sgwsqLib.SGWSQGetEncodedImageSize(wsqImageOutSize, SGWSQLib.BITRATE_5_TO_1, mRegisterImage512, 512, 512, 8, 500);

        byte[] wsqImageOut = new byte[wsqImageOutSize[0]];

        sgwsqLib.SGWSQEncode(wsqImageOut, SGWSQLib.BITRATE_5_TO_1, mRegisterImage512, 512, 512, 8, 500);

        writeLogToFile("out.wsq", null, wsqImageOut);
        String encodedBase64 = Base64.encodeToString(wsqImageOut, Base64.NO_WRAP);

        FINGER_PRINT.setEncodeBase64(encodedBase64);
        FINGER_PRINT.setHaveFingerImage(true);
    }

    private void getEncodeBase64FingerPrint(){

        int nImageWidth = 0;
        int nImageHeight = 0;

        if (mBioMiniHandle.getProductId() == 0x0406) {
            nImageWidth = 288;
            nImageHeight = 320;
        } else if (mBioMiniHandle.getProductId() == 0x0407) {
            nImageWidth = 320;
            nImageHeight = 480;
        } else {
            e("Invalid Device. ");
        }

        //        nImageWidth = 512;
        //        nImageHeight = 512;

        //Get WSQ Buffer.
        byte[] pwImage = new byte[nImageWidth * nImageHeight * 2];
        int[] pwSize = new int[4];
        // compression ratio 2.25
        ufa_res = mBioMiniHandle.UFA_GetCaptureImageBufferToWSQBufferVar(pwImage, pwSize, nImageWidth * nImageHeight * 2, (float) 2.25, 512, 512);
        if (ufa_res == mBioMiniHandle.UFA_OK) {
            pwImage = removeUnusedBytes(pwImage, pwSize[0]);
            //saveByteToPngFile(pwImage);
            //writeLogToFile("bio.wsq", null, pwImage);
            String encodedBase64 = Base64.encodeToString(pwImage, Base64.NO_WRAP);
            //writeLogToFile("biobase64", null, encodedBase64.getBytes());
            FINGER_PRINT.setEncodeBase64(encodedBase64);
            FINGER_PRINT.setHaveFingerImage(true);
            e("UFA_GetCaptureImageBufferToWSQBuffer : successful");
        } else {
            e("UFA_GetCaptureImageBufferToWSQBuffer : fail");
            FINGER_PRINT.setEncodeBase64(null);
        }
    }

    private void compareQuality(int bioQuality){
        //1 : 100%
        //2 : 99% - 80%
        //3 : 79% - 60%
        //4 : 59% - 40%
        //5 : 39% - 20%
        //6 : 19% - 0%

        int dbQuality = FingerPrint.IMAGE_QUALITY;
        switch (bioQuality){
            case 1:
            case 2://hardcode bio quality
                if(dbQuality == 100){
                    isFingerPrintSafe = true;
                }
                return;
            //            case 2:
            //                if(99 >= dbQuality && dbQuality >= 80){
            //                    isFingerPrintSafe = true;
            //                }
            //                return;
            case 3:
                if(79 >= dbQuality && dbQuality >= 60){
                    isFingerPrintSafe = true;
                }
                return;
            case 4:
                if(59 >= dbQuality && dbQuality >= 40){
                    isFingerPrintSafe = true;
                }
                return;
            case 5:
                if(39 >= dbQuality && dbQuality >= 20){
                    isFingerPrintSafe = true;
                }
                return;
            case 6:
                if(19 >= dbQuality && dbQuality >= 0){
                    isFingerPrintSafe = true;
                }
        }
    }
}
