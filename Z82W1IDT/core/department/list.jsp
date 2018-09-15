<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<% 
	String contextPath = request.getContextPath();
	String parentid = (String)request.getAttribute("parentid");
	String domain = request.getParameter("domain");
	// 获取扩展字段
	FieldExtendsProcess fieldExtendsProcess = (FieldExtendsProcess) ProcessFactory.createProcess(FieldExtendsProcess.class);
	List<FieldExtendsVO> fieldExtendses = fieldExtendsProcess.queryFieldExtendsByTableAndEnabel(domain, FieldExtendsVO.TABLE_DEPT, true);
	request.setAttribute("fieldExtendses", fieldExtendses);
%>

<%@page import="cn.myapps.core.fieldextends.ejb.FieldExtendsProcess"%><%@page import="cn.myapps.util.ProcessFactory"%><%@page import="java.util.List"%>
<%@page import="cn.myapps.core.fieldextends.ejb.FieldExtendsVO"%><html><o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.domain.department.department_list]*}</title>
<link rel="stylesheet" type="text/css"	href="<s:url value='/resource/css/main.css' />" />
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script type="">
	var contextPath='<%=contextPath%>';
</script>
<script src="<s:url value="/script/list.js"/>"></script>
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

	function donew(){
		parent.document.getElementById("selectnode").value="";
		parent.document.getElementById("isclick").value ="true";
		var page = contextPath + "/core/department/new.action?domain=<%=request.getParameter("domain")%>&_currpage=<s:property value="datas.pageNo"/>&_pagelines=<s:property value="datas.linesPerPage"/>&_rowcount=<s:property value="datas.rowCount"/>";
		location.replace(page) ;
		
	}
	
	jQuery(document).ready(function(){
		ev_onload();
		cssListTable();
		window.top.toThisHelpPage("domain_dept_list");
		window.parent.init_DepartmentTree();
	});
</script>
<body id="domain_dept_list" class="listbody">
<div style="height:100%;overflow:auto;">
<s:form id="formList" name="formList" action="departmentlist" method="post" theme="simple">
    <%@include file="/common/list.jsp"%>
    <table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.domain.department.department_list]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" class="button-image" onClick="donew()"><img src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[New]*}</button>
					<button type="button" class="button-image" onClick="parent.doDelete()"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
				</div>
			</td></tr>
	</table> 
	<div id="main">   
		<%@include file="/common/msg.jsp"%>	
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<div id="searchFormTable" class="justForHelp" title="{*[cn.myapps.core.domain.department.search_department]*}">
			<table class="table_noborder">
				<tr><td class="head-text">
					{*[cn.myapps.core.domain.department.department_name]*}:
					<input class="input-cmd" type="text" name="sm_name" id="sm_name" value='<s:property value="params.getParameterAsString('sm_name')"/>' size="10" />
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
			<table class="table_noborder tableTOver"  border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="column-head2" scope="col"><input type="checkbox"
						onclick="selectAll(this.checked)"></td>
					<td class="column-head" scope="col" title="{*[cn.myapps.core.domain.department.department_name]*}"><o:OrderTag field="name"
						css="ordertag">{*[cn.myapps.core.domain.department.department_name]*}</o:OrderTag></td>
					<td class="column-head" scope="col" title="{*[Superior]*}"><o:OrderTag field="superior.name"
						css="ordertag">{*[Superior]*}</o:OrderTag></td>
						
					<!-- 扩展字段头 -->
					<s:iterator value="#request.fieldExtendses">
						<td class="column-head" scope="col" title="<s:property value="label"/>"><s:property value="label"/></td>
					</s:iterator>
				</tr>
				<s:iterator value="datas.datas" status="index" id="dep">
					<tr>
					<td class="table-td"><input type="checkbox" id="_selects" name="_selects" value="<s:property value="id"/>"></td>
					<td title='<s:property value="name" />'>
						<a href="javascript: isEdit();document.forms[0].action='<s:url action="edit">
								<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
							<s:property value="name" />
						</a>
					</td>
					<td title='<s:property value="superior.name" />'>
						<a href="javascript: isEdit();document.forms[0].action='<s:url action="edit">
								<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
							<s:property value="superior.name" />
						</a>
					</td>
					
					<!-- 扩展字段内容 -->
					<s:iterator value="#request.fieldExtendses" id="field">
						<td title='<s:property value="#field.getValue(#dep)"/>'>
							<a href="javascript: isEdit();document.forms[0].action='<s:url action="edit">
									<s:param name="id" value="#dep.id"/></s:url>';document.forms[0].submit();">
								<s:property value="#field.getValue(#dep)"/>
							</a>
						</td>
					</s:iterator>
					
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
</div>
</body>
</o:MultiLanguage></html>



