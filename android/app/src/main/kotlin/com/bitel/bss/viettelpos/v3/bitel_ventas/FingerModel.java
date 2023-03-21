package com.bitel.bss.viettelpos.v3.bitel_ventas;

public class FingerModel {
    String pathImage;
    String imageBase64;

    public FingerModel(String pathImage, String imageBase64) {
        this.pathImage = pathImage;
        this.imageBase64 = imageBase64;
    }

    @Override
    public String toString() {
        return "{" +
                "\"pathImage\":" + "\"" + pathImage + "\"" +
                ", \"imageBase64\":" + "\"" + imageBase64 + "\"" + '}';
    }
}
