<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<html>
<o:MultiLanguage>
	<head>
	<title>{*[Module]*}</title>
	<link rel="stylesheet"
		href="<s:url value='/resource/css/main.css' />"
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
	</head>
	<script src="<s:url value='copymodule.js'/>"></script>
	<script>
	function ev_next(){
		var url='<s:url action="copyformafter"></s:url>';
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
</script>
	<body onload="ev_init();">
	<s:form action="tostep2forminfo" method="post">
		<%@include file="/common/page.jsp"%>
		<s:hidden name="s_module" value="%{#parameters.s_module}" />
		<s:hidden name="moduleid" value="%{content.moduleId}" />
		<table width="100%">
			<tr bgcolor="#CCCCCC">
				<td width="100%" height="26" class="STYLE2" class="commFont">{*[page.copyform.success]*}</td>
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
						<td><font size="2" style="text-align: center;">
						[*如要复制视图请点击复制视图选项后再点击的下一步,否则点击完成*]</font>
						</td>

					</tr>
					<tr>
						<td class="commFont"><input type="checkbox" id="copyview"
							value="next" onclick="on_change(this);">
						{*[page.copyview.ToNext]*}</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
						<button type="button" onClick="ev_next();" id="nextTo" name="Next">{*[Next]*}</button>
						</td>
						<td colspan="2" align="center">
						<button type="button" onClick="doCancel();">{*[Finish]*}</button>
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
