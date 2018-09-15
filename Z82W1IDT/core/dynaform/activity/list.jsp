<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
ul li{
	margin-right: 5px;
	display: inline;
}

ul {
	margin-left:0px;
	padding-left:0px;
}

#activitydiv {
	overflow-x: scroll;
	overflow-y: hidden;
	width:100%;
	height:40px;
}

</style>
<title>activity list</title>
<%
String contextPath = request.getContextPath();
%>

<script language="JavaScript" type="text/javascript">
  	 wx = '600px';
	 wy = '500px';
	 
	function adjust_clientdivwidth() {
		var clientWidth = document.body.clientWidth - 50;
		document.getElementById("activitydiv").style.width = clientWidth+"px";
	}
	
	function ev_load() {
		
		//adjust_clientdivwidth();
		
		<% 
		String parentType=request.getParameter("parentType");
		if (parentType!=null && parentType.equals("FORM")) {
		%>
			if(formList._formid.value=='') {
				document.getElementById('toolbar').style.display = 'none';
			}
		<%
		} else if (parentType!=null && parentType.equals("VIEW")) {
		%>
			if (formList._viewid.value=='') {
				document.getElementById('toolbar').style.display = 'none';
			}
		<%}%>
	
	}

	function CreateActivity(){
      var url="<s:url value='new.action'><s:param name='id' value='id'/><s:param name='application' value='#parameters.application'/><s:param name='s_module' value='#parameters.s_module'/><s:param name='_viewid' value='_viewid'/><s:param name='_formid' value='_formid'/><s:param name='_currpage' value='datas.pageNo'/><s:param name='_pagelines' value='datas.linesPerPage' /><s:param name='_rowcount' value='datas.rowCount' /></s:url>";
	   showframe("Activity",url);
	  window.location=parent.document.getElementById("activityFrame").src;
	}
	function EditActivity(url){
     

	   wx = '600px';
	   wy = '500px';
	   showframe("Activity",url);
	   window.location=parent.document.getElementById("activityFrame").src;
	}
</script>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
</head>
<body onload="ev_load()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<s:form name="formList" action="list" method="post">

<%@include file="/common/list.jsp"%>	
	<s:hidden name="_viewid" />
	<s:hidden name="_formid" />
	<input type="hidden" name="s_module" value="<s:property value='#parameters.s_module'/>">
	<input type="hidden" name="moduleid" value="<s:property value='#parameters.s_module'/>">
	<input type="hidden" name="_orderby" value="orderno"/>
	
	<table class="list-table" border="0" cellpadding="2" cellspacing="0" width="100%"> 
		<tr>
			<td>
		  		<!-- vinsun -->
		  		<div id='activitydiv'>
		  		<ul>
			    		<s:iterator value="datas.datas" status="index">       
				  		<li style="white-space: nowrap">
				  			<input type="checkbox" name="_selects" value='<s:property value="id"/>' />
							<a href='<s:url value="changeOrder.action"><s:param name="id" value="id"/><s:param name="_currpage" value="datas.pageNo" /><s:param name="_pagelines" value="datas.linesPerPage" /><s:param name="_rowcount" value="datas.rowCount" /><s:param name="_viewid" value="_viewid"/><s:param name="_formid" value="_formid"/><s:param name="flag" value="'previous'"/><s:param name="_orderby" value="'orderno'"/><s:param name="s_module" value="#parameters.s_module"/><s:param name="application" value="#parameters.application"/></s:url>'>
					  			<img border=0 src="<s:url value='/resource/imgnew/leftStep.gif' />" />
					  		</a>
							<a href='javascript:EditActivity("<s:url value='edit.action'><s:param name='id' value='id'/><s:param name='application' value='#parameters.application'/><s:param name='s_module' value='#parameters.s_module'/><s:param name='_viewid' value='_viewid'/><s:param name='_formid' value='_formid'/><s:param name='_currpage' value='datas.pageNo'/><s:param name='_pagelines' value='datas.linesPerPage' /><s:param name='_rowcount' value='datas.rowCount' /></s:url>")' style="cursor:hand">
								<s:property value="name" />
							</a>
							<a href='<s:url value="changeOrder.action"><s:param name="_currpage" value="datas.pageNo" /><s:param name="_pagelines" value="datas.linesPerPage" /><s:param name="_rowcount" value="datas.rowCount" /><s:param name="id" value="id"/><s:param name="_viewid" value="_viewid"/><s:param name="_formid" value="_formid"/><s:param name="flag" value="'next'"/><s:param name="_orderby" value="'orderno'"/><s:param name="s_module" value="#parameters.s_module"/><s:param name="application" value="#parameters.application"/></s:url>'>
							    <img border=0 src="<s:url value='/resource/imgnew/rightStep.gif' />" />
							</a>
						</li>
						</s:iterator>
				</ul>
				</div>	
			</td>
			<td width="50">
				<button type="button" class="workflow1-image" onClick="CreateActivity()" >
					<img border=0 SRC="<s:url  value='/resource/imgnew/act/act_2.gif'></s:url>"  alt="{*[cn.myapps.core.dynaform.activity.create_activity_button]*}">
				</button>
				<button type="button" class="workflow1-image" onClick="forms[0].action='<s:url action="delete"></s:url>';forms[0].submit();"  >
					<img border=0 SRC="<s:url value='/resource/imgnew/act/act_3.gif'></s:url>" alt="{*[cn.myapps.core.dynaform.activity.remove_activity_button]*}">
				</button>
			</td>	
		</tr>
	</table>
</s:form>
</body>
</o:MultiLanguage></html>
