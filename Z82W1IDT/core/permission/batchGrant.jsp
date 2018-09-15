<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/tags.jsp"%>
<%@include file="/common/head.jsp" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<o:MultiLanguage>
<html>
<title>{*[Resources]*}</title>
<link rel="stylesheet" type="text/css"	href="<s:url value='/resource/css/main.css' />" />
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<link rel="stylesheet" href='<s:url value="/resource/css/dtree.css" />' type="text/css">
<link rel="stylesheet" href='<s:url value="/resource/css/popupmenu.css" />' type="text/css">
<!-- 树形插件 -->
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/_lib/jquery.cookie.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/_lib/jquery.hotkeys.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/jquery.jstree.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/plugins/jquery.jstree.checkbox.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/json/json2.js'/>"></script>
<script src="<s:url value='/core/permission/dtree_perssiom.js'/>"></script>
<!-- 布局插件 -->
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/layout/jquery.layout.js'/>"></script>

<script type="text/javascript">
jQuery(document).ready(function(){
	window.top.toThisHelpPage("application_info_generalTools_role_info_batchAuthorize");
});
function selectBtn(mode,obj){
	if(mode =='selectAll'){//全选模式
		if(obj){
			while(obj.tagName != "TABLE"){
				obj = obj.parentNode;
			}
			jQuery(obj).find("input[type=checkbox]").each(function(){
				jQuery(this).attr("checked",true);
			});
		}
	}else if(mode =='unSelectAll'){//反选模式
		if(obj){
			while(obj.tagName != "TABLE"){
				obj = obj.parentNode;
			}
			jQuery(obj).find("input[type=checkbox]").each(function(){
				jQuery(this).attr("checked",false);
			});
		}
	}
	
}
</script>
<head>
<style type="text/css">


body {
	margin: 0px;
	background-color: #FFFFFF;
	font-size:12px;

}
.tab-content-left{width:254px;float: left;border: 1px solid gray;}
.tab-content-right{height: 375px;overflow: auto;border: 1px solid gray;padding: 10px;}
</style>
</head>
<title></title>
<body style="overflow: scroll;">
<DIV class="ui-layout-north">
	<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>&nbsp;&nbsp;</td>
			<td class="line-position2">
				<a href="###" onClick="document.forms[0].submit();" style="text-decoration:none;"><img border="0" src="<s:url value="/resource/image/save.gif"/>">{*[OK]*}</a>
			</td>
			<td>&nbsp;&nbsp;</td>
			<td class="line-position2">
				<a href="###" onClick="OBPM.dialog.doExit();" style="text-decoration:none;"><img border="0" src="<s:url value="/resource/image/cancel2.gif"/>">{*[Cancel]*}</a>
			</td>
		</tr>
	</table>
</DIV>
<DIV class="ui-layout-center">
		<%@include file="/common/msg.jsp"%>
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<div id="contents">
		<s:form method="post" action="batchGrant" theme="simple">
		<input type="hidden" id="applicationid" id="applicationid" name="applicationid"
			value='<s:property value="#parameters.applicationid" />' />
		<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper"
			id="ModuleHelper">
			<s:param name="applicationid" value="#applicationid" />
		</s:bean>
		<s:bean name="cn.myapps.core.resource.action.ResourceUtil"
			id="ResourceUtil">
		</s:bean>
		<s:bean name="cn.myapps.core.role.action.RoleHelper" id="RoleHelper">
		</s:bean>
		<!-- Role -->
		<table width="100%">
			<tr>
				
			</tr>
			<tr>
				<td colspan="2">
					<div style="background-color: #CCCCCC">
						<b>角色</b><span style="font-size: 12; color: blue">（选择需要批量授权的角色，此次设置将会清空角色原来的授权设置，未选择的角色将不受影响。）</span>
					</div> <s:set name="roleList"
						value="#RoleHelper.getRoleList(#parameters.applicationid)" />
					<table>
						<tr style="font-size: 12px" class="module_resource">
							<td><s:iterator value="#roleList">
									<s:set name="role" />
									<span id="formDiv"> <input
										id="<s:property value='#role.getId()'/>" type="checkbox"
										name="_roles" value="<s:property value='#role.getId()'/>">
										<label><s:property value="#role.getName()" /></label> </input>
									</span>
