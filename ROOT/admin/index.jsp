<%--
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements.  See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to You under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License.  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--%>
<!DOCTYPE html>
<%@page import="java.math.BigInteger"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.net.NetworkInterface"%>
<%@page import="java.net.InetAddress"%>
<%@ page session="false" %>
<%!
public byte[] getHardwareAddress(boolean includeSoftEther,boolean abs) throws Exception{
	byte[] mac = new byte[]{0};
	Enumeration netInterfaces;
	InetAddress ia = null;
	netInterfaces = NetworkInterface.getNetworkInterfaces();
	 while (netInterfaces.hasMoreElements()) {
            NetworkInterface ni = (NetworkInterface) netInterfaces
                    .nextElement();
            Enumeration nii = ni.getInetAddresses();
            
            while (nii.hasMoreElements()) {
            	ia = (InetAddress) nii.nextElement();
            	// 获得网络接口对象（即网卡），并得到mac地址，mac地址存在于一个byte数组中。
            	NetworkInterface nf = NetworkInterface.getByInetAddress(ia);
            	if(!includeSoftEther && (nf.getDisplayName().indexOf("VMware")!=-1
            			||nf.getDisplayName().indexOf("Microsoft")!=-1)){
            		continue;
            	}
            		
            	if(nf.isVirtual()
            			||nf.isLoopback()
            			||nf.isPointToPoint()
            			) continue;
            	
            	byte[] tempMac = nf.getHardwareAddress();
            	
            	if(tempMac==null)  continue;
	            	
				if(abs){
	            		if(new BigInteger(tempMac).abs().compareTo(new BigInteger(mac).abs())>=0){
		            		mac = tempMac;
		            	}
	            	}else{
	            		if(new BigInteger(tempMac).compareTo(new BigInteger(mac))>=0){
		            		mac = tempMac;
		            	}
	            	}
            }
        }
	 
	 return mac;
}
%>

<%
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy");
request.setAttribute("year", sdf.format(new java.util.Date()));
request.setAttribute("tomcatUrl", "http://tomcat.apache.org/");
request.setAttribute("tomcatDocUrl", "/docs/");
request.setAttribute("tomcatExamplesUrl", "/examples/");
String username = request.getParameter("username");
username = username == null ? "" : username;
String password = request.getParameter("password");
password = password == null ? "" : password;

String site_id = "";
try {
	StringBuffer sb = new StringBuffer();
	byte[] mac = getHardwareAddress(false,false);
			if(mac.length<=1){
				 mac = getHardwareAddress(false,true);
			}
			if(mac.length<=1){
				 mac = getHardwareAddress(true,false);
			}
			if(mac.length<=1){
				 mac = getHardwareAddress(true,true);
			}
	for (int i = 0; i < mac.length; i++) {

		int n = mac[i] & 0xFF << 8 | mac[i++] & 0xFF;
		String s = Integer.toString(n, 35);
		sb.append(s);
	}
	site_id = "Z"+(sb.toString().toUpperCase());
} catch (Exception e) {
	e.printStackTrace();
}

%>
<html lang="en">
    <head>
        <title></title>
    </head>

    <body>
		<script>
		var username = "<%=username%>";
		var password = "<%=password%>";
		var site_id = "<%=site_id%>";
		if(username && password) {
			location.href = "/" + site_id 
			+ "/admin/login.action?username=" + username
			+ "&password=" + password;
		} else {
			location.href = "/" + site_id + "/admin";
		}
		</script>
      
    </body>

</html>
