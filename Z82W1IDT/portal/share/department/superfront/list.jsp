<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/portal/share/common/head.jsp"%>
<% 
	String contextPath = request.getContextPath();
	String parentid = (String)request.getAttribute("parentid");
%>
<html><o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.manage.attr.department_list]*}</title>
<link rel="stylesheet" type="text/css"	href="<s:url value='/resource/css/main.css' />" />
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script type="">
	var contextPath='<%=contextPath%>';
</script>
<script src="<s:url value="/portal/share/script/list.js"/>"></script>
</head>
<script>
	function ev_onload(){
		try { 
			var operation = document.getElementsByName("operation")[0].value;
		    if("delete"==operation){
			if (parent) {
				if (parent.treeview) {
					parent.treeview.jstree("refresh");
				}
				if (parent.parentWindow) {
					parent.parentWindow.ev_reload();
				}
			 }
		}
		}catch (ex) {
		
		}   
	}
	
	function isEdit(){
		window.parent.document.getElementById("isedit").value="true";
	}

	function adjustConDiv(){
		var conFormH = jQuery("#departmentlist").height(),
			iframeH = jQuery("body",parent.document).find("iframe").height();
		if(conFormH > iframeH){
			var titleH = jQuery("#main").prev().height(),
				serH = jQuery("#searchFormTable").height() + 20,
				pagNavH = jQuery("#contentTable").find("table").eq(1).height();
			jQuery("#listContentDiv").height(iframeH - titleH - serH - pagNavH);
		}
	}
	
	jQuery(document).ready(function(){
		ev_onload();
		cssListTable();
		setTimeout(function(){
			adjustConDiv(); //调整部门列表高度
		},500);
	});
</script>
<body id="domain_dept_list" class="listbody">
<div>
<s:form name="formList" action="departmentlist" method="post" theme="simple">
    <%@include file="/common/list.jsp"%>
    <table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.manage.attr.department_list]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" class="button-image" onClick="parent.donew()"><img src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[New]*}</button>
					<button type="button" class="button-image" onClick="parent.doDelete()"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
				</div>
			</td></tr>
	</table> 
	<div id="main">   
		<%@include file="/portal/share/common/msg.jsp"%>	
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<div id="searchFormTable" class="justForHelp" title="{*[Search]*}{*[Department]*}">
			<table class="table_noborder">
				<tr><td class="head-text">
					{*[Department]*}{*[Name]*}:
					<input class="input-cmd" type="text" name="sm_name" id="sm_name" value='<s:property value="params.getParameterAsString('sm_name')"/>' size="10" />
					{*[Superior]*}:
					<s:select  name="sm_superior.id"  emptyOption="true"  list="_departments" id="superiorid" theme="simple" value="params.getParameterAsString('sm_superior.id')"/>
					
					<s:hidden id="isclick" value="false"></s:hidden>
					<s:hidden id="selectnode" value=""></s:hidden>
					<s:hidden id="departname" value=""></s:hidden>
					<s:hidden id="isedit" value="false"></s:hidden>
					
					<input class="button-cmd" type="button" onclick="document.forms[0].submit();" value="{*[Query]*}" />
					<input class="button-cmd" type="button" value="{*[Reset]*}" onclick="resetAll()" />
				</td></tr>
			</table>
		</div>
		
		<div id="contentTable">
			<s:hidden name="parentid" id="parentid" value="%{#request.parentid}"></s:hidden>
			<s:hidden name="operation" value="%{#request.operation}" />
			<div id="listContentDiv" style="overflow: auto;">
				<table class="table_noborder"  border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td class="column-head2" scope="col"><input type="checkbox"
							onclick="selectAll(this.checked)"></td>
						<td class="column-head" scope="col"><o:OrderTag field="name"
							css="ordertag">{*[Department]*}{*[Name]*}</o:OrderTag></td>
						<td class="column-head" scope="col"><o:OrderTag field="superior.name"
							css="ordertag">{*[Superior]*}</o:OrderTag></td>
							
						<!-- 扩展字段头 -->
						<s:iterator value="fieldExtendses">
							<td class="column-head" scope="col"><s:property value="label"/></td>
						</s:iterator>
					</tr>
					<s:iterator value="datas.datas" status="index">
						<tr>
						<td class="table-td"><input type="checkbox" name="_selects" value="<s:property value="id"/>"></td>
						<td><a
							href="javascript: isEdit();document.forms[0].action='<s:url action="edit">
							<s:param name="id" value="id"/></s:url>';
							document.forms[0].submit();">
							<s:property value="name" /></a></td>
						<td><s:property value="superior.name" /></td>
						
						<!-- 扩展字段内容 -->
						<s:iterator value="fieldExtendsValues">
							<td><s:property/></td>
						</s:iterator>
						
						</tr>
					</s:iterator>
				</table>
			</div>
			<table class="table_noborder">
				<tr>
					<td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag" /></td>
				</tr>
			</table>
		</div>
	</div>
</s:form>
</div>
</body>
</o:MultiLanguage></html>



