<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<% 
	String contextPath = request.getContextPath();
%>

<html><o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.deploy.application.application_list]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script type="">
	var contextPath='<%=contextPath%>';
</script>
<script src="<s:url value="/script/list.js"/>"></script>
<script src="<s:url value='/script/help.js'/>"></script>
<script type="text/javascript">
function doDelete(){
	var listform = document.forms['formList'];
	if(isSelectedOne("_selects","{*[please.choose.one]*}")){
		if(confirm("{*[cn.myapps.core.deploy.application.delete_current_application]*}?"))
		 {
			 listform.action='<s:url action="delete"/>';
		     listform.submit();
		 }
    	
    }
}

jQuery(function(){
	var obj=window.parent.document;
	obj.getElementById("currentPosition").innerHTML=obj.getElementById("currentPosition3").innerHTML;
	jQuery(".forInitCurrentPosition").click(function(){
		obj.getElementById("currentPosition").innerHTML=obj.getElementById("currentPosition3").innerHTML+">><a target='detail' title='"+jQuery(this).attr("topage")+"' href='"+jQuery(this).attr("href")+"' class='currentPosition'>"+jQuery(this).attr("topage")+"</a>";
		if(obj.getElementById("currentPosition4")){
			obj.getElementById("currentPosition4").innerHTML=obj.getElementById("currentPosition").innerHTML;
		}
	});
});

jQuery(document).ready(function(){
	cssListTable();
	window.top.toThisHelpPage("application_list");
});
</script>
</head>
<body id="application_list" class="listbody">
<div>
<s:form name="formList" action="list-apps" method="post">
	<s:if test="#parameters._currpage != null && #parameters._currpage!=''">
		<input type="hidden" name="_currpage" value='<s:property value="#parameters._currpage"/>' />
	</s:if>
	<s:else>
		<input type="hidden" name="_currpage" value='<s:property value="datas.pageNo"/>' />
	</s:else>
	
	
	<input type="hidden" name="_pagelines" value='<s:property value="datas.linesPerPage"/>' />
	
	
	<s:if test="#parameters._rowcount != null && #parameters._rowcount!=''">
	 	<input type="hidden" name="_rowcount" value='<s:property value="#parameters._rowcount"/>' />
	</s:if>
	<s:else>
		<input type="hidden" name="_rowcount" value='<s:property value="datas.rowCount"/>' />
	</s:else>
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.deploy.application.application_list]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" id="new_Application" title="{*[cn.myapps.core.deploy.application.new_application]*}" class="justForHelp button-image" onClick="forms[0].action='<s:url action="new"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"></s:url>">{*[New]*}</button>
					<button type="button" id="delete_Application" title="{*[cn.myapps.core.deploy.application.delete_application]*}" class="justForHelp button-image" onClick="doDelete()"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
				</div>
			</td></tr>
	</table>
	<div id="main">
		<%@include file="/common/msg.jsp"%>
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<div id="searchFormTable" class="justForHelp" title="{*[cn.myapps.core.deploy.application.search_form]*}">
			<table class="table_noborder">
				<tr><td class="head-text">
					{*[cn.myapps.core.deploy.application.application_name]*}:<input id="Application_name" title="{*[cn.myapps.core.deploy.application.search_by_app_name]*}" pid="searchFormTable" class="justForHelp input-cmd" type="text" name="sm_name"	value='<s:property value="#parameters['sm_name']" />' size="10" />
					{*[Description]*}:<input id="Application_description" title="{*[cn.myapps.core.deploy.application.search_by_app_description]*}" pid="searchFormTable" class="justForHelp input-cmd" type="text" name="sm_description" value='<s:property value="#parameters['sm_description']" />' size="10" />
					<input class="button-cmd" type="button" value="{*[Query]*}" onclick="document.getElementsByName('_currpage')[0].value='1';document.forms[0].submit();" />
					<input class="button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll();" />
					<td>
				</td>
			</table>
		</div>
		<div id="contentTable">
			<table class="table_noborder"  border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="column-head2" scope="col"><input type="checkbox"
						onclick="selectAll(this.checked)"></td>
					<td class="column-head" scope="col"><o:OrderTag field="name"
						css="ordertag">{*[Name]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag
						field="description" css="ordertag">{*[Description]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag
						field="activated" css="ordertag">{*[State]*}</o:OrderTag></td>
				</tr>
				<s:iterator value="datas.datas" status="index">
					<tr>
					<td class="table-td"><input type="checkbox" name="_selects"
						value="<s:property value="id" />"></td>
					<td><a class='forInitCurrentPosition' topage='{*[cn.myapps.core.deploy.application.application_information]*}(<s:property value="name" />)'
						href="<s:url value="/core/deploy/application/frames.jsp">
							<s:param name="id" value="id"/>
							<s:param name="application" value="id"/>
							<s:param name="_currpage" value="datas.pageNo" />
							<s:param name="_pagelines" value="datas.linesPerPage" />
							<s:param name="_rowcount" value="datas.rowCount" />
							<s:param name="sm_name" value="#parameters.sm_name"/>
							<s:param name="sm_description" value="#parameters.sm_description"/>
						</s:url>"><s:property value="name" /></a></td>
					<td><s:property value="description.length()>40?description.substring(0,40)+'...':description" /></td>
					<td>
						<s:if test="activated">
							{*[core.workflow.storage.runtime.proxy.activation]*}
						</s:if>
						<s:elseif test="!activated">
							{*[core.workflow.storage.runtime.proxy.disable]*}
						</s:elseif>
					</td>
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
</div>
</body>
</o:MultiLanguage></html>
