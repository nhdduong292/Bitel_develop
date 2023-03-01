package com.bitel.bss.viettelpos.v3.bitel_ventas;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner.FingerPrintScannerBase;
import com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner.FingerScannerFactory;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

public class MainFingerActivity extends FlutterActivity {
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

    }
}
