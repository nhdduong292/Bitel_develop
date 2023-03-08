package com.bitel.bss.viettelpos.v3.bitel_ventas.camera.permission;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.provider.Settings;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.content.ContextCompat;

import java.io.Serializable;
import java.util.HashMap;

public class PermissionsUtil {


    protected static HashMap<String, PermissionListener> listenerMap = new HashMap();

    public static void requestPermission(Activity activity, PermissionListener listener, String[] permissions) {
        requestPermission(activity, listener, permissions, true, null);
    }

    public static void requestPermission(@NonNull Activity activity, @NonNull PermissionListener listener, @NonNull String[] permissions, boolean showTip, @Nullable TipInfo tip) {

        if (Build.VERSION.SDK_INT < 23) {
            listener.permissionGranted(permissions);
            return;
        }

        String key = String.valueOf(System.currentTimeMillis());

        listenerMap.put(key, listener);
        Intent intent = new Intent(activity, PermissionActivity.class);
        intent.putExtra("permission", permissions);
        intent.putExtra("key", key);
        intent.putExtra("showTip", showTip);
        intent.putExtra("tip", tip);

        activity.startActivity(intent);
    }

    public static boolean allPermissionGranted(Context context, String... permissions) {
        for (String permission : permissions) {
            if (!hasPermission(context, permission)) {
                return false;
            }
        }
        return true;
    }

    public static boolean allPermissionsGranted(@NonNull int[] grantResults) {
        for (int grantResult : grantResults) {
            if (grantResult == PackageManager.PERMISSION_DENIED) {
                return false;
            }
        }
        return true;
    }

    public static boolean hasPermission(Context context, String permission) {
        return ContextCompat.checkSelfPermission(context, permission) ==
                PackageManager.PERMISSION_GRANTED;
    }

    public static void gotoSetting(Context context) {
        Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
        intent.setData(Uri.parse("package:" + context.getPackageName()));
        context.startActivity(intent);
    }

    static PermissionListener fetchListener(String key) {
        return listenerMap.remove(key);
    }


    static public class TipInfo implements Serializable {

        private static final long serialVersionUID = 1L;

        String title;
        String content;
        String cancel;
        String ensure;

        public TipInfo(@Nullable String title, @Nullable String content, @Nullable String cancel, @Nullable String ensure) {
            this.title = title;
            this.content = content;
            this.cancel = cancel;
            this.ensure = ensure;
        }
    }
}