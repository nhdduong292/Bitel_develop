package com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner;

import static com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner.FingerScannerFactory.createEmptyFingerPrint;

import android.annotation.SuppressLint;
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
import android.os.Handler;
import android.os.Message;
import android.util.Base64;
import android.util.Log;
import android.widget.Toast;


import java.nio.ByteBuffer;

import SecuGen.FDxSDKPro.JSGFPLib;
import SecuGen.FDxSDKPro.SGAutoOnEventNotifier;
import SecuGen.FDxSDKPro.SGDeviceInfoParam;
import SecuGen.FDxSDKPro.SGFDxDeviceName;
import SecuGen.FDxSDKPro.SGFDxErrorCode;
import SecuGen.FDxSDKPro.SGFDxTemplateFormat;
import SecuGen.FDxSDKPro.SGFingerInfo;
import SecuGen.FDxSDKPro.SGFingerPresentEvent;
import SecuGen.FDxSDKPro.SGImpressionType;
import SecuGen.FDxSDKPro.SGWSQLib;

/**
 * Created by Apple on 11/22/16.
 */

public class SecugenFingerPrintScanner extends FingerPrintScannerBase implements SGFingerPresentEvent {
    final String TAG = "SecugenFingerPrintScanner";
    public final boolean IS_BY_PASS_PK = true;

    private IntentFilter filter; // 2014-04-11
    protected PendingIntent mPermissionIntent;

    private JSGFPLib sgfplib;
    private byte[] mRegisterImage;
    private byte[] mRegisterTemplate;
    private int[] mMaxTemplateSize;
    private int[] quality1 = new int[1];
    private int mImageWidth;
    private int mImageHeight;
    // CaptureModeN enable
    private boolean isCaptureModeN = false;
    private long secugenDeviceError;
    private UsbDevice usbDevice;
    private boolean isSmartCapture = true;
    private boolean usbReceiverRegistered = false;
    private SGAutoOnEventNotifier autoOn;
//    private Context context;
    public SecugenFingerPrintScanner(Context context){
        super(context);
//        this.context = context;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        initUsbPermissionReceiver();
        initSecugenDevices(false);
    }

    @Override
    public void onResume() {
        super.onResume();
        registerUsbPermissionReceiver();
        resumeSecugenDevice();
    }

    @Override
    public void onPause() {
        super.onPause();
        try {
            unregisterUsbPermissionReceiver();
            pauseSecugenDevice();
        } catch (Exception e) {

        }
    }


    public void onCapturing(){

        captureFingerPrint();
    }

    @Override
    protected String getSerial() {
        SGDeviceInfoParam deviceInfo = new SGDeviceInfoParam();

        long result = sgfplib.GetDeviceInfo(deviceInfo);
        String serial;
        if (result == 0L) {
            serial = new String(deviceInfo.deviceSN()).trim();
        }else{
            serial = null;
        }

//        if(Constant.WRITE_LOG_FILE){
//            MBCCSLogger.getInstance().writeToLog("Secugen Scanner serial:" + serial);
//        }
        return serial;
    }

    public String getSerialNumber(){
        secugenDeviceError = sgfplib.OpenDevice(0);
        return getSerial();
    }

    public void onDestroy(){
        super.onDestroy();
        destroySecugenDevice();
    }

    private void destroySecugenDevice(){
        if(sgfplib != null) {
            sgfplib.CloseDevice();
            sgfplib.Close();
        }
    }

    private void resumeSecugenDevice() {
        if(isPausedWhileInUse) {
            initSecugenDevices(true);
        }
    }

    private void pauseSecugenDevice() {
        if (sgfplib.DeviceInUse()) {
            sgfplib.CloseDevice();
            mRegisterImage = null;
            mRegisterTemplate = null;
//            getMainActivity().hideWaitProgress();
            isPausedWhileInUse = true;
        }
    }

