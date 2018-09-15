<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/tags.jsp"%>
<%String contextPath = request.getContextPath();%>
<%@ page import="cn.myapps.util.sequence.Sequence" %>
<%
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 

String field_id = Sequence.getSequence();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<%= contextPath %>/script/util.js"></script>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css">
<script>
	var sAction = '<s:property value="#parameters.action" />' ;
	var sTitle = "{*[Insert]*}";
	
	var oControl;
	var oSeletion;
	var sRangeType;
	
	function ev_doConfirm() {
		var rtn="";
		var selcomponentid='<s:property value="#parameters.id" />';
		id = '<%=field_id%>';
		/*
		oActiveEl = CreateNamedElement( oEditor, oActiveEl, 'img', {
				classname: className,
				
				aliases:getAliasExpr()
				} 
		   ) ;	*/	
		rtn="{\"id\":\""+id+"\",\"aliases\":\""+getAliasExpr()+"\"}";
		window.returnValue = rtn;
		window.close();
	}

	function getAliasExpr() {
		var rtn = "";
		var elements = document.getElementsByName('fields');
		for (var i=0; i < elements.length; i++) {
			var name = elements[i].id;
			var alias = elements[i].value;
			rtn += name + ':' + alias + ';';
		}
		rtn = rtn.substring(0, rtn.lastIndexOf(";"));
		return rtn;
	}
	
	function InitDocument(){
	//Get value when modifying status
		if (sAction == "modify"){
			var aliasExpr = oControl.aliases;
			//alert(aliasExpr);
			var aliaslist = aliasExpr.split(";");			
			for(var i=0; i<aliaslist.length; i++) {
				var aliasProps = aliaslist[i];
				//alert(aliasProps);
				var fieldName = aliasProps.substring(0, aliasProps.indexOf(":"));
				var value = aliasProps.substring(aliasProps.indexOf(":") + 1);
				var field = document.all(fieldName)
				if (field != null && field != 'undefine') {
					field.value = value;
				}
			}
		}	
	}
</script>
</head>
<body onload="InitDocument()">
<s:form name="temp" action="list.action" method="post">
	<s:if test="hasFieldErrors()">
		<span class="errorMessage"> <b>{*[Errors]*}:</b><br>
		<s:iterator value="fieldErrors">
			*<s:property value="value[0]" />;
		</s:iterator> </span>
	</s:if>		
		<table>
		<tr><td colspan="2" class="commFont">{*[Alias]*}{*[Define]*}</td></tr>
		<tr>
			<td><input type="button" class="bt-cancel"
				onclick="ev_doConfirm()" value="{*[Confirm]*}"></td>
			<td><input type="button" class="bt-cancel"
				onclick="doExit()" value="{*[Cancel]*}"></td>
		</tr>
		<s:hidden name="id" value="%{id}" />	
			<s:iterator value="fieldList">
				<s:set name="n" value="name" />
					<s:textfield id="%{n}" label="%{n}" name="fields" />
			</s:iterator>
		</table>
</s:form>

</body>
<script>
	//alert(document.getElementById('id').value);
</script>
</o:MultiLanguage></html>
