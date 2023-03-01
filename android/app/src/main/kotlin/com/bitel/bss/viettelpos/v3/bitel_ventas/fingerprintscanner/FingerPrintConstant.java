package com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner;

/**
 * Created by TuanLQ on 4/8/17.
 */

public class FingerPrintConstant {
    public final static String OPERATION_INIT_DEVICE = "initDevice";

    public final static String OPERATION_CAPTURE_FINGERPRINT = "captureFingerprint";

    public final static String IMAGEBUFFER_WSQ = "imagebufferwsq";

    public final static String IMAGEBUFFER_RAW = "imagebufferraw";

    public final static String BITMAP_FOR_VIEWER = "bitmapforviewer";

    public final static String BITMAP_HEIGHT_FOR_VIEWER = "height_bitmap";

    public final static String BITMAP_WIDTH_FOR_VIEWER = "width_bitmap";

    public static String RESPONSE = "response";

    public static String CO_ERROR = "coError";

    public static String DE_ERROR = "deError";

    public static int CODE_SIN_PERMISOS = -91;

    public static int CODE_LECTOR_NO_DETECTADO = -1000;

    public static int CODE_ALL_OK = 8000;

    public static String HUELLA_NO_CAPTURADA = "Huella no capturada";

    public static String LECTOR_NO_CONECTADO = "The reader has not been detected, or you have not granted the USB permissions, please click on the Give Permissions button and then on Configure Reader";

    public static String TEMPLATEBUFFER = "templateBuffer";
}
