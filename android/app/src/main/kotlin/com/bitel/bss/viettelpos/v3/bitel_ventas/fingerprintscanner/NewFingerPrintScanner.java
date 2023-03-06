package com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.util.Base64;
import android.util.Log;
import android.widget.Toast;

import androidx.fragment.app.Fragment;


import java.nio.ByteBuffer;


/**
 * Created by TuanLQ on 5/16/17.
 */

public class NewFingerPrintScanner extends FingerPrintScannerBase {


    public static final String ZYTRUST_PACKAGE_NAME_FINGER_APP = "com.zytrust.bitel";
    public static final String INSOLUTION_PACKAGE_NAME_FINGER_APP = "insolutions.veridium.bitel";

    public static final String ACTIVITY_NAME_SECUGEN = "com.zytrust.bitel.secugen.JSGDActivity";

    public static final String ACTIVITY_NAME_MORPHO = "com.zytrust.bitel.morpho.cbm.ProcessBioActivity";

    public static final String ACTIVITY_NAME_INSOLUTION = "insolutions.veridium.bitel.activity.BioMainActivity";

    public static final String FINGER_EXTRA_OPERATION = "operation";

    public static final String USER = "user";
    public static final String PASS = "passwd";
    public static final String APP_USER_PASS_BITTEL = "ApiBitel2017";

    public static final int ZYTRUST_BIOMETRIC_MORPHO_REQUEST = 1234;

    public static final int ZYTRUST_BIOMETRIC_SECUGEM_REQUEST = 2345;

    static final int IS_BIO_REQUEST = 99;


    private static final String TAG = "NewFingerPrintScanner";

    public byte[] templateBuffer;

    public byte[] imageBufferWSQ;

    public byte[] bitmapforviewer;

    public int height_bitmap;

    public int width_bitmap;

    private CaptureFingerListener mCallBack;

    private ComponentName cn;

    private Intent apiIntent;

    private String operation = "";

    private String deviceSerial = "";

    private IFingerPrint.FingerMethod method;

    private Fragment fragment;

    protected NewFingerPrintScanner(Activity activity, IFingerPrint.FingerMethod method) {
        super(activity);
        fragment = null;
        this.method = method;
    }

    public NewFingerPrintScanner(Fragment fragment, IFingerPrint.FingerMethod method) {
        super(fragment.getActivity());
        this.fragment = fragment;
        activity = null;
        this.method = method;
    }

    @Override
    public void onCapture(final CaptureFingerListener captureFingerListener) {
        this.captureFingerListener = captureFingerListener;

        newCapture(method, new CaptureFingerListener() {
            @Override
            public void onPreExecute() {

            }

            @Override
            public void onPostExecute(FingerPrint fingerPrint) {
                if (captureFingerListener != null) {
                    captureFingerListener.onPostExecute(fingerPrint);
                }
            }

            @Override
            public void onErrorExecute(String reason) {
                if (captureFingerListener != null) {
                    captureFingerListener.onErrorExecute(reason);
                }
            }
        });
    }

    @Override
    protected void onCapturing() {
        // start activity called from onCaptured.
    }

    @Override
    protected String getSerial() {
        return deviceSerial;
    }

    /**
     * Converts image to grayscale (NEW)
     */
    public static Bitmap toGrayscale(byte[] mImageBuffer, int imageWidth, int imageHeigth) {
        byte[] Bits = new byte[mImageBuffer.length * 4];
        for (int i = 0; i < mImageBuffer.length; i++) {
            Bits[i * 4] = Bits[i * 4 + 1] = Bits[i * 4 + 2] = mImageBuffer[i]; // Invert the source bits
            Bits[i * 4 + 3] = -1;// 0xff, that's the alpha.
        }
        Bitmap bmpGrayscale = Bitmap.createBitmap(imageWidth, imageHeigth, Bitmap.Config.ARGB_8888);
        //Bitmap bm contains the fingerprint img
        bmpGrayscale.copyPixelsFromBuffer(ByteBuffer.wrap(Bits));
        return bmpGrayscale;
    }

