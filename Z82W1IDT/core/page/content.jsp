<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page buffer="50kb"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script type='text/javascript'
	src='<s:url value="/dwr/interface/RoleUtil.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script type="text/javascript" src="../dynaform/form/webeditor/fckeditor.js"></script>

<s:bean name="cn.myapps.core.style.repository.action.StyleRepositoryHelper" id="sh">
	<s:param name="applicationid" value="#parameters.application" />
	<s:param name="moduleid" value="#parameters.s_module" />
</s:bean>
<html>
<o:MultiLanguage>
<head>
<title>{*[Page]*}{*[Info]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>"	type="text/css">
<style type="text/css">
.btn {
	font-size: 9pt;
	TEXT-ALIGN: center;
	cursor: pointer;
	color: #000;
	background-image: url('<s:url value = "/resource/imgnew/buttonsmall.gif" />');
	background-repeat: no-repeat;
	display: block;
	background-position: left top;
	padding: 3px 0px 0px 0px;
	float: left;
	width: 70px;
	height: 21px
}
</style>
<script>
var sContentPath = '<s:url value="/"/>';
var mode = '<%=request.getParameter("mode")%>';

function ev_switchpage(sId) {
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
  	alert("{*[Please_Save]*}");
  }
  else {	
    var url = '<s:url action="preview" namespace="/core/dynaform/document" />' 
  			+ '?formid=' + formid + "&application=<s:property value='#parameters.application' />";
  	window.open(url);
  }
}

function ev_save() {
	/*if(eWebEditor.window.ev_updatefield) {
		eWebEditor.window.ev_updatefield();
	}*/
	document.forms[0].action='<s:url action="save"></s:url>?mode=' + mode;
	document.forms[0].submit();
}
wx = '600px'; 
wy = '600px';
function chooseName() {
	var roles = document.getElementById("content.roles").value;
	
	var url = '<s:url value="/core/role/linkRole.action">';
		url += '<s:param name="application" value="#parameters.application" />';
		url += '</s:url>';
		url += '&tempRoles='+roles;
	//var rtn = showframe("Choose Role", url);
	OBPM.dialog.show({
				opener:window.parent,
				width: 800,
				height: 500,
				url: url,
				args: {},
				title: '{*[Select]*}{*[Role]*}',
				close: function(rtn) {
					if (rtn){
						if (rtn == 'clear') {
							document.getElementById("content.roles").value = "";
							document.getElementById("content.roleNames").value = "";
						}else{
							document.getElementById("content.roles").value = rtn;
							RoleUtil.findRoleNames(rtn, insertName);
						}
					}
				}
		});
}

function clearRole(){
	document.getElementById("content.roles").value = "";
	document.getElementById("content.roleNames").value = "";
}

function insertName(data) {
	jQuery("#content.roleNames").val(data);
}

function ev_init(){
	if (mode=='' || mode=='null'){
		mode = 'basicpage';
	}
	ev_switchpage(mode);
	inittab();
}

jQuery(document).ready(function(){
	ev_init();
	window.top.toThisHelpPage("application_info_advancedTools_page_info");
});
</script>
</head>
<body class="contentBody">
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
						<button type="button" class="button-image" onClick="ev_preview()"><img
							src="<s:url value="/resource/imgnew/act/preview.gif" />">{*[Preview]*}</button>
						<button type="button" id="save_btn" class="button-image" onClick="ev_save()">
							<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
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
	<table class="id1" width="140" border="0" cellspacing="0"
		cellpadding="0" style="padding-top: 10px;">
		<tr>
			<td width="64" align="center"><span class="btn"
				onclick="ev_switchpage('basicpage')" style="cursor: pointer">{*[Basic]*}</span></td>
			<td width="64" align="center"><span class="btn"
				onclick="ev_switchpage('advancepage')" style="cursor: pointer">{*[Advance]*}</span></td>
		</tr>
	</table>
	<table class="table_noborder" height="83%">
		<s:form action="save" method="post" theme="simple">
		<s:hidden name='content.version'></s:hidden>
		<s:textfield name="tab" cssStyle="display:none;" value="3" />
		<s:textfield name="selected" cssStyle="display:none;"
			value="%{'btnPage'}" />
		<s:textfield cssStyle="display:none;" name="tab" value="3" />
		<s:textfield cssStyle="display:none;" name="selected"
			value="%{'btnPage'}" />
		<s:hidden name="content.titlescript" />
		<input type="hidden" name="s_module"
			value="<s:property value='#parameters.s_module'/>">
		<input type="hidden" name="moduleid"
			value="<s:property value='#parameters.s_module'/>">
		<%@include file="/common/page.jsp"%>
		<tr id="basicpage" valign='top'>
			<td style="padding-left: 10px;">
				<table class="table_noborder id1">
					<tr>
						<td class="commFont">{*[Name]*}:</td>
						<td class="commFont">{*[StyleLib]*}:</td>
					</tr>
					<tr>
						<td align="left"><s:textfield cssClass="input-cmd"
							name="content.name" theme="simple" /></td>
						<td><s:select cssClass="input-cmd" label="{*[StyleLib]*}"
							name="_styleid"
							list="#sh.get_listStyleByApp(#parameters.application)"
							listKey="id" listValue="name" emptyOption="true" theme="simple" /></td>
					</tr>
					<tr>
						<td class="commFont">{*[Roles]*}:</td>
						<td class="commFont">{*[DEFAULT]*}:</td>
					</tr>
					<tr>
						<td align="left"><s:textfield cssStyle="width:210px;"
							id="content.roleNames" readonly="true" name="content.roleNames" /><s:textfield
							cssClass="input-cmd" cssStyle="display:none" id="content.roles"
							name="content.roles" />
							<button type="button" class="button-image" style="color: #1E50C4" onclick="chooseName()">{*[Choose]*}</button>
							<button type="button" class="button-image" style="color: #1E50C4" onclick="clearRole()">{*[Clear]*}</button>
						</td>
						<td align="left"><s:radio name="_default"
							list="#{'true':'{*[Yes]*}','false':'{*[No]*}'}" theme="simple" /></td>
					</tr>
					<tr>
						<td class="commFont">{*[Description]*}:</td>
						<td class="commFont"></td>
					</tr>
					<tr>
						<td colspan="2"><s:textarea cols="150" rows="5"
							cssClass="input-cmd" name="content.discription" theme="simple" /></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr id='advancepage' style="display: none" valign="top">
				<td>
						<s:textarea cssStyle="display:none"
							name="content.templatecontext" theme="simple" /> <script
							type="text/javascript">
							var sBasePath = '<s:url value="/core/dynaform/form/webeditor/"/>';
							var oFCKeditor = new FCKeditor("content.templatecontext");
							//oFCKeditor.ToolbarSet = "myeditor";
							oFCKeditor.BasePath	= sBasePath;
							oFCKeditor.Height	= 100+"%";
							oFCKeditor.ReplaceTextarea();
						</script>
				</td>
			</tr>
			<s:hidden name="content.type"/>
		</s:form>
	</table>
</body>
</o:MultiLanguage>
</html>
