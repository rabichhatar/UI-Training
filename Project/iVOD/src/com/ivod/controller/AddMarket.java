/*
 * File name	: AddMarket.java
 * Author		: Ranjith Reddy Deena Bandulu (rreddy008c)
 * 
 * Description	: This servlet processes the doPost messages received from the
 *                newmarket.jsp form and creates a record in the ivodMarkets table.
 *                The table entry is created by invoking iVodQuery webservice 
 *                (to be replaced by Merlin webservice in production)      
 */

package com.ivod.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.ws.http.HTTPException;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 * Servlet implementation class AddMarket
 */
public class AddMarket extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddMarket() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
	    out.println ("Success"); 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String marketName;
		String marketGroup;
		String marketDma;
		String cdlList;
		String timezone;
		String description;
		
		Boolean isCreateNewMktGrp = false; // Creating a new Market Group ?
		
		try
		{
			//Retrieve input data from newmarket.jsp (Add Market form) and validate the same 			
			if (null == (marketName = request.getParameter("Market_Name")))
			{
				throw new IllegalArgumentException("AddMarket: Market Name cannot be null");
			}

			if (null == (marketGroup = request.getParameter("mkt_group")))
			{
				throw new IllegalArgumentException("AddMarket: Market Group cannot be null");
			}
			
			if (null == (marketDma = request.getParameter("Market_DMA")))
			{
				throw new IllegalArgumentException("AddMarket: DMA cannot be null");
			}
			
			if (null == (cdlList = request.getParameter("CDL")))
			{
				throw new IllegalArgumentException("AddMarket: CDL List cannot be null");
			}
			
			if (null == (timezone = request.getParameter("timezone")))
			{
				throw new IllegalArgumentException("AddMarket: TimeZone cannot be null");
			}
			
			if (null == (description = request.getParameter("mkt_desc")))
			{
				//throw new IllegalArgumentException("AddMarket: Description cannot be null");
				description = " "; // DEBUG-- Remove this line
			}
			
			if (marketGroup.equals("create_new"))
			{
				isCreateNewMktGrp = true;

				if (null == (marketGroup = request.getParameter("new_market_name")))
				{
					throw new IllegalArgumentException("AddMarket: Market Group cannot be null");
				}								
			}
			
			System.out.println("Debug Info:\n"+"Market Name = " + marketName + "\nMarket Group = " + marketGroup + 
				"\nMarket DMA = " + marketDma + "\nCDL List = " + cdlList +"\nTime Zone = " + timezone + "\nDescription = " + description);

			//////////////////////////////
			
			URL url;
			HttpURLConnection conn;
			BufferedReader brd;
			String line;
			String result = "";
			
			url = new URL("http://162.150.162.102:9001/ivodquery/insert");
			//url = new URL("http://stackoverflow.com");			
				
			System.out.println("Data Service End Point : " + url.toString());
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			conn.setRequestProperty("Content-Type", "application/json");
			conn.setRequestProperty("charset", "utf-8");
			conn.setRequestProperty("Accept-Charset", "UTF-8");
			 
			JSONObject marketRec = new JSONObject();			 
			JSONArray marketArray = new JSONArray();
			JSONObject marketArrayElementOne = new JSONObject();
			 
			marketArrayElementOne.put("market", marketName);
			marketArrayElementOne.put("marketGroup", marketGroup);
			marketArrayElementOne.put("marketDma", marketDma);
			marketArrayElementOne.put("cdlList", cdlList);
			marketArrayElementOne.put("timezone", timezone);
			marketArrayElementOne.put("description", description);
			 
			marketArray.add(marketArrayElementOne);	     	     	      
			marketRec.put("ivodMarkets", marketArray);	
			
			     
			System.out.println("ivodMarkets Insert Record request : " + marketRec.toString());
			OutputStreamWriter out = new OutputStreamWriter(conn.getOutputStream());
			out.write(marketRec.toJSONString());
			out.flush();
			out.close();
			
			brd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			while ((line = brd.readLine()) != null) {
				result += line;
			}
			
			System.out.println("Response message = " + result + "\n");
			brd.close();
			
			int statusCode = conn.getResponseCode();
			System.out.println("Status Code = " + statusCode + "\n");

			HttpSession session = request.getSession();
			session.setAttribute("mkt_name", marketName);
			
			if (true == isCreateNewMktGrp)
			{
				session.setAttribute("mkt_group", "create_new");
				session.setAttribute("mkt_group_name", marketGroup);	
			}
			else
			{
				session.setAttribute("mkt_group", marketGroup);
			}
			
			session.setAttribute("mkt_dma", marketDma);
			session.setAttribute("cdl", cdlList);
			session.setAttribute("timezone", timezone);
			session.setAttribute("mkt_desc", description);
			
			if(statusCode == 200)
			{
				session.setAttribute("result", "success");
			}
			else
			{
				session.setAttribute("result", "fail");
			}
			
			conn.disconnect();
			
			response.sendRedirect("newmarket.jsp");

			
			//////////////////////////////
			
		}
		catch(IllegalArgumentException e)
		{
			System.out.println(e.getMessage());
			HttpSession session = request.getSession();
			session.setAttribute("result", "fail");
		}
		catch(HTTPException e)
		{
			System.out.println("Inside HTTP exception");
		 	System.out.println("Status Code = " + e.getStatusCode());
			HttpSession session = request.getSession();
			session.setAttribute("result", "fail");
			e.printStackTrace();
		}
		catch (IOException e) 
		{
			e.printStackTrace();
			HttpSession session = request.getSession();
			session.setAttribute("result", "invalid");
			response.sendRedirect("newmarket.jsp");
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			HttpSession session = request.getSession();
			session.setAttribute("result", "invalid");
			response.sendRedirect("newmarket.jsp");
		}		
	}

}
