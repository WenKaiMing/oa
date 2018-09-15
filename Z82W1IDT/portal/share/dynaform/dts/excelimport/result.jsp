<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%String contextPath = request.getContextPath();%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head><title>{*[{Import result]]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css"></head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<s:url id="url" value='/resourse/main.css'/>"/>
<body>
<table>
<tr><td>
<s:if test="hasFieldErrors()">
     <span class="errorMessage"> <b>{*[Errors]*}:</b><br> </span>
		<s:generator val="fieldErrors" separator="!" id="iter1">
        </s:generator>
    <%-- <div>
         <ul>
             <s:iterator status="st" value="#request.iter1" id="name">
                <li style="display: block;list-style-position: inside; "> <s:property value="name" /> </li>
             </s:iterator>
         </ul>
     </div>--%>
      <span class="errorMessage"> <b>{*[Errors]*}:</b><br>
         <s:generator val="fieldErrors" separator="__" id="iter1">
         </s:generator>
         <s:iterator status="st" value="#request.iter1" id="name">
             <s:property value="name" /> </br>
         </s:iterator>
      </span>
</s:if>
</td></tr>

<tr>
<td>
<s:property value="_msg" />
</td>
</tr>
</table>
	  	
</body>
</o:MultiLanguage></html>