    private void newCapture(IFingerPrint.FingerMethod method, CaptureFingerListener callBack) {
        mCallBack = callBack;

        if (IFingerPrint.FingerMethod.INSOLUTION.getName().equals(method.getName())) {
            captureFingerprintInsolution();
        }if (IFingerPrint.FingerMethod.MORPHO.getName().equals(method.getName())) {
            captureFingerprintMorpho();
        } else if (IFingerPrint.FingerMethod.SECUGEN.getName().equals(method.getName())) {
            captureFingerprintSecugen();
        }
    }

    private void genIntentInsoltion() {
        apiIntent = new Intent(Intent.ACTION_MAIN, null);
        apiIntent.addCategory(Intent.CATEGORY_LAUNCHER);
        cn = new ComponentName(INSOLUTION_PACKAGE_NAME_FINGER_APP, ACTIVITY_NAME_INSOLUTION);
        apiIntent.setComponent(cn);

//        apiIntent.putExtra("numeroDNICliente", CacheData.getInstanse().getLoginAccount());
        apiIntent.putExtra("codigoHuellaIzquierda", CacheData.getInstanse().getLastLeftBestFinger());
        apiIntent.putExtra("codigoHuellaDerecha", CacheData.getInstanse().getLastRightBestFinger());
    }


    private void genIntentMorpho() {
        apiIntent = new Intent(Intent.ACTION_MAIN, null);
        apiIntent.addCategory(Intent.CATEGORY_LAUNCHER);
        cn = new ComponentName(ZYTRUST_PACKAGE_NAME_FINGER_APP, ACTIVITY_NAME_MORPHO);
        apiIntent.setComponent(cn);
        operation = FingerPrintConstant.OPERATION_CAPTURE_FINGERPRINT;
        apiIntent.putExtra(FINGER_EXTRA_OPERATION, operation);
        //Hieunv31 --------------13/07/2017 THEM PASS-----------------------
        apiIntent.putExtra(USER, APP_USER_PASS_BITTEL);
        apiIntent.putExtra(PASS, APP_USER_PASS_BITTEL);
        //Hieunv31 --------------13/07/2017 END-----------------------------

    }

    private void captureFingerprintInsolution() {


        try {
            Log.i(TAG, "captureFingerprintInsolution");
            genIntentInsoltion();
            if (fragment == null) {
                activity.startActivityForResult(apiIntent, IS_BIO_REQUEST);
            } else {
                fragment.startActivityForResult(apiIntent, IS_BIO_REQUEST);
            }
        } catch (Exception e) {
//            MBCCSLogger.getInstance().writeToLog(
//                    NewFingerPrintScanner.class.getSimpleName() + ", Exception genIntentMorpho: " +
//                            e.getMessage()
//            );

           e.printStackTrace();
        }

    }

    private void captureFingerprintMorpho() {


        try {
            Log.i(TAG, "captureFingerprintMorpho");
            genIntentMorpho();
            if (fragment == null) {
                activity.startActivityForResult(apiIntent, ZYTRUST_BIOMETRIC_MORPHO_REQUEST);
            } else {
                fragment.startActivityForResult(apiIntent, ZYTRUST_BIOMETRIC_MORPHO_REQUEST);
            }
        } catch (Exception e) {
//            MBCCSLogger.getInstance().writeToLog(
//                    NewFingerPrintScanner.class.getSimpleName() + ", Exception genIntentMorpho: " +
//                            e.getMessage()
//            );

            e.printStackTrace();
        }

    }

    private void genIntentSecugen() {
        apiIntent = new Intent(Intent.ACTION_MAIN, null);
        apiIntent.addCategory(Intent.CATEGORY_LAUNCHER);
        cn = new ComponentName(ZYTRUST_PACKAGE_NAME_FINGER_APP, ACTIVITY_NAME_SECUGEN);
        apiIntent.setComponent(cn);
        operation = FingerPrintConstant.OPERATION_CAPTURE_FINGERPRINT;
        apiIntent.putExtra(FINGER_EXTRA_OPERATION, operation);
        //Hieunv31 --------------13/07/2017 THEM PASS-----------------------
        apiIntent.putExtra(USER, APP_USER_PASS_BITTEL);
        apiIntent.putExtra(PASS, APP_USER_PASS_BITTEL);
        //Hieunv31 --------------13/07/2017 END-----------------------------
    }


