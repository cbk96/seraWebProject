package org.goods.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class OrderVO {
	
	private String order_number;
	private String goods_id;
	private String goods_image;
	private String goods_name;
	private String category_id;
	private String user_id;
	private String name;
	private String order_status;
	private String member_order;
	private int sell_price;
	private int all_price;
	private int discount_price;
	private int quantity;
	private int shipping_fee;
	private String post_code;
	private String address;
	private String payment;
	private String customer_req;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date reguest_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date order_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date cancel_date;

	public String getOrder_number() {
		return order_number;
	}
	public void setOrder_number(String order_number) {
		this.order_number = order_number;
	}
	public String getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(String goods_id) {
		this.goods_id = goods_id;
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
	public String getCategory_id() {
		return category_id;
	}
	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getOrder_status() {
		return order_status;
	}
	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}
	public String getMember_order() {
		return member_order;
	}
	public void setMember_order(String member_order) {
		this.member_order = member_order;
	}
	public int getSell_price() {
		return sell_price;
	}
	public void setSell_price(int sell_price) {
		this.sell_price = sell_price;
	}
	public int getAll_price() {
		return all_price;
	}
	public void setAll_price(int all_price) {
		this.all_price = all_price;
	}
	public int getDiscount_price() {
		return discount_price;
	}
	public void setDiscount_price(int discount_price) {
		this.discount_price = discount_price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getShipping_fee() {
		return shipping_fee;
	}
	public void setShipping_fee(int shipping_fee) {
		this.shipping_fee = shipping_fee;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public String getPost_code() {
		return post_code;
	}
	public void setPost_code(String post_code) {
		this.post_code = post_code;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCustomer_req() {
		return customer_req;
	}
	public void setCustomer_req(String customer_req) {
		this.customer_req = customer_req;
	}
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	public Date getCancel_date() {
		return cancel_date;
	}
	public void setCancel_date(Date cancel_date) {
		this.cancel_date = cancel_date;
	}
	public Date getReguest_date() {
		return reguest_date;
	}
	public void setReguest_date(Date reguest_date) {
		this.reguest_date = reguest_date;
	}
	
	
}
