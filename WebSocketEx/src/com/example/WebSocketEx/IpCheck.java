package com.example.WebSocketEx;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public class IpCheck {
	List<String> ipList = null;
	public IpCheck(){
		ipList = new ArrayList<String>();
		ipList.add("192.168.0.101");
	}
	
	public boolean authentication(HttpServletRequest request){
		boolean isSuccess = false;
		String ipAddress = request.getRemoteAddr();
		if(ipAddress.equalsIgnoreCase("0:0:0:0:0:0:0:1")){
		    InetAddress inetAddress;
			try {
				inetAddress = InetAddress.getLocalHost();
				ipAddress = inetAddress.getHostAddress();
			} catch (UnknownHostException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		for(String ip : ipList){
			if(ipAddress.equals(ip)){
				isSuccess = true;
				break;
			}
		}
		return isSuccess;
	}
}
