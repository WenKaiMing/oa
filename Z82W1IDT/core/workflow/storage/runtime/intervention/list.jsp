<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<%@ page import="cn.myapps.core.workflow.storage.definition.action.BillDefiHelper" %>
<%@ page import="cn.myapps.util.StringUtil" %>
<%@ page import="cn.myapps.core.user.action.WebUser" %>

<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[log.operation.log]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css" />
<link rel="stylesheet" href="<s:url value='/resource/css/style.css' />" type="text/css" />
<script type="text/javascript" src="<s:url value="/script/datePicker/WdatePicker.js" />"></script>
<script type="text/javascript">
	var domainid = "<s:property value='#parameters.domain'/>";

	//流程监控查看流程信息
	function doProcess(id,application,title){
		var url =  contextPath + '/core/workflow/storage/runtime/intervention/view.action?id='+id+'&application='+application;
		
		OBPM.dialog.show({
				opener:window.parent,
				width: 600,
				height: 400,
				url: url,
				args: {},
				title: title,
				close: function(rtn) {
					if (rtn) {
						document.getElementsByName("nextNodeId")[0].value=rtn;
						document.forms[0].action = contextPath + '/core/workflow/storage/runtime/intervention/flow.action?id='+id;
						document.forms[0].submit();
					}
					
				}
		});
	}

	//流程监控查询
	function doQuery() {
		document.getElementsByName("_currpage")[0].value = 1;
		document.forms[0].submit();
	}
	
	//流程监控重置
	function clearForm(formName) {
	    var formObj = document.forms[formName];
	    var formEl = formObj.elements;
	    for (var i=0; i<formEl.length; i++)
	    {
	        var element = formEl[i];
	        if (element.type == 'submit') { continue; }
	        if (element.type == 'reset') { continue; }
	        if (element.type == 'button') { continue; }
	        if (element.type == 'hidden') { continue; }
	 
	        if (element.type == 'text') { element.value = ''; }
	        if (element.type == 'textarea') { element.value = ''; }
	        if (element.type == 'checkbox') { element.checked = false; }
	        if (element.type == 'radio') { element.checked = false; }
	        if (element.type == 'select-multiple') { element.selectedIndex = -1; }
	        if (element.type == 'select-one') { element.selectedIndex = -1; }
	    }
	}

	//流程监控与流程仪表盘的切换
	function ev_switchpage(id_no) {
		for(var i=1;i<3;i++) {
			if(i == id_no){
				document.getElementById("tab" + i).style.display = "";
				document.getElementById("span_tab"+i).className="btcaption-s-selected";
				showHelp(id_no);
				//jQuery("#_tabcount").attr("value", id_no);
			} else {
				document.getElementById("tab" + i).style.display = "none";
				document.getElementById("span_tab"+i).className="btcaption";
			}
		}
		if (id_no==2) {
			var url = "../../../analyzer/dashboard.jsp?domain=<s:property value='#parameters.domain'/>";
			if (jQuery("#dashboard").attr("src")=="")
				jQuery("#dashboard").attr("src", url);
		}
	}

	function showHelp(id_no){
		if(id_no == 1){
			window.top.toThisHelpPage("domain_workflowMonitor");
		}else if(id_no == 2){
			window.top.toThisHelpPage("domain_workflowPanel");
		}
	}

	jQuery(document).ready(function(){
		cssListTable();
		window.top.toThisHelpPage("domain_workflowMonitor");
		setContentTableSize();
	});
	function doDelete(){
		var listform = document.forms['formList'];
	    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
	    	listform.action='<s:url action="delete"></s:url>';
	    	listform.submit();
	    }
	}
	function setContentTableSize(){
		var frameH = jQuery('#frame', parent.document).height();
		jQuery("#contentTable").height(frameH - jQuery(".nav-s-td").height() - jQuery("#tableNoborder").height() - jQuery("#searchFormTable").height() - jQuery("#pagenavId").height()-30);
	}

	jQuery(window).resize(function(){
		setContentTableSize();
	});
