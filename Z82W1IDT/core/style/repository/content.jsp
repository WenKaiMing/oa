<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper" id="moduleHelper" /> 
<html><o:MultiLanguage>
<head>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<script>

var bXmlHttpSupport = (typeof XMLHttpRequest != "undefined" || window.ActiveXObject);

if (typeof XMLHttpRequest == "undefined" && window.ActiveXObject) {
    function XMLHttpRequest() {
        var arrSignatures = ["MSXML2.XMLHTTP.5.0", "MSXML2.XMLHTTP.4.0",
                             "MSXML2.XMLHTTP.3.0", "MSXML2.XMLHTTP",
                             "Microsoft.XMLHTTP"];
                         
        for (var i=0; i <  arrSignatures.length; i++) {
            try {        
                var oRequest = new ActiveXObject(arrSignatures[i]);            
                return oRequest;        
            } catch (oError) { /*ignore*/ }
        }          

        throw new Error("MSXML is not installed on your system.");               
    }
}    
//   
var isNameExit=false;

function checkExitName(){
	var name=document.getElementById("name").value;
	if(name==null || name==""){
		var tips = document.getElementById('tips');
		isNameExit=false;
    	tips.style.color="#FF0000";
    	tips.innerHTML = "名称不能为空！";
	}
	else
		checkname();
}

function checkname() {    
	var url="checkexitname.action?name="+document.getElementById("name").value+"&application="+document.getElementById("application").value;
    if(bXmlHttpSupport) {
        var oRequest = new XMLHttpRequest();
        oRequest.onreadystatechange = function() {
            if(oRequest.readyState == 4) { 
                var message = oRequest.responseText;
                var tips = document.getElementById('tips');
                if(message=="false"){
                	isNameExit=true;
                	tips.style.color="#339900";
                	tips.innerHTML = "名称可以使用！";
                }
                else if(message=="true"){
                	isNameExit=false;
                	tips.style.color="#FF0000";
                	tips.innerHTML = "名称已存在！";
                }
                
               
            }
        };
        oRequest.open('POST', url);
        oRequest.send(null);
    }
}

function formSubmit(){
	if(!isNameExit){
		alert("名称已存在！");
		return false;
	}
	document.forms[0].action='<s:url action="save"></s:url>';
	document.forms[0].submit();
}

function returncheck()
{
     var mode = document.getElementById('mode').value;
     if(mode==''){document.getElementById('s_module').value='';}
     document.forms[0].action="<s:url action='list.action'/>";
     document.forms[0].submit();
}

jQuery(document).ready(function(){
	inittab();
	window.top.toThisHelpPage("application_info_libraries_styleLibs_info");
});
</script>
<title>{*[StyleLib]*}{*[Info]*}</title>
</head>
<body id="application_info_libraries_styleLibs_info" class="contentBody">
<s:form name="cotentfrom" action="save" method="post" theme="simple">
	<s:hidden name="sm_name" value="%{#parameters.sm_name}"/>
	<s:hidden name="sm_content" value="%{#parameters.sm_content}"/>
	<table cellpadding="0" cellspacing="0" width="100%">
		<tr class="nav-td"  style="height:27px;">
			<td rowspan="2"><div style="width:500px"><%@include file="/common/commontab.jsp"%></div></td>
			<td class="nav-td" width="100%">&nbsp;</td>
		</tr>
		<tr class="nav-s-td">
			<td align="right" class="nav-s-td">
				<table width="100%" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" align="right">
						<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
						<button type="button" class="button-image"
							onClick="forms[0].action='<s:url action="save"></s:url>';forms[0].submit();"><img
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
	<div class="navigation_title">{*[StyleLibs]*}</div>
	<div id="contentMainDiv" class="contentMainDiv">
	<%@include file="/common/page.jsp"%>
		<table class="table_noborder id1">
			<s:hidden name='s_module' value="%{#parameters._moduleid}" />
			<s:hidden name='content.version'></s:hidden>
			<s:hidden id="application" name='content.applicationid' value="%{#parameters.application}" />
			<s:hidden name='mode' value="%{#parameters.mode}" />
			<s:textfield name="tab" cssStyle="display:none;" value="2" />
			<s:textfield name="selected" cssStyle="display:none;" value="%{'btnStyleLibs'}" />
			<tr>
			  <td colspan="2" class="commFont">{*[Name]*}:</td>
			</tr>
			<tr>
			  <td width="30px">
			      <s:textfield cssClass="input-cmd" label="{*[Name]*}" theme="simple" id="name" name="content.name" />
			  </td>
			  <td align="left"><div id="tips"></div></td>
			</tr>
			<tr>
				<td colspan="2" class="commFont">{*[Content]*}：<button type="button" class="button-image" onclick="openIscriptEditor('content.content','{*[Script]*}{*[Editor]*}','{*[StyleLib]*}{*[Info]*}','content.name','{*[Save]*}{*[Success]*}');"><img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/></button></td>
			</tr>
			<tr style="height:80%;">
				<td colspan="2" valign="top">
					<s:textarea cssClass="content-textarea" rows="15" theme="simple" name="content.content"/>
				</td>
			</tr>
		</table>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>
