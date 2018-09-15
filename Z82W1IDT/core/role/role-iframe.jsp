<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.user.ejb.UserVO"%>
<%@ page import="cn.myapps.core.fieldextends.ejb.FieldExtendsVO"%>
<%@ page import="cn.myapps.core.fieldextends.action.FieldExtendsHelper"%>
<%@ page import="java.lang.reflect.Method"%>
<%@ page import="cn.myapps.core.deploy.application.ejb.ApplicationVO"%>
<%@ page import="cn.myapps.core.deploy.application.ejb.ApplicationProcess"%>
<%@ page import="cn.myapps.util.ProcessFactory"%>
<%@ page import="cn.myapps.core.domain.ejb.SystemModuleConfig"%>
<%@ page import="cn.myapps.core.domain.action.DomainHelper"%>

<%
	String contextPath = request.getContextPath();
	String domain = request.getParameter("domain");
	// 获取扩展字段
	FieldExtendsProcess fieldExtendsProcess = (FieldExtendsProcess) ProcessFactory.createProcess(FieldExtendsProcess.class);
	List<FieldExtendsVO> fieldExtendses = fieldExtendsProcess.queryFieldExtendsByTable(domain, FieldExtendsVO.TABLE_USER);
	
	ApplicationProcess applicationProcess = (ApplicationProcess) ProcessFactory.createProcess(ApplicationProcess.class);
    Collection<ApplicationVO> apps = applicationProcess.queryByDomain(domain);
    request.setAttribute("_applications",apps);
   	DomainHelper dh = new DomainHelper();

%>

<%@page import="cn.myapps.core.fieldextends.ejb.FieldExtendsProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="cn.myapps.util.property.PropertyUtil"%>
<%@page import="cn.myapps.core.sysconfig.ejb.KmConfig"%><html>
<o:MultiLanguage>
<s:bean id="userUtil" name="cn.myapps.core.user.action.UserUtil" />
<s:bean name="cn.myapps.core.multilanguage.action.MultiLanguageHelper"	id="mh" /> 
<s:bean name="cn.myapps.core.workcalendar.calendar.action.CalendarHelper" id="ch">
	<s:param name="domain" value="#parameters.domain" />
</s:bean>
<s:bean name="cn.myapps.util.UsbKeyUtil" id="usbKeyUtil" />

<head>
<title>{*[cn.myapps.core.domain.userEdit.user_information]*}</title>
	
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/dtree.css'/>"	type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<link rel="stylesheet" href="<s:url value='/script/jstree/themes/default/style.min.css'/>" type="text/css" />
<link rel="stylesheet" type="text/css" href="<s:url value='/resource/css/ajaxtabs.css'/>" />

<script src='<s:url value="/script/jquery-ui/js/jquery-1.8.3.js"/>'></script>
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="../user/dtree-user.js"/>'></script>
<script src='<s:url value="/script/dtree/contextmenu.js"/>'></script>
<script src='<s:url value="/script/jstree/jstree.min.js"/>' ></script>
<script>
	var contextPath='<%=contextPath%>';
</script>

<script>
var departmentRemindedInformation = '{*[cn.myapps.core.domain.userEdit.tips.please_select_department]*}';
var def = "({*[Default]*})";
var checkedList = new Array(); 
var imageSrc = '<s:url value="/resource/images/loading.gif" />';
var text = '{*[page.loading]*}...';
var URL = '<s:url value="/core/resource/resourcechoice.jsp" />';
var depttree;
var _departmentids = [];
var _departmentNames = [];
var roles ;

jQuery(document).ready(function(){
	selectRole();//初始化角色
	setHideRole();//隐藏禁用软件的角色
	
	$("#departmentBtn").click(function(){
		var departments = [];
		$("input[name='_roleSelectItem']:checked").each(function(){
			var roleId = $(this).val();
			var roleName = $(this).attr("text");
			var roleAppid = $(this).parent().parent(".clip").prev().find("input").val();
			var dept = {"id":roleId,"name":roleName,"applicationid":roleAppid};
			departments.push(dept);
		})
		$("input[name='_kmRoleSelectItem']:checked").each(function(){
			var roleId = $(this).val();
			var roleName = $(this).attr("text");
			var roleAppid = $(this).parent().parent(".clip").prev().find("input").val();
			var dept = {"id":roleId,"name":roleName,"applicationid":roleAppid};
			departments.push(dept);
		})
		
		parent.OBPM.dialog.doReturn(departments);
	})
});


