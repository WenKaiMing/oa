<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@include file="/common/tags.jsp"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=request.getParameter("title")%></title>
<script src="<s:url value='/script/check.js'/>"></script>
<script src="<s:url value='/script/util.js'/>"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/DWRHtmlUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormulaTreeHelper.js"/>'></script>
<script>
	var contextPath = '<%= request.getContextPath()%>';
	var valuetype = '<%= request.getParameter("valuetype") %>';
	var value = '<%= request.getParameter("value") %>';
	var moduleid = '<s:property value="#parameters.s_module" />';
	
	function doReturn() {
		var elements = document.forms[0].elements;
		var rtn;
		for(var i=0; i<elements.length; i++) {
			if (elements[i].type != 'button' 
					&& elements[i].name != 'form'
					&& elements[i].value != null 
					&& elements[i].value != '') {
				var obj = new Object();
				
				if (elements[i].name == 'express' 
						&& valuetype == 'VALUE_TYPE_PROPERTY') { 
					obj.text = "\'" + elements[i].value + "\'" +' ';	
				} else {
					obj.text = elements[i].value + ' ';
				}
				
				
				obj.valuetype = document.getElementById('valuetype').value;
				rtn = obj;
				//rtn += elements[i].value + ' ';
				//alert(rtn);
			}
		}
		window.returnValue = rtn;
		window.close();
	}

	function ev_onload() {
		var express = document.all('express');
		if(valuetype != 'null' && valuetype !='' && express != null) {
			ev_createClew(valuetype);
		}
	}
	
	function ev_init(fn1, fn2) {
		if (document.all(fn1) != null && document.all(fn2) != null) {
			var instance = '<%= session.getAttribute("APPLICATION")%>';
			var def0 = moduleid;
			var def1 = document.getElementById(fn1).value;
			var def2 = document.getElementById(fn2).value;
			
			var func = new Function("ev_init('"+fn1+"','"+fn2+"')");
			document.getElementById(fn1).onchange = func;
			document.getElementById(fn2).onchange = func;
			
			FormulaTreeHelper.createForm(fn1,def0,def1,instance,function(str) {var func=eval(str);func.call()});
			FormulaTreeHelper.createFiled(fn2,def1,def2,function(str) {var func=eval(str);func.call()});
			FormulaTreeHelper.getFieldtype(def2, def1, ev_setValuetype);
		}
	}

	function ev_setValuetype(type) {
		//alert("settype->" + type);
		document.getElementById('valuetype').value = type;
	}

	function ev_createClew(type) {
		//alert(type);
		if (type != null && type != '') {
			//alert(type);
			var html = '<font color="red">Notice:please ';
			document.getElementById('datebt').style.display = "none";
			if (type == 'VALUE_TYPE_VARCHAR') {
				html += ' input character string';
			} else if (type == 'VALUE_TYPE_NUMBER') {
				html += ' input number'; 
			} else if (type == 'VALUE_TYPE_DATE') {
				html += ' select date'
				document.getElementById('datebt').style.display = "";
			} else if (type == 'VALUE_TYPE_PROPERTY') {
				html += ' select ' + value;
				document.getElementById('selbt').style.display = "";
				//alert('****value->' + value);
			}
			
			html += ' </font>';
			
			clewDiv.innerHTML = html;
			curtype = type;
		}
	}

	function selectField() {
		  wx = '600px';
		  wy = '500px';
		  var url = contextPath + "/portal/dynaform/document/select.action";
		 
		  url = addParam(url, 's_module', moduleid);
		  url = addParam(url, 'fieldname', value);
		  var rtn = showframe("{*[Select ]*}Form", url);
		  
		  if (rtn == null || rtn == 'undefined') {
		  }
		  else if (rtn == '') {
			document.getElementById('express').value = '';
		  }
		  else {
			  	document.getElementById('express').value = rtn;
			}
	}
</script>
</head>
<body onload="ev_onload()">
<s:form name="treeForm" method="post">	
	<s:bean id="fth" name="cn.myapps.core.formula.FormulaTreeHelper" />
	<button type="button" class="button-image" onClick="doReturn();">
	<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}
	</button>
	
	<s:hidden name="valuetype" />
	
	<s:if test="#parameters.fieldName[0] == 'create'">
		<s:select label="Operator" name="operator" list="#fth.ALL_SYMBOL"/>
		<!--  
		-->
	</s:if>

	<s:if test="#parameters.fieldName[0] == 'relation'">
		<s:select label="Relation" name="relation" list="#fth.RELATION_SYMBOL" />
	</s:if>
	
	<s:if test="#parameters.fieldName[0] == 'operator'">
		<s:select label="Operator" name="operator" list="#fth.OPERATOR_SYMBOL" />
	</s:if>

	<s:if test="#parameters.fieldName[0] == 'compare'">
		<s:select label="Compare" name="compare" list="#fth.COMPARE_SYMBOL" />
	</s:if>
	
	<s:if test="#parameters.fieldName[0] == 'fieldname'">
		<s:select label="Form" name="form" list="{}" />
		<s:select label="FieldName" name="fieldname" list="{}" />
	</s:if>

	<s:if test="#parameters.fieldName[0] == 'express'">
		<tr><td colspan="2">
		<div id='clewDiv'></div></td></tr>
		<tr>
		<td class="tdLabel"><label class="label">Express:</label></td>
		<td><s:textfield name="express" theme="simple"/></td>
		<td><button type="button" name="datebt" style="display:none" class="button-image" onClick="treeForm.elements['express'].value = selectDate(treeForm.elements['express'].value);">
			<img src="<s:url value="/resource/image/search.gif"/>"></button>
			<input name="selbt" style="display:none" class="button-cmd" onclick="selectField()" type="button" value="{*[Select]*}" />
		</td></tr>
	</s:if>
</s:form>	
</body>
<script>
ev_init('form', 'fieldname');
</script>
</o:MultiLanguage></html>