package com.bitel.bss.viettelpos.v3.bitel_ventas.fingerprintscanner;


import java.util.ArrayList;

public class CacheData {

	private String 	versionclient;
	private String 	version;
	private String 	stockOrderCode;
	private String 	downloadLink;
	private int lastLeftBestFinger = 0;
	private int lastRightBestFinger = 0;
	boolean isByPassFingerPrint = false;

	private static CacheData 				instanse 					= null;
//	private ArrayList<ViewInfoOjectMerge> 	lisInfoOjectMerges 			= new ArrayList<>();
//	private ArrayList<StockOrderDetail> 	lisStockOrderDetails 		= new ArrayList<>();
//	private ArrayList<GetOrderObjectDetail> lisGetOrderObjectDetails 	= new ArrayList<>();
//	private GetOrderObject 					orderObject 				= new GetOrderObject();

	public boolean isByPassFingerPrint() {
		return isByPassFingerPrint;
	}

	public void setByPassFingerPrint(boolean byPassFingerPrint) {
		isByPassFingerPrint = byPassFingerPrint;
	}

	public String getVersionclient() {
		return versionclient;
	}

	public void setVersionclient(String versionclient) {
		this.versionclient = versionclient;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

//	public GetOrderObject getOrderObject() {
//		return orderObject;
//	}
//
//	public void setOrderObject(GetOrderObject orderObject) {
//		this.orderObject = orderObject;
//	}
//
//	public ArrayList<GetOrderObjectDetail> getLisGetOrderObjectDetails() {
//		return lisGetOrderObjectDetails;
//	}
//
//	public void setLisGetOrderObjectDetails(
//			ArrayList<GetOrderObjectDetail> lisGetOrderObjectDetails) {
//		this.lisGetOrderObjectDetails = lisGetOrderObjectDetails;
//	}

	public String getStockOrderCode() {
		return stockOrderCode;
	}

	public void setStockOrderCode(String stockOrderCode) {
		this.stockOrderCode = stockOrderCode;
	}

//	public ArrayList<StockOrderDetail> getLisStockOrderDetails() {
//		return lisStockOrderDetails;
//	}
//
//	public void setLisStockOrderDetails(
//			ArrayList<StockOrderDetail> lisStockOrderDetails) {
//		this.lisStockOrderDetails = lisStockOrderDetails;
//	}

	public static CacheData getInstanse() {
		if(instanse == null){
			instanse = new CacheData();
		}
		return instanse;
	}

//	public void setLisInfoOjectMerges(
//			ArrayList<ViewInfoOjectMerge> lisInfoOjectMerges) {
//		this.lisInfoOjectMerges = lisInfoOjectMerges;
//	}

	public String getDownloadLink() {
		return downloadLink;
	}

	public void setDownloadLink(String downloadLink) {
		this.downloadLink = downloadLink;
	}

	public int getLastLeftBestFinger() {
		return lastLeftBestFinger;
	}

	public void setLastLeftBestFinger(int lastLeftBestFinger) {
		this.lastLeftBestFinger = lastLeftBestFinger;
	}

	public int getLastRightBestFinger() {
		return lastRightBestFinger;
	}

	public void setLastRightBestFinger(int lastRightBestFinger) {
		this.lastRightBestFinger = lastRightBestFinger;
	}
}
