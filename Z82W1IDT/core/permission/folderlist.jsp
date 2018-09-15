<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/tags.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!-- 资源操作选择 -->
<s:bean name="cn.myapps.core.privilege.operation.action.OperationHelper" id="oh">
	<s:param name="applicationid" value="#parameters.applicationid" />
</s:bean>
<div style="font-weight: bold">{*[Folder]*}<s:property value="#parameters.resourcename" />操作</div>
<div id="operationDiv">
	<s:hidden value="%{#parameters.resourceid}@%{#parameters.resourcename}@%{#parameters.resourcetype}" id="folder"/>
	<!--  
	<input type="checkbox" id="operationSelectAll" ></input><label>{*[All]*}</label>
	-->
	<s:checkboxlist 
		list="#oh.getOperationMap(#parameters.resourceid,#parameters.resourcetype,#parameters.applicationid)" 
		name="operation"
		onclick="changePermissionByFolder(this, 'Folder_operation_unselect');"
		theme="simple"
		>
	</s:checkboxlist>
</div>