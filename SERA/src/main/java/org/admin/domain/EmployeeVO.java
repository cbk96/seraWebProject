package org.admin.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class EmployeeVO {
	
	private String emp_id;
	private String emp_pwd;
	private String member_type;
	private String emp_name;
	private String emp_nick_name;
	private String emp_id_photo;
	private String emp_gender;
	private String emp_tel;
	private String emp_email;
	private String depart;
	private int level;
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date join_day;
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date last_work_day;
	private String admin_approval;
	
	public String getEmp_id() {
		return emp_id;
	}
	public void setEmp_id(String emp_id) {
		this.emp_id = emp_id;
	}
	public String getEmp_pwd() {
		return emp_pwd;
	}
	public void setEmp_pwd(String emp_pwd) {
		this.emp_pwd = emp_pwd;
	}
	public String getMember_type() {
		return member_type;
	}
	public void setMember_type(String member_type) {
		this.member_type = member_type;
	}
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public String getEmp_nick_name() {
		return emp_nick_name;
	}
	public void setEmp_nick_name(String emp_nick_name) {
		this.emp_nick_name = emp_nick_name;
	}
	public String getEmp_id_photo() {
		return emp_id_photo;
	}
	public void setEmp_id_photo(String emp_id_photo) {
		this.emp_id_photo = emp_id_photo;
	}
	public String getEmp_gender() {
		return emp_gender;
	}
	public void setEmp_gender(String emp_gender) {
		this.emp_gender = emp_gender;
	}
	public String getEmp_tel() {
		return emp_tel;
	}
	public void setEmp_tel(String emp_tel) {
		this.emp_tel = emp_tel;
	}
	public String getEmp_email() {
		return emp_email;
	}
	public void setEmp_email(String emp_email) {
		this.emp_email = emp_email;
	}
	public String getDepart() {
		return depart;
	}
	public void setDepart(String depart) {
		this.depart = depart;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public Date getJoin_day() {
		return join_day;
	}
	public void setJoin_day(Date join_day) {
		this.join_day = join_day;
	}
	public Date getLast_work_day() {
		return last_work_day;
	}
	public void setLast_work_day(Date last_work_day) {
		this.last_work_day = last_work_day;
	}
	public String getAdmin_approval() {
		return admin_approval;
	}
	public void setAdmin_approval(String admin_approval) {
		this.admin_approval = admin_approval;
	}
	
	
}
