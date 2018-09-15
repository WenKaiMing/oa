<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css">
<link rel="stylesheet" type="text/css" href='<s:url value="/resource/css/style.css" />' />
<title>{*[cn.myapps.core.expimp.module_list]*}</title>
<style type="text/css">
<!--
.cur-table { 
	width:100%; 
	}
-->
</style>
<script src="<s:url value='export.js'/>"></script>
<script>
	window.onload = function(){
		ev_download('<s:property value="filename" />');
	}
	
	function showRelating(trId) {
		var ele = document.getElementById(trId);
		
		if (ele.style.display == 'none') {
			ele.style.display = '';
		} else {
			ele.style.display = 'none';
		}
	}
	
</script>
</head>
<body leftmargin=0 rightmargin=0 topmargin=0 bottommargin=0>
<s:form name="formList" action="exp" method="post" theme="simple">

<%@include file="/common/list.jsp"%>
<table width="98%" class="list-table" >
		<tr class="list-toolbar">
			<td width="10" class="image-label"><img
				src="<s:url value="/resource/image/email2.jpg"/>" /></td>
			<td width="3"></td>
			<td width="120" class="text-label">{*[Elements]*}{*[List]*}</td>
			<td>
			<table width="100%" border=1 cellpadding="0" cellspacing="0" class="line-position" ><tr><td ></td>
				<td class="line-position2" width="60" valign="top">
				<button type="button" class="back-class" onClick="forms[0].action='<s:url action="step2exp"></s:url>';forms[0].submit();">
				<img src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[Export]*}</button>
				</td>
				<td class="line-position2" width="60" valign="top">
					<button type="button" class="back-class" onClick="forms[0].action='<s:url action="backToStep1"></s:url>';forms[0].submit();" >
					<img src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[Back]*}</button>
				</td>
			</tr></table>
			</td>
		</tr>
	</table>

<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<div id="loading" style="display:none">
	<div class="loading-indicator">Loading...</div>
</div>
<table width="100%" border="0">
<tr>
<td valign="top">
 <DIV style="overflow-x:hidden;OVERFLOW-y:auto;WIDTH:100%;HEIGHT:200;">
 <table class="cur-table">
	<tr class="column-head" scope="col">
   		<td class="column-head2" width="30"><input type="checkbox" onclick="selectAllByField(this.checked, 'expSelect.forms')"></td>
   		<td class="column-head">{*[Form]*}</td>
	</tr>
	
	<s:bean name="cn.myapps.core.expimp.exp.action.ExpHelper" id="eh">
		<s:param name="moduleid" value="#session.exportmoduleid" />
	</s:bean>
	<s:iterator value="#eh._formList" status="index">
		<s:if test="#index.odd == true">
				<tr class="table-text">
			</s:if>
			<s:else>
				<tr class="table-text2">
			</s:else>
	   	 
	   	 <td class="table-td">
  	 		<input id='fs<s:property value="#index.index" />' 
  	 			type="checkbox" name="expSelect.forms" 
  	 			value='<s:property value="id"/>' />
  	 	 </td>
		 
		 <td colspan="2"><s:property value="name"/></td>
	</s:iterator>
</table>
</DIV>  
</td>

<td valign="top">
<DIV style="overflow-x:hidden;OVERFLOW-y:auto;WIDTH:100%;HEIGHT:200;"> 
 <table class="cur-table">
	<tr class="column-head" scope="col">
   		<td class="column-head" width="28"><input type="checkbox" onclick="selectAllByField(this.checked, 'expSelect.views')"></td>
   		<td class="column-head" ><o:OrderTag field="name" css="ordertag">{*[View]*}</o:OrderTag></td>
	</tr>
	
	<s:iterator value="#eh._viewList" status="index">
		<s:if test="#index.odd == true">
				<tr class="table-text">
			</s:if>
			<s:else>
				<tr class="table-text2">
			</s:else>
	   	 
	   	 <td class="table-td">
  	 		<input type="checkbox" name="expSelect.views" value='<s:property value="id"/>'/>
  	 	 </td>
		 
		 <td colspan="2"><s:property value="name"/></td>
		 </tr>
	</s:iterator>
</table>
</DIV>
</td>

<td valign="top">
<DIV style="overflow-x:hidden;OVERFLOW-y:auto;WIDTH:100%;HEIGHT:200;"> 
 <table class="cur-table">
	<tr class="column-head" scope="col">
   		<td class="column-head2" width="30"><input type="checkbox" onclick="selectAllByField(this.checked, 'expSelect.workflows')"></td>
   		<td class="column-head" ><o:OrderTag field="name" css="ordertag">{*[Workflow]*}</o:OrderTag></td>
	</tr>
	
	<s:iterator value="#eh._flowList" status="index">
		<s:if test="#index.odd == true">
				<tr class="table-text">
			</s:if>
			<s:else>
				<tr class="table-text2">
			</s:else>
	   	 
	   	 <td class="table-td">
  	 		<input type="checkbox" name="expSelect.workflows" value='<s:property value="id"/>'/>
  	 	 </td>
		 
		 <td colspan="2"><s:property value="subject"/></td>
		 </tr>
	</s:iterator>
</table>
</DIV>
</td>
</tr>
<!------------------------------------------------ Task列表 ---------------------------------------------------------->
<tr>
<td valign="top">
 <DIV style="overflow-x:hidden;OVERFLOW-y:auto;WIDTH:100%;HEIGHT:200;">
 	<table class="cur-table">
	<tr class="column-head" scope="col">
   		<td class="column-head2" width="30">
   			<input type="checkbox" onclick="selectAllByField(this.checked, 'expSelect.tasks')">
   		</td>
   		<td class="column-head" >
   			<o:OrderTag field="name" css="ordertag">{*[Task]*}</o:OrderTag>
   		</td>
	</tr>
	
	<s:iterator value="#eh._taskList" status="index">
		<s:if test="#index.odd == true">
		<tr class="table-text">
		</s:if>
		<s:else>
		<tr class="table-text2">
		</s:else>
	   		<td class="table-td">
  	 			<input type="checkbox" name="expSelect.tasks" value='<s:property value="id"/>'/>
  	 	 	</td>
		 	<td colspan="2"><s:property value="name"/></td>
		</tr>
	</s:iterator>
	</table>
  </DIV>
</td>

<td valign="top">
 <DIV style="overflow-x:hidden;OVERFLOW-y:auto;WIDTH:100%;HEIGHT:200;">
 	<table class="cur-table">
	<tr class="column-head" scope="col">
   		<td class="column-head2" width="30">
   			<input type="checkbox" onclick="selectAllByField(this.checked, 'expSelect.crossReports')">
   		</td>
   		<td class="column-head" >
   			<o:OrderTag field="name" css="ordertag">{*[cn.myapps.core.report.crossreport.name]*}</o:OrderTag>
   		</td>
	</tr>
	
	<s:iterator value="#eh._crossReportList" status="index">
		<s:if test="#index.odd == true">
		<tr class="table-text">
		</s:if>
		<s:else>
		<tr class="table-text2">
		</s:else>
	   		<td class="table-td">
  	 			<input type="checkbox" name="expSelect.crossReports" value='<s:property value="id"/>'/>
  	 	 	</td>
		 	<td colspan="2"><s:property value="name"/></td>
		</tr>
	</s:iterator>
	</table>
  </DIV>
</td>
</tr>
</table>
</s:form>
</body>
</o:MultiLanguage></html>