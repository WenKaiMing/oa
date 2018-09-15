<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<html>
<o:MultiLanguage>
	<head>
	<title>{*[Module]*}</title>
	<script src="<s:url value='copymodule.js'/>"></script>
	<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />"
		type="text/css">
	<style type="text/css">
<!--
.STYLE2 {
	font-size: 16px;
	color: #000000;
}

.STYLE3 {
	color: #000000
}
-->
</style>
	<script>

function ev_next(){
    var moduleId = '<s:property value='#parameters.s_module'/>';
    var url='<s:url action="copyviewafter"></s:url>';
    document.forms[0].action=url;
    document.forms[0].submit();
}	
function on_change(d){
	    if(d.checked){
	       document.getElementById("nextTo").disabled = false;
	    }else{
	       document.getElementById("nextTo").disabled = true;
	    }
	}
function ev_init(){
	    //alert(document.getElementById("nextTo").name);
	    document.getElementById("nextTo").disabled = true;
}
window.onload = ev_init;
</script>
	</head>
	<body>
	<s:form action="tostep2forminfo" method="post">
		<%@include file="/common/page.jsp"%>
		<s:hidden name="s_module" value="%{#parameters.s_module}" />
		<s:hidden name="moduleid" value="%{content.moduleId}" />
		<table width="100%" height="359" border="1" class="list-table"
			valign="bottom" cellpadding="0" cellspacing="0" bordercolor="#999999">
			<tr bgcolor="#CCCCCC">
				<td width="100%" height="26" class="STYLE2" class="commFont">{*[page.copyview.success]*}</td>
			</tr>
			<tr>
			<tr valign="top" align="center">
				<td height="334"><%@include file="/common/msg.jsp"%>
				<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
					<%@include file="/portal/share/common/msgbox/msg.jsp"%>
				</s:if>
				<table>
					<tr>
						<td class="commFont"></td>
						<td class="commFont"></td>
					</tr>
					<tr>
						<td colspan="2"></td>
					</tr>
					<tr>
						<td></td>
						<td class="commFont">[*如要复制流程点击复制流程选项再点下一步,否则点击完成*]</td>
					</tr>
					<tr>
						<td></td>
						<td class="commFont"><input type="checkbox" id="copyview"
							value="next" onclick="on_change(this);">{*[page.copyflow.ToNext]*}</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
						<button type="button" onClick="ev_next();" id="nextTo">{*[Next]*}</button>
						</td>
						<td colspan="2" align="center">
						<button type="button"
							onClick="doCancel();">{*[Finish]*}</button>
						</td>
					</tr>
				</table>

				</td>
			</tr>
		</table>
	</s:form>
	</body>
</o:MultiLanguage>
</html>
