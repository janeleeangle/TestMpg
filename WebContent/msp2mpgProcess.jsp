<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.*"%>
<%@ page import="java.io.IOException"%>
<%@ page import="sun.misc.BASE64Encoder"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="mspxml.HttpClientUtil"%>
<%@ page import="mspxml.XmlUtil"%>
<%@ page import="org.apache.log4j.Logger"%>

<!DOCTYPE html>
<html lang="zh">
<head>
  <script type="text/javascript" src="jquery-7.min.js"></script>
</head>
<body>
<%
   Logger log = Logger.getLogger(this.getClass().getName());

    final String CHARSET_UTF8 = "UTF-8";
    // call MPG API 回傳結果
    String resultRequestId = "-9999999999";
    String resultCode = "-9999999999";
    String resultText = "作業失敗！";

    // 接受的參數
    final String msisdn = (String)request.getParameter("msisdn");
    final String otp = (String)request.getParameter("otp");
    final String httpUrl = (String)request.getParameter("url");
    log.debug(otp + " msisdn|otp =" + msisdn + "|" + otp);  

    // 組 xml -> 模擬 MSP 回覆 MPG 
    try {

      // otp -> base64 編碼
      final BASE64Encoder encoder = new BASE64Encoder();
      final byte[] otpByte = otp.getBytes(CHARSET_UTF8);
      final String encodedOtp = encoder.encode(otpByte);
      log.debug(otp + " base64 =" + encodedOtp);
      
      // rquestId -> call MPG API 序號
      java.util.Random random = new java.util.Random();
      java.util.Calendar cal = java.util.Calendar.getInstance();
      java.text.SimpleDateFormat df = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
      String requestId = df.format(cal.getTime());       

      // urlencode xml data
      final String xmlData = 
        "<MspXmlApi xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"MspXmlApi.xsd\">"
        +"<SmsArriveNreq>"
        +"<RequestId>" + requestId + "</RequestId>"
        +"<ClientId>CL-6941554</ClientId>"
        +"<FromAddress>" + msisdn + "</FromAddress>"
        +"<ToAddress>" + otp + "</ToAddress>"
        +"<Charset>big5</Charset>"
        +"<SmsEncoding>base64</SmsEncoding>"
        +"<SmsBody>" + encodedOtp + "</SmsBody>"
        +"</SmsArriveNreq>"
        +"</MspXmlApi>";
        
      String encodeXmlData = "xml=" + XmlUtil.urlencodeByUTF8(xmlData);
      
      log.debug("【 call MSP】原始 xml:");
      log.debug(xmlData);
      log.debug("【 call MSP】Base64 xml:");
      log.debug(encodeXmlData);
      
      // httpclient
      String result = HttpClientUtil.getInstance().sendHttpPostXML(httpUrl, encodeXmlData);
      log.debug("@@@@@@@@@@@@@@@@@@@@@@@@");
      log.debug("call MPG result : " + result);
      log.debug("@@@@@@@@@@@@@@@@@@@@@@@@");
      if (result.indexOf("<MspXmlApi>") > -1) {
        result = result.substring(result.indexOf("<MspXmlApi>") + 11, result.indexOf("</MspXmlApi>"));
      }
      Map<String, String> xmlMap = XmlUtil.parseXml(result);
      
      resultRequestId = (String)xmlMap.get("RequestId");
      resultCode = (String)xmlMap.get("ResultCode");
      resultText = (String)xmlMap.get("ResultText");
      log.debug(" processMsp2mpg MPG API response: RequestId|ResultCode|ResultText=" + resultRequestId + "|" + resultCode + "|" + resultText);
      
    } catch (Exception e) {
      log.error(" processMsp2mpg Exception:" + e.toString());
    }
    
    log.debug(" processMsp2mpg finished. msisdn|otp|resultCode=" + msisdn + "|" + otp + "|" + resultCode);
    
    out.println("門號 / 簡訊的認證密碼 / 作業結果  = " + msisdn + " / " + otp + " / " + resultCode + " " + resultText);  
%>

</body>
</html>
