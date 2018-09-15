<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>

<%String contextPath = request.getContextPath();%>
<html><o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.task.info]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<script src="<s:url value='/script/check.js'/>"></script>
<script src="<s:url value='/script/util.js'/>"></script>

<script>
	var contextPath = '<%=contextPath%>';
	jQuery(document).ready(function(){
		inittab();
	});
	function selectMappingConfig()
	{
	  var mcs = document.getElementsByName("_mappingconfigs");
	  var id;
		<s:iterator value="_mappingconfigs">
			 id ='<s:property value="id" />';
			 		  if (mcs != null ) {
			  for (var i=0; i<mcs.length; i++) {
			  
			         if(id==mcs[i].value){
			          mcs[i].checked = true;
	       			    }
				    }
			    }
		</s:iterator> 
	}
	
	function selectFirstTime() {
		var firstTime = selectDate(formItem.elements['content.runningTime'].value);
		formItem.elements['content.runningTime'].value = firstTime;
	}
	function ev_init() {
		/*var name  = document.getElementsByName('content.id');
		if (name != null && name != '') {
			document.getElementById('start');
			document.getElementById('stop');
		}
		*/
		selectMappingConfig();
		ev_dateShow();
		ev_typeShow();
		//adjustContentTable();
	}
	function ev_dateShow() {
	
		document.getElementById('dateTR').style.display = "none";
		document.getElementById('weekTR').style.display = "none";
		document.getElementById('monthTR').style.display = "none";
		document.getElementById('timeTR').style.display ="none";
		var reptype = document.getElementsByName('content.period')[0].value;
		if (reptype == 0) {
			document.getElementById('dateTR').style.display = '';
			document.getElementById('timeTR').style.display = '';
		} else if (reptype == 32) {
		    document.getElementById('timeTR').style.display = '';
			document.getElementById('weekTR').style.display = '';
		} else if (reptype == 512) {
			document.getElementById('monthTR').style.display = '';
			document.getElementById('timeTR').style.display = '';
		}else if(reptype == 2){
		    document.getElementById('timeTR').style.display = '';
		}
	}

	function ev_typeShow() {
		document.getElementById('con_tr').style.display = "none";
		document.getElementById('ret_tr').style.display = "none";
		
		var tasktype = document.getElementsByName('content.type')[0].value;
		//alert(tasktype);
		
		if (tasktype == 1) {
			document.getElementById('con_tr').style.display = "";
		} else if (tasktype == 16) {
			document.getElementById('ret_tr').style.display = "";
		}
	}

	function adjustContentTable() {
		var container = document.getElementById("container");
		var navigateTable = document.getElementById("navigateTable");
		var contentTable = document.getElementById("contentTable");
		var containerHeight = document.body.clientHeight;
		container.style.height = containerHeight + 'px';
		var contentTableHeight = containerHeight;
		if (navigateTable) {
			contentTableHeight = contentTableHeight - navigateTable.offsetHeight;
		}
		contentTable.style.height = contentTableHeight + 'px';
		contentTable.style.width = document.body.clientWidth + 'px';
		container.style.visibility = "visible";
	}
	
	jQuery(document).ready(function(){
		window.top.toThisHelpPage("application_module_task_info");
	});
	
