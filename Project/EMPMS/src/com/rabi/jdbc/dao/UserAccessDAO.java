package com.rabi.jdbc.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;

import com.rabi.model.UserModel;

public class UserAccessDAO {
	
	private UserModel user;
	
	private String driverClassName;
	private String driverUrl;
	private String userName;
	private String passWord;
	
	public UserModel validateUser(String username,String password){
		
		Connection con = null;
		try {
			Class.forName(driverClassName);
			
			con = DriverManager.getConnection(driverUrl, userName, passWord);
			
			String sql = new String("select * from login where username='"+username+"' and pass='"+password+"'");
			PreparedStatement st = con.prepareStatement(sql);
			
			ResultSet set = st.executeQuery();
			while (set.next()) {
				user.setHasAccess(true);
				user.setFname(set.getString(4));
				user.setLname(set.getString(5));
				user.setGender("male");
				break;
			}
			
			set.close();
			st.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(con!=null)
					con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return user;
	}

	public UserModel getUser() {
		return user;
	}

	public void setUser(UserModel user) {
		this.user = user;
	}

	public String getDriverClassName() {
		return driverClassName;
	}

	public void setDriverClassName(String driverClassName) {
		this.driverClassName = driverClassName;
	}

	public String getDriverUrl() {
		return driverUrl;
	}

	public void setDriverUrl(String driverUrl) {
		this.driverUrl = driverUrl;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassWord() {
		return passWord;
	}

	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	
}
