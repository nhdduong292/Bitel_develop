package com.bitel.bss.viettelpos.v3.bitel_ventas.camera.utils;

import android.Manifest;
import android.annotation.SuppressLint;
import android.content.Context;
import android.content.pm.PackageManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Build;
import android.os.Environment;
import android.provider.Settings;
import android.telephony.CellIdentityWcdma;
import android.telephony.CellInfo;
import android.telephony.CellInfoLte;
import android.telephony.CellInfoWcdma;
import android.telephony.CellLocation;
import android.telephony.TelephonyManager;
import android.telephony.cdma.CdmaCellLocation;
import android.telephony.gsm.GsmCellLocation;

import androidx.annotation.RequiresApi;
import androidx.core.app.ActivityCompat;


import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Collections;
import java.util.List;

public class DeviceUtils {

    @SuppressLint("MissingPermission")
    public static String getDeviceId(Context context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            return Settings.Secure.getString(
                    context.getContentResolver(),
                    Settings.Secure.ANDROID_ID);
        } else {
            TelephonyManager telephonyManager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
            if (ActivityCompat.checkSelfPermission(context, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
                return "716152528202008";
            } else {
                return telephonyManager.getDeviceId();
            }
        }
    }
    @SuppressLint("MissingPermission")
    public static String getSerial(Context mActivity){
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                return Settings.Secure.getString(
                        mActivity.getContentResolver(),
                        Settings.Secure.ANDROID_ID);
            } else {
                TelephonyManager telephonyManager = (TelephonyManager) mActivity.getSystemService(Context.TELEPHONY_SERVICE);
                return  telephonyManager.getSimSerialNumber();
            }
        }catch (Exception e){
            return "";
        }
    }
    public static boolean appInstalledOrNot(Context context, String packageName) {
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
//    public static String getCellIdNew(Context context) {
//        try {
//            String networkType = getConnectNetWorkType(context);
//            if (networkType.equalsIgnoreCase(Constance.BundleKey.NETWORK_TYPE_MOBILE)) {
//                networkType = getMobileNetworkType(context);
//            }
//            switch (networkType) {
//                case Constance.BundleKey.NETWORK_TYPE_MOBILE_3G:
//                    return getCellId3G(context);
//                case Constance.BundleKey.NETWORK_TYPE_MOBILE_4G:
//                    return getCellId4G(context);
//                default:
//                    return "716150220048022";
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            return "716150220048022";
//        }
//    }

    public static String getIPAddress(boolean useIPv4) {
        try {
            List<NetworkInterface> interfaces = Collections.list(NetworkInterface.getNetworkInterfaces());
            for (NetworkInterface intf : interfaces) {
                List<InetAddress> addrs = Collections.list(intf.getInetAddresses());
                for (InetAddress addr : addrs) {
                    if (!addr.isLoopbackAddress()) {
                        String sAddr = addr.getHostAddress();

                        boolean isIPv4 = sAddr.indexOf(':')<0;

                        if (useIPv4) {
                            if (isIPv4)
                                return sAddr;
                        } else {
                            if (!isIPv4) {
                                int delim = sAddr.indexOf('%'); // drop ip6 zone suffix
                                return delim<0 ? sAddr.toUpperCase() : sAddr.substring(0, delim).toUpperCase();
                            }
                        }
                    }
                }
            }
        } catch (Exception ignored) {
        } // for now eat exceptions
        return "";
    }

    public static String getMACAddress(String interfaceName) {
        try {
            List<NetworkInterface> interfaces = Collections.list(NetworkInterface.getNetworkInterfaces());
            for (NetworkInterface networkInterface : interfaces) {
                if (interfaceName != null) {
                    if (!networkInterface.getName().equalsIgnoreCase(interfaceName)) {
                        continue;
                    }
                }

                byte[] mac = networkInterface.getHardwareAddress();

                if (mac == null) {
                    return "";
                }

                StringBuilder stringBuilder = new StringBuilder();

                for (byte aMac : mac) {
                    stringBuilder.append(String.format("%02X:", aMac));
                }

                if (stringBuilder.length() > 0) {
                    stringBuilder.deleteCharAt(stringBuilder.length() - 1);
                }

                return stringBuilder.toString();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

//    public static String getMacAddress(){
//        String macAddress = DeviceUtils.getMACAddress(Constance.WLAN);
//        if (macAddress.isEmpty()) {
//            macAddress = Constance.MAC_ADDRESS;
//        }
//
//        macAddress = macAddress.replace(":", "-");
//        if (Config.IS_BY_PASS_FINGER_PRINT) {
//            macAddress = Constance.MAC_ADDRESS_BY_PASS;
//        }
//        return macAddress;
//    }
//
//    public static String getCellId() {
//        try {
//            Context context = BitelApplication.self();
//            TelephonyManager tm = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
//            @SuppressLint("MissingPermission") CellLocation cellLocation = tm.getCellLocation();
//            if (cellLocation instanceof GsmCellLocation) {
//                GsmCellLocation location = (GsmCellLocation) cellLocation;
//                return String.valueOf(location.getCid());
//            } else if (cellLocation instanceof CdmaCellLocation) {
//                CdmaCellLocation location = (CdmaCellLocation) cellLocation;
//                return String.valueOf(location.getBaseStationId());
//            }
//        } catch (Throwable th) {
//            th.printStackTrace();
//        }
//        return "";
//    }
//
//    public static String getLAC() {
//        try {
//            Context context = BitelApplication.self();
//            TelephonyManager tm = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
//            @SuppressLint("MissingPermission") CellLocation cellLocation = tm.getCellLocation();
//            if (cellLocation instanceof GsmCellLocation) {
//                GsmCellLocation location = (GsmCellLocation) cellLocation;
//                return String.valueOf(location.getLac());
//            }
//        } catch (Throwable th) {
//            th.printStackTrace();
//        }
//        return "";
//    }

    @SuppressLint("MissingPermission")
    public static String getIMSI(Context context) {
        if (context == null) {
            return "";
        }

        TelephonyManager mTelephonyMgr = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);

        try {
            return mTelephonyMgr.getSubscriberId();
        } catch (Exception s) {
            return ""; // fake: 716152528202008
        }
    }

//    public static String getConnectNetWorkType(Context context) {
//        ConnectivityManager connMgr = (ConnectivityManager)
//                context.getSystemService(Context.CONNECTIVITY_SERVICE);
//        NetworkInfo networkInfo = connMgr.getActiveNetworkInfo();
//        if (networkInfo != null && networkInfo.isConnected()) {
//            if (networkInfo.getType() == ConnectivityManager.TYPE_WIFI) {
//                return Constance.BundleKey.NETWORK_TYPE_WIFI;
//            } else {
//                return Constance.BundleKey.NETWORK_TYPE_MOBILE;
//            }
//        } else {
//            return Constance.BundleKey.NETWORK_TYPE_UNKNOWN;
//        }
//    }

//    public static String getMobileNetworkType(Context context) {
//        TelephonyManager tm = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
//        @SuppressLint("MissingPermission") int networkType = tm.getNetworkType();
//        switch (networkType) {
//            case TelephonyManager.NETWORK_TYPE_GPRS:
//            case TelephonyManager.NETWORK_TYPE_EDGE:
//            case TelephonyManager.NETWORK_TYPE_CDMA:
//            case TelephonyManager.NETWORK_TYPE_1xRTT:
//            case TelephonyManager.NETWORK_TYPE_IDEN:
//                return Constance.BundleKey.NETWORK_TYPE_MOBILE_2G;
//            case TelephonyManager.NETWORK_TYPE_UMTS:
//            case TelephonyManager.NETWORK_TYPE_EVDO_0:
//            case TelephonyManager.NETWORK_TYPE_EVDO_A:
//            case TelephonyManager.NETWORK_TYPE_HSDPA:
//            case TelephonyManager.NETWORK_TYPE_HSUPA:
//            case TelephonyManager.NETWORK_TYPE_HSPA:
//            case TelephonyManager.NETWORK_TYPE_EVDO_B:
//            case TelephonyManager.NETWORK_TYPE_EHRPD:
//            case TelephonyManager.NETWORK_TYPE_HSPAP:
//                return Constance.BundleKey.NETWORK_TYPE_MOBILE_3G;
//            case TelephonyManager.NETWORK_TYPE_LTE:
//                return Constance.BundleKey.NETWORK_TYPE_MOBILE_4G;
//            default:
//                return Constance.BundleKey.NETWORK_TYPE_UNKNOWN;
//        }
//    }

//    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR1)
//    public static String getCellId3G(Context context) {
//        TelephonyManager tm = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
//        List<CellInfo> cellInfoList = null;
//        try {
//            cellInfoList = tm.getAllCellInfo();
//        } catch (SecurityException e) {
//            return null;
//        }
//        if (CollectionUtils.isEmpty(cellInfoList)) {
//            return null;
//        }
//
//        StringBuilder sb = new StringBuilder();
//        for (final CellInfo info : cellInfoList) {
//            if (info == null || !info.isRegistered()) {
//                continue;
//            }
//            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2 && info instanceof CellInfoWcdma) {
//                // find first signal pass condition
//                CellIdentityWcdma cell = ((CellInfoWcdma) info).getCellIdentity();
//                sb.append(cell.getMcc());
//                sb.append(cell.getMnc());
//                int lac = cell.getLac();
//                sb.append(String.format("%05d", lac));
//                // CI = LCID % 65536
//                int ci = cell.getCid() % 65536;
//                sb.append(String.format("%05d", ci));
//                return sb.toString();
//            }
//        }
//        return null;
//    }

//    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR1)
//    public static String getCellId4G(Context context) {
//        TelephonyManager tm = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
//        List<CellInfo> cellInfoList = null;
//        try {
//            cellInfoList = tm.getAllCellInfo();
//        } catch (SecurityException e) {
//            return null;
//        }
//        if (CollectionUtils.isEmpty(cellInfoList)) {
//            return null;
//        }
//
//        StringBuilder sb = new StringBuilder();
//        for (final CellInfo info : cellInfoList) {
//            if (info == null || !info.isRegistered()) {
//                continue;
//            }
//            if (info instanceof CellInfoLte && Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
//                CellInfoLte cell = (CellInfoLte) info;
//                // max value is unknown signal
//                if (cell.getCellIdentity() == null || cell.getCellIdentity().getTac() == Integer.MAX_VALUE) {
//                    continue;
//                }
//                // find first signal pass condition
//                sb.append(cell.getCellIdentity().getMcc());
//                sb.append(cell.getCellIdentity().getMnc());
//                int cellId = cell.getCellIdentity().getCi();
//                // ENB = LCID / 256 , if length  < 7 , append 0
//                int enb = cellId / 256;
//                sb.append(String.format("%07d", enb));
//                // CI = LCID % 256 , if length  < 3 , append 0
//                int ci = cellId % 256;
//                sb.append(String.format("%03d", ci));
//                return sb.toString();
//            }
//        }
//        return null;
//    }

    public static boolean isMockSettingsON(Context context) {
        // returns true if mock location enabled, false if not enabled.
        return !Settings.Secure.getString(context.getContentResolver(),
                Settings.Secure.ALLOW_MOCK_LOCATION).equals("0");
    }
    public static File createImageFile(Context context) throws IOException {
        // Create an image file name
        return createFile(context, ".jpg");
    }
    public static File createFile(Context context, String extension) throws IOException {
        String imageFileName = "bccs_" + System.currentTimeMillis() + "_";
        File storageDir = context.getExternalFilesDir(Environment.DIRECTORY_PICTURES);
        File image = File.createTempFile(
                imageFileName,  /* prefix */
                extension,  /* suffix */
                storageDir      /* directory */
        );
        return image;
    }
}
