<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<o:MultiLanguage>
	<head>
	<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>"
		type="text/css">
	<title>{*[cn.myapps.core.role.role_list]*}</title>
	<script src="<s:url value="/script/list.js"/>"></script>
	<script type="text/javascript">
function doDelete(){
	var listform = document.forms['formList'];
    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
    	listform.action='<s:url action="delete"/>';
    	listform.submit();
    }
}
function doList(){
	var listform = document.forms['formList'];
	if ('<s:property value="datas.pageNo" />'!='1') {
	    document.getElementsByName("_currpage")[0].value=1;
    	listform.action='<s:url action="list"></s:url>';
    	listform.submit();
	}else{
	listform.action='<s:url action="list"/>';
	listform.submit();}
    
}

function adjustDataIteratorSize() {
	var containerHeight = document.body.clientHeight-50;
	var container = document.getElementById("main");
	container.style.height = containerHeight + 'px';
}

jQuery(document).ready(function(){
	inittab();
	cssListTable();
	adjustDataIteratorSize();
	window.top.toThisHelpPage("application_info_generalTools_role_list");
});

//批量资源授权
function configureResources(){
	var myDate=new Date().toString();
	// 写死type参数测试
	var url = '<s:url value="/core/permission/batchGrant.jsp"></s:url>?applicationid=<s:property value="#parameters.application" />';
	wy = '200px';
	wx = '200px';
	OBPM.dialog.show({
			opener:window.parent,
			width: 1000,
			height: 520,
			url: url,
			args: {},
			title: '{*[cn.myapps.core.role.group_resources]*}',
			close: function(rtn) {
				window.top.toThisHelpPage("application_info_generalTools_role_list");
			}
	});
}

</script>
</head>
<body id="application_info_generalTools_role_list" class="body-back">
<s:actionerror /> 
<s:form theme="simple" id="formList" name="formList" action="list" method="post">
	<%@include file="/common/list.jsp"%>
	<s:textfield name="tab" cssStyle="display:none;" value="1" />
	<s:textfield name="selected" cssStyle="display:none;" value="%{'btnRole'}" />
	<table cellpadding="0" cellspacing="0" width="100%">
		<tr style="height: 27px;">
			<td rowspan="2"><div class="appsUsualIncludeTab"><%@include file="/common/commontab.jsp"%></div></td>
			<td class="nav-td" width="100%">&nbsp;</td>
		</tr>
		<tr class="nav-s-td">
			<td class="nav-s-td" align="right">
				<table width="100%" border=0 cellpadding="0" cellspacing="0">
					<tr>
						<td valign="top" align="right">
							<button type="button" class="button-image"
								onClick="configureResources();"><img
								src="<s:url value="/resource/imgnew/act/plugin.png"/>" border=0>{*[cn.myapps.core.role.group_authorize]*}</button>
							<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
							<button type="button" class="button-image"
								onClick="forms[0].action='<s:url action="new"></s:url>';forms[0].submit();"><img
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
		<div id="main" style="overflow-y:auto;overflow-x:hidden;"> 
	<div class="navigation_title">{*[Role]*}</div>
	<div id="searchFormTable" class="justForHelp" title="{*[cn.myapps.core.role.search_role]*}">
		<table class="table_noborder">
			<tr>
			<td class="head-text">
				{*[Name]*}:<input class="input-cmd" type="text" name="sm_name" value='<s:property value="#parameters['sm_name']" />' size="10" />
				<input class="button-cmd" type="button" onclick="doList()" value="{*[Query]*}" />
				<input class="button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll()" />
			</td></tr>
		</table>
	</div>
	<div id="contentTable" class="listbody">
		<table class="table_noborder">
			<tr>
				<td class="column-head2"><input type="checkbox"
					onclick="selectAll(this.checked)"></td>
				<td class="column-head" scope="col"><o:OrderTag field="name"
					css="ordertag">{*[Name]*}</o:OrderTag></td>
			</tr>
			<s:iterator value="datas.datas" status="index">
				<tr>
				<td class="table-td"><input type="checkbox" name="_selects"
					value="<s:property value="id"/>"></td>
				<td><a
					href='<s:url action="edit">
				<s:param name="_currpage" value="datas.pageNo" />
				<s:param name="_pagelines" value="datas.linesPerPage" />
				<s:param name="_rowcount" value="datas.rowCount" />
				<s:param name="application" value="#parameters.application" />
				<s:param name="id" value="id"/>
				<s:param name="tab" value="1" />
				<s:param name="selected" value="%{'btnRole'}" />
				<s:param name="sm_name" value="#parameters.sm_name" />
				</s:url>'>
				<s:property value="name" /></a></td>
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
	</div>
</s:form>
</body>
</o:MultiLanguage>
</html>
