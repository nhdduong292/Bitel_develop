package com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner;

import android.graphics.Bitmap;


/**
 * Created by TuanLQ on 4/2/17.
 */

public interface IFingerPrint {

    enum FingerMethod {
        MORPHO("Morpho") ,
        SECUGEN("Secugen"),
        INSOLUTION("Insolution");

        private String name;

        FingerMethod(String name) {
            this.name = name;
        }

        public String getName() {
            return name;
        }

    }

    void capture(FingerMethod method, ICaptureCallBack callBack);

    interface ICaptureCallBack {
        void onFingerSuccess(Bitmap bitmap);

        void onFingerFailured(String reason);
    }

}