function selectRole(){
	var openedNode = document.getElementsByName("_roleSelectItem");
	var openedId;
  	var roleid;

}

</script>
<style>
.jstree-default.jstree-checkbox-selection .jstree-clicked .jstree-checkbox, 
.jstree-default .jstree-checked .jstree-checkbox {
    background-position: -228px -4px;
}
#contentMainDiv{
	height:320px;
	overflow:auto;
}
#departmentList {
    text-align: center;
    border-top: 1px solid #999;
    padding: 10px;
    margin-top:10px;
}
#departmentList #departmentBtn{
    padding: 5px 10px;
}
</style>
</head>
<body>
<input type="hidden" name="content.domainid" value="<s:property value='#parameters.domain' />" />
<s:hidden cssClass="input-cmd" theme="simple" name="content.defaultDepartment" id="content.defaultDepartment"/>	
<div id="contentMainDiv" class="contentMainDiv">	
	<!-- <s:radio name="filterRoles" list="%{#{'all':'显示全部','selected':'显示选中项'}}" onclick ="displayroles(this.value)"></s:radio> -->
	<input type="radio" name="filterRoles" value="all" checked="checked" onclick ="displayroles(this.value)"/>{*[cn.myapps.core.domain.userEdit.show_all_role]*}
	<input type="radio" name="filterRoles" value="selected" onclick ="displayroles(this.value)"/>{*[cn.myapps.core.domain.userEdit.show_chose_role]*}

	<div style="margin-top: 5px;margin-bottom: 5px;">
		<span>{*[cn.myapps.core.domain.userEdit.role_name]*}:</span>
		<input type="text" id="filterCondition" name="filterCondition" size="4"/>				
		<input type="button" value="{*[Query]*}" onclick="showSearchRoles()"/>
	</div>
	<table cellpadding="0" cellspacing="0" style="vertical-align: top">
		<tr>
			<td class="commFont">
			<div id="rolelist" class="commFont">
			<script type="text/javascript">
			var kmJSON = parent.OBPM.dialog.getArgs()['kmJSON'];
			var datas = parent.OBPM.dialog.getArgs()['data'];
			roles = eval(datas);
		    kmJSON = eval(kmJSON);
		    
			var selArray = new Array();
			var dt = new dTree('dt', 'rolelist','_roleSelectItem');
			var appListArr = [];
			var roleAjax = false;
			dt.config.multiSelect = true;
			
			

			//--定义一个默认根,名称为：角色选择--
			dt.add(
					'1001',
					-1,
					'{*[cn.myapps.core.domain.userEdit.user_role_select]*}',
					'javascript:selectOne(\'1001;{*[cn.myapps.core.domain.userEdit.user_role_select]*}\');',
					'1001',
					'',
					'<%=contextPath%>/resource/images/dtree/app.gif',
					'',
					'false',
					'',
			        '');
			
			//-----应用列表-----	加载应用列表	
			<s:iterator value="#request._applications">
					
					dt.add(
						'<s:property value="id" />',
						'1001',
						'<s:property value="name" />',
						'javascript:selectOne(\'<s:property value="id" />;<s:property value="name" />\');',
						'<s:property value="id" />',
						'',
						'<%=contextPath%>/resource/images/dtree/app.gif',
						'<%=contextPath%>/resource/images/dtree/app.gif',
						'',
						'',
						'',
						'<s:property value="activated" />');
					
			     	selArray[selArray.length] = {id:'<s:property value="id" />',activated:'<s:property value="activated" />'};
					appListArr.push({id:'<s:property value="id" />',activated:'<s:property value="activated" />'});
			</s:iterator> 
			
			
			 $.each(appListArr,function(key,data){
				var appId = data.id;
				$.ajax({
					url : contextPath + "/core/role/rolesListByApplicationJSON.action?application="+appId,
					async:false,
					success : function(data){
						var dataJson = eval("("+data+")");
						$.each(dataJson.data.role,function(key,data){
							var flag  = false;   //回显标识
							for(var i = 0 ; i < roles.length ;i++){
								if(data.roleId == roles[i].id){
									flag =true ; // 选项回显
									break;
								}
							}
							if(flag){
								dt.add(  //(id, pid, name, url, title, target, icon, iconOpen, open)
										data.roleId,
										appId,
										data.roleName,
										'javascript:selectOne('+data.roleId+';'+data.roleName+');',
										data.roleId,
										'',
										'<%=contextPath%>/resource/images/dtree/role.gif',
										'<%=contextPath%>/resource/images/dtree/role.gif',
										'',
										"checked",
										'');
							}else{
								dt.add(  //(id, pid, name, url, title, target, icon, iconOpen, open)
										data.roleId,
										appId,
										data.roleName,
										'javascript:selectOne('+data.roleId+';'+data.roleName+');',
										data.roleId,
										'',
										'<%=contextPath%>/resource/images/dtree/role.gif',
										'<%=contextPath%>/resource/images/dtree/role.gif',
										'',
										'',
										'');
							}
						})
						roleAjax = true;
					}
				})
			}) 
					var $roleList  = $("#rolelist");
					var dtHtml = dt+"";
					
					$roleList.prepend(dtHtml);
					//document.getElementById("rolelist").innerHTML = dt;
					
			
			function displayroles(tempValue){
				if(tempValue == 'all'){
					jQuery(".dTreeNode").css("display","block");
					dt.openAll();
					km_dt.openAll();
				}else if(tempValue == 'selected'){
					showCheckRoles();
					dt.openAll();
					km_dt.openAll();
				}
				setHideRole();//隐藏禁用软件的角色
			}

			function showCheckRoles(){
				jQuery(".dTreeNode").css("display","block");
				jQuery("input[name=_roleSelectItem]").each(function(i){
					if(jQuery(this).attr("checked") != 'checked'){
						jQuery(this).parent().css("display","none");
					}
				});

				//--------KM---------
				jQuery("input[name=_kmRoleSelectItem]").each(function(i){
					if(jQuery(this).attr("checked") != 'checked'){
						jQuery(this).parent().css("display","none");
					}
				});

				jQuery("a").each(function(i){
					jQuery(this).parent().css("display","block");
				});
			}
			
			function showSearchRoles(){
				dt.openAll();
				var textVal = document.getElementById("filterCondition").value;
				jQuery("input[name=_roleSelectItem]").each(function(i){
					var StrVal = jQuery(this).attr("text");
					if(StrVal.indexOf(textVal) == -1){
						jQuery(this).parent().css("display","none");
					}else{
						jQuery(this).parent().css("display","block");									
					}
				});

				//--------KM---------

				jQuery("input[name=_kmRoleSelectItem]").each(function(i){
					var StrVal = jQuery(this).attr("text");
					if(StrVal.indexOf(textVal) == -1){
						jQuery(this).parent().css("display","none");
					}else{
						jQuery(this).parent().css("display","block");									
					}
				});

				jQuery("a").each(function(i){
					jQuery(this).parent().css("display","block");
				});
				setHideRole();//隐藏禁用软件的角色
			}

		<% 
		if(dh.getModuleConfigByDomain(domain,SystemModuleConfig.KM)){
		%>

			//--------KM---------
			var km_dt = new dTree('km_dt', 'kmRoles','_kmRoleSelectItem');
			km_dt.config.multiSelect = true;
            
			km_dt.add(
				'km_id',
				-1,
				'{*[km.name]*}',
				'javascript:selectOne(\'km_id;{*[km.name]*}\');',
				'km_id',
				'',
				'<%=contextPath%>/resource/images/dtree/app.gif',
				'',
				'false',
				'false',
		        '');
		//--------KM下的角色列表--------
	    
			$.each(kmJSON,function(){
				var flag = false;
				for(var i = 0 ; i <roles.length ; i++){
					if(this.id == roles[i].id){
						flag =true ; // 选项回显
						break;
					}
				}
				if(flag){
					km_dt.add(
							this.id,
							'km_id',
							this.name,
							'javascript:selectOne(\'<s:property value="id" />;<s:property value="name" />\');',
							this.id,
							'',
							'<%=contextPath%>/resource/images/dtree/role.gif',
							'<%=contextPath%>/resource/images/dtree/role.gif',
							'',
							"checked",
							'');
				}else{
					km_dt.add(
							this.id,
							'km_id',
							this.name,
							'javascript:selectOne(\'<s:property value="id" />;<s:property value="name" />\');',
							this.id,
							'',
							'<%=contextPath%>/resource/images/dtree/role.gif',
							'<%=contextPath%>/resource/images/dtree/role.gif',
							'',
							'',
							'');
				}
			}); 
			document.write(km_dt);
		<%}%>
			</script></div>
			</td>
		</tr>
	</table>
</div>

<div id="departmentList">
	<input type="button" id="departmentBtn" value="确认" />
</div>
</body>
</o:MultiLanguage>
</html>