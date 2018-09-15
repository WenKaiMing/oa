<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/tags.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[Success]*}</title>
</head>
<script>
	window.onload = function(){
		refreshApplicationTree("refreshid");
	}
</script>
<body>
<s:form action="" method="post">
	<s:hidden id="refreshid" name="refresh"/>
	<p>
		<strong style="font-size:20px">{*[Import]*}{*[Successful]*}</strong>
	</p>
	
<ul>
    <li>
        Go to:
        <a href='<s:url value="/core/expimp/exporimp.jsp" ><s:param name="applicationid" value="#parameters.applicationid" /></s:url>'>{*[Import]*}/{*[Export]*}{*[HomePage]*}</a>
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
</s:form>
</body>
</o:MultiLanguage></html>