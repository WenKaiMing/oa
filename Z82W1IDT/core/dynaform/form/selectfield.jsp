<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/taglibs.jsp"%>
<%
String contextPath = request.getContextPath();
%>
<html>
<o:MultiLanguage>
<head>
<title> {*[Document type list]*} </title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%= contextPath %>resource/css/css.jsp" type="text/css">
<script src="<%= contextPath %>/script/billlist.js"></script>
<script src="<%= contextPath %>/script/util.js"></script>
<script language="JavaScript">
var contextPath = '<%= contextPath %>';

function selectOne(value) {
  top.window.returnValue = value;
  top.window.close();
}

function doReturn() {
  var sis = document.all("_selectitem");
  var rtn = new Array();
  var p = 0;

  if (sis.length != null) {
	  for (var i=0; i<sis.length; i++) {
	    var e = sis[i];
	    if (e.type == 'checkbox') {
	      if (e.checked) {
	        rtn[p++] = e.value;
	      }
	    }
	  }
  }
  else {
    var e = sis;
    if (e.type == 'checkbox') {
      if (e.checked) {
        rtn[p++] = e.value;
      }
    }
  }

  window.returnValue = rtn;
  window.close();
}

function ev_check() {
  return true;
}

function ev_resetForm() {
  formList.s_name.value = "";
  resetForm();
}

</script>
</head>
<body color=black>
<style>
body { font-size: 10pt;	margin-left: 0px; margin-top: 0px;font-family: "{*[Song]*}"; scrollbar-base-color: #B6F48F;	scrollbar-arrow-color: #ffffff;	text-align: center;}
</style>
<s:form id="formList" method="post" action="/dynaform/form/selectField.do">
<input type="hidden" name="formids" value="<c:out value="${param.formids}"/>">
<table class="list-table" border="0" cellpadding="4" cellspacing="0" width="100%">
  <tr>
    <td class="list-srchbar" align="right">
     <input type="button" class="bt-cancel" onclick="doExit()" value="{*[Cancel]*}">
	 <input type="button" class="bt-empty" onclick="doEmpty()" value="{*[Clear]*}">
    </td>
  </tr>
  <tr>
    <td class="list-datas"> 
	  <table class="list-datas-table" border="0" cellpadding="0" cellspacing="1">
        <tr class="row-hd">
          <td width="40%">{*[Module name]*}</td>
          <td width="60%">{*[Field name]*}</td>
        </tr>
       
        <s:set name="formname" value="content.name" /> 
       
        <s:iterator value="content.fields">
        <tr class="row-content">        
          <td><s:property value="#formname" /></td>
		  
		  <td><a href="javascript:selectOne('<s:property value="id" />,<s:property value="name" />')">
		  <s:property value="name" /></a></td>
		</tr>
        </s:iterator>
        
	  </table>
	</td>
  </tr>
    <tr>
    <td align="right"><!--s:PageNav dpName="LIST"/--></td>
  </tr>
</table>
</s:form>
</body>
</o:MultiLanguage>
</html>
