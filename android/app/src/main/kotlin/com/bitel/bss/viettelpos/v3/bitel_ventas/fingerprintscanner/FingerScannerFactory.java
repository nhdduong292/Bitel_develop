package com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbManager;
import android.widget.Toast;

import androidx.fragment.app.Fragment;

import com.futronictech.UsbDeviceDataExchangeImpl;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class FingerScannerFactory {

    public static final String TAG = FingerScannerFactory.class.getSimpleName();
    public static final String ZYTRUST_MOBILE_APP_PACKAGE = "com.zytrust.bitel";
    public static final String INSOLUTION_MOBILE_APP_PACKAGE = "insolutions.veridium.bitel";


    public static FingerPrintScannerBase fingerPrintScannerImp;
    private static Context context;
    private static Activity activity;
    private static Fragment fragment;

    private static BroadcastReceiver attachedUsbReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            getFingerPrintScanner(context);
            try {
                fingerPrintScannerImp.onCreate();
            } catch (Throwable e) {
                Toast.makeText(context, e.getMessage(), Toast.LENGTH_LONG).show();
                try {
                    FingerScannerFactory.fingerPrintScannerImp.onDestroy();
                } catch (Throwable throwable) {
                }
                createEmptyFingerPrint(EmptyFingerPrintScanner.STATUS.LOAD_LIBRARY_ERROR);
            }
        }
    };

    private static BroadcastReceiver detachedUsbReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            if (fingerPrintScannerImp != null) {
                fingerPrintScannerImp.onPause();
                fingerPrintScannerImp.onStop();
                fingerPrintScannerImp.onDestroy();
            }
            fingerPrintScannerImp = new EmptyFingerPrintScanner(context);
        }
    };

    public static void createEmptyFingerPrint(EmptyFingerPrintScanner.STATUS status) {
        fingerPrintScannerImp = new EmptyFingerPrintScanner(context, status);
    }

    static void createEmptyFingerPrint() {
        // Most of cases caused by the device was not found
        createEmptyFingerPrint(EmptyFingerPrintScanner.STATUS.DEVICE_NOT_FOUND);
    }

    static public void onResume() {
        context.registerReceiver(attachedUsbReceiver, new IntentFilter(UsbManager.ACTION_USB_DEVICE_ATTACHED));
        context.registerReceiver(detachedUsbReceiver, new IntentFilter(UsbManager.ACTION_USB_DEVICE_DETACHED));
    }

    public static void getFingerPrintScanner(Context context) {
        FingerScannerFactory.context = context;
        fragment = null;
        detectDevicesType();
    }

    public static void getFingerPrintScanner(Activity context) {
        FingerScannerFactory.context = context;
        activity = context;
        fragment = null;
        detectDevicesType();
    }

    public static void getFingerPrintScanner(Context context, boolean byPassInsolution) {
        FingerScannerFactory.context = context;
        fragment = null;
        detectDevicesType(byPassInsolution);
    }

    public static void getFingerPrintScanner(Activity context, boolean byPassInsolution) {
        FingerScannerFactory.context = context;
        activity = context;
        fragment = null;
        detectDevicesType(byPassInsolution);
    }

    public static void getFingerPrintScanner(Fragment context) {

        FingerScannerFactory.context = context.getActivity();
        fragment = context;
        activity = null;
        detectDevicesType();
    }
    private static void detectDevicesType() {
        detectDevicesType(false);
    }

    private static void detectDevicesType(boolean byPassInsolution) {
        UsbManager usbManager = (UsbManager) context.getSystemService(Context.USB_SERVICE);
        HashMap<String, UsbDevice> hashDevices = usbManager.getDeviceList();
        Set<Map.Entry<String, UsbDevice>> set = hashDevices.entrySet();
        fingerPrintScannerImp = new EmptyFingerPrintScanner(context);


        if (!byPassInsolution && isNewFingerPrintAvailable(INSOLUTION_MOBILE_APP_PACKAGE)) {
            if (fragment != null) {
                fingerPrintScannerImp = new NewFingerPrintScanner(fragment, IFingerPrint.FingerMethod.INSOLUTION);
            } else {
                fingerPrintScannerImp = new NewFingerPrintScanner(activity, IFingerPrint.FingerMethod.INSOLUTION);
            }
        } else {
            for (Map.Entry<String, UsbDevice> entry : set) {

                UsbDevice usbDevice = entry.getValue();

                if (isNewFingerPrintAvailable(ZYTRUST_MOBILE_APP_PACKAGE) && isNewFingerPrintSupportedType(usbDevice)) {
                    if (usbDevice.getVendorId() == 4450 && (usbDevice.getProductId() == 8704 || usbDevice.getProductId() == 8707)) {
                        if (fragment != null) {
                            fingerPrintScannerImp = new NewFingerPrintScanner(fragment, IFingerPrint.FingerMethod.SECUGEN);
                        } else {
                            fingerPrintScannerImp = new NewFingerPrintScanner(activity, IFingerPrint.FingerMethod.SECUGEN);
                        }
                    } else {
                        if (fragment != null) {
                            fingerPrintScannerImp = new NewFingerPrintScanner(fragment, IFingerPrint.FingerMethod.MORPHO);
                        } else {
                            fingerPrintScannerImp = new NewFingerPrintScanner(activity, IFingerPrint.FingerMethod.MORPHO);
                        }

                    }
                } else {

                    if (usbDevice.getVendorId() == 0x16d1 && (usbDevice.getProductId() == 0x0407 || usbDevice.getProductId() == 0x0406)) {
                        fingerPrintScannerImp = new SupremiaFingerPrintScanner(context);

//                    } else if (usbDevice.getVendorId() == 4450 && (usbDevice.getProductId() == 8704 || usbDevice.getProductId() == 8707)) {
                    } else if (usbDevice.getVendorId() == 7516 && (usbDevice.getProductId() == 28930 || usbDevice.getProductId() == 8707)) {
                        fingerPrintScannerImp = new SecugenFingerPrintScanner(context);
                    } else if (UsbDeviceDataExchangeImpl.IsFutronicDevice(usbDevice.getVendorId(), usbDevice.getProductId())) {
                        fingerPrintScannerImp = new FutronicFingerPrintScanner(context);
                    } else {
                        fingerPrintScannerImp = new EmptyFingerPrintScanner(context);
                    }
                }
                break;
            }
        }
    }

    static public void onStop() {

        try {
            context.unregisterReceiver(attachedUsbReceiver);
            context.unregisterReceiver(detachedUsbReceiver);
        } catch (Exception ignored) {
        }

    }

    static public void destroy() {
        fingerPrintScannerImp = null;
    }

    public static boolean isNewFingerPrintAvailable(String packageName) {
//        return Utilities.appInstalledOrNot(context, packageName);
        PackageManager pm = context.getPackageManager();
        try {
            pm.getPackageInfo(packageName, PackageManager.GET_ACTIVITIES);
            return true;
        } catch (PackageManager.NameNotFoundException e) {
            try {
                context.getPackageManager().getApplicationInfo(packageName, 0);
                return true;
            } catch (PackageManager.NameNotFoundException ex) {
                return false;
            }
        }
    }


    public static boolean isNewFingerPrintSupportedType(UsbDevice usbDevice) {
        return (usbDevice.getVendorId() == 4450 && (usbDevice.getProductId() == 8704 || usbDevice.getProductId() == 8707)) //Secugen
                || (usbDevice.getVendorId() == 1947 && usbDevice.getProductId() == 71) || (usbDevice.getVendorId() == 8797 && usbDevice.getProductId() == 10); //mopho;
    }

    /**
     * Dinh Minh Quoc
     * create createInstance() function to get fingerPrintScannerImp
     */
    public static void createInstance() {
        try {
            fingerPrintScannerImp.onCreate();
        } catch (Throwable e) {
            try {
                fingerPrintScannerImp.onDestroy();
            } catch (Throwable ignored) {
            }
            createEmptyFingerPrint(EmptyFingerPrintScanner.STATUS.LOAD_LIBRARY_ERROR);
        }
    }

    public static String getDeviceSerial() {
        if (fingerPrintScannerImp == null) {
            return null;
        }
        if (fingerPrintScannerImp instanceof SecugenFingerPrintScanner) {
            SecugenFingerPrintScanner secugenFingerPrintScanner = (SecugenFingerPrintScanner) fingerPrintScannerImp;
            return secugenFingerPrintScanner.getSerialNumber();
        }
        return null;
    }
}
