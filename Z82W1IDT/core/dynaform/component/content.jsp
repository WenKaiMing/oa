<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page buffer="50kb"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<html>
<o:MultiLanguage>
<head>
<title>{*[Component]*}{*[Info]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />"	type="text/css">
<style type="text/css">
.btn {
	font-size: 9pt;	TEXT-ALIGN: center;	cursor: pointer;color: #000;
	background-image: url('<s:url value = "/resource/imgnew/buttonsmall.gif" />');
	background-repeat: no-repeat;display: block;background-position: left top;padding: 3px 0px 0px 0px;
	float: left;width: 70px;height: 21px
}
</style>
<script type="text/javascript" src="../form/webeditor/fckeditor.js"></script>
<script>
	var sContentPath = '<s:url value="/"/>';
	var mode = 'basicpage';

	function ev_switchpage(sId) {
		/*if(eWebEditor.window.ev_updatefield) {
			eWebEditor.window.ev_updatefield();
		}*/
	
		document.getElementById('basicpage').style.display="none";
		document.getElementById('advancepage').style.display="none";
		if (document.getElementById(sId)) {
			document.getElementById(sId).style.display="";
		}
		mode = sId;
	}
	
	function ev_preview(){
	  var formid = document.forms[0].elements['content.id'].value;
	  
	  if (formid == "") {
	  	alert("{*[cn.myapps.core.dynaform.form.please_save]*}");
	  }
	  else {	
	    var url = '<s:url action="preview" namespace="/core/dynaform/document" />' 
	  			+ '?formid=' + formid + '&application=<%=request.getParameter("application")%>';
	  	window.open(url);
	  }
	}
	
	function ev_save() {
		document.forms[0].action='<s:url action="save"></s:url>';
		document.forms[0].submit();
	}
	
	jQuery(document).ready(function(){
		inittab();
		window.top.toThisHelpPage("application_info_advancedTools_component_info");
	});
</script>
</head>
<body id="application_info_advancedTools_component_info" class="contentBody">
	<table cellpadding="0" cellspacing="0" width="100%">
		<tr style="height: 27px;">
			<td rowspan="2"><div style="width:500px"><%@include file="/common/commontab.jsp"%></div></td>
			<td class="nav-td" width="100%">&nbsp;</td>
		</tr>
		<tr>
			<td class="nav-s-td" align="right">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" align="right">
						<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
					<button type="button" class="button-image" onClick="ev_preview()" height="22px"><img
						src="<s:url value="/resource/imgnew/act/preview.gif" />">{*[Preview]*}</button>
					<button type="button" id="save_btn" class="button-image" height="22px"
						onClick="ev_save()"><img
						src="<s:url value="/resource/imgnew/act/act_4.gif"/>">
					{*[Save]*}</button>
					</td>
					<td width="25" align="left">
					<button type="button" class="button-image" height="22px"
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
	<div id="contentMainDiv" class="contentMainDiv">
	<table width="140" class="id1" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="64" align="center"><span class="btn"
				onclick="ev_switchpage('basicpage')" style="cursor: pointer">{*[Basic]*}</span></td>
			<td width="64" align="center"><span class="btn"
				onclick="ev_switchpage('advancepage')" style="cursor: pointer">{*[Advance]*}</span></td>
		</tr>
	</table>
	<table border=0 width=100% height=80%>
		<s:form action="save" method="post" theme="simple">
			<s:bean
				name="cn.myapps.core.style.repository.action.StyleRepositoryHelper"
				id="sh">
				<s:param name="applicationid" value="#parameters.application" />
			</s:bean>
			<s:textfield name="tab" cssStyle="display:none;" value="3" />
			<s:textfield name="selected" cssStyle="display:none;"
				value="%{'btnComponent'}" />
			<%@include file="/common/page.jsp"%>
			<s:hidden name='content.version'></s:hidden>
			<s:hidden name="content.titlescript" />
			<s:hidden name="isComponent" value="false" />
			<input type="hidden" name="s_module"
				value="<s:property value='#parameters.s_module'/>">
			<input type="hidden" name="moduleid"
				value="<s:property value='#parameters.s_module'/>">
			<tr id='basicpage' valign="top">
				<td colspan="4" height="100">
				<table width='100%' border="0">
					<tr>
						<td align="left"><font class="commFont commLabel">{*[Name]*}:</font></td>
						<td width="50%" align="left">{*[StyleLib]*}:</td>
					</tr>
					<tr>
						<td><s:textfield cssStyle="width:200px;"
							cssClass="input-cmd" name="content.name" theme="simple" /></td>
						<td valign="top">
							<s:select cssStyle="width:200px;" label="{*[StyleLib]*}" name="_styleid"
							list="#sh.get_listStyleByApp(#parameters.application)"
							listKey="id" listValue="name" emptyOption="true" theme="simple" /></td>
					</tr>
					<tr>
						<td width="50%" align="left">{*[Description]*}:</td>
						<td></td>
					</tr>
					<tr>
						<td><s:textarea cols="80" rows="5" cssClass="input-cmd"
							name="content.discription" theme="simple" /></td>
						<td></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr id='advancepage' valign="top" style='display: none'>
				<td colspan="4" height="20">
				<table width="100%">
					<tr valign='top' height='20'>
						<td colspan="4">
						<div style="color: red">{*[alias.setting.desc]*}</div>
						</td>
					</tr>
					<tr>
						<td>
						<div id="editor"><s:textarea cssStyle="display:none"
							name="content.templatecontext" theme="simple" /> <script
							type="text/javascript">
							var sBasePath = '<s:url value="/core/dynaform/form/webeditor/"/>';
							var oFCKeditor = new FCKeditor("content.templatecontext");
							//oFCKeditor.ToolbarSet = "myeditor";
							oFCKeditor.BasePath	= sBasePath;
							oFCKeditor.Height	= 400;
							oFCKeditor.ReplaceTextarea();
						</script></div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</s:form>
	</table>
	</div>
</body>
</o:MultiLanguage>
</html>
