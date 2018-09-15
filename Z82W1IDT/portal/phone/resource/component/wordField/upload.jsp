<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/portal/phone/resource/common/include_css.jsp" %>
<%@ include file="/portal/phone/resource/common/include_js.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
  function checkReturn(){
	  var msgHtml = jQuery("div.msgSub").html();
	  if(msgHtml!=""){
		  window.returnValue=0;
	  }
  }
</script>
<title> 文件上传页面</title>
</head>
  <body onunload="checkReturn()">
    <%@include file="/portal/share/common/msg.jsp"%><br/><br/>
    <s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
    <s:form action="uploadfile" namespace="/portal/upload" method="post" enctype="multipart/form-data">
      <input type="hidden" id="type" name="type" value="<s:property value='#parameters.type'/>"/>
      <input type="hidden" name="EDITFILEFileName" value="true" />
      <table border="0" align="center">
        <tr>
          <td>
            <s:file name="upload" theme="simple"/>
          </td>
        </tr>
        <tr>
          <td align="center">
           <s:submit theme="simple" value="提交"></s:submit>&nbsp;&nbsp;<s:reset theme="simple" value="重置"></s:reset>
          </td>
        </tr>
      </table> 
     </s:form>
  </body>
  </o:MultiLanguage>
</html>