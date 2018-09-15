<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<html><o:MultiLanguage>
<head>
<title>{*[MultiLanguage]*}{*[Info]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
</head>
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script src="<s:url value="/script/list.js"/>"></script>
<script src="<s:url value='/script/help.js'/>"></script>

<script type="text/javascript">
jQuery(document).ready(function(){
	inittab();
	cssListTable();
	window.top.toThisHelpPage("domain_multiLanguages_info");
});

function checkForm(){
	var label=document.getElementsByName("content.label")[0];
	var text=document.getElementsByName("content.text")[0];
	if(label.value==null || label.value==""){
		alert("{*[cn.myapps.core.multilanguage.please_input_label]*}");
		return false;
	}
	else if(text.value==null || text.value==""){
		alert("{*[cn.myapps.core.multilanguage.please_input_text]*}");
		return false;
	}
	else return true;
}

function ev_save(){
	if(checkForm()){
		var url = '<s:url action="save"/>';
		document.forms[0].action=url;
		if(!containSpecial(document.getElementById('contentLabel').value)){
			document.forms[0].submit();
		}else{
			alert('标签不能包含特殊字符！');
		}
	}
}

function doExit(){
	var applicationid = jQuery("input[name='application']").val(); 
	contentForm.action="<s:url value='/core/multilanguage/list.action'/>?id=" + applicationid + "&selected=btnMltLng&tab=4";
	contentForm.submit();
}

//校验s是否包含特殊字符
function containSpecial(s)
{
	var containSpecial = RegExp(/[(\ )(\~)(\!)(\@)(\#)(\$)(\%)(\^)(\&)(\*)(\()(\))(\-)(\_)(\+)(\=)(\[)(\])(\{)(\})(\|)(\\)(\;)(\:)(\')(\")(\,)(\.)(\/)(\<)(\>)(\?)(\)]+/);
	return (containSpecial.test(s));
}

</script>

<body id="domain_multiLanguages_info" class="contentBody">
<s:form name="contentForm" theme="simple" action="save" method="post">
	<s:hidden name="sm_label" value="%{#parameters.sm_label}"/>
	<s:hidden name="sm_text" value="%{#parameters.sm_text}"/>
	<s:hidden name="sm_type" value="%{#parameters.sm_type}"/>
	<s:hidden name="_currpage" value="%{#parameters._currpage}"/>
	<s:hidden name="_pagelines" value="%{#parameters._pagelines}"/>
	<s:textfield name="tab" cssStyle="display:none;" value="4" />
	<s:textfield name="selected" cssStyle="display:none;" value="" />
<s:bean name="cn.myapps.core.multilanguage.action.MultiLanguageHelper" id="mh" />
<div class="ui-layout-center">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr class="nav-td" style="height:27px;">
		<td rowspan="2"><div style="width:400px"><%@include file="/common/commontab.jsp"%></div></td>
		<td class="nav-td" width="100%">&nbsp;</td>
	</tr>
	<tr class="nav-s-td" >
		<td class="nav-s-td" align="right">
			<table class="table_noborder">
					<tr><td>
						<div style="text-align: right;">
							<img style="vertical-align: middle;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
							<button type="button" class="button-image"
								onClick=" ev_save();"><img
								src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
							<button type="button" class="button-image"
								onClick="doExit()"><img
								src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
						</div>
					</td></tr>
				</table>
		</td>
	</tr>
</table>	
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div class="navigation_title">{*[MultiLanguages]*}</div>
	<div id="contentMainDiv" class="contentMainDiv">
		<table class="table_noborder id1" width="100%">
		        <s:hidden name="content.domainid" value = "%{#parameters.domain}"/>
		        <s:hidden name="application" value = "%{#parameters.application}"/>
		        
		        <s:hidden name="content.id" />
				<tr>
					<td class="commFont">{*[Label]*}:</td>
				</tr>
				<tr>
					<td><s:textfield id="contentLabel"  size="50" cssClass="input-cmd" theme="simple" label="{*[Label]*}"  name="content.label" /></td>
				</tr>
				<tr><td class="commFont">{*[Text]*}:</td>
				</tr>
				<tr>
				<td>
				<s:textfield id="contentText" size="50" cssClass="input-cmd" theme="simple" label="{*[Text]*}" name="content.text" /></td></tr>
				
				<tr><td class="commFont">{*[Type]*}:</td>
				</tr>
				<tr>	
				<td>
				<s:select label="{*[Type]*}" cssClass="input-cmd" name="content.type" theme="simple" list="#mh.getTypeList()" /></td></tr>
		</table>
	</div>
</div>
</s:form>
</body>
</o:MultiLanguage></html>
