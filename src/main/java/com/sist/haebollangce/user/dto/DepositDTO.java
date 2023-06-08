package com.sist.haebollangce.user.dto;

import org.springframework.boot.autoconfigure.domain.EntityScan;


public class DepositDTO {
	
	String purchase_code;
	String fk_userid;
	String purchase_date;
	String purchase_price;
	String purchase_status;
	
	//////////////////////////////////////
	
	public String getPurchase_code() {
		return purchase_code;
	}
	public void setPurchase_code(String purchase_code) {
		this.purchase_code = purchase_code;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public String getPurchase_date() {
		return purchase_date;
	}
	public void setPurchase_date(String purchase_date) {
		this.purchase_date = purchase_date;
	}
	public String getPurchase_price() {
		return purchase_price;
	}
	public void setPurchase_price(String purchase_price) {
		this.purchase_price = purchase_price;
	}
	public String getPurchase_status() {
		return purchase_status;
	}
	public void setPurchase_status(String purchase_status) {
		this.purchase_status = purchase_status;
	}
	
	
}