    private void captureFingerprintSecugen() {



        try {
            Log.i(TAG, "captureFingerprintSecugen");
            genIntentSecugen();
            if (fragment == null) {
                activity.startActivityForResult(apiIntent, ZYTRUST_BIOMETRIC_SECUGEM_REQUEST);
            } else {
                fragment.startActivityForResult(apiIntent, ZYTRUST_BIOMETRIC_SECUGEM_REQUEST);
            }
        } catch (Exception e) {
            e.printStackTrace();
//            MBCCSLogger.getInstance().writeToLog(
//                    NewFingerPrintScanner.class.getSimpleName() + ", Exception: genIntentSecugen " +
//                            e.getMessage());


        }

    }

    /**
     * Method used to check result from finger print.
     *
     * @param requestCode
     * @param resultCode
     * @param data
     */
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        try{
            int coError;
            String deError;
            String response;
            String deErrorBio;
            if (requestCode == ZYTRUST_BIOMETRIC_MORPHO_REQUEST) {
                if (resultCode == Activity.RESULT_OK) {
                    Bundle bundle = data.getExtras();
                    if (bundle != null) {
                        deError = (String) bundle.get(FingerPrintConstant.DE_ERROR);
                        StringBuilder sb = new StringBuilder();
                        switch (operation) {
                            case FingerPrintConstant.OPERATION_CAPTURE_FINGERPRINT:
                                // dismiss progress dialog.
                                // hideWaitProgress();

                                coError = data.getIntExtra(FingerPrintConstant.CO_ERROR, 0);
                                response = data.getStringExtra(FingerPrintConstant.RESPONSE);
                                sb.append(FingerPrintConstant.OPERATION_CAPTURE_FINGERPRINT);
                                sb.append("\n");
                                sb.append(FingerPrintConstant.CO_ERROR);
                                sb.append(":");
                                sb.append(coError);
                                sb.append("\n");
                                sb.append(FingerPrintConstant.DE_ERROR);
                                sb.append(":");
                                sb.append(deError);
                                sb.append("\n");

                                if (response.equals("0")) {
                                    if (coError == FingerPrintConstant.CODE_SIN_PERMISOS) {
                                        deErrorBio = deError;
                                        // showWaitProgress(BaseFingerPrint.this, "Por favor espere. Conectando a lector...");
                                        captureFingerprintMorpho();
                                    } else if (coError == -1000 || coError == -3) {
                                        deErrorBio = FingerPrintConstant.LECTOR_NO_CONECTADO;
                                    } else {
                                        deErrorBio = FingerPrintConstant.HUELLA_NO_CAPTURADA;
                                    }
                                    sb.append(deErrorBio);
                                    if (mCallBack != null) {
                                        mCallBack.onErrorExecute(sb.toString());
                                    }

                                    return;
                                } else {

                                    // HIT
                                    if (response.equals("1")) {
                                        //pk
                                        templateBuffer = data.getByteArrayExtra(FingerPrintConstant.TEMPLATEBUFFER);
                                        //wsq
                                        imageBufferWSQ = data.getByteArrayExtra(FingerPrintConstant.IMAGEBUFFER_WSQ);
                                        bitmapforviewer = data.getByteArrayExtra(FingerPrintConstant.BITMAP_FOR_VIEWER);
                                        height_bitmap = data.getIntExtra(FingerPrintConstant.BITMAP_HEIGHT_FOR_VIEWER, 0);
                                        width_bitmap = data.getIntExtra(FingerPrintConstant.BITMAP_WIDTH_FOR_VIEWER, 0);
                                        System.out.println("templateBuffer -> "+templateBuffer );
                                        System.out.println("imageBufferWSQ -> "+imageBufferWSQ );

                                        System.out.println("templateBuffer -> "+templateBuffer );
                                        System.out.println("imageBufferWSQ -> "+imageBufferWSQ );

                                        try {
                                            deviceSerial = data.getStringExtra("nuSerial");
                                            deviceSerial = deviceSerial.replaceAll("\\s", "");
                                        } catch (Exception e) {
                                        }
                                        // success.
                                        FINGER_PRINT.setFingerPrintBmp(toGrayscale(bitmapforviewer, width_bitmap, height_bitmap));
                                        FINGER_PRINT.setImageHeight(height_bitmap);
                                        FINGER_PRINT.setImageWidth(width_bitmap);
                                        FINGER_PRINT.setHaveFingerImage(true);

                                        String encode64 = Base64.encodeToString(imageBufferWSQ, Base64.NO_WRAP);
                                        FINGER_PRINT.setEncodeBase64(encode64);
                                        FINGER_PRINT.setSerial(deviceSerial);
                                        FINGER_PRINT.setPk(templateBuffer);

                                        if (mCallBack != null) {
                                            mCallBack.onPostExecute(FINGER_PRINT);
                                        }
                                    } else {
                                        if (mCallBack != null) {
                                            mCallBack.onErrorExecute(sb.toString());
                                        }
                                    }
                                }
                                break;
                        }
                    }

                } else if (resultCode == Activity.RESULT_CANCELED) {
                    Log.d(TAG,"onErrorExecute");
//                    if (mCallBack != null) {
//                        mCallBack.onErrorExecute(context.getString(R.string.text_cancel_finger_print));
//                    }
                }
            } else if (requestCode == ZYTRUST_BIOMETRIC_SECUGEM_REQUEST) {
                if (resultCode == Activity.RESULT_OK) {
                    Log.d(TAG,"Secugen:onActivityResult.operation=" + operation);
//                    Timber.i(TAG, "Secugen:onActivityResult.operation=" + operation);
                    Bundle bundle = data.getExtras();
                    if (bundle != null) {
                        deError = (String) bundle.get(FingerPrintConstant.DE_ERROR);
                        StringBuilder sb = new StringBuilder();

                        switch (operation) {
                            case FingerPrintConstant.OPERATION_CAPTURE_FINGERPRINT:

                                // show progress dialog.
                                // showWaitProgress(this);

                                Log.d(getClass().toString(), deError);
                                coError = data.getIntExtra(FingerPrintConstant.CO_ERROR, 0);
                                response = data.getStringExtra(FingerPrintConstant.RESPONSE);

                                sb.append(FingerPrintConstant.OPERATION_CAPTURE_FINGERPRINT);
                                sb.append("\n");
                                sb.append(FingerPrintConstant.CO_ERROR);
                                sb.append(":");
                                sb.append(coError);
                                sb.append("\n");
                                sb.append(FingerPrintConstant.DE_ERROR);
                                sb.append(":");
                                sb.append(deError);
//                                Timber.i(TAG, "" + coError);
                                Log.d(TAG, "" + coError);

                                if (response.equals("0")) {
                                    if (coError == FingerPrintConstant.CODE_SIN_PERMISOS) {
                                        // showWaitProgress(BaseFingerPrint.this, "Por favor espere. Conectando a lector...");
                                        deErrorBio = deError;
                                        captureFingerprintSecugen();
                                    } else if (coError == -95 || coError == -3) {
                                        deErrorBio = FingerPrintConstant.LECTOR_NO_CONECTADO;

                                    } else {

                                        deErrorBio = FingerPrintConstant.HUELLA_NO_CAPTURADA;
                                    }
                                    sb.append(deErrorBio);

                                    if (mCallBack != null) {
                                        mCallBack.onErrorExecute(sb.toString());
                                    }

                                    return;
                                } else {

                                    if (response.equals("1")) {
                                        //pk
                                        templateBuffer = data.getByteArrayExtra(FingerPrintConstant.TEMPLATEBUFFER);
                                        //wsq
                                        imageBufferWSQ = data.getByteArrayExtra(FingerPrintConstant.IMAGEBUFFER_WSQ);
                                        bitmapforviewer = data.getByteArrayExtra(FingerPrintConstant.BITMAP_FOR_VIEWER);

                                        height_bitmap = data.getIntExtra(FingerPrintConstant.BITMAP_HEIGHT_FOR_VIEWER, 0);
                                        width_bitmap = data.getIntExtra(FingerPrintConstant.BITMAP_WIDTH_FOR_VIEWER, 0);

                                        System.out.println("templateBuffer -> "+templateBuffer );
                                        System.out.println("imageBufferWSQ -> "+imageBufferWSQ );

                                        try {
                                            deviceSerial = data.getStringExtra("nuSerial");
                                            deviceSerial = deviceSerial.replaceAll("\\s", "");
                                        } catch (Exception e) {
                                        }
                                        // successfully.

                                        Toast.makeText(context, width_bitmap + " - " + height_bitmap, Toast.LENGTH_LONG).show();
                                        FINGER_PRINT.setFingerPrintBmp(toGrayscale(bitmapforviewer, width_bitmap, height_bitmap));
                                        FINGER_PRINT.setImageHeight(height_bitmap);
                                        FINGER_PRINT.setImageWidth(width_bitmap);
                                        FINGER_PRINT.setHaveFingerImage(true);
                                        String encode64 = Base64.encodeToString(imageBufferWSQ, Base64.NO_WRAP);
                                        FINGER_PRINT.setEncodeBase64(encode64);
                                        FINGER_PRINT.setSerial(deviceSerial);
                                        FINGER_PRINT.setPk(templateBuffer);

                                        if (mCallBack != null) {
                                            mCallBack.onPostExecute(FINGER_PRINT);
                                        }
                                    } else {
                                        if (mCallBack != null) {
                                            mCallBack.onErrorExecute(sb.toString());
                                        }
                                    }
                                }

                                break;
                        }
                    }
                } else if (resultCode == Activity.RESULT_CANCELED) {
                    Log.d(TAG,"onErrorExecute");
//                    if (mCallBack != null) {
//                        mCallBack.onErrorExecute(context.getString(R.string.text_cancel_finger_print));
//                    }
                }
            } else if (requestCode == IS_BIO_REQUEST) {
                if (resultCode == Activity.RESULT_OK) {
                    Log.d(TAG,"Secugen:onActivityResult.operation=" + operation);
//                    Timber.i(TAG, "Insolution:onActivityResult.operation=" + operation);
                    Bundle bundle = data.getExtras();
                    if (bundle != null) {
                        int codigoTransaccion = data.getIntExtra("codigoTransaccion", 0);
                        String respuestaTransaccion = data.getStringExtra("respuestaTransaccion");
                        String codigoServicio = data.getStringExtra("codigoServicio");
                        String plantillaWSQ = data.getStringExtra("plantillaWSQ").replace("\n","");
                        String plantillaANSI = data.getStringExtra("plantillaANSI").replace("\n","");

                        if ("200".endsWith(codigoServicio)) {
                            //wsq
                            FINGER_PRINT.setPk(Base64.decode(plantillaANSI, Base64.DEFAULT));
                            FINGER_PRINT.setEncodeBase64(plantillaWSQ);
                            FINGER_PRINT.setHaveFingerImage(true);
                            FINGER_PRINT.setSerial("Insolution");

//                            org.jnbis.api.model.Bitmap bitmapModel = Jnbis.wsq().decode(Base64.decode(plantillaWSQ, Base64.NO_WRAP)).asBitmap();
//
//                            FINGER_PRINT.setImageHeight(bitmapModel.getHeight());
//                            FINGER_PRINT.setImageWidth(bitmapModel.getWidth());
//                            FINGER_PRINT.setFingerPrintBmp(toGrayscale(bitmapModel.getPixels(), bitmapModel.getWidth(), bitmapModel.getHeight()));
                            if (mCallBack != null) {
                                mCallBack.onPostExecute(FINGER_PRINT);
                            }
                        } else {
                            if (mCallBack != null) {
                                mCallBack.onErrorExecute("Insolution(" + codigoTransaccion + "):" + respuestaTransaccion);
                            }
                        }

                    }
                } else if (resultCode == Activity.RESULT_CANCELED) {
                    Log.d(TAG,"onErrorExecute");
//                    if (mCallBack != null) {
//                        mCallBack.onErrorExecute(context.getString(R.string.text_cancel_finger_print));
//                    }
                }
            }
        }
        catch(Exception e)
        {
            Log.d(TAG,e.getMessage());
//            MBCCSLogger.getInstance().writeToLog(
//                    NewFingerPrintScanner.class.getSimpleName() + ", Exception: Onresult " +
//                            e.getMessage().toString());
        }

    }
}
