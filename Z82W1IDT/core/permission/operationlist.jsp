<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/tags.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<s:bean name="cn.myapps.core.privilege.operation.action.OperationHelper" id="oh">
	<s:param name="applicationid" value="#parameters.applicationid" />
</s:bean>
<s:bean name="cn.myapps.core.privilege.res.action.ResHelper" id="rh" >
	<s:param name="applicationid" value="#parameters.applicationid" />
</s:bean>
<!-- 资源操作选择 -->
<div style="font-weight: bold">操作</div>
<div id="operationDiv">
	<!-- 是否为菜单 -->
	<s:if test="!#oh.isMenuType(#parameters.resourcetype)">
		<input type="checkbox" id="operationSelectAll" ></input><label>{*[All]*}</label>
		<s:checkboxlist 
			list="#oh.getOperationMap(#parameters.resourceid,#parameters.resourcetype,#parameters.applicationid)" 
			name="operation"
			theme="simple">
		</s:checkboxlist>
	</s:if>
	<s:else>
		<s:radio 
			name="operation" 
			list="#oh.getOperationMap(#parameters.resourceid,#parameters.resourcetype,#parameters.applicationid)" 
			theme="simple"/>
	</s:else>
</div>
<p></p>

<!-- 为子资源赋权(如:表单的字段) -->
<s:set name="subResource" value="#rh.getInnerResources(#parameters.resourceid,#parameters.resourcetype)"/>
<s:if test="#subResource.size()>0">
<div style="font-weight: bold">表单字段</div>
<div id="subResourceDiv">
	<table>
	<!-- 选择所有  -->
	<tr style="font-size: 12px">
		<td>&nbsp;</td>
		<td id="subResourceSelectAll">
			<input type="radio" name='selectAll' value='<s:property value="@cn.myapps.core.privilege.operation.ejb.OperationVO@FORMFIELD_READONLY" />' /><label>{*[All]*}</label>
			<input type="radio" name='selectAll' value='<s:property value="@cn.myapps.core.privilege.operation.ejb.OperationVO@FORMFIELD_MODIFY" />' /><label>{*[All]*}</label>
			<input type="radio" name='selectAll' value='<s:property value="@cn.myapps.core.privilege.operation.ejb.OperationVO@FORMFIELD_HIDDEN" />' /><label>{*[All]*}</label>
			<input type="radio" name='selectAll' value='<s:property value="@cn.myapps.core.privilege.operation.ejb.OperationVO@FORMFIELD_DISABLED" />' /><label>{*[All]*}</label>
		</td>
	</tr>
	<!-- 资源循环 -->
	<s:iterator value="#subResource">
		<tr style="font-size: 12px">
			<td align="right">
				<s:property value="%{name}" />：
			</td>
			<td>
				<s:set name="resIdNameType" />
				<!-- 操作循环，3为表单字段类型 -->
				<s:iterator value="#oh.getOperationList('','3')">
					<input type="radio" 
						name='<s:property value="#resIdNameType.id" />@<s:property value="#resIdNameType.name" />@<s:property value="#resIdNameType.type" />' 
						value='<s:property value="id" />'
						class='<s:property value="code" />'
					/><label>{*[<s:property value="name" />]*}</label>
				</s:iterator>
				<!--  
				<s:radio name="%{id}@%{name}@%{type}" list="#oh.getOperationList('','3')" listKey="id" listValue="name" cssClass="%{code}" theme="simple"/>
				-->
			</td>
		</tr>
	</s:iterator>
	</table>
</div>
</s:if>