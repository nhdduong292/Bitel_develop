package com.bitel.bss.viettelpos.v3.bitel_ventas.camera.utils;

import android.app.Activity;
import android.hardware.Camera;
import android.util.Log;
import android.view.Surface;
import android.widget.Toast;

import java.util.ArrayList;

public class CameraUtils {

    private static final String TAG = CameraUtils.class.getSimpleName();

    public static Camera.Size preferredSize;
    public static ArrayList<Camera.Size> listVideoSize;
    public static ArrayList<Camera.Size> listSupportPreviewSizeCamera;
    public static ArrayList<Camera.Size> listSupportPictureSizeCamera;
    public static Camera.Parameters parameters;
    public static boolean isExistSize;

    public static Camera getCameraInstance(int cameraId) {
        Camera c = null;
        try {
            c = Camera.open(cameraId); // attempt to get a Camera instance
            parameters = c.getParameters();
            listVideoSize = (ArrayList<Camera.Size>) parameters.getSupportedVideoSizes();
            if (listVideoSize != null) {
                preferredSize = parameters.getPreferredPreviewSizeForVideo();
            } else {
                listSupportPreviewSizeCamera = (ArrayList<Camera.Size>) parameters
                        .getSupportedPreviewSizes();
            }

            listSupportPictureSizeCamera = (ArrayList<Camera.Size>) parameters
                    .getSupportedPictureSizes();
            parameters.setFocusMode(Camera.Parameters.FOCUS_MODE_CONTINUOUS_PICTURE);
        } catch (Exception e) {
            // Camera is not available (in use or does not exist)
            Log.e("TAG:" + TAG, "Camera is not available: " + e.getMessage());
        }
        return c; // returns null if camera is unavailable
    }

    public static void setCameraDisplayOrientation(Activity activity,
                                                   int cameraId, Camera camera) {
        if (camera == null) {
            Toast.makeText(activity, "Camera không hoạt động.", Toast.LENGTH_SHORT).show();
            return;
        }

        Camera.CameraInfo info =
                new Camera.CameraInfo();
        Camera.getCameraInfo(cameraId, info);
        int rotation = activity.getWindowManager().getDefaultDisplay()
                .getRotation();
        int degrees = 0;
        switch (rotation) {
            case Surface.ROTATION_0:
                degrees = 0;
                break;
            case Surface.ROTATION_90:
                degrees = 90;
                break;
            case Surface.ROTATION_180:
                degrees = 180;
                break;
            case Surface.ROTATION_270:
                degrees = 270;
                break;
        }

        int result;
        if (info.facing == Camera.CameraInfo.CAMERA_FACING_FRONT) {
            result = (info.orientation + degrees) % 360;
            result = (360 - result) % 360;  // compensate the mirror
        } else {  // back-facing
            result = (info.orientation - degrees + 360) % 360;
        }
        camera.setDisplayOrientation(result);
    }

}
