package com.bitel.bss.viettelpos.v3.bitel_ventas;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner.EmptyFingerPrintScanner;
import com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner.FingerPrint;
import com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner.FingerPrintConstant;
import com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner.FingerPrintScannerBase;
import com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner.FingerScannerFactory;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainFingerActivity extends FlutterActivity {
    private String platformFinger = "bitel.com/finger";
    String nameFinger = "getFinger";
    private MethodChannel channelFinger;
    private ProgressDialog waitProgress;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // finger print.
        FingerScannerFactory.getFingerPrintScanner(this, true);
        FingerPrintScannerBase.FINGER_PRINT.reset();
        FingerScannerFactory.createInstance();
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), platformFinger).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                if(call.method.equals(nameFinger)){
                   getImageCapture();
                    if(bitmap != null) {
                        result.success(saveImageToCache(bitmap));
                        bitmap = null;
                    } else {
                        result.error("UNAVAILABLE", "Finger not available.", null);
                    }
                } else {
                    result.notImplemented();
                }
            }
        });
    }
    Bitmap bitmap;
    void getImageCapture(){
        if (FingerPrintConstant.IS_BY_PASS_FINGER_PRINT) {
            String wsqLeft = FingerPrintConstant.DUMMY_FINGERPRINT;
            Bitmap fingerPrintImgTest = BitmapFactory.decodeResource(getResources(), R.drawable.fingerprint_test);
            FingerPrintScannerBase.FINGER_PRINT.setEncodeBase64(wsqLeft);
            FingerPrintScannerBase.FINGER_PRINT.setFingerPrintBmp(fingerPrintImgTest);
            return;
        }

        if (FingerScannerFactory.fingerPrintScannerImp == null) {
            showDialog("Error","Your device is not compatible with this version. Please, use Android 6 or lower.","","Cancel");
        } else if (FingerScannerFactory.fingerPrintScannerImp instanceof EmptyFingerPrintScanner) {
            if (((EmptyFingerPrintScanner) FingerScannerFactory.fingerPrintScannerImp).getStatus()
                    == EmptyFingerPrintScanner.STATUS.DEVICE_NOT_FOUND) {
                showDialog("Error","Can\\'t find usb fingerprint scanner. Please go back one step and plugin the device","","Cancel");
            } else {
                showDialog("Error","Your device is not compatible with this version. Please, use Android 6 or lower.","","Cancel");
            }
        } else {
            FingerScannerFactory.fingerPrintScannerImp.onCapture(new FingerPrintScannerBase.CaptureFingerListener() {
                @Override
                public void onPreExecute() {
                    showWaitProgress(MainFingerActivity.this,"Each capture should not longer than 10s, please try to re-position your finger");
                }

                @Override
                public void onPostExecute(FingerPrint fingerPrint) {
                    hideWaitProgress();
                    if (fingerPrint != null) {
                        if (fingerPrint.getFingerPrintBmp() != null) {
                            bitmap = fingerPrint.getFingerPrintBmp();
                        } else {
                            bitmap = null;
                        }
                    }
                }

                @Override
                public void onErrorExecute(String reason) {
                    Toast.makeText(MainFingerActivity.this, reason, Toast.LENGTH_SHORT).show();
                }
            });
        }
    }
    private void showDialog(String title, String content, String btnLeft, String btnRight){
        AlertDialog alertDialog = new AlertDialog.Builder(this).create();
        alertDialog.setTitle(title);
        alertDialog.setMessage(content);
        alertDialog.setButton(AlertDialog.BUTTON_NEGATIVE, btnLeft,
                new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.dismiss();
                    }
                });
        alertDialog.setButton(AlertDialog.BUTTON_POSITIVE, btnRight, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        alertDialog.show();
    }

    public void showWaitProgress(Context context, String message) {
        if (isFinishing()) {
            return;
        }
        hideWaitProgress();

        waitProgress = new ProgressDialog(context);
        waitProgress.setMessage(message);
        waitProgress.setCancelable(false);
        waitProgress.show();
    }

    public void hideWaitProgress() {
        if (waitProgress != null && waitProgress.isShowing()) {
            waitProgress.cancel();
        }
    }

    public void dissmissProgressDialog() {
        if (waitProgress != null && waitProgress.isShowing()) {
            waitProgress.dismiss();
        }
    }

    String saveImageToCache(Bitmap bitmap){
        File sd = getCacheDir();
        File folder = new File(sd, "/finger/");
        if (!folder.exists()) {
            if (!folder.mkdir()) {
                Log.e("ERROR", "Cannot create a directory!");
            } else {
                folder.mkdirs();
            }
        }
        File fileName = new File(folder,System.currentTimeMillis()+".jpg");
        try {
            FileOutputStream outputStream = new FileOutputStream(String.valueOf(fileName));
            bitmap.compress(Bitmap.CompressFormat.JPEG, 100, outputStream);
            outputStream.close();

        } catch (IOException e) {
            e.printStackTrace();
            return "";
        }
        return fileName.getPath();
    }
}
