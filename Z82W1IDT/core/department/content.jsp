<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.department.ejb.DepartmentVO"%>
<%@ page import="cn.myapps.core.fieldextends.ejb.FieldExtendsVO"%>
<%@ page import="java.lang.reflect.Method"%>
<s:bean name="cn.myapps.core.permission.action.PermissionHelper" id="ph" />
<%
	String contextPath = request.getContextPath();
	String domain = request.getParameter("domain");
	// 获取扩展字段
	FieldExtendsProcess fieldExtendsProcess = (FieldExtendsProcess) ProcessFactory.createProcess(FieldExtendsProcess.class);
	List<FieldExtendsVO> fieldExtendses = fieldExtendsProcess.queryFieldExtendsByTable(domain, FieldExtendsVO.TABLE_DEPT);
	//request.setAttribute("fieldExtendses", fieldExtendses);
%>

<%@page import="cn.myapps.core.fieldextends.ejb.FieldExtendsProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="cn.myapps.core.fieldextends.action.FieldExtendsHelper"%><html><o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.domain.department.department_information]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script type="">
	var contextPath='<%=contextPath%>';
</script>
<script src='<s:url value="/script/datePicker/WdatePicker.js"/>' ></script>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css" />
<link rel="stylesheet" type="text/css" href="<s:url value='/resource/css/ajaxtabs.css'/>" />
</head>
<script>
	var checkedList = new Array(); 
	var imageSrc = '<s:url value="/resource/images/loading.gif" />';
	var text = '{*[page.loading...]*}';
	function ev_onload(){
		try { 
			var operation = document.getElementsByName("operation")[0].value;
			//alert(operation);
		    if("save"==operation){
			if (parent) {
				if (parent.treeview) {
					parent.treeview.jstree("refresh");
				}
				if (parent.parentWindow) {
					parent.parentWindow.ev_reload();
				}
			 } else {}
		    }
		} catch (ex) {
		}   
			}
	function doexit(){
		var page = contextPath + '/core/department/departmentlist.action?'
				+ 'domain=<%=request.getParameter("domain")%>'
				+ '&_currpage=<s:property value="#parameters._currpage"/>'
				+ '&_pagelines=<s:property value="#parameters._pagelines"/>'
				+ '&_rowcount=<s:property value="#parameters._rowcount"/>'
				+ '&sm_name=<s:property value="%{#parameters.sm_name}"/>';
		location.replace(page) ;
	}
	function adjustDataIteratorSize() {
		var containerHeight = document.body.clientHeight-160;
		//var container = document.getElementById("frame");
		//container.style.height = containerHeight + 'px';
	}
	
	jQuery(document).ready(function(){
		window.parent.init_DepartmentTree();
		ev_onload();
		adjustDataIteratorSize();
		window.top.toThisHelpPage("domain_dept_info");
	});

	//去所有空格   
	String.prototype.trimAll = function(){   
	    return this.replace(/(^\s*)|(\s*)|(\s*$)/g, "");   
	};   

	//检查部门中名称中是否包含()字符
//	function checkStringAsDefault(){
//		var sObj = jQuery("input[name='content.name']").val();
//		jQuery("input[name='content.name']").val(sObj.trimAll());
//		var s = jQuery("input[name='content.name']").val();
//		if(s.indexOf("(")!=-1){
//			alert("{*[cn.myapps.core.domain.department.can_not_have_keyword]*} (  ");
//			return false;
//		}else if(s.indexOf(")")!=-1){               *取消部门字符校验
//			alert("{*[cn.myapps.core.domain.department.can_not_have_keyword]*} )  "); 
//			return false;
//		}
//		return true;
//	}

	function dosave(){
		if(checkIsNumber()){
			document.forms[0].action='<s:url action="save"></s:url>';
			document.forms[0].submit();
		}
	}

	function dosaveandnew(){
		if(checkIsNumber()){
			document.getElementById('application').value = '';
			document.forms[0].action='<s:url action="saveAndNew"></s:url>';
			document.forms[0].submit();
		}
	}
	
	//检查排序号是否为数字类型
	function checkIsNumber(){
		var obj = document.getElementsByName('content.orderByNo');
		var regex = /^[0-9]*$/;
		if(regex.test(obj[0].value)){
			return true;
		}else{
			alert("{*[cn.myapps.core.domain.userEdit.tips.orderbyno_legal]*}!");
			return false;
		}
	}
	
</script>
<body id="domain_dept_info" class="contentBody" style="overflow:hidden;height:100%\9;">
<s:form action="save" method="post" theme="simple">
	<div id="contentActDiv" >
		<s:hidden name="operation" value="%{#request.operation}" />
		<s:hidden name="content.indexCode" />
		<s:hidden name="content.weixinDeptId" />
		<s:hidden name="content.lanxinDeptId" />
		<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.domain.department.department_information]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" id="btnSaveNew" class="button-image" onclick="dosaveandnew()"><img src="<s:url value="/resource/imgnew/act/act_12.gif"/>">{*[Save&New]*}</button>
					<button type="button" class="button-image" onclick="dosave()"><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
					<button type="button" class="button-image" onclick="doexit()"><img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
				</div>
			</td></tr>
		</table>
	</div>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
	<%@include file="/portal/share/common/msgbox/msg.jsp"%>
	</s:if>
	<div id="contentMainDiv" class="contentMainDiv">
		<%@include file="/common/page.jsp"%>
		<table class="table_noborder id1">
			<tr>
				<td class="commFont" align="left">{*[Name]*}:</td>
				<td class="commFont" align="left">{*[Code]*}:</td>
			</tr>
			<tr>
				<td><s:textfield cssClass="input-cmd" name="content.name" /></td>
				<td><s:textfield cssClass="input-cmd" label="{*[Code]*}" name="content.code" /></td>
			</tr>
			<tr>
				<td class="commFont" align="left">{*[Superior]*}:</td>
				<td class="commFont" align="left">{*[cn.myapps.core.domain.departmentEdit.setup_order_number]*}:</td>
			</tr>
			<tr>
				<td><s:select cssClass="input-cmd" label="{*[Superior]*}"
					name="_superiorid" list="_departments" /></td>
				<td>
					<s:textfield cssClass="input-cmd" theme="simple" name="content.orderByNo" />
				 </td>
			</tr>
			<tr>
				<td>{*[cn.myapps.core.domain.department.validation]*}:</td>
			</tr>
			<tr>
				<td><s:radio name="content.valid" list="#{0:'{*[cn.myapps.core.domain.department.invalid]*}',1:'{*[cn.myapps.core.domain.department.valid]*}'}" theme="simple"/></td>
			</tr>
			
			<!-- 扩展字段开始 -->
			<%
			DepartmentVO dep = (DepartmentVO) request.getAttribute("content");
			FieldExtendsHelper helper = new FieldExtendsHelper();
			List<FieldExtendsVO> fes = new ArrayList<FieldExtendsVO>();
			for(int i=0;i<fieldExtendses.size();i++){
				FieldExtendsVO fevo = fieldExtendses.get(i);
				if(fevo != null && fevo.getEnabel()){
					fes.add(fevo);
				}
			}
			out.append(helper.getFieldHtml(fes, dep));
			%>
			<!-- 扩展字段结束 -->
		</table>
		<s:if test="content.id!=null&&content.id.trim().length()>0">
			<iframe scrolling="no" id="frame" name="Frame" border="0" src="<s:url value='/core/user/listByDepartment.action'/>?sm_userDepartmentSets.departmentId=<s:property value="content.id" />"
				width="100%" frameborder="0" />
			</iframe>
				
		</s:if>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>
