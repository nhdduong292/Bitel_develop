package com.bitel.bss.viettelpos.v3.bitel_ventas.camera.camera;

import android.app.Activity;
import android.content.Intent;

import androidx.fragment.app.Fragment;

import java.lang.ref.WeakReference;


public class IDCardCamera {

    public final static int    TYPE_IDCARD_FRONT     = 1;
    public final static int    REQUEST_SCAN_IMAGE     = 101;
    public final static int    TYPE_IDCARD_BACK      = 2;
    public final static int    RESULT_CODE           = 0X11;
    public final static int    PERMISSION_CODE_FIRST = 0x12;
    public final static String TAKE_TYPE             = "take_type";
    public final static String IMAGE_PATH            = "image_path";

    private final WeakReference<Activity> mActivity;
    private final WeakReference<Fragment> mFragment;

    public static IDCardCamera create(Activity activity) {
        return new IDCardCamera(activity);
    }

    public static IDCardCamera create(Fragment fragment) {
        return new IDCardCamera(fragment);
    }

    private IDCardCamera(Activity activity) {
        this(activity, (Fragment) null);
    }

    private IDCardCamera(Fragment fragment) {
        this(fragment.getActivity(), fragment);
    }

    private IDCardCamera(Activity activity, Fragment fragment) {
        this.mActivity = new WeakReference(activity);
        this.mFragment = new WeakReference(fragment);
    }


    public void openCamera(int IDCardDirection) {
        Activity activity = this.mActivity.get();
        Fragment fragment = this.mFragment.get();
        Intent intent = new Intent(activity, CameraActivity.class);
        intent.putExtra(TAKE_TYPE, IDCardDirection);
        if (fragment != null) {
            fragment.startActivityForResult(intent, IDCardDirection);
        } else {
            activity.startActivityForResult(intent, IDCardDirection);
        }
    }

    public static String getImagePath(Intent data) {
        if (data != null) {
            return data.getStringExtra(IMAGE_PATH);
        }
        return "";
    }
}

