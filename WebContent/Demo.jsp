
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="zh">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Demo</title>
<script type="text/javascript" src="jquery-7.min.js"></script>
</head>
<body>
    <form name="trand" action="#" method="post" >

      <table style="text-align: left; width: 100%;" cellpadding="2" cellspacing="2">
        <tbody>
          <tr><td>CP_ID:<input type="text" id="CP_ID" name="CP_ID" value="0017234447" size = "50"/></td></tr>
          <tr><td>TID:<input type="text" id="TID" name="TID" value="0986844003-2017060613-010001" size = "50" /></td></tr>
          <tr><td>R_URL:<input type="text" id="R_URL" name="R_URL" value="http://127.0.0.1/" size = "50"/></td></tr>
          <tr><td>MSISDN:<input type="text" id="MSISDN" name="MSISDN" value="0987440120 " size = "50"/></td></tr>
          
        </tbody>
      </table>
      <input type="button" class="queryBtn" id="btnOK" value="測試" />
    </form>
</body>
</html>

<script type="text/javascript">
  var form = document.trand;
  
  $(document).ready(function() {

    $('#btnOK').click(function() {    
      form.action = "http://172.22.137.66:8080/mpg_merchant/MPGLogin.jsp";
      form.submit();
    }); 
     

  });
</script>