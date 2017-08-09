/**
 * 
 */
package com.rabi.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rabi.jdbc.dao.UserAccessDAO;
import com.rabi.model.UserModel;

/**
 * @author Mr.Rabi
 *
 */
@Controller
public class EntryController {
	
	@Autowired
	private UserAccessDAO userDao;
	
	@RequestMapping("/entry")
	public ModelAndView enter(HttpServletRequest request){
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		UserModel user = userDao.validateUser(username, password);
		
		if(user.getHasAccess()){			
			return new ModelAndView("entry","user",user);
		}else{
			return new ModelAndView("login"); 
		}
	}
}