<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />' type="text/css">
<title>{*[Error]*}</title>
</head>
<body>
<ul>
	<s:url id="expimphome" value="/core/expimp/exporimp.jsp" >
		<s:param name="applicationid" value="#parameters.applicationid" />
	</s:url>
	
	<li>
		{*[go.to]*}: <a href='<s:property value="#expimphome" />'>{*[Import]*}/{*[Export]*}{*[HomePage]*}</a>
	</li>
	
	<li>
		{*[go.to]*}: <a href='javascript: history.back();'>{*[PrevPage]*}</a>
	</li>
	
	<li>
		<s:if test="hasFieldErrors()">
			<div><b>{*[System]*}{*[Error]*}:</b></div>
			<ul>
				<s:iterator value="fieldErrors">
				<li class="errorMessage">
					<s:property value="value[0]" escape="false" />
				</li>
				</s:iterator> 
			</ul>
		</s:if>
		
		<s:if test="hasActionErrors()">
			<div><b>{*[Export]*}{*[Error]*}:</b></div>
			<ul>
				<s:iterator value="actionErrors">
				<li class="errorMessage">
					<s:property escape="false" />
				</li>
				</s:iterator> 
			</ul>
		</s:if>
		
		<s:if test="hasActionMessages()">
			<div><b>{*[Export]*}{*[Warn]*}:</b></div>
			<ul>
				<s:iterator value="actionMessages">
				<li class="warnMessage">
					<s:property escape="false" />
				</li>
				</s:iterator> 
			</ul>
		</s:if>
	</li>
</ul>
</body>
</o:MultiLanguage>
</html>