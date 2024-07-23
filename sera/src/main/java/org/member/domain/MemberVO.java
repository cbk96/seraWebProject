package org.member.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class MemberVO {

	private String user_id;
	private String user_pwd;
	private String member_type;
	private String name;
	private String nick_name;
	private String grade;
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date birth;
	private String gender;
	private String skin_type;
	private String brand;
	private String tel;
	private String email;
	private String post_code;
	private String address;
	private String access_route;
	private String black_list;
	private String black_list_reson;
	private String active;
	private String active_conver_reson;
	private int mileage;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date reg_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date up_date;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pwd() {
		return user_pwd;
	}
	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}
	public String getMember_type() {
		return member_type;
	}
	public void setMember_type(String member_type) {
		this.member_type = member_type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNick_name() {
		return nick_name;
	}
	public void setNick_name(String nick_name) {
		this.nick_name = nick_name;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getSkin_type() {
		return skin_type;
	}
	public void setSkin_type(String skin_type) {
		this.skin_type = skin_type;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	public String getAccess_route() {
		return access_route;
	}
	public void setAccess_route(String access_route) {
		this.access_route = access_route;
	}
	public String getBlack_list() {
		return black_list;
	}
	public void setBlack_list(String black_list) {
		this.black_list = black_list;
	}
	public String getBlack_list_reson() {
		return black_list_reson;
	}
	public void setBlack_list_reson(String black_list_reson) {
		this.black_list_reson = black_list_reson;
	}
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}
	public String getActive_conver_reson() {
		return active_conver_reson;
	}
	public void setActive_conver_reson(String active_conver_reson) {
		this.active_conver_reson = active_conver_reson;
	}
	public int getMileage() {
		return mileage;
	}
	public void setMileage(int mileage) {
		this.mileage = mileage;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public Date getUp_date() {
		return up_date;
	}
	public void setUp_date(Date up_date) {
		this.up_date = up_date;
	}
	
	
}
