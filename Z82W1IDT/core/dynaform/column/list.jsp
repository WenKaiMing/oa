<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
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

#clientdiv {
	overflow-x: scroll;
	overflow-y: hidden;
	width:100%;
	height:40px;
}

</style>
<script language="JavaScript" type="text/javascript">
 	 wx = '600px';
	 wy = '500px';
	 function adjust_clientdivwidth() {
		var clientWidth = document.body.clientWidth-75;
		document.getElementById('clientdiv').style.width = clientWidth+"px";
	}
	function ev_load() {
	  adjust_clientdivwidth();
		if (formList.viewid.value=='') {
			document.getElementById('toolbar').style.display = 'none';
		}
	}
	function CreateColumn(){
      var url="<s:url value='new.action'><s:param name='_pagelines' value='datas.linesPerPage' /><s:param name="application" value="#parameters.application"/><s:param name='_rowcount' value='datas.rowCount' /><s:param name='id' value='id'/><s:param name='viewid' value='viewid'/><s:param name='moduleid' value='#parameters.moduleid'/></s:url>'>";

	   showframe("{*[Column]*}",url);
	   window.location=parent.document.getElementById("cloumnFrame").src;
	}
	function CreateColumns(){
      var url="<s:url value='newcolumns.action'><s:param name='_pagelines' value='datas.linesPerPage' /><s:param name="application" value="#parameters.application"/><s:param name='_rowcount' value='datas.rowCount' /><s:param name='id' value='id'/><s:param name='viewid' value='viewid'/><s:param name='moduleid' value='#parameters.moduleid'/></s:url>'>";
       wx = '450px';
	   wy = '520px';
	   showframe("{*[Column]*}",url);
	   window.location=parent.document.getElementById("cloumnFrame").src;
	}
	function EditColumn(url){
     
	   wx = '600px';
	   wy = '500px';
	   showframe("{*[Column]*}",url);
	   window.location=parent.document.getElementById("cloumnFrame").src;
	}
</script>
<title>{*[Column]*} {*[List]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
</head>
<body onload="ev_load()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<s:form name="formList" action="list" method="post">
<s:hidden name="viewid"/>
<s:hidden name="moduleid" value="%{#parameters.moduleid}"/>
<s:hidden name="s_view" value="%{#parameters.viewid}"/>
<s:hidden name="_orderby" value="orderno"/>
<%@include file="/common/list.jsp"%>
<table class="list-table" border="0" cellpadding="2" cellspacing="0"
		width="100%">
		<tr>
		   <td>
			<div id='clientdiv'> 
				<ul>
				   <s:iterator value="datas.datas" status="index">
			  	 	<li>
			  	 	<input type="checkbox" name="_selects" value='<s:property value="id"/>'/>
			  	 	         <a href='<s:url value="changeOrder.action">
			  	 					<s:param name="id" value="id"/>
			  	 					<s:param name="viewid" value="viewid"/>
			  	 					<s:param name="flag" value="'previous'"/>
			  	 					<s:param name="_orderby" value="'orderno'"/>
			  	 					<s:param name="application" value="#parameters.application"/>
					  	 					<s:param name="s_module" value="#parameters.s_module"/>
					  	 					<s:param name="s_view" value="viewid"/>
					  	 				 </s:url>'><img border=0 SRC="<s:url value='/resource/imgnew/leftStep.gif'></s:url>"  ></a>
					  	 			<a href='javascript:EditColumn("<s:url value='edit.action'><s:param name='id' value='id'/><s:param name="application" value="#parameters.application"/><s:param name='viewid' value='viewid'/><s:param name='moduleid' value='#parameters.moduleid'/></s:url>")' style="cursor:hand">
					  	 		     <s:property value="name"/></a>
					  	 				 <a href='<s:url value="changeOrder.action">
					  	 					<s:param name="id" value="id"/>
					  	 					<s:param name="viewid" value="viewid"/>
			  	 					<s:param name="flag" value="'next'"/>
			  	 					<s:param name="_orderby" value="'orderno'"/>
			  	 					<s:param name="application" value="#parameters.application"/>
			  	 					<s:param name="s_module" value="#parameters.s_module"/>
			  	 					<s:param name="s_view" value="viewid"/>
			  	 				 </s:url>'><img border=0 SRC="<s:url value='/resource/imgnew/rightStep.gif'></s:url>"></a>
			  	 		</li>
			       </s:iterator>
			       </ul>
                            </div>
               </td>
			<td width="75">
			  
			   <button type="button" class="workflow1-image" onClick="CreateColumn()" ><img border=0 SRC="<s:url  value='/resource/imgnew/act/act_2.gif'></s:url>"  alt="{*[Create]*} {*[Column]*}"></button>
			   	<button type="button" class="workflow1-image" onClick="CreateColumns()" ><img border=0 SRC="<s:url  value='/resource/imgnew/act/act_2.gif'></s:url>"  alt="{*[Create]*} {*[Columns]*} {*[Guide]*}"></button>
			   	<button type="button" class="workflow1-image" onClick="forms[0].action='<s:url action="delete"></s:url>';forms[0].submit();"  ><img border=0 SRC="<s:url value='/resource/imgnew/act/act_3.gif'></s:url>" alt="{*[Remove]*} {*[Column]*}"></button>		
			</td>		
		</tr>
</table>
</body>
</s:form>
</o:MultiLanguage></html>