package com.wcd.pojo;

public class TrilaterationRequest {
	private double coordXAp1;
	private double coordXAp2;
	private double coordYAp1;
	private double coordYAp2;
    private int rssi0; // = -14.0;// Valor promedio de RSSI a una distancia d0/ d0=1
	private double n;// = 4.0; // factor de atenuación
    private int rssi1;// = RSSI CLIENTE;
    private int rssi2;// = NEARBY RSSI
	public double getCoordXAp1() {
		return coordXAp1;
	}
	public void setCoordXAp1(double coordXAp1) {
		this.coordXAp1 = coordXAp1;
	}
	public double getCoordXAp2() {
		return coordXAp2;
	}
	public void setCoordXAp2(double coordXAp2) {
		this.coordXAp2 = coordXAp2;
	}
	public double getCoordYAp1() {
		return coordYAp1;
	}
	public void setCoordYAp1(double coordYAp1) {
		this.coordYAp1 = coordYAp1;
	}
	public double getCoordYAp2() {
		return coordYAp2;
	}
	public void setCoordYAp2(double coordYAp2) {
		this.coordYAp2 = coordYAp2;
	}
	public int getRssi0() {
		return rssi0;
	}
	public void setRssi0(int rssi0) {
		this.rssi0 = rssi0;
	}
	public double getN() {
		return n;
	}
	public void setN(double n) {
		this.n = n;
	}
	public int getRssi1() {
		return rssi1;
	}
	public void setRssi1(int rssi1) {
		this.rssi1 = rssi1;
	}
	public int getRssi2() {
		return rssi2;
	}
	public void setRssi2(int rssi2) {
		this.rssi2 = rssi2;
	}
	
    
	

	// Modelo matemático de Canal PATH LOSS
    // RSSI=-10nlog(d/d0)+sRSSI0
		
	
}
