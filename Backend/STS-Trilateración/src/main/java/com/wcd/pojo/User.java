package com.wcd.pojo;



public class User {

	private String MAC;
	private int RSSI;
	private String SSID;
	private String Username;
	private String apName;
	private String nearNameAP;
	private int nearRSSIAP;


	public int getRSSI() {
		return RSSI;
	}

	public String getMAC() {
		return MAC;
	}

	public void setMAC(String mAC) {
		MAC = mAC;
	}

	public String getSSID() {
		return SSID;
	}

	public void setSSID(String sSID) {
		SSID = sSID;
	}

	public String getUsername() {
		return Username;
	}

	public void setUsername(String username) {
		Username = username;
	}

	public String getApName() {
		return apName;
	}

	public void setApName(String apName) {
		this.apName = apName;
	}

	public String getNearNameAP() {
		return nearNameAP;
	}

	public void setNearNameAP(String nearNameAP) {
		this.nearNameAP = nearNameAP;
	}

	public int getNearRSSIAP() {
		return nearRSSIAP;
	}

	public void setNearRSSIAP(int nearRSSIAP) {
		this.nearRSSIAP = nearRSSIAP;
	}

	public void setRSSI(int rSSI) {
		RSSI = rSSI;
	}

	public User() {
		
	}



}
