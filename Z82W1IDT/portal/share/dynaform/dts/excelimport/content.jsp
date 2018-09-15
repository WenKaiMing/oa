<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%String contextPath = request.getContextPath();
%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>Excel Import Mapping Config</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<script src="<%= contextPath %>/js/billitem.js"></script>
<script src="<%= contextPath %>/js/check.js"></script>
<script src="<%= contextPath %>/js/util.js"></script>
<script src="<s:url value='/portal/share/script/list.js'/>"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/DWRHtmlUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/ApplicationUtil.js"/>'></script>
<script src="<s:url value='/portal/share/script/util.js'/>"></script>
<script language="JavaScript">
<!--
var contextPath = '<%= contextPath %>';

function ev_checkval() {
  return true;
}

function ev_save() {
  formItem.elements['content.xml'].value=document.BFApplet.saveToXML();
  alert(formItem.elements['content.xml'].value);
  doSave();
}
function save() {
  formItem.elements['content.xml'].value=document.BFApplet.saveToXML();
  forms[0].action="<s:url action='save'></s:url>";
  forms[0].submit();
}


//-->
</script>
<SCRIPT LANGUAGE="JavaScript">

function attechmentupload(excelpath){
	 var rtr = uploadFile(excelpath,'path','','','','','',applicationid);
	 if(rtr!=null&&rtr!='') {
	   formItem.elements['content.path'].value = rtr;
	 }
}

function addMasterSheet()
{
	url="EditMasterSheet.jsp"
	var rtn=new Object()
	rtn=window.showModalDialog(url)
	if(rtn!=null){
		document.BFApplet.addMasterSheet(rtn.name,rtn.formName,"")
	}
}

function addDetailSheet()
{
	url="EditDetailSheet.jsp"
	var rtn=new Object()
	rtn=window.showModalDialog(url)
	if(rtn!=null){
		document.BFApplet.addDetailSheet(rtn.name,rtn.formName,"")
	}
}

function addColumn()
{
	url="EditColumn.jsp"
	var rtn=new Object()
	rtn=window.showModalDialog(url)
	if(rtn!=null){
		document.BFApplet.addColumn(rtn.name,rtn.fieldName,rtn.valueScript,rtn.validateRule,rtn.primaryKey, "")
	}
}


function addRelation()
{
	url="EditRelation.jsp"
	document.BFApplet.addRelation()

}

function editMasterSheet()
{
	url="EditMasterSheet.jsp"
	var oldAttr = new Object();
	oldAttr.name = document.BFApplet.getCurrToEditElement().name;
	oldAttr.formName = document.BFApplet.getCurrToEditElement().formName;
	var rtn=new Object()
	rtn=window.showModalDialog(url,oldAttr)
	if(rtn!=null){
		document.BFApplet.editMasterSheet(rtn.name,rtn.formName,"")
	}
}

function editDetailSheet()
{
	url="EditDetailSheet.jsp"
	var oldAttr = new Object();
	oldAttr.name = document.BFApplet.getCurrToEditElement().name;
	oldAttr.formName = document.BFApplet.getCurrToEditElement().formName;
	var rtn=new Object()
	rtn=window.showModalDialog(url,oldAttr)
	if(rtn!=null){
		document.BFApplet.editDetailSheet(rtn.name,rtn.formName,"")
	}
}

function editColumn()
{
	url="EditColumn.jsp"
	var oldAttr = new Object();
	oldAttr.name = document.BFApplet.getCurrToEditElement().name;
	oldAttr.fieldName = document.BFApplet.getCurrToEditElement().fieldName;
	oldAttr.valueScript = document.BFApplet.getCurrToEditElement().valueScript;
	oldAttr.validateRule = document.BFApplet.getCurrToEditElement().validateRule;
	oldAttr.primaryKey = document.BFApplet.getCurrToEditElement().primaryKey;
	var rtn=new Object()
	rtn=window.showModalDialog(url,oldAttr)
	if(rtn!=null){
		document.BFApplet.editColumn(rtn.name,rtn.fieldName,rtn.valueScript,rtn.validateRule,rtn.primaryKey,"");
	}
}


function removeElement()
{
document.BFApplet.removeElement()
}

function saveToXML()
{
returnValue=document.BFApplet.saveToXML();

}

function refresh()
{
var xmlstr=document.BFApplet.saveToXML();
frm1.xml.value = xmlstr;
}

function editElement()
{
  var toEdit = document.BFApplet.getCurrToEditElement();
  if (toEdit != null) {
    if (toEdit.getClass().getName()=="cn.myapps.core.dynaform.dts.excelimport.MasterSheet") {
    	editMasterSheet();
    }
    else if (toEdit.getClass().getName()=="cn.myapps.core.dynaform.dts.excelimport.DetailSheet") {
    	editDetailSheet();
    }
    else if (toEdit.getClass().getName()=="cn.myapps.core.dynaform.dts.excelimport.Column") {
    	editColumn();
    }
  }
}

