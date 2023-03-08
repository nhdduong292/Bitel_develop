package com.bitel.bss.viettelpos.v3.bitel_ventas.camera.permission;


import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.provider.Settings;
import android.text.TextUtils;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;

import java.io.Serializable;

import io.flutter.embedding.android.FlutterActivity;

public class PermissionActivity extends FlutterActivity {

    private static final int PERMISSION_REQUEST_CODE = 64;
    private boolean isRequireCheck;

    private String[] pers;
    private String key;
    private boolean showTip;
    private PermissionsUtil.TipInfo tipInfo;

    private final String defaultTitle = "Info";
    private final String defaultContent = "\n" +
            "The current application is missing the necessary permissions.\n" +
            " \n" +
            " Click \"Settings\" - \"Permissions\" - to open the required permissions.";
    private final String defaultCancel = "Cancel";
    private final String defaultEnsure = "OK";

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getIntent() == null || !getIntent().hasExtra("permission")) {
            finish();
            return;
        }

        isRequireCheck = true;
        pers = getIntent().getStringArrayExtra("permission");
        key = getIntent().getStringExtra("key");
        showTip = getIntent().getBooleanExtra("showTip", true);
        Serializable ser = getIntent().getSerializableExtra("tip");

        if (ser == null) {
            tipInfo = new PermissionsUtil.TipInfo(defaultTitle, defaultContent, defaultCancel, defaultEnsure);
        } else {
            tipInfo = (PermissionsUtil.TipInfo)ser;
        }

    }

    @Override
    protected void onResume() {
        super.onResume();
        if (isRequireCheck) {
            if (PermissionsUtil.allPermissionGranted(this, pers)) {
                allPermissionsGranted();
            } else {
                requestPermissions(pers);
                isRequireCheck = false;
            }
        } else {
            isRequireCheck = true;
        }
    }


    private void requestPermissions(String... permissions) {
        ActivityCompat.requestPermissions(this, permissions, PERMISSION_REQUEST_CODE);
    }

    private void allPermissionsGranted() {
        PermissionListener listener = PermissionsUtil.fetchListener(key);
        if (listener != null) {
            listener.permissionGranted(pers);
        }
        finish();
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        if (requestCode == PERMISSION_REQUEST_CODE && PermissionsUtil.allPermissionsGranted(grantResults)) {
            allPermissionsGranted();
        } else if (showTip){
            showMissingPermissionDialog();
        } else {
            denyPermit();
        }
    }

    private void showMissingPermissionDialog() {

        AlertDialog.Builder builder = new AlertDialog.Builder(PermissionActivity.this);

        builder.setTitle(TextUtils.isEmpty(tipInfo.title) ? defaultTitle : tipInfo.title);
        builder.setMessage(TextUtils.isEmpty(tipInfo.content) ? defaultContent : tipInfo.content);

        builder.setNegativeButton(TextUtils.isEmpty(tipInfo.cancel) ? defaultCancel : tipInfo.cancel, new DialogInterface.OnClickListener(){
            @Override
            public void onClick(DialogInterface dialog, int which) {
                denyPermit();
            }
        });

        builder.setPositiveButton(TextUtils.isEmpty(tipInfo.ensure) ? defaultEnsure : tipInfo.ensure, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                startAppSettings();
            }
        });

        builder.setCancelable(false);
        builder.show();

    }

    private void startAppSettings() {
        Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
        intent.setData(Uri.parse("package:" + getPackageName()));
        startActivity(intent);
    }


    private void denyPermit() {
        PermissionListener listener = PermissionsUtil.fetchListener(key);
        if (listener != null) {
            listener.permissionDenied(pers);
        }
        finish();
    }

    protected void onDestroy() {
        super.onDestroy();
    }

}

