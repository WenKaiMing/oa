<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/tags.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<o:MultiLanguage>
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="FormHelper" >
	<s:param name="applicationid" value="#parameters.applicationid" />
	<s:param name="moduleid" value="#parameters.moduleid" />
</s:bean>
<s:bean name="cn.myapps.core.dynaform.view.action.ViewHelper" id="ViewHelper" >
	<s:param name="applicationid" value="#parameters.applicationid" />
	<s:param name="moduleid" value="#parameters.moduleid" />
</s:bean>

<div id="formDiv">
	<s:set name="formList" value="#FormHelper.get_FormByModule()"/>
	<div style="font-weight: bold">表单资源  <input type="button" onclick="selectAll('selectAll','form');" value="全选"/> <input type="button" onclick="selectAll('unSelectAll','form');" value="重置"/></div>
	<table id="formOperations">
		<!-- 表单资源循环 -->
		<s:iterator value="#formList">
			<s:set name="form" />
			<s:if test="#form.type !=256">
			<tr style="font-size: 12px" class="module_resource" 
				id='<s:property value="id" />' 
				resourcename='<s:property value="%{#form.name}" />'
				resourcetype='<s:property value="%{@cn.myapps.core.privilege.res.ejb.ResVO@FORM_TYPE}" />'>
				<td align="right">
					<s:property value="%{name}" />
					<font color="#666666">[
					<s:if test="#form.permissionType =='public'">{*[cn.myapps.core.permission.permission_type.public]*}</s:if>
					<s:else>{*[cn.myapps.core.permission.permission_type.private]*}</s:else>
					]</font>：
				</td>
				<td>
					<input type="checkbox" 
						name='operation' 
						value='<s:property value="%{#form.id}"/>'
						open = 'open'
						onClick="changePermissionByModule(this, 'module_resource_unselect');"
						resourceid='<s:property value="%{#form.id}" />'
						resourcename='<s:property value="%{#form.name}" />'
						<s:if test="#form.permissionType =='public'"> 
						disabled='disabled' 
						checked='checked' 
						</s:if>
						resourcetype='<s:property value="%{@cn.myapps.core.privilege.res.ejb.ResVO@FORM_TYPE}" />'
					/>
					<label>{*[Open]*}</label>
					<!-- 表单操作循环 -->
					<s:iterator value="#form.getActivitys()">
						<input type="checkbox" 
							name='operation'
							value='<s:property value="id" />'
							onClick="changePermissionByModule(this, 'module_resource_unselect');"
							resourceid='<s:property value="%{#form.id}" />'
							resourcename='<s:property value="%{#form.name}" />'
							<s:if test="#form.permissionType =='public'"> 
							disabled='disabled' 
							checked='checked' 
							</s:if>
							resourcetype='<s:property value="%{@cn.myapps.core.privilege.res.ejb.ResVO@FORM_TYPE}" />'
						/>
						<label><s:property value="name" /></label>
					</s:iterator>
				</td>
			</tr>
			</s:if>
		</s:iterator>
	</table>
</div>
<p></p>
<div id="viewDiv">
	<s:set name="viewList" value="#ViewHelper.get_viewList(#parameters.applicationid)"/>
	<div style="font-weight: bold">视图资源    <input type="button" onclick="selectAll('selectAll','view');" value="全选"/> <input type="button" onclick="selectAll('unSelectAll','view');" value="重置"/></div>
	<table id="viewOperations">
		<!-- 视图资源循环 -->
		<s:iterator value="#viewList">
			<s:set name="view" />
			<tr style="font-size: 12px" class="module_resource" 
				id='<s:property value="id" />'
				resourcename='<s:property value="%{#view.name}" />'
				resourcetype='<s:property value="%{@cn.myapps.core.privilege.res.ejb.ResVO@VIEW_TYPE}" />'>
				<td align="right">
					<s:property value="%{name}" />
					<font color="#666666">[
					<s:if test="#view.permissionType =='public'">{*[cn.myapps.core.permission.permission_type.public]*}</s:if>
					<s:else>{*[cn.myapps.core.permission.permission_type.private]*}</s:else>
					]</font>：
				</td>
				<td>
					<input type="checkbox" 
						name='operation' 
						value='<s:property value="%{#view.id}"/>'
						open = 'open'
						onClick="changePermissionByModule(this, 'module_resource_unselect');"
						resourceid='<s:property value="%{#view.id}" />'
						resourcename='<s:property value="%{#view.name}" />'
						<s:if test="#view.permissionType =='public'"> 
						disabled='disabled' 
						checked='checked' 
						</s:if>
						resourcetype='<s:property value="%{@cn.myapps.core.privilege.res.ejb.ResVO@VIEW_TYPE}" />'
					/>
					<label>{*[Open]*}</label>
					<!-- @package.ClassName@property -->
					<!-- 视图操作循环 -->
					<s:iterator value="#view.getActivitys()">
						<input type="checkbox" 
							name='operation'
							value='<s:property value="id" />'
							onClick="changePermissionByModule(this, 'module_resource_unselect');"
							resourceid='<s:property value="%{#view.id}" />' 
							resourcename='<s:property value="%{#view.name}" />'
							<s:if test="#view.permissionType =='public'"> 
							disabled='disabled' 
							checked='checked' 
							</s:if>
							resourcetype='<s:property value="%{@cn.myapps.core.privilege.res.ejb.ResVO@VIEW_TYPE}" />'
						/>
						<label><s:property value="name" /></label>
					</s:iterator>
				</td>
			</tr>
		</s:iterator>
	</table>
</div>
</o:MultiLanguage>