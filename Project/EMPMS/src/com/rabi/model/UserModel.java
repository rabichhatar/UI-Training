package com.rabi.model;

public class UserModel {
	
	private String fname;
	private String lname;
	private String gender;
	private Boolean hasAccess;
	
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public Boolean getHasAccess() {
		return hasAccess;
	}
	public void setHasAccess(Boolean hasAccess) {
		this.hasAccess = hasAccess;
	}
}