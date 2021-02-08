<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.io.*" %>
<%@ page import = "java.net.URLConnection" %>
<%@ page import = "javax.net.ssl.TrustManager" %>
<%@ page import = "javax.net.ssl.HostnameVerifier" %>
<%@ page import = "javax.net.ssl.HttpsURLConnection" %>
<%@ page import = "javax.net.ssl.SSLContext" %>
<%@ page import = "javax.net.ssl.SSLSession" %>
<%@ page import = "javax.net.ssl.X509TrustManager" %>
<%@ page import = "java.security.cert.X509Certificate" %>

<%!
    TrustManager[] trustAllCerts = new TrustManager[] { new X509TrustManager() {
          public java.security.cert.X509Certificate[] getAcceptedIssuers() { return null; }
          public void checkClientTrusted(X509Certificate[] certs, String authType) {  }
          public void checkServerTrusted(X509Certificate[] certs, String authType) {  }
       }
    };    
    // Create all-trusting host name verifier
    HostnameVerifier allHostsValid = new HostnameVerifier() {
        public boolean verify(String hostname, SSLSession session) { return true; }
    };    
%>
<%
request.setCharacterEncoding("UTF-8"); 
response.setCharacterEncoding("UTF-8"); 
response.setHeader("Cache-Control","no-store");     // HTTP 1.1
response.setHeader("Pragma","no-cache");            // HTTP 1.0
response.setDateHeader("Expires", 0);

SSLContext sc = SSLContext.getInstance("SSL");
sc.init(null, trustAllCerts, new java.security.SecureRandom());
HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());	
HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);

String url = "http://dev.coocon.co.kr/sol/gateway/acctnm_rcms_wapi.jsp";// API 개발주소
byte[] resMessage = null;

//String JSONDataVal = request.getParameter("JSONData");

String JSONDataVal ="{\"SECR_KEY\":\"BBWRx53Z6N2umcUNOukS\",\"KEY\":\"ACCTNM_RCMS_WAPI\",\"REQ_DATA\":[{\"BANK_CD\": \"011\",\"SEARCH_ACCT_NO\": \"14902597746\",\"ACNM_NO\": \"\" ,\"ICHE_AMT\": 0}]}";
HttpURLConnection conn;
try {
    conn = (HttpURLConnection) new URL(url).openConnection();
    conn.setDoInput(true); 
    conn.setDoOutput(true);
    conn.setRequestMethod("POST");
    conn.setUseCaches(false);
    OutputStreamWriter os = new OutputStreamWriter(conn.getOutputStream());
    
String postString = "JSONData="+JSONDataVal;
    os.write(postString);
    os.flush();
    os.close();

    DataInputStream in = new DataInputStream(conn.getInputStream());
    ByteArrayOutputStream bout = new ByteArrayOutputStream();
    int bcount = 0;
    byte[] buf = new byte[2048];
    while (true) {
        int n = in.read(buf);
        if (n == -1) break;
        bout.write(buf, 0, n);
    }

    bout.flush(); 
    resMessage = bout.toByteArray();
    conn.disconnect(); 
}
catch (MalformedURLException e) {
    System.out.println("MalformedURLException");
}
catch (IOException e) {
    e.printStackTrace();
}
//결과처리
String temp = new String(resMessage, "UTF-8");
temp = temp.replaceAll("\r\n","");
temp = temp.replaceAll("\r","");
temp = temp.replaceAll("\n","");
out.println(temp.trim());
%>