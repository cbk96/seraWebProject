package org.goods.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class GoodsVO {
	
	private String goods_id;
	private String emp_id;
	private String depart;
	private String goods_image;
	private String goods_name;
	private String goods_search_key;
	private String category_id;
	private String skin_type;
	private String main_type;
	private String sub_type;
	private int purchase_price;
	private int sell_price;
	private int amount;
	private int shipping_fee;
	private int view_cnt;
	private String sale_active;
	private String goods_content;
	@DateTimeFormat(pattern="yyyy년 MM월 dd일")
	private Date goods_reg_date;
	@DateTimeFormat(pattern="yyyy년 MM월 dd일")
	private Date goods_up_date;
	
	public String getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(String goods_id) {
		this.goods_id = goods_id;
	}
	public String getEmp_id() {
		return emp_id;
	}
	public void setEmp_id(String emp_id) {
		this.emp_id = emp_id;
	}
	public String getDepart() {
		return depart;
	}
	public void setDepart(String depart) {
		this.depart = depart;
	}
	public String getGoods_image() {
		return goods_image;
	}
	public void setGoods_image(String goods_image) {
		this.goods_image = goods_image;
	}
	public String getGoods_name() {
		return goods_name;
	}
	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}
	public String getGoods_search_key() {
		return goods_search_key;
	}
	public void setGoods_search_key(String goods_search_key) {
		this.goods_search_key = goods_search_key;
	}
	public String getSkin_type() {
		return skin_type;
	}
	public void setSkin_type(String skin_type) {
		this.skin_type = skin_type;
	}
	public String getCategory_id() {
		return category_id;
	}
	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}
	public String getMain_type() {
		return main_type;
	}
	public void setMain_type(String main_type) {
		this.main_type = main_type;
	}
	public String getSub_type() {
		return sub_type;
	}
	public void setSub_type(String sub_type) {
		this.sub_type = sub_type;
	}
	public int getPurchase_price() {
		return purchase_price;
	}
	public void setPurchase_price(int purchase_price) {
		this.purchase_price = purchase_price;
	}
	public int getSell_price() {
		return sell_price;
	}
	public void setSell_price(int sell_price) {
		this.sell_price = sell_price;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getShipping_fee() {
		return shipping_fee;
	}
	public void setShipping_fee(int shipping_fee) {
		this.shipping_fee = shipping_fee;
	}
	public int getView_cnt() {
		return view_cnt;
	}
	public void setView_cnt(int view_cnt) {
		this.view_cnt = view_cnt;
	}
	public String getSale_active() {
		return sale_active;
	}
	public void setSale_active(String sale_active) {
		this.sale_active = sale_active;
	}
	public String getGoods_content() {
		return goods_content;
	}
	public void setGoods_content(String goods_content) {
		this.goods_content = goods_content;
	}
	public Date getGoods_reg_date() {
		return goods_reg_date;
	}
	public void setGoods_reg_date(Date goods_reg_date) {
		this.goods_reg_date = goods_reg_date;
	}
	public Date getGoods_up_date() {
		return goods_up_date;
	}
	public void setGoods_up_date(Date goods_up_date) {
		this.goods_up_date = goods_up_date;
	}
	
	
	

}
