<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<html><o:MultiLanguage>
<head>
<title>{*[Module]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<style type="text/css">
<!--
.STYLE2 {
	font-size: 16px;
	color: #000000;
}
.STYLE3 {color: #000000}
-->
</style>
</head>
<script>
function ev_isPagination(item) {
	if (item.checked && item.value == "true") {
		pl_tr.style.display="";
	} else {
		pl_tr.style.display="none";
		document.getElementsByName("content.v_pagelines")[0].value="";
	}
}


function on_submit(){
    var v_activitys = document.all("content.v_activity");
    var i = 0;
    
    while(i<v_activitys.length){
		if(v_activitys[i].value=="2" ){
        	v_activitys[i].disabled = "";
        }
        i++;
    }
}

function validate1(obj) {
	if (obj.value == "" || obj.value == 'undefined') {
		jQuery("#validate_info1").css("display","");
		jQuery("#validate_info1").html("{*[page.name.notexist]*}");
		return false;
	}
	else {
		jQuery("#validate_info1").css("display","none");
		jQuery("#validate_info1").html("&nbsp;");
		return true;
	}
}

function validate2(obj) {
	if (obj.value == "" || obj.value == 'undefined') {
		jQuery("#validate_info2").css("display","");
		jQuery("#validate_info2").html("{*[page.description.notexist]*}");
		return false;
	}
	else {
		jQuery("#validate_info2").css("display","none");
		jQuery("#validate_info2").html("&nbsp;");
		return true;
	}
}

function ev_next() {
	var flag = false;
	if (jQuery("#name").val() == "" || jQuery("#name").val() == 'undefined') {
		jQuery("#validate_info1").css("display","");
		jQuery("#validate_info1").html("{*[page.name.notexist]*}");
		flag = true;
	}
	if (jQuery("#des").val() == "" || jQuery("#des").val() == 'undefined') {
		jQuery("#validate_info2").css("display","");
		jQuery("#validate_info2").html("{*[page.description.notexist]*}");
		flag = true;
	}
	if (flag)
		return;
	
	document.forms[0].action='<s:url action="toviewtype"></s:url>';
	on_submit();
	document.forms[0].submit();
}

</script>


<body>

<s:form action="save" method="post">

<%@include file="/common/page.jsp"%>
<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<table width="99%">
	<tr style="height:100px;">
		<td>
			<%@include file="wizard_guide.jsp" %>
		</td>
		<td rowspan="2" style="width:200px;"><s:include value="wizard_common.jsp"><s:param name="step" value="51"/></s:include></td>
		
	</tr>
	<tr style="height:400px; vertical-align: top;">
		<td style="text-align: center;">
		 	<table class="marAuto">
	   		<tr>
	   			<td class="commFont commLabel">{*[Name]*}:</td>
	   			<td><s:textfield size="50" cssClass="input-cmd" label="{*[Name]*}" name="content.v_name"  theme="simple" onblur="validate1(this);" id="name"/></td>
	   			<td style="width:100px;"><div id="validate_info1" style="display:none; color:red">&nbsp;</div></td>
	   		</tr>
       		<tr>
       			<td class="commFont commLabel">{*[Description]*}:</td>
       			<td><s:textfield size="50" cssClass="input-cmd" label="{*[Description]*}" name="content.v_description"  theme="simple" onblur="validate2(this);" id="des"/></td>
       			<td style="width:100px;"><div id="validate_info2" style="display:none; color:red">&nbsp;</div></td>
       		</tr>
       		<tr>
       			<td class="commFont commLabel">{*[Activity]*}:</td>
       			<td align="left" style="font-size:12px">
        			<input type="checkbox" disabled="disabled" checked="checked" name="content.v_activity" value="2" />{*[Create]*}
        			<input type="checkbox" name="content.v_activity" value="3"  />{*[Delete]*}
        			<input type="checkbox" name="content.v_activity" value="16"  />{*[page.wizard.step5.export_to_excel]*}</td>
       			<td>&nbsp;</td>
       		</tr>
       		<tr>
        		<td class="commFont commLabel">{*[Pagination]*}:</td>
        		<td><input type="checkbox" name="content.v_isPagination" value="true" checked="checked" disabled="disabled"  />
						<span id="pl_tr"><s:select label="{*[PageLines]*}" name="content.v_pagelines" 
															list="#{'05':'5','10':'10','15':'15','30':'30'}"
															theme="simple" />{*[page.view.pageline]*}
						</span>
				</td>
				<td>&nbsp;</td>
			</tr>
	   		<tr>
	    		<td class="commFont commLabel">{*[page.wizard.step5.show_total_rows]*}:</td>
	    		<td>
	    			<s:checkbox name="content.v_isShowTotalRow" theme="simple"/>
	    		</td>
	    		<td>&nbsp;</td>
	   		</tr>
       		<tr>
        		<td valign="top" colspan="2"  align="center"><button type="button" onClick="forms[0].action='<s:url action="backtostep4"></s:url>';forms[0].submit();">{*[Back]*}</button> &nbsp;<button type="button" onClick="ev_next()">{*[Next]*}</button></td>
       		</tr>
			<tr>
				<td colspan="3"><br/>
					*{*[page.wizard.step5.description1]*}<br />
					*{*[page.wizard.step5.description2]*}.<font color="red">{*[page.wizard.step5.description3]*}</font>.{*[page.wizard.step5.description4]*}<br/>
				</td>
			</tr>
		</table>
	</td>
	</tr>
</table>
</s:form>
</body>
</o:MultiLanguage></html>
