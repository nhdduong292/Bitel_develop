package com.bitel.bss.viettelpos.v3.bitel_ventas;

import java.io.Serializable;

public class FingerModel implements Serializable {
    String pathImage;
    String imageBase64;
    String pk;

    public FingerModel(String pathImage, String imageBase64) {
        this.pathImage = pathImage;
        this.imageBase64 = imageBase64;
    }

    public FingerModel(String pathImage, String imageBase64, String pk) {
        this.pathImage = pathImage;
        this.imageBase64 = imageBase64;
        this.pk = pk;
    }

    @Override
    public String toString() {
        return "{" +
                "\"pathImage\":" + "\"" + pathImage + "\"" +
                ", \"imageBase64\":" + "\"" + imageBase64 + "\"" +
                ", \"pk\":" + "\"" + pk + "\""
                + '}';
    }
}
