<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<s:bean name="cn.myapps.core.macro.repository.action.RepositoryActionHelper" id="RepositoryActionHelper"/>
<s:bean name="cn.myapps.core.deploy.application.action.ApplicationHelper" id="ah" />
<% 
	WebUser user = (WebUser)session.getAttribute(Web.SESSION_ATTRIBUTE_USER);
	String contextPath = request.getContextPath();
	String username = user.getName();
%>
<html><o:MultiLanguage>
<head>
<title>{*[Macro_Libraries]*}{*[List]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script type="">
	var contextPath='<%=contextPath%>';
</script>
<script src="<s:url value="/script/list.js"/>"></script>
</head>
<script>
	function query(){
	   document.forms[0].submit();
	}
	function doDelete(){
		var listform = document.forms['formList'];
	    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
	    	listform.action='<s:url action="deleteByAdmin"/>';
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
		initWinPosition();
		cssListTable(); /*in list.js*/
		window.top.toThisHelpPage("repository_list");
	});
</script>

<body id="repository_list" class="listbody">
<div class="ui-layout-center">
<s:form name="formList" action="listAll" method="post">
	
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[Macro_Libraries]*}{*[List]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" id="New_Macro_Libraries" title="{*[New]*}{*[Macro_Libraries]*}" class="justForHelp button-image" onClick="forms[0].action='<s:url action="newByAdmin"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"></s:url>">{*[New]*}</button>
					<button type="button" id="Delete_Macro_Libraries" title="{*[Delete]*}{*[Macro_Libraries]*}" class="justForHelp button-image" onClick="doDelete()"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
				</div>
			</td>
			</tr>
	</table>
	<div id="main">
		<%@include file="/common/msg.jsp"%>	
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<div id="searchFormTable">
			<table class="table_noborder">
				<tr><td class="head-text">
					{*[Name]*}:	<input class="input-cmd" type="text" name="sm_name" value='<s:property value="#parameters['sm_name']"/>'size="10" />
					{*[Content]*}:	<input class="input-cmd" type="text" name="sm_content" value='<s:property value="#parameters['sm_content']"/>'	size="10" />
					<input style="cursor:hand" class="button-cmd" type="submit" onclick="query()" value="{*[Query]*}" />
					<input style="cursor:hand" class="button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll();" />
				<tr><td>
			</table>
		</div>
		<div id="contentTable">	
			<table class="table_noborder">
				<%@include file="/common/basic.jsp"%>
				<tr>
					<td class="column-head2" scope="col"><input type="checkbox"
						onclick="selectAll(this.checked)"></td>
					<td class="column-head" scope="col"><o:OrderTag field="name"
						css="ordertag">{*[Name]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag field="name"
						css="ordertag">{*[Belong]*}{*[Application]*}</o:OrderTag></td>
					<td class="column-head" scope="col">{*[Content]*}</td>
				</tr>
		
				<s:iterator value="datas.datas" status="index">
					<tr>
					<td class="table-td"><input type="checkbox" name="_selects"
						value="<s:property value="id" />"></td>
					<td ><a class='forInitCurrentPosition' topage='{*[Macro_Library]*}{*[Info]*}(<s:property value="name" />)'
						href="<s:url action="editByAdmin"><s:param name="id" value="id"/>
						<s:param name="_currpage" value="datas.pageNo" />
						<s:param name="_pagelines" value="datas.linesPerPage" />
						<s:param name="_rowcount" value="datas.rowCount" />
						<s:param name="applicationid" value="applicationid" />
						</s:url>">
					<s:property value="name" /></a></td>	
					<td width="20%"><s:property value="#ah.getApplicationNameById(applicationid)"/></td>
					<td><s:property value="content.length()>20?content.substring(0,20):content" /></td>
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
