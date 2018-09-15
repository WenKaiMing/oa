<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<title>{*[Page_List]*}</title>

<script>
     wx = '600px';
	 wy = '400px';
function CreatePage(){
      var url="<s:url value='/core/page/new.action'><s:param name='_currpage' value='datas.pageNo' /><s:param name='_pagelines' value='datas.linesPerPage' /><s:param name='_rowcount' value='datas.rowCount' /><s:param name='s_module' value='#parameters.s_module'/><s:param name='s_application' value='#parameters.application'/><s:param name='application' value='#parameters.application'/></s:url>";
      //var id=showframe("{*[Page]*}",url);
	  OBPM.dialog.show({
				opener:window.parent,
				width: 600,
				height: 500,
				url: url,
				args: {},
				title: '{*[Create]*}{*[Page]*}',
				close: function(id) {
					var pageurl="<s:url action='edit'><s:param name='_currpage' value='datas.pageNo' /><s:param name='_pagelines' value='datas.linesPerPage' /><s:param name='_rowcount' value='datas.rowCount' /><s:param name='s_module' value='#parameters.s_module'/><s:param name='s_application' value='#parameters.application'/><s:param name='application' value='#parameters.application'/></s:url>";
				  	if(id!=null){
						pageurl += '&id=' +id;
						pageurl += '&tab=3&selected=btnPage';
						window.location.replace(pageurl);
				  	}
				}
		});
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
	window.top.toThisHelpPage("application_info_advancedTools_page_list");
});
</script>
</head>
<body id="application_info_advancedTools_page_list" style="margin: 0;padding: 0;">
<s:form name="formList" action="list" method="post" theme="simple">
	<input type="hidden" name="s_module"
		value="<s:property value='#parameters.s_module'/>">
	<%@include file="/common/list.jsp"%>
	<s:textfield name="tab" cssStyle="display:none;" value="3" />
	<s:textfield name="selected" cssStyle="display:none;" value="%{'btnPage'}" />
<table cellpadding="0" cellspacing="0" width="100%">
	<tr style="height:27px;">
			<td rowspan="2"><div style="width:500px"><%@include file="/common/commontab.jsp"%></div></td>
			<td class="nav-td" width="100%">&nbsp;</td>
	</tr>
	<tr>
		<td class="nav-s-td" align="right">
			<table width="100%" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" align="right">
						<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
						<button type="button" class="button-image" onClick="CreatePage()"><img src="<s:url value="/resource/imgnew/act/act_2.gif"></s:url>">{*[New]*}</button>
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
	<table border="0">
		<tr>
			<td></td>
			<td class="head-text">{*[Name]*}:</td>
			<td><input class="input-cmd" type="text" name="sm_name" value='<s:property value="#parameters['sm_name']"/>'
				size="30" /></td>
			<td><input class="button-cmd" type="submit" value="{*[Query]*}" /></td>
			<td><input class="button-cmd" type="button" value="{*[Reset]*}" onclick="resetAll();"/></td>
		</tr>
	</table>
	</div>
	<div id="contentTable">
		<table class="table_noborder">
			<tr>
				<td class="column-head2" scope="col"><input type="checkbox"
					onclick="selectAll(this.checked)"></td>
				<td class="column-head"><o:OrderTag field="name" css="ordertag">{*[Name]*}</o:OrderTag></td>
				<td class="column-head"><o:OrderTag field="type" css="ordertag">{*[Type]*}</o:OrderTag></td>
				<td class="column-head"><o:OrderTag field="discription"
					css="ordertag">{*[Description]*}</o:OrderTag></td>
			</tr>
			<s:iterator value="datas.datas" status="index">
				<tr>
				<td class="table-td"><input type="checkbox" name="_selects"
					value="<s:property value="id" />"></td>
				<td><a
					href="<s:url action="edit"><s:param name="_currpage" value="datas.pageNo" />
					<s:param name="_pagelines" value="datas.linesPerPage" />
					<s:param name="_rowcount" value="datas.rowCount" />
					<s:param name="s_application" value='#parameters.application'/>
					<s:param name="application" value='#parameters.application'/>
					<s:param name="s_module" value='#parameters.s_module'/>
					<s:param name="id" value="id"/>
					<s:param name="tab" value="3" />
					<s:param name="selected" value="%{'btnPage'}" />
					</s:url>">
					<s:property value="name" /> </a></td>
				<td>{*[<s:property value="typeName" />]*}</td>
				<td><s:property value="discription" /></td>
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