    @SuppressLint("LongLogTag")
    private void initSecugenDevices(boolean resume){
        if(!resume) {
            sgfplib = new JSGFPLib((UsbManager) getMainActivity().getSystemService(Context.USB_SERVICE));
            sgfplib.WriteData((byte) 0, isCaptureModeN ? (byte) 0 : (byte) 1);
        }

        secugenDeviceError = sgfplib.Init(SGFDxDeviceName.SG_DEV_AUTO);
        isPausedWhileInUse= false;
        usbDevice = sgfplib.GetUsbDevice();

        if(usbDevice != null) {
            sgfplib.GetUsbManager().requestPermission(usbDevice, mPermissionIntent);
        }
        else
        {
            Log.d(TAG,"warning_usb_device_not_available");
//            CommonActivity.createAlertDialog(getMainActivity(),
//                    getString(R.string.warning_usb_device_not_available),
//                    getString(R.string.error) ).show();
            Utilities.showToastMessage(activity, "Không tìm thấy thiết bị lấy dấu vân tay, hay quay lại bước trước và cắm máy vân tay");
        }
    }

    private byte[] convertBitmapToFixedSize(Bitmap bitmap, int fixedWidth, int fixedHeight){

        Bitmap largeBitmap = Bitmap.createBitmap(fixedWidth, fixedHeight, bitmap.getConfig());
        Canvas canvas = new Canvas(largeBitmap);
        canvas.drawColor(Color.WHITE);
        canvas.drawBitmap(bitmap, 0, 0, null);


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

    @SuppressLint("LongLogTag")
    private void captureFingerPrint() {
        //
        FINGER_PRINT.reset();
        if (secugenDeviceError != SGFDxErrorCode.SGFDX_ERROR_NONE || usbDevice == null) {
            Log.d(TAG,"error_capture_finger");
            activity.runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Utilities.showToastMessage(activity, "Cannot capture your fingerprint, please try to plugin in a Secugen finger print scanner and restart current flow!");
                }
            });
        }
        else {

            secugenDeviceError = sgfplib.OpenDevice(0);

            //get device info, width and height
            SecuGen.FDxSDKPro.SGDeviceInfoParam deviceInfo = new SecuGen.FDxSDKPro.SGDeviceInfoParam();
            secugenDeviceError = sgfplib.GetDeviceInfo(deviceInfo);
            mImageWidth = deviceInfo.imageWidth;
            mImageHeight = deviceInfo.imageHeight;

            FINGER_PRINT.setImageWidth(mImageWidth);
            FINGER_PRINT.setImageHeight(mImageHeight);


            //set finger print template format for data interchange operability
            sgfplib.SetTemplateFormat(SGFDxTemplateFormat.TEMPLATE_FORMAT_ISO19794);

            //enable smart capture
            sgfplib.WriteData((byte) 5, isSmartCapture ? (byte) 1 : (byte) 0);

            //create or reset byte array contain raw image finger print byte array
            if (mRegisterImage != null)
                mRegisterImage = null;
            mRegisterImage = new byte[mImageWidth * mImageHeight];

            //capture the finger print from the device, byte array contain image must be initialized
            //60 seconds timeout, with imageFingerPrintQuality configured from database
            long result = sgfplib.GetImageEx(mRegisterImage, 10*1000, FingerPrint.IMAGE_QUALITY);

            // WSQ
            try {

                SGWSQLib sgwsqLib = new SGWSQLib();
                int[] wsqImageOutSize = new int[1];

                Bitmap displayBitmap = toGrayscale(mRegisterImage);
                FINGER_PRINT.setFingerPrintBmp(displayBitmap);

                byte[] mRegisterImage512 = convertBitmapToFixedSize(displayBitmap, 512, 512);
                sgwsqLib.SGWSQGetEncodedImageSize(wsqImageOutSize, SGWSQLib.BITRATE_5_TO_1, mRegisterImage512, 512, 512, 8, 500);

                byte[] wsqImageOut = new byte[wsqImageOutSize[0]];

                sgwsqLib.SGWSQEncode(wsqImageOut, SGWSQLib.BITRATE_5_TO_1, mRegisterImage512, 512, 512, 8, 500);

//                writeLogToFile("out.wsq", null, wsqImageOut);
                String encodedBase64 = Base64.encodeToString(wsqImageOut, Base64.NO_WRAP);

                FINGER_PRINT.setEncodeBase64(encodedBase64);
                FINGER_PRINT.setHaveFingerImage(true);
                if (IS_BY_PASS_PK) {
                    mMaxTemplateSize = new int[1];
                    sgfplib.SetTemplateFormat(SecuGen.FDxSDKPro.SGFDxTemplateFormat.TEMPLATE_FORMAT_ISO19794);
                    sgfplib.GetMaxTemplateSize(mMaxTemplateSize);
                    sgfplib.GetImageQuality(mImageWidth, mImageHeight, mRegisterImage, quality1);
                    mRegisterTemplate = new byte[mMaxTemplateSize[0]];
                    SGFingerInfo fpInfo = new SGFingerInfo();
                    fpInfo.FingerNumber = 1;
                    fpInfo.ImageQuality = quality1[0];
                    fpInfo.ImpressionType = SGImpressionType.SG_IMPTYPE_LP;
                    fpInfo.ViewNumber = 1;
                    for (int i=0; i< mRegisterTemplate.length; ++i)
                        mRegisterTemplate[i] = 0;
                    sgfplib.CreateTemplate(fpInfo, mRegisterImage, mRegisterTemplate);
                    FINGER_PRINT.setPk(mRegisterTemplate);
                }
                FINGER_PRINT.setSerial(getSerial());
            } catch (Exception e) {
                Toast.makeText(context, e.getMessage(), Toast.LENGTH_LONG).show();
                FINGER_PRINT.reset();
            }
        }
    }

    @Override
    public void SGFingerPresentCallback() {
        autoOn.stop();
        fingerDetectedHandler.sendMessage(new Message());
    }

    private Handler fingerDetectedHandler = new Handler() {
        // @Override
        public void handleMessage(Message msg) {
            // Handle the message
            captureFingerPrint();
        }
    };

    private void initUsbPermissionReceiver(){
        filter = new IntentFilter(ACTION_USB_PERMISSION);
        // request USB Permissions

        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.S) {
            mPermissionIntent = PendingIntent.getBroadcast(context, 0, new Intent(ACTION_USB_PERMISSION), PendingIntent.FLAG_MUTABLE);
        } else {
            mPermissionIntent = PendingIntent.getBroadcast(context, 0, new Intent(ACTION_USB_PERMISSION), 0);
        }
    }

    private void registerUsbPermissionReceiver(){
        if(!usbReceiverRegistered) {
            context.registerReceiver(mUsbPermissionReceiver, filter);
            usbReceiverRegistered = true;
        }
    }

    private void unregisterUsbPermissionReceiver(){
        if(usbReceiverRegistered) {
            context.unregisterReceiver(mUsbPermissionReceiver);
            usbReceiverRegistered = false;
        }
    }

    private static final String ACTION_USB_PERMISSION = "com.android.example.USB_PERMISSION";
    private final BroadcastReceiver mUsbPermissionReceiver = new BroadcastReceiver() {
        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            // DEBUG log.d(TAG,"Enter mUsbPermissionReceiver.onReceive()");
            if (ACTION_USB_PERMISSION.equals(action)) {
                synchronized (this) {
                    UsbDevice device = intent.getParcelableExtra(UsbManager.EXTRA_DEVICE);
                    if (intent.getBooleanExtra(UsbManager.EXTRA_PERMISSION_GRANTED, false)) {

                    } else {
                        createEmptyFingerPrint();
                    }
                }
            }
        }
    };

}
