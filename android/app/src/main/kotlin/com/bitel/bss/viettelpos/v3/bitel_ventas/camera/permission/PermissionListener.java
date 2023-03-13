package com.bitel.bss.viettelpos.v3.bitel_ventas.camera.permission;

import androidx.annotation.NonNull;

public interface PermissionListener {

    void permissionGranted(@NonNull String[] permissions);

    void permissionDenied(@NonNull String[] permissions);
}
