package com.bitel.bss.viettelpos.v3.bitel_ventas.camera.utils;

public class CommonUtils {

    private static long lastClickTime;

    public static boolean isFastClick() {
        return isFastClick(1000);
    }

    public static boolean isFastClick(long intervalTime) {
        long time = System.currentTimeMillis();
        if (time - lastClickTime < intervalTime) {
            return true;
        }
        lastClickTime = time;
        return false;
    }
}
