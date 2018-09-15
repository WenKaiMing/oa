<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<html>
<o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.role.role_info]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" type="text/css" href="<s:url value='/resource/css/ajaxtabs.css'/>" />
</head>
<script>
	var imageSrc = '<s:url value="/resource/images/loading.gif" />';
	var text = '{*[page.loading...]*}';

	jQuery(document).ready(function(){
		inittab();
	});
	function checkSpace(obj) {
		var regex = /[^\w\u4e00-\u9fa5^(^)^（^）^+^#]/g;
		obj.value = obj.value.replace(regex, '');
	}

	//配置资源
	function configureResources(){
		var myDate=new Date().toString();
		var applicationid = document.getElementsByName("content.applicationid")[0].value;
		// 写死type参数测试
		var url = contextPath + '/core/permission/list.action?roleid=<s:property value="content.id" />&type=0&applicationid='+applicationid+'&pageNo=1&date='+myDate;
		wy = '200px';
		wx = '200px';
		//var value= window.showModalDialog(contextPath + '/frame.jsp?title={*[Configuration]*}{*[Resources]*}',
				//url, );
		OBPM.dialog.show({
				opener:window.parent,
				width: 1000,
				height: 520,
				url: url,
				args: {},
				title: '{*[cn.myapps.core.role.configuration_resources]*}',
				close: function(rtn) {
					window.top.toThisHelpPage("application_info_generalTools_role_info");
				}
		});
	}
	
	jQuery(document).ready(function(){
		//设置iframe高度
		jQuery("#frame").height(function(){
			var bodyH = jQuery("body").height();
			var divH = jQuery(".table_noborder").height();
			var height = bodyH - divH - 54 - 27 - 15;
			return height;
		});
		var oViewFrame = parent.document.getElementById("frame");
		if (oViewFrame) {
			oViewFrame.style.height =(jQuery("#main").height()+30)+"px";			
		}
		if(window.top.document.getElementById("helper")){
			window.top.toThisHelpPage("application_info_generalTools_role_info");
		}
	});

	function checkForm(){
		var name=document.getElementsByName("content.name")[0];
		var roleNo=document.getElementsByName("content.roleNo")[0];
		if(name.value==null || name.value==""){
			alert("{*[cn.myapps.core.role.please_input_name]*}");
			return false;
		}
		//else if(roleNo.value==null || roleNo.value==""){
			//alert("{*[cn.myapps.core.workflow.statelabel.please_input_value]*}");
			//return false;
		//}
		else return true;
	}

	function doSave(){
		if(checkForm()){
			document.forms[0].action='<s:url action="save"></s:url>';
			document.forms[0].submit();
		}
	}

	function doSaveAndNew(){
		if(checkForm()){
			document.forms[0].action='<s:url action="saveAndNew"></s:url>';
			document.forms[0].submit();
		}
	}
</script>

<body id="application_info_generalTools_role_info" class="contentBody">
<s:form action="save" method="post" theme="simple">
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr style="height: 27px;">
			<td rowspan="2"><div class="appsUsualIncludeTab"><%@include file="/common/commontab.jsp"%></div></td>
			<td class="nav-td" width="100%">&nbsp;</td>
		</tr>
		<tr>
			<td class="nav-s-td" align="right">
			<table width="100%" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" align="right">
						<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
				    <s:if test="content.id!=null">
						<button type="button" class="button-image"
							onClick="configureResources()"><img
							src="<s:url value="/resource/imgnew/act/plugin.png"/>" border=0>{*[cn.myapps.core.role.resources_authorize]*}</button>
					</s:if>
						<button type="button" class="button-image"
							onClick="doSaveAndNew()"><img
							src="<s:url value="/resource/imgnew/act/act_12.gif"/>">{*[Save&New]*}</button>
						<button type="button" class="button-image"
							onClick="doSave()"><img
							src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
						<button type="button" class="button-image"
							onClick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();"><img
							src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div class="navigation_title">{*[Role]*}</div>
	<div id="contentMainDiv" class="contentMainDiv">
	<%@include file="/common/page.jsp"%>
	<table class="table_noborder id1">
		<s:hidden name="sm_name" value="%{#parameters.sm_name}"/>
		<s:hidden name="tab" value="1" />
		<s:hidden name="selected" value="%{'btnRole'}" />
			<tr>
				<td class="commFont" align="left">{*[Name]*}:</td>
				<td class="commFont" align="left">{*[cn.myapps.core.role.label.id]*}:</td>
			</tr>
			<tr>
				<td><!-- ww:textfield cssClass="input-cmd" onblur="checkSpace(this)" label="{*[Name]*}" name="content.name"  /> -->
				<s:textfield cssClass="input-cmd" onblur="checkSpace(this)"
					label="{*[Name]*}" name="content.name" /></td>
				<td><s:textfield cssClass="input-cmd" onblur="checkSpace(this)"
					label="{*[cn.myapps.core.role.label.id]*}" name="content.roleNo" /></td>
			</tr>
			<tr>
				<td>{*[Status]*}:</td>
				<td>{*[cn.myapps.core.role.default_role]*}:</td>
			</tr>
			<tr>
				<td><s:radio name="content.status" list="#{1:'{*[cn.myapps.core.domain.department.valid]*}',0:'{*[cn.myapps.core.domain.department.invalid]*}'}" theme="simple"/></td>
			    <td><s:radio name="content.defaultRole" list="#{true:'{*[Yes]*}',false:'{*[No]*}'}" theme="simple"/></td>
			</tr>
			
		<s:hidden name="content.applicationid"	value="%{#parameters.application}" />
	</table>
	<s:if test="content.id!=null&&content.id.trim().length()>0">
		<iframe scrolling="auto" id="frame" name="Frame" border="0"
			src="<s:url value='/core/user/listRole.action'/>?sm_userRoleSets.roleId=<s:property value="content.id" />"
			width="100%" height="300" frameborder="0" /></iframe>
	</s:if>
	</div>
</s:form>
</body>
</o:MultiLanguage>
</html>
