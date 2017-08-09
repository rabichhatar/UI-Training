package com.ivod.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 * Servlet implementation class AddAccount
 */
public class AddAccount extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddAccount() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String accountName;
		String billingAccNum;
		String accountID;
		String deviceID;
		String marketName;
		String description; // TBD in FORM
		
		Boolean isCreateNewMkt = false; // Intended market not available ? Creating new market ? 
		
		try
		{
	        //handleRequest(request, response); //DEBUG - Remove
			/*
			String mkt_drop = (String)request.getParameter("mkt_drop");
			
			String mkt_group = (String)request.getParameter("mkt_group");
			String mkt_group_name = (String)request.getParameter("new_market_name");
			String mkt_dma = (String)request.getParameter("Market_DMA");
			String cdl = (String)request.getParameter("CDL");
			String timezone = (String)request.getParameter("timezone");
			*/

			//Retrieve input data from newMarket.jsp (Add Market form) and validate the same 
			
			if (null == (accountName = request.getParameter("Account_Name")))
			{
				throw new IllegalArgumentException("AddAccount: Account Name cannot be null");
			}

			if (null == (billingAccNum = request.getParameter("Billing_Account_Number")))
			{
				throw new IllegalArgumentException("AddAccount: Billing Account Number cannot be null");
			}
						
			if (null == (accountID = request.getParameter("X1_Account_Number")))
			{
				throw new IllegalArgumentException("AddAccount: Account Number cannot be null");
			}
			
			if (null == (deviceID = request.getParameter("X1_Device_Number")))
			{
				throw new IllegalArgumentException("AddAccount: Device Number cannot be null");
			}
			
			if (null == (marketName = request.getParameter("mkt_drop")))
			{
				throw new IllegalArgumentException("AddAccount: Market Name cannot be null");
			}
			
			if (null == (description = request.getParameter("acc_desc")))  // TO BE Added in the form
			{
				throw new IllegalArgumentException("AddAccount: Description cannot be null");
			}
			
			System.out.println("Debug Info:\n"+"Account Name = " + accountName + "\nBilling Account Number = " + billingAccNum + 
				"\nAccount Number = " + accountID + "\nDevice Number = " + deviceID + "\nMarket Name = " + marketName + "\n Description =" + description);

			//////////////////////////////
			try 
			{
				if (marketName.equals("create_new_mkt"))
				{
					isCreateNewMkt = true;
					
					//RequestDispatcher dispatcher = getRequestDispatcher("AddMarket");
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/AddMarket");
					dispatcher.include( request, response );				
					
					if (null == (marketName = request.getParameter("Market_Name")))
					{
						throw new IllegalArgumentException("AddAccount: Market Name cannot be null");
					}
				}			
			}
			catch(Exception e)
			{
				throw e;
			}
			
			//////////////////////////////
			
			URL url;
			HttpURLConnection conn;
			BufferedReader brd;
			String line;
			String result = "";
			
			url = new URL("http://162.150.162.102:9001/ivodquery/insert");
				
			System.out.println("Data Service End Point : " + url.toString());
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			conn.setRequestProperty("Content-Type", "application/json");
			conn.setRequestProperty("charset", "utf-8");
			conn.setRequestProperty("Accept-Charset", "UTF-8");
			 
			JSONObject accountRec = new JSONObject();			 
			JSONArray accountArray = new JSONArray();
			JSONObject accountArrayElementOne = new JSONObject();
			
			accountArrayElementOne.put("id", deviceID);  /* This is an Auto-Increment field at the db level. But ivodquery service doesn't allow
			insertion without primary key value. After discussion with Jack, a temporary fix was agreed upon - to use deviceID itself as the key value for now */
			
			accountArrayElementOne.put("accountName", accountName);
			accountArrayElementOne.put("billingAccount", billingAccNum);
			accountArrayElementOne.put("xAccount", accountID);
			accountArrayElementOne.put("xDevice", deviceID);
			accountArrayElementOne.put("market", marketName);
			accountArrayElementOne.put("description", description);						
			
			accountArray.add(accountArrayElementOne);	     	     	      
			accountRec.put("ivodAccounts", accountArray);										
			
			System.out.println("ivodAccounts Insert Record request : " + accountRec.toJSONString());
			OutputStreamWriter out = new OutputStreamWriter(conn.getOutputStream());
			out.write(accountRec.toJSONString());
			out.flush();
			out.close();
			
			brd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			while ((line = brd.readLine()) != null) {
				result += line;
			}
			
			System.out.println("Response message = " + result + "\n");
			
			//String statusCode = conn.getHeaderField("Status-Code");
			//String date = conn.getHeaderField("Date");
			int statusCode = conn.getResponseCode();

			System.out.println("Status code = " + statusCode + "\n");
		
			brd.close();
			conn.disconnect();
		
			HttpSession session = request.getSession();
			session.setAttribute("acc_name", accountName);
			session.setAttribute("bill_acc_no", billingAccNum);
			session.setAttribute("x1_acc_no", accountID);
			session.setAttribute("x1_dvs_no", deviceID);
			session.setAttribute("acc_desc", description);
			
			if (true == isCreateNewMkt)
			{
				session.setAttribute("mkt_drop", "create_new_mkt");
			}
			else
			{
				session.setAttribute("mkt_drop", marketName);
			}
				
			if(statusCode == 200)
			{
				session.setAttribute("queryRsp", "success");
			}
			else
			{
				session.setAttribute("queryRsp", "fail");
			}		
			
			response.sendRedirect("newaccount.jsp");
		}
		catch(IllegalArgumentException e)
		{
			System.out.println(e.getMessage());
			HttpSession session = request.getSession();
			session.setAttribute("queryRsp", "fail");
		}
		catch (IOException e) 
		{
			e.printStackTrace();
			HttpSession session = request.getSession();
			session.setAttribute("queryRsp", "invalid");
			response.sendRedirect("newaccount.jsp");
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			HttpSession session = request.getSession();
			session.setAttribute("queryRsp", "invalid");
			response.sendRedirect("newaccount.jsp");
		}		
	}
	
	public void handleRequest(HttpServletRequest req, HttpServletResponse res) throws IOException 
	{
		PrintWriter out = res.getWriter();
		res.setContentType("text/plain");
		Enumeration<String> parameterNames = req.getParameterNames();

		while (parameterNames.hasMoreElements()) 
		{
			String paramName = parameterNames.nextElement();
			out.write(paramName);
			out.write("\n");
			String[] paramValues = req.getParameterValues(paramName);

			for (int i = 0; i < paramValues.length; i++) 
			{
				String paramValue = paramValues[i];
				out.write("\t" + paramValue);
				out.write("\n");
			}
		}
		out.close();
	}
}