
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.IOException"%>

<html>
<head>
  <script type="text/javascript" src="jquery-7.min.js"></script>
</head>

<body>

<%
    //  MPG API URL
    // 【SIT】http://172.22.137.66:8080/mpg_merchant/request/smsArrive
%>

  <form name="submitForm" action="" method="post">
    <br/>功能：【模擬 MSP 回覆 MPG 簡訊認證動作】
    <br/><br/>
  	API URL:<input type="text" name="url" id="url" value="http://172.22.137.66:8080/mpg_merchant/request/smsArrive" size="50">
    <br/><br/>
  	* FromAddress:<input type="text" name="msisdn" id="msisdn" value=""> 【範例】：886987000111
    <br/><br/>
  	* 簡訊的認證密碼:<input type="text" name="otp" id="otp" value="">
    <br/><br/>
  	<input id="btnOK" type="button" value="確定" >
    <br/><br/>
    <%-- 結果 --%>
    <div id="DIVQUERY"></div>  
  </form>
</body>
</html>

<script language="javascript">

$(document).ready(function() {

  $('#btnOK').click(function() {
  	
	  var url = $("#url").val();
	  var msisdn = $("#msisdn").val();
	  var otp = $("#otp").val();
	  
  	var parameters = 'url=' + url + "&msisdn=" + msisdn + "&otp=" + otp;
		var url = 'msp2mpgProcess.jsp?' + parameters;
		newPopup(url);
		
  });

});

function newPopup(url) {
	newwindow = window.open(url,'name','height=200,width=600,menubar=no,resizable=no,scrollbars=no,toolbar=no,location=no');
	newwindow.focus();
}
</script>
