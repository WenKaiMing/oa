<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper" id="mh" />
<s:bean name="cn.myapps.core.homepage.action.ReminderHelper" id="helper" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css">
<script src="<s:url value="/script/list.js"/>"></script>
<title>{*[Reminder]*}{List}</title>
	<s:url action="new" id="doNewURL">
		<s:param name="s_homepage" value="#parameters.s_homepage" />
		<s:param name="application" value="#parameters.application" />
		<s:param name="_currpage" value="datas.pageNo" />
		<s:param name="_pagelines" value="datas.linesPerPage" />
		<s:param name="_rowcount" value="datas.rowCount" />
	</s:url>
<script>
function doNew() {
	var newURL = '<s:property value="#doNewURL" escape="false"/>';
	//showframe("Reminder",  newURL);
	document.forms[0].action=newURL;
	document.forms[0].submit();
}

function doDelete(){
	var listform = document.forms['formList'];
    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
    	listform.action='<s:url action="delete"/>';
    	listform.submit();
    }
}

	jQuery(document).ready(function(){
		cssListTable();
		inittab();
		window.top.toThisHelpPage("application_info_generalTools_reminder_list");
	});

</script>
</head>
<body id="application_info_generalTools_reminder_list" class="body-back">
<s:form name="formList" action="list" method="post" theme="simple">
	<%@include file="/common/list.jsp"%>
	<s:hidden name="s_homepage" value="%{#parameters.s_homepage}" />	
	<s:textfield name="tab" cssStyle="display:none;" value="1" />
	<s:textfield name="selected" cssStyle="display:none;" value="%{'btnReminder'}" />	
	<table cellpadding="0" cellspacing="0" width="100%">
		<tr  class="nav-td" style="height:27px;">
			<td rowspan="2"><div class="appsUsualIncludeTab"><%@include file="/common/commontab.jsp"%></div></td>
			<td class="nav-td" width="100%">&nbsp;</td>
		</tr>
		<tr class="nav-s-td">
			<td class="nav-s-td" align="right">
				<table width="100%" border=0 cellpadding="0" cellspacing="0">
					<tr>
						<td valign="top" align="right">
							<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
							<button type="button" class="button-image"
								onClick="forms[0].action='<s:url action="new"/>';forms[0].submit();"><img
								src="<s:url value="/resource/imgnew/act/act_2.gif"></s:url>">{*[New]*}</button>
							<button type="button" class="button-image"
								onClick="doDelete()"><img
								src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
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
	<div id="searchFormTable">
			<table class="table_noborder">
				<tr><td class="head-text">
					{*[Name]*}:<input class="input-cmd" type="text" name="sm_title" value='<s:property value="#parameters['sm_title']"/>' size="30" />
					<input class="button-cmd" type="submit" value="{*[Query]*}" />
					<input class="button-cmd" type="button" value="{*[Reset]*}" onclick="resetAll();"/>
				<tr><td>
			</table>
	</div>
	<div id="contentTable">
		<table class="table_noborder">
			<tr>
				<td class="column-head2" scope="col"><input type="checkbox"
					onclick="selectAll(this.checked)"></td>
				<td class="column-head"><o:OrderTag field="name" css="ordertag">{*[Title]*}</o:OrderTag></td>
				<td class="column-head"><o:OrderTag field="summayFiledNames"
					css="ordertag">{*[To_Summary_Fields]*}</o:OrderTag></td>
			</tr>
			<s:iterator value="datas.datas" status="index" id="reminder">
				<tr>
				<td class="table-td"><input type="checkbox" name="_selects"
					value="<s:property value="id" />"></td>
				<td><a
					href="<s:url action="edit"><s:param name="_currpage" value="datas.pageNo" />
				<s:param name="_pagelines" value="datas.linesPerPage" />
				<s:param name="_rowcount" value="datas.rowCount" />
				<s:param name="application" value="#parameters.application" />
				<s:param name="s_module" value='#parameters.s_module'/>
				<s:param name="id" value="id"/>
				<s:param name="tab" value="1"/>
				<s:param name="selected" value="%{'btnReminder'}"/>
				</s:url>">
				<s:property value="title" /> </a></td>
				<td><s:property value="#helper.getDisplayFileds(#reminder)" /></td>
				</tr>
			</s:iterator>
		</table>
		<table class="table_noborder">
			<tr>
				<td align="right" class="pagenav"><o:PageNavigation
					dpName="datas" css="linktag" /></td>
			</tr>
		</table>
	</div>
</s:form>
</body>
</o:MultiLanguage>
</html>
