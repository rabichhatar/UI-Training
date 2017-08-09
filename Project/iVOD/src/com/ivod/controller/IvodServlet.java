package com.ivod.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Iterator;
import java.util.TimeZone;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;


public class IvodServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	  PrintWriter out = resp.getWriter();
	  out.println ("Success"); 
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		URL url, url1;
		HttpURLConnection conn,conn1, connMarkets;
		BufferedReader rd,brd1;
		String line;
		String result = "";
		String result1 = "";
		String xAccount = "";
		String xDevice = "";
		
		try {
			String seriesID = req.getParameter("SeriesID"); 
			//String accountId = req.getParameter("AccountId");  
			//String deviceId = req.getParameter("DeviceId"); 
			String newRepeat = req.getParameter("NewRepeat");
			//String mkt_list = req.getParameter("mkt_drop");
					
			System.out.println("NewRepeat = " + newRepeat);
			
			String title = null;
			//System.out.println ("AccountId = " + accountId +"\nDeviceId = " + deviceId+"\nSeriesID = "+seriesID);
			
			String optionNewRepeat; 
			
			if (newRepeat.equals("new-only")){
				optionNewRepeat = "OnlyNew";
			}else if (newRepeat.equals("new-repeat")){
				optionNewRepeat = "NewAndRepeats";
			}else{
				System.out.println("Error: Please check the value for new-repeat on the Account Details form");
				optionNewRepeat = "OnlyNew"; // default option is "OnlyNew"
			}
			
			System.out.println("optionNewRepeat = " + optionNewRepeat);
			
			String markets = req.getParameter("mkt_drop");
			
			HttpSession session = req.getSession();
			session.setAttribute("queryRsp", result1);
			session.setAttribute("seriesId", seriesID);
			session.setAttribute("markets", markets);
			
			System.out.println("Add Series: Printing the Selected Markets:\n");
			String[] marketsArray = markets.split("\\s*,\\s*");
			for (String sMarket: marketsArray)
			{
				System.out.println("Market : " + sMarket + "\n");
				
			}
			
			url = new URL("http://mwsprod.ccp.xcal.tv:9002/entityDataService/data/Program?schema=1.5.8&form=cjson&pretty=true&byType=SeriesMaster&byId="+seriesID);
			System.out.println("End Point :: " + url.toString());
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			while ((line = rd.readLine()) != null) 
			{
				result += line;
			}
			
			rd.close();
		
			System.out.println("Result" + result);
			
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(result); 
			JSONObject jsonObject = (JSONObject) obj;
			JSONArray msg = (JSONArray) jsonObject.get("entries");
			 
			Iterator<JSONObject>  iterator = msg.iterator();
			Boolean validSeries = false; 
			 
			while (iterator.hasNext())
			{
				JSONObject entriesId = iterator.next();
				title = (String)entriesId.get("title");
				validSeries = true;
				System.out.println("Title from json query : " + title);   
			}
			
			session.setAttribute("title", title);
			
			conn.disconnect();
			

			for (String sMarket: marketsArray)
			{
				System.out.println("Processing Add Schedule for Market : " + sMarket + "\n");
			
				/////
				URL urlMarkets = new URL("http://162.150.162.102:9001/ivodquery/select/ivodAccounts?market=" + sMarket);
			  result = "";
				System.out.println("urlAccounts = " + urlMarkets.toString());
				connMarkets =  (HttpURLConnection) urlMarkets.openConnection();
				connMarkets.setRequestMethod("GET");
				
				rd = new BufferedReader(new InputStreamReader(connMarkets.getInputStream()));
				while ((line = rd.readLine()) != null) 
				{
					result += line;
				}
				
				rd.close();
				connMarkets.disconnect();

			
				System.out.println("Result = " + result + "<End>");
				
				JSONParser parserMkt = new JSONParser();
				Object objMkt = parserMkt.parse(result); 
				JSONObject jsonObjectMkt = (JSONObject) objMkt;
				JSONArray msgMkt = (JSONArray) jsonObjectMkt.get("ivodAccounts");
				 
				Iterator<JSONObject>  itMkt = msgMkt.iterator();
				 
				while (itMkt.hasNext())
				{
					JSONObject mktRec = itMkt.next();
					xAccount = (String)mktRec.get("xAccount");
					xDevice = (String)mktRec.get("xDevice");
					System.out.println("xAccount = " + xAccount + "\nxDevice = " + xDevice + "\n");
					
					///////
					
					url1 = new URL("http://current.scheduler.ccp.xcal.tv:9051/schedulerWebService/scheduling");
					System.out.println("End Point " + url1.toString());
					conn1 = (HttpURLConnection) url1.openConnection();
					conn1.setRequestMethod("POST");
					conn1.setDoOutput(true);
					conn1.setRequestProperty("Content-Type", "application/json");
					 
					JSONObject json = new JSONObject();
					json.put("requestId", "d44ccf00-73f9-11e1-bc3c-00505693338c");
					json.put("requester", "XRE_e9c994f0-ec62-44cd-a9e8-2f81773e54c0");
					json.put("deviceId", xDevice);
					json.put("accountId", xAccount);	     
					 
					JSONArray seriesArray = new JSONArray();
					JSONObject seriesArrayElementOne = new JSONObject();
					 
					seriesArrayElementOne.put("displayName", title);
					seriesArrayElementOne.put("entityId", seriesID);
					seriesArrayElementOne.put("entityType", "Program");
					 
					JSONObject seriesArrayElementOneObjectTwo = new JSONObject();
					seriesArrayElementOneObjectTwo.put("rerecordOption", optionNewRepeat);
					seriesArrayElementOneObjectTwo.put("channelOption", "HDOnly");
					seriesArrayElementOneObjectTwo.put("episodesToKeep", 0);
					seriesArrayElementOneObjectTwo.put("deletePriority", "P3");
					seriesArrayElementOneObjectTwo.put("padBefore", 0);
					seriesArrayElementOneObjectTwo.put("padAfter", 0);
					 
					seriesArrayElementOne.put("rules", seriesArrayElementOneObjectTwo);
					seriesArray.add(seriesArrayElementOne);	     	    	     
					json.put("series", seriesArray);	
					   
					JSONObject request = new JSONObject();
					request.put("addSeries", json);
					System.out.println("Json Add request : " + request.toString());
					OutputStreamWriter out = new OutputStreamWriter(conn1.getOutputStream());
					out.write(request.toString());     
					out.close();
					   
					brd1 = new BufferedReader(new InputStreamReader(conn1.getInputStream()));
					result1="";
					
					while ((line = brd1.readLine()) != null) 
					{
						result1 += line;
					}
					
					System.out.println("Result = " + result1);
					brd1.close();
					conn1.disconnect();					
					
					//////
					try{
						
						URL urlSeries;
						HttpURLConnection connSeries;
						BufferedReader brdSeries;
						
						urlSeries = new URL("http://162.150.162.102:9001/ivodquery/insert");
						//urlSeries = new URL("http://stackoverflow.com");			
							
						System.out.println("Series Data Service End Point : " + urlSeries.toString());
						connSeries = (HttpURLConnection) urlSeries.openConnection();
						connSeries.setRequestMethod("POST");
						connSeries.setDoOutput(true);
						connSeries.setRequestProperty("Content-Type", "application/json");
						connSeries.setRequestProperty("charset", "utf-8");
						connSeries.setRequestProperty("Accept-Charset", "UTF-8");
						 
						JSONObject seriesRec = new JSONObject();			 
						JSONArray ivodSeriesArray = new JSONArray();
						JSONObject ivodSeriesArrayElementOne = new JSONObject();
						 
						Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
						String milSecSinceEpoch = Long.toString(calendar.getTimeInMillis());

						DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
						Calendar cal = Calendar.getInstance();
						String createDate = dateFormat.format(cal.getTime());
						
						String createdBy = "ivodUser";

						ivodSeriesArrayElementOne.put("id", milSecSinceEpoch); //replace with an incrementing ID later
						ivodSeriesArrayElementOne.put("seriesId", seriesID);
						ivodSeriesArrayElementOne.put("seriesName", title);
						ivodSeriesArrayElementOne.put("market", sMarket);
						ivodSeriesArrayElementOne.put("ivodAccountId", xAccount);
						 
						ivodSeriesArrayElementOne.put("createDate", createDate);
						ivodSeriesArrayElementOne.put("createdBy", createdBy);
						ivodSeriesArrayElementOne.put("modifyDate", "");
						ivodSeriesArrayElementOne.put("modifiedBy", "");
						 
						ivodSeriesArray.add(ivodSeriesArrayElementOne);	     	     	      
						seriesRec.put("ivodSeries", ivodSeriesArray);	
									     
						System.out.println("ivodSeries Insert Record request : " + seriesRec.toString());
						OutputStreamWriter out2 = new OutputStreamWriter(connSeries.getOutputStream());
						out2.write(seriesRec.toJSONString());
						out2.flush();
						out2.close(); 
						
						BufferedReader brd2 = new BufferedReader(new InputStreamReader(connSeries.getInputStream()));
						result1="";
						
						while ((line = brd2.readLine()) != null) 
						{
							result1 += line;
						}
						
						System.out.println("Series Table write result = " + result1);
						brd2.close(); 
						
						
						connSeries.disconnect();
						System.out.println("Created Series table record");
					}
					catch (Exception e) {
						e.printStackTrace();
						e.getCause();
						e.getMessage();
						System.out.println("Exception***");
					}					
					/////					
				}								
				/////				
			}
			
			//session.setAttribute("accountId", accountId);
			//session.setAttribute("deviceId", deviceId);
			session.setAttribute("queryRsp", result1);
			session.setAttribute("title", title);
			resp.sendRedirect("addSeries_success.jsp");
			
		} catch (IOException e) {
			e.printStackTrace();
			e.getCause();
			e.getMessage();
			HttpSession session = req.getSession();
			session.setAttribute("queryRsp", "invalid");
			resp.sendRedirect("scheduleseries.jsp");
			System.out.println("IOException***");
		} catch (Exception e) {
			e.printStackTrace();
			e.getCause();
			e.getMessage();
			HttpSession session = req.getSession();
			session.setAttribute("queryRsp", "invalid");
			resp.sendRedirect("scheduleseries.jsp");
			System.out.println("Exception***");
		}
		
	}
}
