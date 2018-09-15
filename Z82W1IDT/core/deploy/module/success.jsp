<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Success</title>
</head>
<body>
	<p>
	<strong style="font-size:20px">{*[cn.myapps.core.deploy.module.commit_succeed]*}</strong>
	</p>
	
<ul>
    <li>
        {*[cn.myapps.core.deploy.module.goto]*}:
        <a href='<s:url value="/portal/share/welcome.jsp" />'>{*[Home]*}</a>
    </li>
	
    <li>
        {*[cn.myapps.core.deploy.module.goto]*}:
        <s:url id="editURL" action="edit.action" >
        	<s:param name="id" value="%{content.id}" />
        </s:url>
        <a href='<s:property value="#editURL" />'>{*[cn.myapps.core.deploy.module.basic_info]*}</a>
    </li>

	<li>
		<s:if test="hasFieldErrors()">
			<div><b>{*[Error]*}:</b></div>
			<div class="errorMessage"> 				
				<s:iterator value="fieldErrors">
						*<s:property value="value[0]" escape="false" /><br>
				</s:iterator> 
			</div>
		</s:if>
	
		<s:if test="hasActionMessages()">
			<div><b>{*[cn.myapps.core.deploy.module.info]*}:</b></div>
			<div class="errorMessage"> 				
				<s:iterator value="actionMessages">
						*<s:property escape="false" /><br>
				</s:iterator> 
			</div>
		</s:if>
	</li>
</ul>
</body>
</o:MultiLanguage></html>