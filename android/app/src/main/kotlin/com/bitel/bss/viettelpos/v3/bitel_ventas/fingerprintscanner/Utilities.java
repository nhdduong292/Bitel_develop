package com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner;

import android.content.Context;
import android.view.Gravity;
import android.widget.Toast;

public class Utilities {
    private static Toast toastMessage;
    public static void showToastMessage(Context context, String message) {
        if (toastMessage != null) {
            toastMessage.cancel();
        }

        toastMessage = Toast.makeText(context, message, Toast.LENGTH_LONG);
        toastMessage.setGravity(Gravity.CENTER, 0, 0);
        toastMessage.show();
    }
}
