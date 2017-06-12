import java.net.URLEncoder;
import java.util.Map;

import javax.xml.bind.DatatypeConverter;

import mspxml.XmlUtil;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class Demo {

  public static void main(String[] args) {
    
    // https://magiclen.org/java-base64/
	// test commit to gitHub
	//

    // TODO Auto-generated method stub
    try {
      
      final String otp = "674266";

      // base64 encode
      final String encodeAuthCose = base64Encode(otp);
      System.out.println(otp + " =>>" + encodeAuthCose);

      // urlencode
      final String encodeStr = 
        "<MspXmlApi xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"MspXmlApi.xsd\">"
        +"<SmsArriveNreq>"
        +"<RequestId>201706071555240004</RequestId>"
        +"<ClientId>CL-6941554</ClientId>"
        +"<FromAddress>886987440120</FromAddress>"
        +"<ToAddress>" + otp + "</ToAddress>"
        +"<Charset>big5</Charset>"
        +"<SmsEncoding>base64</SmsEncoding>"
        +"<SmsBody>" + encodeAuthCose + "</SmsBody>"
        +"</SmsArriveNreq>"
        +"</MspXmlApi>";
      
      System.out.println("【 call MSP】原始 xml:");
      System.out.println(encodeStr);
      System.out.println("【 call MSP】Base64 xml:");
      System.out.println(URLEncoder.encode(encodeStr, java.nio.charset.StandardCharsets.UTF_8.toString()));

      String result = "<a><b><c1>c1</c1><d1>d1</d1></b></a>";
      Map<String, String> xmlMap = XmlUtil.parseXml(result);
      System.out.println("c1=" + xmlMap.get("b").toString());
     
    } catch (Exception e) {
      System.out.println(e.toString());
    }
  }

  private static String base64Encode(String text) {

    System.out.println("【編碼】");

    try {
      final BASE64Encoder encoder = new BASE64Encoder();
      final byte[] textByte = text.getBytes("UTF-8");
      // 編碼
      final String encodedText = encoder.encode(textByte);
      System.out.println(text + "/" + encodedText);

      return encodedText;

    } catch (Exception e) {
      System.out.println(e.toString());
    }
    return null;

  }

  private static String base64Decode(String encodedText) {

    System.out.println("【解碼】");

    try {

      final BASE64Decoder decoder = new BASE64Decoder();
      // 解碼
      final String decodeText = new String(decoder.decodeBuffer(encodedText), "UTF-8");
      System.out.println(encodedText + "/" + decodeText);
      return decodeText;
      
    } catch (Exception e) {
      System.out.println(e.toString());
    }

    return null;
  }

}