function ev_switchsheet(id) {
	document.getElementById('appletcontent').style.display="none";
	document.getElementById('xmlcontent').style.display="none";

	if (id == 'appletcontent') {
		document.getElementById('appletcontent').style.display="";
		var xml = document.getElementsByName('content.xml')[0].value;
		//alert("xml--->" + xml);
		if (xml) {
			document.BFApplet.loadXML(xml);
		}
		document.getElementsByName('modify')[0].checked = false;
	} else {
		document.getElementsByName('content.xml')[0].value = document.BFApplet.saveToXML();
		document.getElementById('xmlcontent').style.display="";
	}
	

}

function ev_onsubmit() 
{
  	var modify = document.getElementsByName('modify')[0].checked;
  	if (!modify) {
  		document.getElementsByName('content.xml')[0].value = document.BFApplet.saveToXML();
	}
}


</SCRIPT>
<script src="<%= contextPath %>/js/attachments.js"></script>
</head>
<body class="body-back" onload="inittab()">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr class="nav-td"  style="height:27px;">
		<td rowspan="2"><%@include file="/common/commontab.jsp"%></td>
		<td class="nav-td" >&nbsp;
		</td>
	</tr>
	<tr class="nav-s-td">
		<td align="right" class="nav-s-td">
			<table width="100%" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top">
					<button type="button" class="button-image"
						onClick="ev_onsubmit(); forms[0].action='<s:url action="save"></s:url>'; forms[0].submit();"><img
						src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
					</td>
					<td valign="top">
					<button type="button" class="button-image"
						onClick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();"><img
						src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%@include file="/portal/share/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<s:form theme="simple" id="formItem" action="save" method="post">
<s:hidden name="content.id" />
<s:hidden name="content.sortId" />
<s:hidden name="application" value="%{#parameters.application}"/>
<s:textfield name="tab" cssStyle="display:none;" value="3" />
<s:textfield name="selected" cssStyle="display:none;" value="%{'btnExcelConf'}" />
	<table class="id1" width="100%" border="0">
	    <tr>
	    	<td class="commFont">{*[Name]*}:</td>
    	</tr>
    	<tr>
	    	<td><s:textfield cssClass="input-cmd" theme="simple" name="content.name"/> </td>
	    </tr>
	    <tr>
			<td class="commFont">{*[cn.myapps.core.dynaform.dts.excelimport.upload_template]*}:</td>
		</tr>
		<tr>
			<td>
			<s:textfield id="path" name="content.path" cssClass="input-cmd" readonly="true" theme="simple"/>
	      	<button type="button" name='upload' class="button-image" onClick="attechmentupload('EXCELTEMPLATE_PATH')">
	      	<img src="<s:url value="/resource/image/search.gif"/>"></button>
	      	</td>
	    </tr>
	    <tr>
	    <td>
		<button type="button"  onClick="ev_switchsheet('appletcontent')">{*[Diagram]*}</button>
		<button type="button"  onClick="ev_switchsheet('xmlcontent')">{*[Code]*}</button>
		</td>
	    </tr>
	    <tr id="xmlcontent" style="display:none" height="250">
			<td>
				<table>
					<tr><td>{*[Modify]*}:
					<s:checkbox name="modify" theme="simple" onclick="document.getElementsByName('content.xml')[0].readOnly = !this.checked;document.getElementsByName('content.xml')[0].style.color = this.checked ? 'black' : 'gray'" /></td>
					</tr>
					<tr><td>
						<s:textarea name="content.xml"  readonly="true" cssStyle="width:700px;height:250px;color:gray">
						</s:textarea>
					</td></tr>
				</table>
			</td>
		</tr>
		<tr id="appletcontent">
			<td>
			<Script language="JavaScript">
            document.write('<applet');
            document.write('  codebase = "."');
            document.write('  code     = "cn.myapps.core.dynaform.dts.excelimport.ExcelMappingApplet.class"');
            document.write('  archive  = "MinML.jar,MXML.jar"');
            document.write('  name     = "BFApplet"');
            document.write('  width    = "700"');
            document.write('  height   = "250"');
            document.write('  hspace   = "0"');
            document.write('  vspace   = "0"');
            document.write('  align    = "top"');
            document.write(' MAYSCRIPT');
            document.write('>');
            document.write('<param name="xmlStr" value="' + formItem.elements['content.xml'].value + '">');
            document.write('</applet>');
            </Script>
            <br/>
			<input type="button" name="addActor" value="{*[Add]*} {*[MasterSheet]*}"
				onClick="addMasterSheet()"> <input type="button" name="addActor"
				value="{*[Add]*} {*[DetailSheet]*}" onClick="addDetailSheet()"> <input
				type="button" name="addGroup" value="{*[Add]*} {*[Column]*}" onClick="addColumn()">
			<input type="button" name="addActor" value="{*[Add]*} {*[Relation]*}"
				onClick="addRelation()"> <input type="button" name="addActor"
				value="{*[Remove]*}" onClick="removeElement()"> <input
				type="button" name="addActor" value="{*[Edit]*}" onClick="editElement()">
			</td>
		</tr>
	</table>
	</s:form>

</body>
</o:MultiLanguage></html>
