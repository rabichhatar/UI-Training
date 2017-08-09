/**
 * 
 */
package com.ivod.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class SeachController extends HttpServlet{
	
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		URL url;
		HttpURLConnection conn;
		BufferedReader rd;
		
		try {
			response.setContentType("application/json");
			JSONParser parser = new JSONParser();
			String seriesString = request.getParameter("json");
			JSONObject json = (JSONObject)parser.parse(seriesString);
			String searchKey = (String)json.get("searchKey");
			long locationId = 7444042768941558110l;
			 
			//url = new URL("http://rex.ccp.xcal.tv/rex/v3/search?q="+searchKey+"&filters=((tvlisting.location:merlin$"+locationId+"))%20AND%20(entitytype:series)&fields=title,-description,-ref,-rex.genre,-startyear,-audience,-language,-rating,-entitytype,-endyear&start=1&returned=10000&client=id:ranjith,product:iVOD");
			// Have firewall opened for only one IP of rex.ccp.xcal.tv - 172.30.146.169 
			url = new URL("http://172.30.146.169/rex/v3/search?q="+searchKey+"&filters=((tvlisting.location:merlin$"+locationId+"))%20AND%20(entitytype:series)&fields=title,-description,-ref,-rex.genre,-startyear,-audience,-language,-rating,-entitytype,-endyear&start=1&returned=10000&client=id:ranjith,product:iVOD");
			System.out.println("End Point " + url.toString());
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		
			Object obj = parser.parse(rd);
			rd.close();
			conn.disconnect();
			
			JSONObject jsonObject = (JSONObject) obj;
			
			PrintWriter out = response.getWriter();
			out.print(jsonObject);
			out.flush();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
