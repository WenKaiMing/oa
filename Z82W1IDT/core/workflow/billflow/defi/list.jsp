<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%String contextPath = request.getContextPath();%>
<html><o:MultiLanguage>
<head>
<head>
<title>{*[cn.myapps.core.workflow.list]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<script src="<s:url value="/script/list.js"/>"></script>
<script type="text/javascript">
function CopyFlow(){
	  var listform = document.forms['formList'];
	    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
	    	listform.action='<s:url action="copy"/>';
	    	listform.submit();
	    }
}

function doDelete(){
	var listform = document.forms['formList'];
    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
    	listform.action='<s:url action="delete"/>';
    	listform.submit();
    }
}

function adjustDataIteratorSize() {
	var containerHeight = document.body.clientHeight-70;
	var container = document.getElementById("main");
	container.style.height = containerHeight + 'px';
}

	jQuery(document).ready(function(){
		window.onload();
		cssListTable();
		adjustDataIteratorSize();
		window.top.toThisHelpPage("application_module_workflows_list");
	});
</script>
</head>
<body id="application_module_workflows_list" class="body-back">
<s:form name="formList" action="list" method="post" theme="simple">
<%@include file="/common/list.jsp"%>	
<input type="hidden" name="s_module" value="<s:property value='#parameters.s_module'/>">
<input type="hidden" name="ISEDIT" value="TRUE">
	<table cellpadding="0" cellspacing="0" style="width:100%">
		<tr>
			<td class="nav-s-td">{*[cn.myapps.core.workflow.list]*}</td>
			<td class="nav-s-td" align="right">
			<table width="180" align="right" border=0 cellpadding="0" cellspacing="0">
				<tr>
					
				<td width="60" valign="top">
					<button type="button" class="button-image" onClick="CopyFlow()"><img src="<s:url value="/resource/imgnew/act/act_4.gif"></s:url>">{*[Copy]*}</button>
				</td>
					<td valign="top">
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
<div id="main" style="overflow-y: auto; overflow-x: hidden;">
	<div id="searchFormTable">
		<table width="100%">
			<tr>
				<td class="head-text">
				{*[Name]*}:
				<input class="input-cmd" type="text" name="sm_subject"
					value='<s:property value="#parameters['sm_subject']"/>' size="10" />
				<input class="button-cmd" type="submit"  value="{*[Query]*}" />
				<input class="button-cmd" type="button" value="{*[Reset]*}"
					onclick="resetQuery('sm_subject')" />
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
			<td class="column-head" ><o:OrderTag field="subject" css="ordertag">{*[Name]*}</o:OrderTag></td>
		</tr>
		<s:iterator value="datas.datas" status="index">
			<tr>
				<td class="table-td"><input type="checkbox" name="_selects"
					value="<s:property value="id" />"></td>
				<td><a
					href="<s:url action="edit">
							<s:param name="id" value="id"/>
							<s:param name="_currpage" value="datas.pageNo" />
				            <s:param name="_pagelines" value="datas.linesPerPage" />
				            <s:param name="_rowcount" value="datas.rowCount" />
						    <s:param name="ISEDIT" value="'TRUE'"/>
						    <s:param name="s_module" value='#parameters.s_module'/>
						    <s:param name="application" value="#parameters.application" />
						    <s:param name="sm_subject" value="#parameters.sm_subject"/>
						  </s:url>">
				<s:property value="subject" /></a></td>
			</tr>
		</s:iterator>
	</table>

	<table class="table_noborder">
		<tr>
			<td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag" /></td>
		</tr>
	</table>
</div>
</div>
</s:form>
</body>
</o:MultiLanguage></html>
