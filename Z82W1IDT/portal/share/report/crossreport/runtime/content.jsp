<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>report content</title>
<%
	String chartstr = (String) (request.getAttribute("str"));
	request.setAttribute("str", chartstr);
	String showSearchForm = (String)request.getAttribute("showSearchForm");
%>
<style>
.content-table {
	border: 1px solid black;
}

.title1 {
	font-weight: bold;
	font-family: 宋体; 
	font-size: 9pt;
}

.note {
	
	font-weight: bold;
	font-family: 宋体; 
	font-size: 9pt
}

.content-table td {
	border: 1px solid gray;
}

a {
	text-decoration: none;
	font-size: 12px;
}

.tr-total {
	background-color:#EEF0F2;
	color: red;
}

a:active {
	text-decoration: underline;
}

a:HOVER {
	text-shadow: black;
	text-decoration: underline;
}

.cursor:pointe

* {
	margin: 0px;
	padding: 0px;
}

#container {
	border: 1px solid #e4e4e4;
}

#activityTable {
	
	border-bottom: 1px solid #e4e4e4;
	align:center;
	width: 100%;
}

#activityTable,#searchFormTable,#pageTable {
	overflow: hidden;
}

#dataTable {
	width:100%;
	padding-bottom:20px;
	background-color: white;
}

#searchFormTable {
	background-color: white;
	padding: 10px;
	width: 100%;
}

.body-front1 {
	margin-top: 0px;
	margin-left: 0px;
	padding: 0px; 
	margin: 0px;
}

.display_view-table1 {
	border: 0px solid #e4e4e4;
	width: 100%;
	font-family: Arial, Vendera;
	font-size: 12px;
	z-index: 100;
}

.dtable-header1 {
	height: 24px;
	text-align: center;
	vertical-align: middle;
	text-align: center;
	z-index: 100;
	white-space: nowrap;
	background-color: #EEF0F2;
}

.table-tr1 td {
	background-color: #FFFFFF;
}

.table-tr-onchange1 {
	background-color: #fbefda;
}

.actionBtn {
	height: 25px;
	margin: 5px;
}
</style>
<script>
  function ev_onclick(values,names)
  { 
    resetAllHiddenColumn();
    var url = contextPath + '/portal/report/crossreport/runtime/detailreport.action';
    var nameArray = names.split(';');
    var valueArray = values.split('!!');
    for(var i = 0;i < nameArray.length-1;i++ )
    {
      document.getElementById(nameArray[i]).value = valueArray[i];  
 
    }
   
    document.forms[0].action = contextPath + '/portal/report/crossreport/runtime/detailreport.action';
    document.forms[0].submit();
  }
  
  function resetAllHiddenColumn()
 {
    var columns = document.getElementById("allcolumn").value;
    var nameArray = columns.split(';');
    for(var i = 0;i < nameArray.length-1;i++ )
    {
      document.getElementById(nameArray[i]).value = '';  
    }
 }
  function ev_export(){
    document.forms[0].action = contextPath + '/portal/report/crossreport/runtime/exportexcel.action';
    document.forms[0].submit();
  }

	function doQuery(){
		var application = document.getElementsByName("application")[0];
	   	if(!application){
		   	return;
		}
	   	OBPM.dialog.show({
			opener: window,
			width: 800,
			height: 400,
			url: contextPath +'/portal/report/crossreport/runtime/doSearchForm.action?reportId='+document.getElementById("reportId").value+'&application='+application.value,
			title: '{*[Query]*}',
			close: function(result) {
			   if (result == null || result == 'undefined') {

			   }else{
				   document.getElementById("valuesMap").value = jQuery.json2Str(result);//toJSON格式
				   document.forms[0].action=contextPath +'/portal/report/crossreport/runtime/runreport.action';
				   document.forms[0].target = "";
				   document.forms[0].submit();
			   }
			}
	   	});
	}
 
  
  function ev_onload()
  {
     //adjustDataIteratorSize();
     var _application = '<s:property value="params.getParameterAsString('application')"/>';
     if(_application != 'null' && _application != ''){
    	 document.getElementsByName("application")[0].value=_application;
     }
  }

function doPrint() {
	  document.getElementById("filter").value = "hidden";
	  document.forms[0].action=contextPath +'/portal/report/crossreport/runtime/runreportprint.action?showRowHead='+document.getElementById("showRowHead").checked;
	  document.forms[0].target = "_blank";
	  document.forms[0].submit();
}

jQuery(function(){
	ev_onload();
});
</script>
<link rel="stylesheet"
	href="<o:Url value='/resource/css/main-front.css'/>" type="text/css">
</head>
	<body class="body-front1" style="overflow:auto;">
		<div class="actionBtn">
			<% if(showSearchForm.equals("0")){ %>
				<span class='button-document'><a  title='{*[Query]*}' onclick="doQuery()"
					onmouseover='this.className="button-onchange"'
					onmouseout='this.className="button-document"'><span> <img
					style='border: 0px solid blue; vertical-align: middle;'
					src='<s:url value="/resource/imgv2/front/main/query.gif" />' />&nbsp;{*[Query]*}</span></a>
			    </span>
		    <%} %>
		    <span class='button-document'><a  title='{*[Query]*}' href='###' onclick="ev_export();return false;"
					onmouseover='this.className="button-onchange"'
					onmouseout='this.className="button-document"'><span> <img
					style='border: 0px solid blue; vertical-align: middle;'
					src='../../../../resource/imgv2/front/act/act_27.gif' />&nbsp;{*[Export]*} Excel</span></a>
			</span>
			<span class='button-document'><a
			 id='button_act' href='###' title='{*[Print]*}' onclick="doPrint();return false;"
				onmouseover='this.className="button-onchange"'
				onmouseout='this.className="button-document"'><span> <img
				style='border: 0px solid blue; vertical-align: middle;'
				src='../../../../resource/imgv2/front/act/act_25.gif' />&nbsp;{*[Print]*}</span></a>
				&nbsp;&nbsp;&nbsp;&nbsp;
				{*[Print]*}是否每行显示表头：<s:checkbox name="showRowHead" id="showRowHead" theme="simple" />
			</span>
		</div>
		<div id="container" style="width: 100%;">
			<s:form
				action="runreport" method="post" theme="simple" id="__formItem"
				validate="true">

				<%@include file="/common/list.jsp"%>
				<s:hidden name="reportId" id="reportId" value="%{#parameters.reportId}" />
				<s:hidden name="valuesMap" id="valuesMap"/>
				<s:hidden name="filter" id="filter"/>
				<%=chartstr%>
			</s:form>
		</div>
	</body>
</o:MultiLanguage>
</html>