</script>
<style>
#container,#navigateTable {overflow:hidden;}
</style>
</head>
<body id="application_module_task_info" class="body-back" onload="ev_init();">
<s:form id="formItem" theme="simple" action="save" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr style="height: 27px;">
			<td rowspan="2"><div class="appsUsualIncludeTab"><%@include file="/common/commontab.jsp"%></div></td>
			<td class="nav-td" width="100%">&nbsp;</td>
		</tr>
	<tr>
		<td height="27px;" valign="top" align="right">
	<table cellpadding="0" cellspacing="0" style="width:100%">
		<tr>
			<td class="nav-s-td" align="right">
			<table align="right" border=0 cellpadding="0" cellspacing="0">
				<tr>
				    <td id="start" style="display:none"  valign="top" >
					<button id="btnStart" type="button" class="button-image" disabled="disabled"
						onClick="forms[0].action='<s:url action="start"></s:url>';forms[0].submit();"><img
						src="<s:url value="/resource/imgnew/act/act_start.png"/>" >{*[Start]*}</button>
					</td>
					<td id="stop" style="display:none" valign="top">
					<button id="btnStop" type="button" class="button-image" disabled="disabled"
						onClick="forms[0].action='<s:url action="stop"></s:url>';forms[0].submit();"><img
						src="<s:url value="/resource/imgnew/act/act_stop.png"/>" >{*[Stopped]*}</button>
					</td>
				    <td valign="top">
					<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
					<button type="button" class="button-image"
							onClick="forms[0].action='<s:url action="saveAndNew"></s:url>';forms[0].submit();"><img
							src="<s:url value="/resource/imgnew/act/act_12.gif"/>">{*[Save&New]*}</button>
					<button type="button" class="button-image"
						onClick="forms[0].action='<s:url action="save"></s:url>';forms[0].submit();"><img
						src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
					<button type="button" class="button-image"
						onClick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();"><img
						src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	</td>
	</tr>
	</table>
	<div class="navigation_title">{*[Task]*}</div>
	<table width="100%">
	<tr>
		<td valign="top" align="left">
		<%@include file="/common/msg.jsp"%>
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<div id="contentMainDiv" style="overflow-y: auto; overflow-x: hidden; width:100%;">
		<%@include file="/common/page.jsp"%>
				<s:bean id="th" name="cn.myapps.core.task.action.TaskHelper" />
				<s:token name="content.token"/>
				<s:hidden name="sm_name" value="%{#parameters.sm_name}"/>
				<s:hidden name="tab" value="1" />
				<s:hidden name="selected" value="%{'btnTask'}" />
				<s:hidden id="runState" name="runState" value="%{runState}"/>
				<s:hidden name="content.totalRuntimes" />
				<s:hidden name="content.state" />
				<s:hidden name="content.applicationid" value="%{#parameters.application}"/>
				<s:hidden name="content.creatorid" value="%{#session.USER.id}" />
				<table width="100%" align="center" class="id1">
					<tr>
						<td class="commFont">{*[cn.myapps.core.task.name]*}:</td>
						
						<td class="commFont">{*[Creator]*}:</td>
					</tr>
					<tr>
						<td>
							<s:textfield size="20" cssClass="input-cmd" theme="simple" label="{*[cn.myapps.core.task.name]*}" name="content.name" />
						</td>
						<td>
							<s:textfield size="20" cssClass="input-cmd" theme="simple" label="{*[Creator]*}" name="content.creator" value="%{#session.USER.name}" readonly="true" />
						</td>
					</tr>
					<tr>
						<td class="commFont">{*[Type]*}:</td>
						<td class="commFont">{*[cn.myapps.core.task.startup_type]*}:</td>
					</tr>
					<tr>
						<td>
							<s:select cssClass="input-cmd" label="{*[Type]*}" theme="simple" name="content.type" list="_TASKTYPE" onchange="ev_typeShow()"/>
						</td>
						<td>
							<s:select cssClass="input-cmd" theme="simple" label="{*[cn.myapps.core.task.startup_type]*}" name="content.startupType" list="_STARTUPTYPE" />
						</td>
					</tr>
					<s:date id="modifyTime" name="content.modifyTime" format="yyyy-MM-dd HH:mm:ss" />
					<tr>
						<td class="commFont">{*[Repeats]*}:</td>
						<td class="commFont">{*[cn.myapps.core.task.modify_time]*}:</td>
					</tr>
					<tr>
						<td>
							<s:select theme="simple" cssClass="input-cmd" label="{*[Repeats]*}" name="content.period" list="_REAPETTYPE" onchange="ev_dateShow()"/>
						</td>
						<td>
							<s:textfield size="50" theme="simple" cssClass="input-cmd" label="{*[cn.myapps.core.task.modify_time]*}"
								name="content.modifyTime" value="%{modifyTime}" readonly="true" />
						</td>
					</tr>
					
					<tr>
						<td class="commFont">{*[Description]*}:</td>
						<td class="commFont">{*[cn.myapps.core.task.terminate_condition]*}:
							<button type="button" class="button-image" onclick="openIscriptEditor('content.terminateScript','{*[cn.myapps.core.task.script_editor]*}','{*[cn.myapps.core.task.terminate_condition]*}','content.name','{*[cn.myapps.core.task.save_success]*}');"><img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/></button>
						</td>
					</tr>
					<tr>
						<td>
							<s:textarea cssClass="input-cmd" theme="simple" label="{*[Description]*}" cols="40"
								name="content.description" rows="3" />
						</td>
						<td>
							<s:textarea cssClass="input-cmd" theme="simple" label="{*[cn.myapps.core.task.terminate_condition]*}"
								cols="40" name="content.terminateScript" rows="3" />
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" cellpadding="0" cellspacing="0" id="con_tr">
							<tr>
							<td class="commFont">{*[cn.myapps.core.task.content]*}:   
								<button type="button" class="button-image" onclick="openIscriptEditor('content.taskScript',
								'{*[cn.myapps.core.task.script_editor]*}','{*[cn.myapps.core.task.content]*}','content.name','{*[cn.myapps.core.task.save_success]*}');">
								<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/></button>
							</td>
							</tr>
							<tr>
							<td>
								<s:textarea cssClass="input-cmd" label="" cols="40" name="content.taskScript" rows="6" theme="simple"/>	
							</td>
							</tr>
						</table>
						</td>
						<td>
							<s:date id="rDate" name="content.runningTime" format="yyyy-MM-dd" />
				
							<s:date id="rTime" name="content.runningTime" format="HH:mm:ss" />
							
							<!-- ***************** Repeat type daily Or none  *************************-->
							<table width="100%" cellpadding="0" cellspacing="0" id="dateTR">
								<tr>
									<td class="commFont">{*[cn.myapps.core.task.label.running_time]*}:</td>
								</tr>
								<tr>
									<td> 
										<s:textfield cssClass="input-cmd" name="rDate" value="%{rDate}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" theme="simple"/>
									</td>
								</tr>
							</table>
							
							<!-- *****************Repeat type weekly *************************-->
							<table width="100%" cellpadding="0" cellspacing="0" id="weekTR">
								<tr>
									<td class="commFont"> {*[cn.myapps.core.task.running_on]*}: </td>
								</tr>
								<tr>
									<td>
										<SPAN style="width: 240px;"><s:checkboxlist name="_dayOfWeek" list="#th.dayOfWeekList" theme="simple"/></SPAN>
									</td>
								</tr>
							</table>
							<!-- *****************Repeat type monthly *************************-->
							<table width="100%" cellpadding="0" cellspacing="0" id="monthTR">
								<tr>
									<td class="commFont">{*[cn.myapps.core.task.running_date]*}:</td>
								</tr>
								<tr>
									<td>	
										<s:select name="content.dayOfMonth" cssClass="input-cmd" list="#th.dayOfMonthList" theme="simple"/>
									</td>
								</tr>
							</table>
							<table width="100%" cellpadding="0" cellspacing="0" id="timeTR">
								<tr id="timeTR" >
									<td class="commFont">
										<label class="label">{*[Time]*}:</label>
									</td>
								</tr>
								<tr>
									<td>
										   <s:textfield cssClass="input-cmd" name="rTime" value="%{rTime}" onfocus="WdatePicker({dateFmt:'HH:mm:ss'})" theme="simple"/>
									</td>
								</tr>
								<s:hidden name="content.runtimes" value="1" />
							</table>
							<table id="ret_tr" width="80%">
								<s:bean name="cn.myapps.core.dynaform.dts.exp.mappingconfig.action.MappingConfigHelper" id="mh"/>
								<tr>
								<!-- <td class="commFont commLabel">{*[Relative]*}{*[Table]*}:</td>
								<td><s:checkboxlist name="_mappingconfigs" list="#mh.get_allMappingConifgs(#parameters.application)" listKey="id" listValue="name" theme="simple" /></td>
							     -->
							     </tr>
							</table>
						</td>
					</tr>
				</table>
				
				 <s:if test="content.id != null && content.id != '' && content.startupType != 2">
				        <script>
				          document.getElementById('start').style.display = "";
				          document.getElementById('stop').style.display = "";
				          if(document.getElementById('runState').value == 0){
					          document.getElementById('btnStart').removeAttribute('disabled');
						  }else{
							  document.getElementById('btnStop').removeAttribute('disabled');
						  }
				        </script>
				 </s:if>
		</div>
	</td>
	</tr>
</table>
</s:form>
</body>
<script src='<s:url value="/script/datePicker/WdatePicker.js" />' ></script>
</o:MultiLanguage></html>
