<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css">
<script src="<s:url value="/script/list.js"/>"></script>
<title>{*[HomePage_List]*}</title>
</head>
<script type="text/javascript">
	function doDelete(){
		var listform = document.forms["homepageList"];
		if(isSelectedOne("_selects","{*[please.choose.one]*}")){
			listform.action='<s:url action="deleteHomepage"/>';
		   	listform.submit();
		}
	}
	
	function doNew(){
		var listform = document.forms["homepageList"];
		listform.action='<s:url action="newHomepage"/>';
		listform.submit();
	}
	function adjustDataIteratorSize() {
		var containerHeight = document.body.clientHeight-80;
		var container = document.getElementById("main");
		container.style.height = containerHeight + 'px';
	}
	jQuery(document).ready(function(){
		inittab();
		cssListTable();
		adjustDataIteratorSize();
		window.top.toThisHelpPage("application_info_generalTools_homePage_list");
	});
</script>
<body id="application_info_generalTools_homePage_list" class="body-back" onload="">
<s:form name="homepageList" action="queryHomepage" method="post" theme="simple">
	<s:textfield name="tab" cssStyle="display:none;" value="1" />
	<s:textfield name="selected" cssStyle="display:none;" value="%{'btnHomepage'}" />
	<%@include file="/common/list.jsp"%>
	<table cellpadding="0" cellspacing="0" width="100%">
		<tr class="nav-td" style="height: 27px;">
			<td rowspan="2"><div class="appsUsualIncludeTab"><%@include file="/common/commontab.jsp"%></div></td>
			<td class="nav-td" width="100%">&nbsp;</td>
		</tr>
		<tr class="nav-s-td">
			<td class="nav-s-td" align="right">
			<table width="100%" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" align="right">
						<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
						<button type="button" onclick="doNew()" class="button-image"><img
							src="<s:url value="/resource/imgnew/act/act_2.gif"></s:url>">{*[New]*}</button>
						<button type="button" class="button-image" onClick="doDelete()"><img
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
	 <div class="navigation_title">{*[HomePage]*}</div>
	 <div id="main" style="overflow-y:auto;overflow-x:hidden;"> 
	<div id="searchFormTable">
			<table class="table_noborder">
				<tr>
					<td class="head-text">
					{*[Name]*}:<input class="input-cmd" type="text" name="sm_name" value='<s:property value="#parameters['sm_name']"/>' size="30" />
					<input class="button-cmd" type="submit" value="{*[Query]*}" />
					<input class="button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll();" />
					</td>
				</tr>
			</table>
	</div>
	<div id="contentTable">
		<table class="table_noborder">
			<tr class="column-head">
				<td class="column-head2" width="30"><input type="checkbox"
					onclick="selectAll(this.checked)"></td>
				<td class="column-head">
					<o:OrderTag field="name" css="ordertag">{*[Name]*}</o:OrderTag>
				</td>
				<td class="column-head">
					<o:OrderTag field="creator" css="ordertag">{*[Creator]*}</o:OrderTag>
				</td>
				<td class="column-head">
					<o:OrderTag field="rolenames" css="ordertag">{*[Role]*}</o:OrderTag>
				</td>
				<td class="column-head">
					<o:OrderTag field="type" css="ordertag">{*[cn.myapps.core.user.create_type]*}</o:OrderTag>
				</td>
				<td class="column-head">
					<o:OrderTag field="published" css="ordertag">{*[cn.myapps.core.user.label.publish_or_not]*}</o:OrderTag>
				</td>
				
				<!-- td class="column-head">
					<o:OrderTag field="id" css="ordertag">{*[Id]*}</o:OrderTag>
				</td>
				<td class="column-head">
					<o:OrderTag field="applicationid" css="ordertag">{*[ApplicationId]*}</o:OrderTag>
				</td>
				<td class="column-head">
					<o:OrderTag field="userid"	css="ordertag">{*[UserId]*}</o:OrderTag>
				</td>
				<td class="column-head">
					<o:OrderTag field="templatestyle" css="ordertag">{*[TemplateStyle]*}</o:OrderTag>
				</td>
				<td class="column-head">
					<o:OrderTag field="templateelement" css="ordertag">{*[TemplateElement]*}</o:OrderTag>
				</td>
				<td class="column-head">
					<o:OrderTag field="name" css="ordertag">{*[Name]*}</o:OrderTag>
				</td>
				<td class="column-head">
					<o:OrderTag field="layout" css="ordertag">{*[Layout]*}</o:OrderTag>
				</td>
				<td class="column-head">
					<o:OrderTag field="description"	css="ordertag">{*[Description]*}</o:OrderTag>
				</td> -->
			</tr>
			<s:iterator value="datas.datas" status="index">
				<tr>
				<td class="table-td"><input type="checkbox" name="_selects"	value="<s:property value="id" />"></td>
				<td>
					<a href="<s:url action="editHomepage">
						<s:param name="_currpage" value="datas.pageNo" />
						<s:param name="_pagelines" value="datas.linesPerPage" />
						<s:param name="_rowcount" value="datas.rowCount" />
						<s:param name="application" value="#parameters.application" />
						<s:param name="s_module" value='#parameters.s_module'/>
						<s:param name="id" value="id"/>
						<s:param name="tab" value="1" />
						<s:param name="selected" value="%{'btnHomepage'}" />
						<s:param name="sm_name" value="#parameters.sm_name"/>
						</s:url>">{*[<s:property value="name" />]*}
					</a>
				</td>
				<td><s:property value="creator" /></td>
				<td>
				<s:if test="displayTo == 1">
					{*[All]*}
				</s:if>
				<s:else>
					<s:property value="roleNames" />
				</s:else>
				</td>
				<td>
				<s:if test="type == 1">					
					{*[Default]*}
				</s:if>
				<s:else>
					{*[Customize]*}
				</s:else>
				</td>
				<td>
				<s:if test="published == true">					
					{*[Yes]*}
				</s:if>
				<s:else>
					{*[No]*}
				</s:else>
				</td>
			</s:iterator>
		</table>
		<table class="table_noborder">
			<tr>
				<td align="right" class="pagenav"><o:PageNavigation
					dpName="datas" css="linktag" /></td>
			</tr>
		</table>
	</div>
	</div>
</s:form>
</body>
</o:MultiLanguage>
</html>
