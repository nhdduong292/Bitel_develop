package com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Environment;
import android.util.Log;


import com.bitel.bss.viettelpos.v3.bitel_ventas.MainFingerActivity;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;

public abstract class FingerPrintScannerBase {

    private static final String TAG = FingerPrintScannerBase.class.getSimpleName();

    protected Context context;

    protected Activity activity;

    boolean isPausedWhileInUse = false;

    CaptureFingerListener  captureFingerListener;

    public static FingerPrint FINGER_PRINT = new FingerPrint();

    protected FingerPrintScannerBase(Context context){
        this.context = context;
        activity = (Activity)context;
    }

    public void onCreate(){}

    public void onResume(){}

    public void onPause(){}

    public void onStop(){}

    protected String getString(int idRes){
        return context.getString(idRes);
    }

    protected MainFingerActivity getMainActivity(){
        return (MainFingerActivity)activity;
    }

    public void onCapture(CaptureFingerListener captureFingerListener) {
        this.captureFingerListener = captureFingerListener;
        CaptureFingerAsyncTask captureFingerAsyncTask = new CaptureFingerAsyncTask();
        captureFingerAsyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR);
    }

    public void onDestroy() {
    }

    /**
     * AsyncTask captures fingerprint
     */
    @SuppressLint("StaticFieldLeak")
    protected class CaptureFingerAsyncTask extends AsyncTask<Void, Void, Void> {
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            captureFingerListener.onPreExecute();
            Log.d(TAG,"showWaitProgress");
//            getMainActivity().showWaitProgress(context, getString(R.string.waiting_put_fingerprint));
        }

        @Override
        protected Void doInBackground(Void... arg0) {
            try {
                onCapturing();
                //captureFingerPrint();
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        protected void onPostExecute(Void arg) {
            captureFingerListener.onPostExecute(FINGER_PRINT);
            Log.d(TAG,"hideWaitProgress");
//            getMainActivity().hideWaitProgress();
        }
    }

    // Converts image to grayscale (NEW)
    protected Bitmap toGrayscale(byte[] mImageBuffer) {
        byte[] Bits = new byte[mImageBuffer.length * 4];
        for (int i = 0; i < mImageBuffer.length; i++) {
            // Invert the source bits
            Bits[i * 4] = Bits[i * 4 + 1] = Bits[i * 4 + 2] = mImageBuffer[i];
            Bits[i * 4 + 3] = -1;// 0xff, that's the alpha.
        }

        Bitmap bmpGrayscale = Bitmap.createBitmap(FINGER_PRINT.getImageWidth(), FINGER_PRINT.getImageHeight(), Bitmap.Config.ARGB_8888);
        // Bitmap bm contains the fingerprint img
        bmpGrayscale.copyPixelsFromBuffer(ByteBuffer.wrap(Bits));
        return bmpGrayscale;
    }

    protected void l(final String msg) {
        Log.e(TAG, ">==< " + msg.toString() + " >==<");
//        if(!Constant.IS_DEBUG_FINGER_PRINT_SCANNER){
//            return;
//        }
//        ((Activity)context).runOnUiThread(new Runnable() {
//            @Override
//            public void run() {
//                CommonActivity.createMultiAlertDialog((Activity)context, msg, "title").show();
//            }
//        });
    }

    protected void e(final String msg) {
        Log.e(TAG, ">==< " + msg.toString() + " >==<");
//        if(!Constant.IS_DEBUG_FINGER_PRINT_SCANNER){
//            return;
//        }
//        ((Activity)context).runOnUiThread(new Runnable() {
//            @Override
//            public void run() {
//                CommonActivity.createMultiAlertDialog((Activity)context, msg, "title").show();
//            }
//        });
    }

    void writeLogToFile(String fileName, String content, byte[] bytes){
//        if(!Constant.IS_DEBUG_FINGER_PRINT_SCANNER){
//            return;
//        }
        // Test code to generate wsq image to local drive to view by http://www.cognaxon.com/index.php?page=wsqview
        String ext_storage_state = Environment.getExternalStorageState();
        File mediaStorage = new File(Environment.getExternalStorageDirectory() + "/ftth");
        if (ext_storage_state.equalsIgnoreCase(Environment.MEDIA_MOUNTED)) {
            if (!mediaStorage.exists()) {
                mediaStorage.mkdirs();
            }
        }

        FileOutputStream fos = null;
        try {
            File myFile = new File(Environment.getExternalStorageDirectory() + "/ftth/"+fileName);
            myFile.createNewFile();
            fos = new FileOutputStream(myFile);

            try {
                if(content!=null)
                    fos.write(content.getBytes());
                else
                    fos.write(bytes);
                fos.flush();
                fos.close();
            } catch (IOException e) {
                e.printStackTrace();
            }

        } catch (IOException e1) {
            e1.printStackTrace();
        }
    }

    void writeBitmapToFile(String fileName, Bitmap bmp){
//        if(!Constant.IS_DEBUG_FINGER_PRINT_SCANNER){
//            return;
//        }
        String ext_storage_state = Environment.getExternalStorageState();
        File mediaStorage = new File(Environment.getExternalStorageDirectory() + "/luong");
        if (ext_storage_state.equalsIgnoreCase(Environment.MEDIA_MOUNTED)) {
            if (!mediaStorage.exists()) {
                mediaStorage.mkdirs();
            }
        }

        FileOutputStream out = null;
        try {

            File myFile = new File(Environment.getExternalStorageDirectory() + "/luong/"+fileName);
            myFile.createNewFile();
            out = new FileOutputStream(myFile);

            bmp.compress(Bitmap.CompressFormat.PNG, 100, out); // bmp is your Bitmap instance
            // PNG is a lossless format, the compression factor (100) is ignored
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (out != null) {
                    out.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    protected abstract void onCapturing();
    protected abstract String getSerial();

    public interface CaptureFingerListener {
        void onPreExecute();
        void onPostExecute(FingerPrint fingerPrint);
        void onErrorExecute(String reason);

    }


    byte[] removeUnusedBytes(byte[] pwImage, int actualLength) {
        try {
            e("wsqImageActualLength" + String.valueOf(actualLength));
            byte[] actualWsqImageBytes = new byte[actualLength];
            System.arraycopy(pwImage, 0, actualWsqImageBytes, 0, actualLength);
            return actualWsqImageBytes;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
