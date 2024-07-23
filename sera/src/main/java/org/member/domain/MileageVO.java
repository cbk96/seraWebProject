package org.member.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class MileageVO {
	
	private String mileage_id;
	private int accumulate_price;
	private String order_id;
	private String user_id;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date reg_date;
	
	public String getMileage_id() {
		return mileage_id;
	}
	public void setMileage_id(String mileage_id) {
		this.mileage_id = mileage_id;
	}
	public int getAccumulate_price() {
		return accumulate_price;
	}
	public void setAccumulate_price(int accumulate_price) {
		this.accumulate_price = accumulate_price;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	
	

}
