package com.bitel.bss.viettelpos.v3.bitel_ventas;

import android.Manifest;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.res.Configuration;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Base64;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.content.FileProvider;

import com.bitel.bss.viettelpos.v3.bitel_ventas.camera.camera.IDCardCamera;
import com.bitel.bss.viettelpos.v3.bitel_ventas.camera.permission.PermissionListener;
import com.bitel.bss.viettelpos.v3.bitel_ventas.camera.permission.PermissionsUtil;
import com.bitel.bss.viettelpos.v3.bitel_ventas.camera.utils.ImageUtils;
import com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner.EmptyFingerPrintScanner;
import com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner.FingerPrint;
import com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner.FingerPrintConstant;
import com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner.FingerPrintScannerBase;
import com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner.FingerScannerFactory;
import com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner.NewFingerPrintScanner;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainFingerActivity extends FlutterActivity {
    private static final String TAG = "MainFingerActivity";
    private String platformFinger = "bitel.com/finger";
    private String platformFingerPK = "bitel.com/fingerPK";
    private String platformScan1 = "bitel.com/scan1";
    private String platformScan2 = "bitel.com/scan2";
    String nameFinger = "getFinger";
    String nameFingerPK = "getFingerPK";
    String nameScan1 = "getScan1";
    String nameScan2 = "getScan2";
    private MethodChannel channelScan1;
    private MethodChannel channelScan2;
    private ProgressDialog waitProgress;


    int positionScan = 0;

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
                if (call.method.equals(nameFinger)) {
                    positionScan = 0;
                    Map<String, String> arguments = call.arguments();
                    String pk = "0";
                    String language = "";
                    if (arguments != null) {
                        if(arguments.size() > 1){
                            pk = arguments.get("pk");
                        }
                        language = arguments.get("language");
                    }
                    getImageCapture(result, pk, language);
                } else {
                    result.notImplemented();
                }
            }
        });

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), platformFingerPK).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                if (call.method.equals(nameFingerPK)) {
                    if (FingerPrintScannerBase.FINGER_PRINT.getPk() != null) {
                        String mPk = Base64.encodeToString(FingerPrintScannerBase.FINGER_PRINT.getPk(), Base64.NO_WRAP);
                        result.success(mPk);
                    } else {
                        result.notImplemented();
                    }
                } else {
                    result.notImplemented();
                }
            }
        });
    }

    Bitmap bitmap;

    void getImageCapture(MethodChannel.Result result, String isPK, String language) {
        Locale myLocale;
        myLocale = new Locale(language);
        Locale.setDefault(myLocale);
        Configuration config = new Configuration();
        config.locale = myLocale;
        getResources().updateConfiguration(config, getResources().getDisplayMetrics());
         String locale = myLocale.getLanguage();
        if (FingerPrintConstant.IS_BY_PASS_FINGER_PRINT) {
            String wsqLeft = FingerPrintConstant.DUMMY_FINGERPRINT;
            Bitmap fingerPrintImgTest = BitmapFactory.decodeResource(getResources(), R.drawable.fingerprint_test);
            FingerPrintScannerBase.FINGER_PRINT.setEncodeBase64(wsqLeft);
            FingerPrintScannerBase.FINGER_PRINT.setFingerPrintBmp(fingerPrintImgTest);
            result.error("UNAVAILABLE", "Finger not available.", null);
            return;
        }

        if (FingerScannerFactory.fingerPrintScannerImp == null) {
            Log.d(TAG, "fingerPrintScannerImp == null");
            showDialog("Error", getString(R.string.title_error_device_lower_6), "", "Cancel");
            result.error("UNAVAILABLE", "Finger not available.", null);
        } else if (FingerScannerFactory.fingerPrintScannerImp instanceof EmptyFingerPrintScanner) {
            Log.d(TAG, "fingerPrintScannerImp instanceof EmptyFingerPrintScanner");
            if (((EmptyFingerPrintScanner) FingerScannerFactory.fingerPrintScannerImp).getStatus()
                    == EmptyFingerPrintScanner.STATUS.DEVICE_NOT_FOUND) {
                Log.d(TAG, "fingerPrintScannerImp instanceof EmptyFingerPrintScanner DEVICE_NOT_FOUND");
                showDialog("Error", getString(R.string.title_error_find_use_findger), "", "Cancel");
            } else {
                Log.d(TAG, "fingerPrintScannerImp instanceof EmptyFingerPrintScanner DEVICE");
                showDialog("Error", getString(R.string.title_error_device_lower_6), "", "Cancel");
            }
            result.error("UNAVAILABLE", "Finger not available.", null);
        } else {
            Log.d(TAG, "fingerPrintScannerImp.onCapture");
            FingerScannerFactory.fingerPrintScannerImp.onCapture(new FingerPrintScannerBase.CaptureFingerListener() {
                @Override
                public void onPreExecute() {

                    showWaitProgress(MainFingerActivity.this, getString(R.string.title_load_fingerScan));
                }

                @Override
                public void onPostExecute(FingerPrint fingerPrint) {
                    hideWaitProgress();
                    if (fingerPrint != null) {
                        if (fingerPrint.getFingerPrintBmp() != null) {
                            try {
                                bitmap = fingerPrint.getFingerPrintBmp();
                                String link = saveImageToCache(bitmap);
                                String imageBase64 = fingerPrint.getEncodeBase64();
                                FingerModel fingerModel;
                                if (isPK.equals("0")) {
                                    fingerModel = new FingerModel(link, imageBase64);
                                } else {
                                    if (fingerPrint.getPk() != null) {
                                        String mPk = Base64.encodeToString(fingerPrint.getPk(), Base64.NO_WRAP);
                                        if(!TextUtils.isEmpty(mPk)) {
                                            fingerModel = new FingerModel(link, imageBase64, mPk);
                                        } else {
                                            fingerModel = new FingerModel(link, imageBase64);
                                        }
                                    } else {
                                        fingerModel = new FingerModel(link, imageBase64);
                                    }
                                }
                                result.success(fingerModel.toString());
                            }catch (Exception e){
                                result.error("UNAVAILABLE", "Finger not crashhhhhhhhhhhhhhh.", null);
                            }
                        } else {
                            result.error("UNAVAILABLE", "Finger not available.", null);
                        }
                    } else {
                        result.error("UNAVAILABLE", "Finger not available.", null);
                    }
                }

                @Override
                public void onErrorExecute(String reason) {
                    Toast.makeText(MainFingerActivity.this, reason, Toast.LENGTH_SHORT).show();
                }
            });
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (FingerScannerFactory.fingerPrintScannerImp instanceof NewFingerPrintScanner) {
            NewFingerPrintScanner newFingerPrintScanner = (NewFingerPrintScanner) FingerScannerFactory.fingerPrintScannerImp;
            newFingerPrintScanner.onActivityResult(requestCode, resultCode, data);
        }
        if (resultCode == IDCardCamera.RESULT_CODE) {
            if (requestCode != IDCardCamera.REQUEST_SCAN_IMAGE) {
                return;
            }
            final String path = IDCardCamera.getImagePath(data);

            if (TextUtils.isEmpty(path)) {
//                decodeORCFail();
                return;
            }
            File photoFile = new File(path);
            Uri imageUri = FileProvider.getUriForFile(MainFingerActivity.this,
                    BuildConfig.APPLICATION_ID + ".provider",
                    photoFile);

            File file = null;
            try {
                file = ImageUtils.convertBitmapToFile(MainFingerActivity.this,
                        ImageUtils.scaleImageBitmap(MainFingerActivity.this,
                                imageUri, 640, 480), "" + System.currentTimeMillis());
//                currentCustomer.setImageFile(file);
            } catch (IOException e) {
                e.printStackTrace();
            }
            if (file == null) {
                if (positionScan == 0) {
                    channelScan1.invokeMethod(nameScan1, photoFile.getPath());
                } else {
                    channelScan2.invokeMethod(nameScan2, photoFile.getPath());
                }
            } else {
                if (positionScan == 0) {
                    channelScan1.invokeMethod(nameScan1, file.getPath());
                } else {
                    channelScan2.invokeMethod(nameScan2, file.getPath());
                }
            }
        }
    }

    @Override
    public void onPause() {
        try {
            FingerScannerFactory.fingerPrintScannerImp.onPause();
        } catch (Exception e) {
        }

        super.onPause();
    }

    @Override
    public void onResume() {
        super.onResume();
        FingerScannerFactory.onResume();
        if (FingerScannerFactory.fingerPrintScannerImp != null) {
            FingerScannerFactory.fingerPrintScannerImp.onResume();
        }
    }

    @Override
    public void onStop() {
        super.onStop();
        FingerScannerFactory.onStop();
    }

    private void showDialog(String title, String content, String btnLeft, String btnRight) {
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

    String saveImageToCache(Bitmap bitmap) {
        File sd = getCacheDir();
        File folder = new File(sd, "/finger/");
        if (!folder.exists()) {
            if (!folder.mkdir()) {
                Log.e("ERROR", "Cannot create a directory!");
            } else {
                folder.mkdirs();
            }
        }
        File fileName = new File(folder, System.currentTimeMillis() + ".jpg");
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

    private void onScanImage() {
        PermissionsUtil.requestPermission(MainFingerActivity.this, new PermissionListener() {
            @Override
            public void permissionGranted(@NonNull String[] permissions) {
//                isCaptureImage.set(false);
                IDCardCamera.create(MainFingerActivity.this).openCamera(IDCardCamera.REQUEST_SCAN_IMAGE);
            }

            @Override
            public void permissionDenied(@NonNull String[] permissions) {


            }
        }, new String[]{android.Manifest.permission.CAMERA,
                android.Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.READ_EXTERNAL_STORAGE});


    }

}
