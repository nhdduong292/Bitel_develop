package com.bitel.bss.viettelpos.v3.bitel_ventas.camera.utils;

import android.content.Context;
import android.content.res.Resources;
import android.hardware.Camera;
import android.view.SurfaceHolder;
import android.view.SurfaceView;


public class CameraPreview extends SurfaceView implements SurfaceHolder.Callback {

    private static final String TAG = CameraPreview.class.getSimpleName();

    public SurfaceHolder mHolder;
    private final Camera mCamera;

    public CameraPreview(Context context, Camera camera) {
        super(context);
        mCamera = camera;
        // Install a SurfaceHolder.Callback so we get notified when the
        // underlying surface is created and destroyed.
        mHolder = getHolder();
        mHolder.addCallback(this);
        // deprecated setting, but required on Android versions prior to 3.0
        mHolder.setType(SurfaceHolder.SURFACE_TYPE_PUSH_BUFFERS);
        setPreviewSize();
        setPictureSize();
    }

    public void surfaceCreated(SurfaceHolder holder) {
        // The Surface has been created, now tell the camera where to draw the preview.
        try {
            setPreviewSize();
            setPictureSize();
            mCamera.setParameters(CameraUtils.parameters);
            mCamera.setPreviewDisplay(holder);
            mCamera.startPreview();
        } catch (Exception e) {
//            Timber.d("Error setting camera preview: %s", e.getMessage());
        }
    }

    public void surfaceDestroyed(SurfaceHolder holder) {
        // Nothing
    }

    public void surfaceChanged(SurfaceHolder holder, int format, int w, int h) {
        if (holder.getSurface() == null) {
            return;
        }
        if (mCamera != null) {
            try {
                mCamera.stopPreview();
                setPreviewSize();
                setPictureSize();
                mCamera.setParameters(CameraUtils.parameters);
                mCamera.setPreviewDisplay(holder);
                mCamera.startPreview();
            } catch (Exception e) {
//                Timber.e("Error starting camera preview: %s", e.getMessage());
            }
        }
    }

    private void setPictureSize() {
        int width = Resources.getSystem().getDisplayMetrics().widthPixels;
        int height = Resources.getSystem().getDisplayMetrics().heightPixels;
        int cameraCount =CameraUtils.listSupportPictureSizeCamera.size();
        for (int i = 0; i < cameraCount; i++) {
            Camera.Size size = CameraUtils.listSupportPictureSizeCamera.get(i);
            if (width == size.height && height == size.width) {
            CameraUtils.parameters.setPictureSize(height, width);
           CameraUtils.isExistSize = true;
                break;
            }
        }

        if (!CameraUtils.isExistSize) {
            double proScreen = Math.round(((double) (width / height)) * 10000);
            for (int i = 0; i < cameraCount; i++) {
                Camera.Size size = CameraUtils.listSupportPictureSizeCamera.get(i);
                double proPicture = Math.round(((double) (size.height / size.width)) * 10000);
                if (proScreen == proPicture) {
                    CameraUtils.parameters.setPictureSize(size.height, size.width);
                    CameraUtils.isExistSize = true;
                    break;
                }
            }
        }
    }

    private void setPreviewSize() {
        //Camera.Parameters params = mCamera.getParameters();
        if (CameraUtils.listVideoSize != null) {
            if (CameraUtils.preferredSize.height >= 600 && CameraUtils.preferredSize.width >= 600) {
                CameraUtils.parameters.setPreviewSize(CameraUtils.preferredSize.width,
                       CameraUtils.preferredSize.height);
            } else {
                Camera.Size size = CameraUtils.listVideoSize.get(0);
                if ((size.width - CameraUtils.listVideoSize.get(CameraUtils.listVideoSize.
                        size() - 1).width) >= 0) {
                    CameraUtils.parameters.setPreviewSize(CameraUtils.listVideoSize.get(0).width,
                            CameraUtils.listVideoSize.get(0).height);
                } else {
                    CameraUtils.parameters.setPreviewSize(CameraUtils.listVideoSize
                                    .get(CameraUtils.listVideoSize.size() - 1).width,
                            CameraUtils.listVideoSize.get(CameraUtils.listVideoSize.size() - 1).height);
                }
            }
        } else {
            if ((CameraUtils.listSupportPreviewSizeCamera.get(0).width - CameraUtils.listSupportPreviewSizeCamera.
                    get(CameraUtils.listSupportPreviewSizeCamera.size() - 1).width) >= 0) {
                CameraUtils.parameters.setPreviewSize(CameraUtils.listSupportPreviewSizeCamera.get(0).width,
                        CameraUtils.listSupportPreviewSizeCamera.get(0).height);
            } else {
                CameraUtils.parameters.setPreviewSize(CameraUtils.listSupportPreviewSizeCamera.get(CameraUtils.
                                listSupportPreviewSizeCamera.size() - 1).width,
                        CameraUtils.listSupportPreviewSizeCamera.get(CameraUtils.
                                listSupportPreviewSizeCamera.size() - 1).height);
            }
        }
    }

}