</script>
</head>
<s:bean name="cn.myapps.core.deploy.application.action.ApplicationHelper" id="ih" />
<s:bean name="cn.myapps.core.logger.action.LogHelper" id="logHelper" />
<body id="domain_flowIntervention_list" class="listbody">
<div class="nav-s-td">
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			<td style="padding-left: 10px;">
				<div id="sec_tab1">
				<div class="listContent"><input type="button"
					id="span_tab1" name="spantab1" class=btcaption-s-selected
					onClick="ev_switchpage(1)" value="{*[core.workflow.storage.runtime.intervention.name]*}" />
				</div>
				<div class="listContent nav-seperate"><img
					src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
				</div>
				<div class="listContent"><input type="button"
					id="span_tab2" name="spantab2" class=btcaption
					onClick="ev_switchpage(2)" value="{*[core.workflow.storage.runtime.intervention.panel]*}" />
				</div>
				</div>
			</td>
		</tr>
	</table>
</div>
<div id="tab1">
<s:form name="formList" action="list" method="post" theme="simple">
	<s:hidden name="nextNodeId" />
	<table id="tableNoborder" class="table_noborder">
			<tr>
				<td >
					<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[core.workflow.storage.runtime.intervention.name]*}</div>
				</td>
				<td valign="top" align="right">
					<button type="button" class="button-image"
					onClick="doDelete()"><img
					src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
				</td>
			</tr>
	</table>
	<div id="main">	
		<%@include file="/common/basic.jsp" %>
		<%@include file="/common/msg.jsp"%>
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<div id="searchFormTable" class="justForHelp" title="{*[Search]*}">
			<table class="table_noborder">
				<tr><td>
				    <table border="0" width="100%">
				     	<tr>
				        	<td class="head-text">{*[core.workflow.storage.runtime.intervention.label.application_name]*}: 
				        	<td>
				        	<s:select name="application" 
									list="#ih.getMapByDomain(#parameters.domain)" theme="simple" /><span style="color: red;size: 4">*</span>
									</td>
									</td>
							<td class="head-text">		
				        		{*[core.workflow.storage.runtime.intervention.label.flow_name]*}: 
				        		<td>
				        		<input pid="searchFormTable" title="{*[cn.myapps.core.workflow.by_flow_name]*}" class="justForHelp input-cmd" type="text" name="_flowName" id="_flowName" value='<s:property value="params.getParameterAsString('_flowName')" />'/>
				        		</td> 
				        		</td>
				        	<td class="head-text">
				        		{*[core.workflow.storage.runtime.intervention.label.current_node]*}: <td> <input pid="searchFormTable" title="{*[cn.myapps.core.workflow.by_current_node]*}" class="justForHelp input-cmd" type="text" name="_stateLabel" id="sm_stateLabel" value='<s:property value="params.getParameterAsString('_stateLabel')" />'/>
				        		</td></td>
				        	<td class="head-text">
				        		{*[core.workflow.storage.runtime.intervention.initiator]*}: <td> <input pid="searchFormTable" title="{*[cn.myapps.core.workflow.by_initiator]*}" class="justForHelp input-cmd" type="text" name="_initiator" id="_initiator" value='<s:property value="params.getParameterAsString('_initiator')" />'/>
				        	</td></td>
				        </tr>
				        <tr class="head-text">
				        	<td class="head-text">
				        		{*[core.workflow.storage.runtime.intervention.firstProcessTime]*}:<td> <input pid="searchFormTable" title="{*[cn.myapps.core.workflow.by_date]*}" class="justForHelp input-cmd" style="width:170px;" type="text" name="_firstProcessTime"	id="_firstProcessTime" value='<s:property value="params.getParameterAsString('_firstProcessTime')" />' onfocus="WdatePicker({lang:'<s:property value="#logHelper.getWdatePickerLang(#session.USERLANGUAGE)" />'})" />
				        		</td></td>
				        	<td class="head-text">	
				        		{*[core.workflow.storage.runtime.intervention.lastAuditor]*}: <td> <input pid="searchFormTable" title="{*[cn.myapps.core.workflow.by_lastauditor]*}" class="justForHelp input-cmd" type="text" name="_lastAuditor" id="_lastAuditor" value='<s:property value="params.getParameterAsString('_lastAuditor')" />'/>
					    		</td></td>
					    	<td class="head-text">
					    		{*[core.workflow.storage.runtime.intervention.lastProcessTime]*}:<td> <input pid="searchFormTable" title="{*[cn.myapps.core.workflow.by_lastprocesstime]*}" class="justForHelp input-cmd" type="text" name="_lastProcessTime"	id="_lastProcessTime" value='<s:property value="params.getParameterAsString('_lastProcessTime')" />' onfocus="WdatePicker({lang:'<s:property value="#logHelper.getWdatePickerLang(#session.USERLANGUAGE)" />'})" />
					    		</td></td>
					    	<td class="head-text">
					    		{*[core.workflow.storage.runtime.intervention.summary]*}:<td><input pid="searchFormTable" title="{*[core.workflow.storage.runtime.intervention.summary]*}" class="justForHelp input-cmd" type="text" name="_summary" id="_summary" value='<s:property value="params.getParameterAsString('_summary')" />'>
					    	</td> 
					    	<td class="head-text">
					    		<td><input id="search_btn" pid="searchFormTable" title="{*[Query]*}" class="justForHelp button-cmd" type="button" onclick="doQuery();" value="{*[Query]*}" />
					    		&nbsp;&nbsp;<input id="reset_btn" pid="searchFormTable" title="{*[Reset]*}{*[Search]*}{*[Form]*}" class="justForHelp button-cmd" type="button" value="{*[Reset]*}"	onclick="clearForm('formList');" />
					    		<td>
					   		</td>
				      	</tr>
				    </table>
				</td></tr>
			</table>
		</div>
		
		<!-- 用户列表 -->
		<div id="contentTable" style="overflow: auto;">
			<table class="table_noborder" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="column-head2" scope="col"><input type="checkbox"
					onclick="selectAll(this.checked)"></td>
					<td class="column-head" scope="col">{*[core.workflow.storage.runtime.intervention.label.flow_name]*}</td>
					<td class="column-head" scope="col">{*[core.workflow.storage.runtime.intervention.label.current_node]*}</td>
					<td class="column-head" scope="col">{*[core.workflow.storage.runtime.intervention.initiator]*}</td>
					<td class="column-head" scope="col">{*[core.workflow.storage.runtime.intervention.firstProcessTime]*}</td>
					<td class="column-head" scope="col">{*[core.workflow.storage.runtime.intervention.lastAuditor]*}</td>
					<td class="column-head" scope="col">{*[core.workflow.storage.runtime.intervention.lastProcessTime]*}</td>
					<td class="column-head" scope="col">{*[core.workflow.storage.runtime.intervention.summary]*}</td>
				</tr>
				<s:iterator value="datas.datas" status="index" id="bean">
					<tr>
					<td class="table-td"><input type="checkbox" name="_selects" value="<s:property value="id"/>"></td>
					<td width="10%"><a href="javascript:doProcess('<s:property value='id'/>','<s:property value='application'/>','{*[Process]*}')"> <s:property value="flowName" /></a></td>
					<td width="10%"><a href="javascript:doProcess('<s:property value='id'/>','<s:property value='application'/>','{*[Process]*}')">  <s:property value="stateLabel" /></a></td>
					<td width="10%"><a href="javascript:doProcess('<s:property value='id'/>','<s:property value='application'/>','{*[Process]*}')"> <s:property value="initiator" /></a></td>
					<td width="15%"><a href="javascript:doProcess('<s:property value='id'/>','<s:property value='application'/>','{*[Process]*}')"> <s:date name="firstProcessTime" format="yyyy-MM-dd HH:mm:ss" /> </a></td>
					<td width="10%"><a href="javascript:doProcess('<s:property value='id'/>','<s:property value='application'/>','{*[Process]*}')">  <s:property value="lastAuditor" /></a></td>
					<td width="15%"><a href="javascript:doProcess('<s:property value='id'/>','<s:property value='application'/>','{*[Process]*}')">  <s:date name="lastProcessTime" format="yyyy-MM-dd HH:mm:ss" /></a></td>
					<td width="30%"><a href="javascript:doProcess('<s:property value='id'/>','<s:property value='application'/>','{*[Process]*}')">  <s:property value="summary" /></a></td>
					</tr>
				</s:iterator>
			</table>
		</div>
		<table id="pagenavId" class="table_noborder">
			<tr>
				<td align="right" class="pagenav"><o:PageNavigation dpName="datas"
					css="linktag" /></td>
			</tr>
		</table>
	</div>
</s:form>
</div>
<div id="tab2" style="display:none;">
	<table class="table_noborder">
			<tr>
				<td >
					<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[core.workflow.storage.runtime.intervention.panel]*}</div>
				</td>
			</tr>
	</table>
	<div id="main" style="overflow:auto;">
		<iframe id="dashboard" name="dashboard" scrolling="auto" style="overflow: auto; width: 100%;height:80%;" src="" frameborder="0" /></iframe>
	</div>
</div>
</body>
</o:MultiLanguage></html>