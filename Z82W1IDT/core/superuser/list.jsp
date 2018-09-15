<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<% 
	String contextPath = request.getContextPath();
%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<html><o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.superuser.label.super_user_List]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script type="">
	var contextPath='<%=contextPath%>';
</script>
<script src="<s:url value="/script/list.js"/>"></script>
<script src="<s:url value='/script/help.js'/>"></script>
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script type="text/javascript">
	function doDelete(){
		var listform = document.forms['formList'];
		if(isSelectedOne("_selects","{*[please.choose.one]*}")){
	    	listform.action='<s:url action="delete"/>';
	    	listform.submit();
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
		cssListTable(); /*in list.js */
		window.top.toThisHelpPage("superuser_list");
	});

</script>
</head>
<body id="superuser_list" class="listbody">
<div class="ui-layout-center">
<s:actionerror /> 
<s:form name="formList" action="list" method="post">
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.superuser.label.super_user_List]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" id="New_SuperUser" title="{*[cn.myapps.core.superuser.title.new_super_user]*}" class="justForHelp button-image" onClick="forms[0].action='<s:url action="new"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"></s:url>">{*[New]*}</button>
					<button type="button" id="Delete_SuperUser" title="{*[cn.myapps.core.superuser.title.delete_super_user]*}" class="justForHelp button-image" onClick="doDelete()"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
				</div>
			</td></tr>
	</table>
	<div id="main">
		<%@include file="/common/basic.jsp" %>
		<%@include file="/common/msg.jsp"%>	
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<div id="searchFormTable" title="{*[cn.myapps.core.domain.title.search_form]*}" class="justForHelp">
			<table class="table_noborder">
				<tr><td class="head-text">
					{*[Name]*}:	<input id="SuperUser_Name" pid="searchFormTable" title="{*[cn.myapps.core.superuser.title.search_by_super_user_name]*}" class="justForHelp input-cmd" type="text" name="sm_name"	value='<s:property value="#parameters['sm_name']" />' size="10" />
					{*[Account]*}:	<input id="SuperUser_Account" pid="searchFormTable" title="{*[cn.myapps.core.superuser.title.search_by_super_user_account]*}" class="justForHelp input-cmd" type="text" name="sm_loginno" value='<s:property value="#parameters['sm_loginno']" />' size="10" />
					<input id="Query" pid="searchFormTable" title="{*[Query]*}" class="justForHelp button-cmd" type="submit" value="{*[Query]*}" />
					<input id="Reset" pid="searchFormTable" title="{*[Reset]*}" class="justForHelp button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll();" />
				</td></tr>
			</table>
		</div>
		<div id="contentTable">
			<table class="table_noborder">
				<tr>
					<td class="column-head2" scope="col"><input type="checkbox"
						onclick="selectAll(this.checked)"></td>
					<td class="column-head" scope="col"><o:OrderTag field="name"
						css="ordertag">{*[Name]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag field="loginno"
						css="ordertag">{*[Account]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag field="email"
						css="ordertag">{*[Email]*}</o:OrderTag></td>
					<td class="column-head" scope="col">{*[cn.myapps.core.domain.holdAdmin.user_type]*}</td>
				</tr>
				<s:iterator value="datas.datas" status="index">
					<tr>
					<td class="table-td"><input type="checkbox" name="_selects"
						value="<s:property value="id"/>"></td>
					<td><a class='forInitCurrentPosition' topage='{*[cn.myapps.core.superuser.super_user_information]*}(<s:property value="name" />)'
						href="<s:url action="edit">
						         <s:param name="id" value="id"/>
						         <s:param name="_currpage" value="#parameters._currpage"/>
						         <s:param name="_pagelines" value="#parameters._pagelines"/>
						      </s:url>">
						<s:property value="name" /></a></td>
					<td><s:property value="loginno" /></td>
					<td><s:property value="email" /></td>
					<td>
					<s:if test="superAdmin">
						{*[SuperAdmin]*}
					</s:if>
					<s:else>
						<s:if test="domainAdmin">
							{*[DomainAdmin]*}
							<s:if test="developer">
							 {*[Developer]*}
							</s:if>
						</s:if>
						<s:elseif test="developer">
							{*[Developer]*}
						</s:elseif>
					</s:else>
					</td>
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
	</div>
</s:form>
</div>
</body>
</o:MultiLanguage></html>
