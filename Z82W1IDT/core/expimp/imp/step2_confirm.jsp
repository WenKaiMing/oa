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
<title>{*[Confirm]*}</title>
</head>
<body>
<ul>
	<li>
		{*[go.to]*}: <a href='<s:url value="/core/expimp/exporimp.jsp" ><s:param name="applicationid" value="applicationid" /></s:url>'>{*[Import]*}/{*[Export]*}{*[HomePage]*}</a>
	</li>
	<li>
		{*[go.to]*}: <a href='<s:url action="backToStep1" ></s:url>'>{*[PrevPage]*}</a>
	</li>	
	
	<s:if test="!hasFieldErrors() && !hasActionErrors()">
	<li>
	    {*[go.to]*}: <a href='<s:url action="impNext"><s:param name="impFilePath" value="impFilePath" /></s:url>'>{*[Confirm]*}{*[Import]*}</a>
	</li>
	</s:if>

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
			<div><b>{*[Import]*}{*[Error]*}:</b></div>
			<ul>
				<s:iterator value="actionErrors">
				<li class="errorMessage">
					<s:property escape="false" />
				</li>
				</s:iterator> 
			</ul>
		</s:if>
		
		<s:if test="hasActionMessages()">
			<div><b>{*[Import]*}{*[Warn]*}:</b></div>
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