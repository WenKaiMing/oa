<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="cn.myapps.core.resource.action.ResourceHelper" %>
<%@page import="cn.myapps.core.resource.ejb.ResourceVO"%>
<html><o:MultiLanguage>
<head>
<title>{*[Links]*}{*[List]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<script>
function ev_load(){
	if ('<s:property value="#parameters['refreshs']" />'=='true') {
		parent.frames[0].location.reload();
	}
}

function doDelete(){
	var listform = document.forms['formList'];
    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
    	listform.action='<s:url action="delete"/>';
    	listform.submit();
    }
}

jQuery(document).ready(function(){
	inittab();
	ev_load();
	cssListTable();
	window.top.toThisHelpPage("application_info_generalTools_links_list");
});

</script>
</head>
<body id="application_info_generalTools_links_list" class="body-back">
<s:form name="formList" theme="simple" action="list" method="post">
	<s:textfield cssStyle="display:none;" name="tab" value="1" />
	<s:textfield cssStyle="display:none;" name="selected" value="%{'btnLinks'}" />
	<%@include file="/common/list.jsp"%>
	<table cellpadding="0" cellspacing="0" width="100%">
		<tr class="nav-td" style="height:27px;">
			<td rowspan="2"><div class="appsUsualIncludeTab"><%@include file="/common/commontab.jsp"%></div></td>
			<td class="nav-td" width="100%">&nbsp;</td>
		</tr>
		<tr class="nav-s-td">
			<td class="nav-s-td" align="right">
				<table width="100%" border=0 cellpadding="0" cellspacing="0">
					<tr>
						<td valign="top" align="right">
							<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
							<button type="button" class="button-image" onClick="forms[0].action='<s:url action="new"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"></s:url>">{*[New]*}</button>
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
	<div id="searchFormTable">
			<table class="table_noborder">
				<tr><td class="head-text">
					{*[Name]*}:<input class="input-cmd" type="text" name="sm_name" value='<s:property value="#parameters['sm_name']"/>' size="30" />
					{*[Type]*}:<s:select name="s_type"   value="#parameters['s_type']" theme="simple" emptyOption="true" list="#{'00':'{*[Form]*}','01':'{*[View]*}','02':'{*[cn.myapps.core.dynaform.links.report]*}','03':'{*[cn.myapps.core.dynaform.links.excel_import]*}','05':'{*[cn.myapps.core.dynaform.links.customize_links_internal]*}','06':'{*[cn.myapps.core.dynaform.links.customize_links_External]*}','07':'{*[cn.myapps.core.dynaform.links.script_links]*}'}"/>
					<input class="button-cmd" type="submit" value="{*[Query]*}" />
					<input class="button-cmd" type="reset" value="{*[Reset]*}" onclick="resetAll();"/>
				</td></tr>
			</table>
	</div>
	<div id="contentTable">
	<table class="table_noborder">
		<tr>
			<td class="column-head2" scope="col"><input type="checkbox"
				onclick="selectAll(this.checked)"></td>
			<td class="column-head" scope="col"><o:OrderTag field="description" css="ordertag">{*[Name]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="type" css="ordertag">{*[Type]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="superior" css="ordertag">{*[Description]*}</o:OrderTag></td>
		</tr>

		<s:iterator value="datas.datas" status="index">
			<tr>
			<td class="table-td"><input type="checkbox" name="_selects"
				value="<s:property value="id" />"></td>
			<td ><a
				href="<s:url action="edit"><s:param name="id" value="id"/>
				<s:param name="_currpage" value="datas.pageNo" />
				<s:param name="_pagelines" value="datas.linesPerPage" />
				<s:param name="_rowcount" value="datas.rowCount" />
				<s:param name="application" value="#parameters.application" />
				<s:param name="tab" value="1" />
				<s:param name="selected" value="%{'btnLinks'}" />
				</s:url>">
			<s:property value="name" /></a></td>
			
			<td>
				<s:if test="type==0">{*[Form]*}</s:if>
				<s:elseif test="type==1">{*[View]*}</s:elseif>
				<s:elseif test="type==2">{*[cn.myapps.core.dynaform.links.report]*}</s:elseif>
				<s:elseif test="type==3">{*[cn.myapps.core.dynaform.links.excel_import]*}</s:elseif>
				<s:elseif test="type==4">{*[Action]*}</s:elseif>
				<s:elseif test="type==5">{*[cn.myapps.core.dynaform.links.customize_links_internal]*}</s:elseif>
				<s:elseif test="type==6">{*[cn.myapps.core.dynaform.links.customize_links_External]*}</s:elseif>
				<s:elseif test="type==7">{*[Script]*}</s:elseif>
				<s:elseif test="type==8">{*[cn.myapps.core.dynaform.links.script_links]*}</s:elseif>
			</td>
			<!-- description -->
			<td><s:property value="description" /></td>
			</tr>
		</s:iterator>
	</table>
	<table class="table_noborder">
		<tr>
			<td align="right" class="pagenav"><o:PageNavigation dpName="datas"
				css="linktag" /></td>
		</tr>
	</table>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>








