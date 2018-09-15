<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page import="cn.myapps.core.task.action.TaskHelper"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<script type="text/javascript">
function doDelete(){
	var listform = document.forms['formList'];
    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
    	listform.action='<s:url action="delete"/>';
    	listform.submit();
    }
}

function adjustDataIteratorSize() {
	var containerHeight = document.body.clientHeight-50;
	var container = document.getElementById("main");
	container.style.height = containerHeight + 'px';
}

	jQuery(document).ready(function(){
		//window.onload(); 
		inittab();
		cssListTable();
		adjustDataIteratorSize();
		window.top.toThisHelpPage("application_module_task_list");
	});
</script>
<title>{*[cn.myapps.core.task.list]*}</title>
</head>
<body id="application_module_task_list" class="body-back">
<s:form id="formList" name="formList" action="list" theme="simple" method="post">
<%@include file="/common/list.jsp"%>
<s:hidden name="tab" value="1" />
<s:hidden name="selected" value="%{'btnTask'}" />
<table cellpadding="0" cellspacing="0" style="width:100%">
	<tr style="height: 27px;">
		<td rowspan="2"><div class="appsUsualIncludeTab"><%@include file="/common/commontab.jsp"%></div></td>
		<td class="nav-td" width="100%">&nbsp;</td>
	</tr>
	<tr>
		<td class="nav-s-td" align="right">
		<table width="120" align="right" border=0 cellpadding="0" cellspacing="0">
		
			<tr>
				<td width="60" valign="top">
					<button type="button" class="button-image" onClick="forms[0].action='<s:url action="new"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"></s:url>">{*[New]*}</button>
				</td>
				<td valign="top">
					<button type="button" class="button-image" onClick="doDelete()"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<div id="main" style="overflow-y:auto;overflow-x:hidden;">
<div class="navigation_title">{*[Task]*}</div>
	<div id="searchFormTable">
	<table width="100%">
		<tr>
			<td class="head-text">
			{*[Name]*}:
			<input class="input-cmd" type="text" name="sm_name"
				value='<s:property value="#parameters['sm_name']"/>' size="10" />
			<input class="button-cmd" type="submit"  value="{*[Query]*}" />
			<input class="button-cmd" type="button" value="{*[Reset]*}"
				onclick="resetQuery()" />
			</td>
			<td align="right">
				&nbsp;
			</td>
		</tr>
	</table>
	</div>
	<div id="contentTable">
	 <table class="table_noborder">
	   	<tr>
	   		<td class="column-head2" scope="col"><input type="checkbox" onclick="selectAll(this.checked)"></td>
	   		<td class="column-head"><o:OrderTag field="name" css="ordertag">{*[Name]*}</o:OrderTag></td>
			<td class="column-head"><o:OrderTag field="creator" css="ordertag">{*[Creator]*}</o:OrderTag></td>
			<td class="column-head"><o:OrderTag field="period" css="ordertag">{*[Period]*}</o:OrderTag></td>
			<td class="column-head" width="20%"><o:OrderTag field="modifyTime" css="ordertag">{*[cn.myapps.core.task.modify_time]*}</o:OrderTag></td>
			<td class="column-head"><o:OrderTag field="totalRuntimes" css="ordertag">{*[cn.myapps.core.task.runtimes]*}</o:OrderTag></td>
			<td class="column-head"><o:OrderTag field="startupType" css="ordertag">{*[cn.myapps.core.task.startup_type]*}</o:OrderTag></td>
			<td class="column-head"><o:OrderTag field="state" css="ordertag">{*[State]*}</o:OrderTag></td>
		</tr> 
		<s:iterator value="datas.datas" status="index">
			<tr>
		   	 	<td class="table-td">
	  	 		<input type="checkbox" name="_selects" value='<s:property value="id"/>'/></td>
	  	 		<td><a href='<s:url value="edit.action">
	  	 					<s:param name="id" value="id"/>
	  	 					<s:param name="_currpage" value="datas.pageNo" />
							<s:param name="_pagelines" value="datas.linesPerPage" />
							<s:param name="_rowcount" value="datas.rowCount" />
	  	 					<s:param name="s_module" value="#parameters.s_module" />
	  	 					<s:param name="application" value='#parameters.application'/>
	  	 					<s:param name="tab" value="1" />
						    <s:param name="selected" value="%{'btnTask'}" />
	  	 					<s:param name="sm_name" value="#parameters.sm_name"/>
	  	 				 </s:url>'>
	  	 			<s:property value="name" />
	  	 		</a></td>
	 			<td><a href='<s:url value="edit.action">
	  	 					<s:param name="id" value="id"/>
	  	 					<s:param name="_currpage" value="datas.pageNo" />
							<s:param name="_pagelines" value="datas.linesPerPage" />
							<s:param name="_rowcount" value="datas.rowCount" />
	  	 					<s:param name="s_module" value="#parameters.s_module" />
	  	 					<s:param name="application" value='#parameters.application'/>
	  	 					<s:param name="tab" value="1" />
						    <s:param name="selected" value="%{'btnTask'}" />
	  	 					<s:param name="sm_name" value="#parameters.sm_name"/>
	  	 				 </s:url>'>
	 				<s:property value="creator" /></a>
	 			</td>
	 			<td> 
	 				<%= TaskHelper.getPeriodName(request.getAttribute("period"))%>
	 			</td>
	 			<td nowrap>
	 				<s:date name="modifyTime" format="yyyy-MM-dd HH:mm:ss" />
	 			</td>
	 			<td>
	 				<s:property value="totalRuntimes" />
	 			</td>
	 			<td>
	 				<% 
	 					TaskHelper th = new TaskHelper();
	 					Integer startupType = (Integer) request.getAttribute("startupType");
	 					out.println(th.getStartupName(startupType.intValue()));
	 				%>
	 			</td>
	 			<td>
	 				{*[<%= TaskHelper.getStateName((String) request.getAttribute("id"))%>]*}
	 			</td>
	 		</tr>
	    </s:iterator>
	</table>
	<table class="table_noborder">
	  <tr>
	    <td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag"/></td>
	  </tr>
	</table>
</div>
</div>
</s:form>
</body>
</o:MultiLanguage></html>