<%
cn.myapps.base.dao.PersistenceUtils.currentSession().clear();
%>
								</s:iterator></td>
						</tr>
					</table> <script type="text/javascript">
						<s:iterator value="#parameters._roles">
						<s:set name="rid" />
						document.getElementById("<s:property value='#rid'/>").checked = true;
						</s:iterator>
					</script>
				</td>
			</tr>
			<tr>
				<td valign="top">
					<!-- Menu -->
					<div style="background-color: #CCCCCC">
						<b>菜单资源</b>
					</div> <s:set name="resourceList"
						value="#ResourceUtil.getResourcesByApp(#parameters.applicationid)" />
					<table>
						<tr><td>
							<input type="button" onclick="selectBtn('selectAll',this);" value="全选" />
							<input type="button" onclick="selectBtn('unSelectAll',this);" value="重置" />
							</td>
						</tr>
						<s:iterator value="#resourceList">
							<s:set name="resource" />
							<s:if test="#resource.type.equals('00') || #resource.type.equals('100')">
								<tr style="font-size: 12px" class="module_resource">
									<td>
										<div id="formDiv">
											<input id="<s:property value='#resource.id'/>"
												<s:if test="#resource.permissionType =='public'"> 
												checked="checked"
												</s:if> 
												type="checkbox" name="_grantedresources"
												value='<s:property value="#resource.id" />' /> <label>
												<s:property value="#resource.getFullName()" />
												<font color="#666666">[
												<s:if test="#resource.permissionType =='public'">{*[cn.myapps.core.permission.permission_type.public]*}</s:if>
												<s:else>{*[cn.myapps.core.permission.permission_type.private]*}</s:else>
												]</font>
											</label> <input type="hidden" name="_allresources"
												value='<s:property value="#resource.id" />'>
										</div>
									</td>
								</tr>
							</s:if>
						</s:iterator>
					</table> <script type="text/javascript">
						<s:iterator value="#parameters._grantedresources">
						<s:set name="rsid" />
						document.getElementById("<s:property value='#rsid'/>").checked = true;
						</s:iterator>
					</script>
				</td>
				<td valign="top">
					<div style="background-color: #CCCCCC">
						<b>模块资源</b><span style="font-size: 12; color: blue">（表单、视图等）</span>
					</div> <!-- 模块 --> <s:set name="moduleList"
						value="#ModuleHelper.get_moduleList(#parameters.applicationid)" />
					<s:iterator value="#moduleList">
						<s:set name="module" />
						<table>
							<tr>
								<td><b>模块:<s:property value="#module.name" /></b></td>
							</tr>
							</tr>
							<tr style="font-size: 12px" class="module_resource">
								<td>
									<div id="formDiv">
										<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper"
											id="FormHelper">
											<s:param name="applicationid"
												value="#parameters.applicationid" />
											<s:param name="moduleid" value="#module.id" />
										</s:bean>
										<s:set name="formList" value="#FormHelper.get_FormByModule()" />
										<div style="font-weight: bold">表单资源</div>
										<table>
											<tr><td>
												<input type="button" onclick="selectBtn('selectAll',this);" value="全选" />
												<input type="button" onclick="selectBtn('unSelectAll',this);" value="重置" />
												</td>
											</tr>
											<!-- 表单资源循环 -->
											<s:iterator value="#formList">
												<s:set name="form" />
												<s:if test="#form.type !=256">
													<tr style="font-size: 12px" class="module_resource">
														<td align="right"><s:property value="%{name}" />
														<font color="#666666">[
														<s:if test="#form.permissionType =='public'">{*[cn.myapps.core.permission.permission_type.public]*}</s:if>
														<s:else>{*[cn.myapps.core.permission.permission_type.private]*}</s:else>
														]</font>
														：</td>
														<td>
															<input id='<s:property value="#form.getId()" />' type="checkbox" checked="checked"
																	name='_grantedoperations'
																	<s:if test="#form.permissionType =='public'"> 
																	</s:if> 
																	value='<s:property value="#form.getId()" />' />
															<label>{*[Open]*}</label>
															<input type="hidden" name='_alloperations'
																	value='FORM@<s:property value="#form.getId()" />@<s:property value="#form.getId()" />' />
															<!-- 表单操作循环 --> 
															<s:iterator value="#form.getActivitys()">
																<input id='<s:property value="id" />' type="checkbox"
																	name='_grantedoperations'
																	<s:if test="#form.permissionType =='public'"> 
																	checked="checked"
																	</s:if> 
																	value='<s:property value="id" />' />
																<label><s:property value="name" /> </label>
																<input type="hidden" name='_alloperations'
																	value='FORM@<s:property value="#form.getId()" />@<s:property value="id" />' />
															</s:iterator>
														</td>
													</tr>
													</s:if>
											</s:iterator>
										</table>
									</div>
								</td>
							</tr>
							<!-- 视图 -->
							<tr style="font-size: 12px" class="module_resource">
								<td>
									<div id="viewDiv">
										<s:bean name="cn.myapps.core.dynaform.view.action.ViewHelper"
											id="ViewHelper">
											<s:param name="applicationid"
												value="#parameters.applicationid" />
											<s:param name="moduleid" value="#module.id" />
										</s:bean>

										<s:set name="viewList"
											value="#ViewHelper.get_viewList(#parameters.applicationid)" />
										<div style="font-weight: bold">视图资源</div>
										<table>
											<tr><td>
												<input type="button" onclick="selectBtn('selectAll',this);" value="全选" />
												<input type="button" onclick="selectBtn('unSelectAll',this);" value="重置" />
												</td>
											</tr>
											<!-- 视图资源循环 -->
											<s:iterator value="#viewList">
												<s:set name="view" />
													<tr style="font-size: 12px" class="module_resource">
														<td align="right"><s:property value="%{name}" />
														<font color="#666666">[
														<s:if test="#view.permissionType =='public'">{*[cn.myapps.core.permission.permission_type.public]*}</s:if>
														<s:else>{*[cn.myapps.core.permission.permission_type.private]*}</s:else>
														]</font>
														：</td>
														<td>
															<input id='<s:property value="#view.getId()" />' type="checkbox" checked="checked"
																	name='_grantedoperations'
																	<s:if test="#view.permissionType =='public'"> 
																	</s:if> 
																	value='<s:property value="#view.getId()" />' />
															<label>{*[Open]*}</label>
															<input type="hidden" name='_alloperations'
																	value='VIEW@<s:property value="#view.getId()" />@<s:property value="#view.getId()" />' />
															<!-- @package.ClassName@property --> 
															<!-- 视图操作循环 --> 
															<s:iterator
																value="#view.getActivitys()">
																<input id='<s:property value="id" />' type="checkbox"
																<s:if test="#view.permissionType =='public'"> 
																	checked="checked"
																	</s:if> 
																	name='_grantedoperations'
																	value='<s:property value="id" />' />
																<label><s:property value="name" /> </label>
																<input type="hidden" name='_alloperations'
																	value='VIEW@<s:property value="#view.getId()" />@<s:property value="id" />' />
															</s:iterator>
														</td>
													</tr>
											</s:iterator>
										</table>
									</div>
								</td>
							</tr>
						</table>
					</s:iterator> <script type="text/javascript">
						<s:iterator value="#parameters._grantedoperations">
						<s:set name="oid" />
						document.getElementById("<s:property value='#oid'/>").checked = true;
						</s:iterator>
					</script>
				</td>
			</tr>
		</table>
	</s:form>
	</div>
</DIV>
</body>
</html>
</o:MultiLanguage>
