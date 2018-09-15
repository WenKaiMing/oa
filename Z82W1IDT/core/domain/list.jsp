<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.constans.Environment"%>
<% 
	String contextPath = request.getContextPath();
	WebUser user = (WebUser) session
		.getAttribute(Web.SESSION_ATTRIBUTE_USER);
%>
<html><o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.main.domain_list]*}</title>
<link rel="stylesheet" href='<s:url value="/resource/css/main.css"/>' type="text/css" />
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script type="">
	var contextPath='<%=contextPath%>';
</script>
<script src="<s:url value="/script/list.js"/>"></script>
<script>
//标准版只允许建一个企业域已有企业域时隐藏新建按钮
function checkVersion(){
	var licenseType = "<%=Environment.licenseType%>";	//如：S.标准版
	if(licenseType.indexOf("S") != -1){
		var domainSize = jQuery("input[name='_selects']").size();
		if(domainSize >= 1){
			jQuery("#new_domain_btn").css("display","none");
		}
	}
}

function query() {
	var managerField = document.getElementById("manager");
	var listform = document.getElementById("listform");
	var action = '<s:url value="/core/domain/findManager.action" />';
	listform.action = action;
	listform.submit();
}

function doDelete(){
    if(isSelectedOne("_selects","{*[cn.myapps.core.domain.tips.please_choose_one]*}")){
    	listform.action='<s:url action="delete"><s:param name="t_users.id" value="#session.USER.id" /></s:url>';
    	listform.submit();
    }
}

/**刷新当前位置**/
jQuery(function(){
	var obj=window.parent.document;
	obj.getElementById("currentPosition").innerHTML=obj.getElementById("currentPosition3").innerHTML;
	jQuery(".forInitCurrentPosition").click(function(){
		obj.getElementById("currentPosition").innerHTML=obj.getElementById("currentPosition3").innerHTML+">><a target='detail' href='"+jQuery(this).attr("href")+"' title='"+jQuery(this).attr("topage")+"' class='currentPosition'>"+jQuery(this).attr("topage")+"</a>";
		if(obj.getElementById("currentPosition4")){
			obj.getElementById("currentPosition4").innerHTML=obj.getElementById("currentPosition").innerHTML;
		}
	});
	cssListTable(); /*in list.js*/
	checkVersion();
	window.top.toThisHelpPage("domain_list");
});

function doExportandImport(){
	var url = contextPath + '/core/domain/exportandimport.jsp';
	OBPM.dialog.show({
		opener:window.parent.parent,
		width: 450,
		height: 270,
		url: url,
		title: "文件导入/导出",
		close: function(result){
			var userid = '<%=user.getId()%>';
			document.forms[0].action = "list.action?t_users.id=" + userid;
			document.forms[0].submit();
		}
	});
}
</script>
</head>
<body id="domain_list" class="listbody">
<div>
	<s:form name="formList" action="list" method="post" id="listform">
	<s:hidden name="usersId" id="usersId" value="%{#request.userId}"></s:hidden>
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.main.domain_list]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
				    <!-- 关闭企业域导入导出功能 -->
					<%-- <button type="button" id="btnPort" class="button-image" onclick="doExportandImport();"><img src="<s:url value="/resource/imgnew/act/act_26.gif"/>" />{*[Domain]*}{*[Import]*}/{*[Export]*}</button> --%>
					<button type="button" id="new_domain_btn" title="{*[cn.myapps.core.domain.title.new_domain]*}" class="justForHelp button-image" onmouseover="" onclick="forms[0].action='<s:url action="new"><s:param name='t_users.id' value='#session.USER.id' /></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"></s:url>">{*[New]*}</button>
					<button type="button" id="delete_domain_btn" title="{*[cn.myapps.core.domain.title.delete_domain]*}" class="justForHelp button-image" onclick="doDelete()"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
				</div>
			</td></tr>
	</table>
	<div id="main">
	<%@include file="/common/msg.jsp"%>	
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<div id="searchFormTable">
			<table class="table_noborder">
				<tr><td class="head-text">
					{*[cn.myapps.core.domain.label.name]*}:	<input id="domain_name" pid="search_btn" class="justForHelp input-cmd"  title="{*[cn.myapps.core.domain.title.query_domain_name]*}" type="text" name="sm_name" value='<s:property value="#parameters['sm_name']"/>' size="10" />
					{*[Manager]*}:	<input id="manager_name" pid="search_btn" class="justForHelp input-cmd" title="{*[cn.myapps.core.domain.title.query_manager]*}"  type="text" name="sm_users.loginno" value='<s:property value="#parameters['sm_users.loginno']"/>' size="10" />
					<input id="search_domain_btn" title="{*[cn.myapps.core.domain.title.search_form]*}" class="justForHelp button-cmd" type="button"  value="{*[Query]*}" onclick="query()" />
					<input id="reset_btn" title="{*[cn.myapps.core.domain.title.reset_search_form]*}" class="justForHelp button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll()" />
				<tr><td>
			</table>
		</div>
		<div id="contentTable">
			<table class="table_noborder">
					<%@include file="/common/basic.jsp" %>
				<tr>
					<td class="column-head2" scope="col"><input type="checkbox"
						onclick="selectAll(this.checked)"></td>
					<td class="column-head" scope="col"><o:OrderTag field="name"
						css="ordertag">{*[cn.myapps.core.domain.label.name]*}</o:OrderTag></td>
					<td class="column-head" scope="col">{*[Manager]*}</td>
					<td class="column-head" scope="col"><o:OrderTag field="status"
						css="ordertag">{*[Status]*}</o:OrderTag></td>
				</tr>
				<s:iterator value="datas.datas" status="index">
					<tr>
					<td class="table-td"><input type="checkbox" name="_selects"
						value="<s:property value="id"/>"></td>
					<td><a class='forInitCurrentPosition' topage='{*[cn.myapps.core.main.domain_info]*}(<s:property value="name" />)'
						href='<s:url action="displayView">
						<s:param name="id" value="id"/>
						<s:param name="domain" value="id"/>
						<s:param name="_currpage" value="datas.pageNo" />
						<s:param name="_pagelines" value="datas.linesPerPage" />
						<s:param name="_rowcount" value="datas.rowCount" />
						<s:param name="sm_name" value="#parameters.sm_name"/>
						<s:param name="sm_users.loginno" value="#parameters['sm_users.loginno']"/>
						</s:url>'><s:property
						value="name" /></a></td>
					<td>|<s:iterator value="users" status="user">
							<s:property value="loginno" /> | 
						</s:iterator>
					</td>
					<td>
						<s:if test="status == 1">
							{*[Enable]*}
						</s:if>
						<s:else>
							{*[Disable]*}
						</s:else>
					</td>
					</tr>
				</s:iterator>
			</table>
		</div>
		<table class="table_noborder">
			<tr>
				<td align="right" class="pagenav"><o:PageNavigation
						dpName="datas" css="linktag" /></td>
			</tr>
		</table>
	</div>
</s:form>
</div>
</body>
</o:MultiLanguage></html>



