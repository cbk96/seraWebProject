package org.goods.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class GoodsViewVO {
	
	private String goods_id;
	private String user_id;
	@DateTimeFormat(pattern="yyyy년 MM월 dd일")
	private Date view_date;
	
	public String getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(String goods_id) {
		this.goods_id = goods_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Date getView_date() {
		return view_date;
	}
	public void setView_date(Date view_date) {
		this.view_date = view_date;
	}
	

}
