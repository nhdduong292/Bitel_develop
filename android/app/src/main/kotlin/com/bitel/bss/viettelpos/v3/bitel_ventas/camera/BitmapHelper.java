package com.bitel.bss.viettelpos.v3.bitel_ventas.camera;


import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.media.ExifInterface;
import android.net.Uri;
import android.os.Build;
import android.util.Base64;


import com.bitel.bss.viettelpos.v3.bitel_ventas.camera.utils.DeviceUtils;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

/*
 * Created by Bardur.thomsen on 15/05/2017.
 *
 * Class to help with bitmap manipulation
 */

public class BitmapHelper {


    public static Bitmap scalePic(Bitmap bitmap, int width , int height) {
        int targetW = width;
        int targetH = height;

        int photoW = bitmap.getWidth();
        int photoH = bitmap.getHeight();

        float widthScale = photoW/(float)targetW;
        float heightScale = photoH/ (float)targetH;

        // Determine how much to scale down the image
        float scaleFactor = Math.min(widthScale, heightScale);
        int newWidth = 0;
        int newHeight = 0;


        if(scaleFactor > 1) {
            newWidth = (int)(photoW / scaleFactor);
            newHeight = (int)(photoH / scaleFactor);
        }else {
            newWidth = (int)(photoW * scaleFactor);
            newHeight = (int)(photoH * scaleFactor);
        }

        return Bitmap.createScaledBitmap(bitmap,newWidth,newHeight,true);
    }

    private static int exifToDegrees(int exifOrientation) {
        if (exifOrientation == ExifInterface.ORIENTATION_ROTATE_90) { return 90; }
        else if (exifOrientation == ExifInterface.ORIENTATION_ROTATE_180) {  return 180; }
        else if (exifOrientation == ExifInterface.ORIENTATION_ROTATE_270) {  return 270; }
        return 0;
    }

    public static Bitmap decodeSampledBitmapFromResource(String path,
                                                         int reqWidth, int reqHeight) {

        // First decode with inJustDecodeBounds=true to check dimensions
        final BitmapFactory.Options options = new BitmapFactory.Options();
        options.inJustDecodeBounds = true;
        BitmapFactory.decodeFile(path, options);

        // get width and height of image;
        int photoW = options.outWidth;
        int photoH = options.outHeight;

        // get scalars for width and height
        float widthScale = photoW/(float)reqHeight;
        float heightScale = photoH/ (float)reqHeight;

        // Determine how much to scale down the image
        float scaleFactor = Math.min(widthScale, heightScale);

        int newWidth = photoW;
        int newHeight = photoH;

        if(scaleFactor >= 1) {
            newWidth = (int)(photoW / scaleFactor);
            newHeight = (int)(photoH / scaleFactor);
        }

        // Decode bitmap with inSampleSize set
        options.inJustDecodeBounds = false;

        // Calculate inSampleSize
        int inSampleSize = calculateInSampleSize(options, reqWidth, reqHeight);

        options.inSampleSize = inSampleSize;
        options.inScaled = false;
        options.inPreferredConfig = Bitmap.Config.ARGB_8888;
        options.inDither = false;

        // load bitmap into memory
        Bitmap bitmap = BitmapFactory.decodeFile(path, options);

       // get data to check rotation of image
        ExifInterface exif = null;
        try {
            exif = new ExifInterface(path);
        } catch (IOException e) {
            e.printStackTrace();
        }

        // try to rotate the image
        if(exif != null){

            int rotation = exif.getAttributeInt(ExifInterface.TAG_ORIENTATION, ExifInterface.ORIENTATION_NORMAL);
            int rotationInDegrees = exifToDegrees(rotation);

            Matrix matrix = new Matrix();

            if (rotation != 0f) {
                matrix.preRotate(rotationInDegrees);
            }

            bitmap = Bitmap.createBitmap(bitmap, 0, 0, newWidth, newHeight, matrix, false);
        }

        return bitmap;
    }

    public static int calculateInSampleSize(
            BitmapFactory.Options options, int reqWidth, int reqHeight) {
        // Raw height and width of image
        final int height = options.outHeight;
        final int width = options.outWidth;
        int inSampleSize = 1;

        if (height > reqHeight || width > reqWidth) {

            final int halfHeight = height / 2;
            final int halfWidth = width / 2;

            // Calculate the largest inSampleSize value that is a power of 2 and keeps both
            // height and width larger than the requested height and width.
            while ((halfHeight / inSampleSize) >= reqHeight
                    && (halfWidth / inSampleSize) >= reqWidth) {
                inSampleSize *= 2;
            }
        }

        return inSampleSize;
    }

    public static String convertBitmapToByte64(Bitmap bitmap){

        ByteArrayOutputStream byteArrayBitmapStream = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.JPEG, 97, byteArrayBitmapStream);
        byte[] bytes = byteArrayBitmapStream.toByteArray();



        // encode to base 64
        String imageBase64 = Base64.encodeToString(bytes, Base64.NO_WRAP);

        return imageBase64;
    }

    public static Bitmap decodeBitmapFromFile(String path,
                                              int reqWidth, int reqHeight) {

        // First decode with inJustDecodeBounds=true to check dimensions
        final BitmapFactory.Options options = new BitmapFactory.Options();
        options.inJustDecodeBounds = true;
        BitmapFactory.decodeFile(path, options);

        // Calculate inSampleSize
        options.inSampleSize = calculateInSampleSize(options, reqWidth, reqHeight);

        // Decode bitmap with inSampleSize set
        options.inJustDecodeBounds = false;
        return BitmapFactory.decodeFile(path, options);
    }

    public static Bitmap decodeBitmapFromFile(Context context, String path,
                                              int reqWidth, int reqHeight) {
        Bitmap bitmap = decodeBitmapFromFile(path, reqWidth, reqHeight);
        Uri uri = Uri.fromFile(new File(path));
        try {
            return rotateImageIfRequired(context, bitmap, uri);
        } catch (Exception e) {
            return null;
        }
    }

    private static Bitmap rotateImageIfRequired(Context context, Bitmap img, Uri selectedImage) throws IOException {

        InputStream input = context.getContentResolver().openInputStream(selectedImage);
        ExifInterface ei;
        if (Build.VERSION.SDK_INT > 23)
            ei = new ExifInterface(input);
        else
            ei = new ExifInterface(selectedImage.getPath());

        int orientation = ei.getAttributeInt(ExifInterface.TAG_ORIENTATION, ExifInterface.ORIENTATION_NORMAL);

        switch (orientation) {
            case ExifInterface.ORIENTATION_ROTATE_90:
                return rotateImage(img, 90);
            case ExifInterface.ORIENTATION_ROTATE_180:
                return rotateImage(img, 180);
            case ExifInterface.ORIENTATION_ROTATE_270:
                return rotateImage(img, 270);
            default:
                return img;
        }
    }

    private static Bitmap rotateImage(Bitmap img, int degree) {
        Matrix matrix = new Matrix();
        matrix.postRotate(degree);
        Bitmap rotatedImg = Bitmap.createBitmap(img, 0, 0, img.getWidth(), img.getHeight(), matrix, true);
        img.recycle();
        return rotatedImg;
    }

    public static File resizeImageFile(Context context, File file, int width, int height){
        try {
            Bitmap bitmapDecode = BitmapHelper.decodeBitmapFromFile(context, file.getPath(), width, height);
            File result =  DeviceUtils.createImageFile(context);
            FileOutputStream out = new FileOutputStream(result);
            bitmapDecode.compress(Bitmap.CompressFormat.PNG, 100, out);
            out.flush();
            out.close();
            bitmapDecode.recycle();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
