<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ page import="cn.myapps.core.user.ejb.UserVO,cn.myapps.constans.*"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<html><o:MultiLanguage>
<head>
<title>{*[Workflow_Info]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<script src="<s:url value='/script/check.js'/>"></script>
<script src="<s:url value='/script/util.js'/>"></script>
<script language="JavaScript">
   var contextPath = "<s:url value='/'/>";
   cmdReturn = 'core/workflow/list.action';
   cmdSave = 'core/workflow/save.action';
   cmdEdit = 'core/workflow/edit.action';
  
function ev_save() 
{
    document.formItem.elements['content.flow'].value = document.BFApplet.saveToXML();
    formItem.submit();
    windows.close();
} 


function editElement()
{
   var toEdit = document.BFApplet.getCurrToEditElementProcess();
   var classname=toEdit.getClass().getName();
   if(classname.indexOf('Auto')!=-1)
       editAutoNode();
   else if(classname.indexOf('Start')!=-1)   
       editStartNode();
   else  if(classname.indexOf('Manual')!=-1)  
       editManualNode();
   else if(classname.indexOf('Relation')!=-1)  
       editRelation();
   else if(classname.indexOf('Abort')!=-1)  
       editAbortNode();
  else if(classname.indexOf('Complete')!=-1)  
       editCompleteNode();
   else if(classname.indexOf('Terminate')!=-1)  
       editTerminateNode();
  else if(classname.indexOf('Suspend')!=-1)  
       editSuspendNode();    
}


function addManualNode()
{
    document.BFApplet.addManualNode()
}


function editManualNode()
{  
   var actorAttr = new Object();
   var oldAttr = document.BFApplet.getCurrToEditManualProcess();
   var url = contextPath + "core/workflow/billflow/defi/addManualNode.jsp";
   url = addParam(url, 's_module', '<s:property value="#parameters.s_module"/>');
   //alert("url->"+url);
   actorAttr=window.showModalDialog(url,oldAttr,"dialogHeight: 460px; dialogWidth: 600px; dialogTop: 120px; dialogLeft: 120px; edge: Raised; center: Yes; help: Yes; resizable: Yes; status: no;")
   if(actorAttr!=null){
     document.BFApplet.editManualNode(actorAttr.name, actorAttr.statelabel, actorAttr.namelist, actorAttr.note, actorAttr.remaindertype, actorAttr.beforetime,
										actorAttr.passcondition, actorAttr.exceedaction, actorAttr.limittimecount,
										actorAttr.backnodeid, actorAttr.formname, actorAttr.fieldpermlist,actorAttr.issplit,actorAttr.isgather)
     }
}

function addStartNode()
{
	document.BFApplet.addStartNode();
}

function editStartNode()
{
   var actorAttr = new Object();
   var oldAttr = document.BFApplet.getCurrToEditStartNodeProcess();
   if (oldAttr == null) return;
   var url = contextPath + "core/workflow/billflow/defi/addStartNode.jsp";
   
   actorAttr=window.showModalDialog(url,oldAttr,"dialogHeight: 450px; dialogWidth: 450px; dialogTop: 120px; dialogLeft: 120px; edge: Raised; center: Yes; help: Yes; resizable: Yes; status: no;")
   if(actorAttr!=null){
   document.BFApplet.editStartNode(actorAttr.name, actorAttr.statelabel);
   }
}


function addAbortNode()
{
	document.BFApplet.addAbortNode();
}

function editAbortNode()
{
   var actorAttr = new Object();
   var oldAttr = document.BFApplet.getCurrToEditAbortNodeProcess();
   if (oldAttr == null) return;
   var url = contextPath + "core/workflow/billflow/defi/addAbortNode.jsp";
   
   actorAttr=window.showModalDialog(url,oldAttr,"dialogHeight: 450px; dialogWidth: 450px; dialogTop: 120px; dialogLeft: 120px; edge: Raised; center: Yes; help: Yes; resizable: Yes; status: no;")
   if(actorAttr!=null){
   document.BFApplet.editAbortNode(actorAttr.name, actorAttr.statelabel);
   }
}

function addTerminateNode()
{
	document.BFApplet.addTerminateNode();
}

function editTerminateNode()
{
   var actorAttr = new Object();
   var oldAttr = document.BFApplet.getCurrToEditTerminateNodeProcess();
   if (oldAttr == null) return;
   var url = contextPath + "core/workflow/billflow/defi/addTerminateNode.jsp";
   
   actorAttr=window.showModalDialog(url,oldAttr,"dialogHeight: 450px; dialogWidth: 450px; dialogTop: 120px; dialogLeft: 120px; edge: Raised; center: Yes; help: Yes; resizable: Yes; status: no;")
   if(actorAttr!=null){
   document.BFApplet.editTerminateNode(actorAttr.name, actorAttr.statelabel);
   }
}

function addSuspendNode()
{
	document.BFApplet.addSuspendNode();
}

function editSuspendNode()
{
   var actorAttr = new Object();
   var oldAttr = document.BFApplet.getCurrToEditSuspendNodeProcess();
   if (oldAttr == null) return;
   var url = contextPath + "core/workflow/billflow/defi/addSuspendNode.jsp";
   
   actorAttr=window.showModalDialog(url,oldAttr,"dialogHeight: 450px; dialogWidth: 450px; dialogTop: 120px; dialogLeft: 120px; edge: Raised; center: Yes; help: Yes; resizable: Yes; status: no;")
   if(actorAttr!=null){
   document.BFApplet.editSuspendNode(actorAttr.name, actorAttr.statelabel);
   }
}
function addCompleteNode()
{
	document.BFApplet.addCompleteNode();
}

function editCompleteNode()
{
   var actorAttr = new Object();
   var oldAttr = document.BFApplet.getCurrToEditCompleteNodeProcess();
   if (oldAttr == null) return;
   var url = contextPath + "core/workflow/billflow/defi/addCompleteNode.jsp";
   
   actorAttr=window.showModalDialog(url,oldAttr,"dialogHeight: 450px; dialogWidth: 450px; dialogTop: 120px; dialogLeft: 120px; edge: Raised; center: Yes; help: Yes; resizable: Yes; status: no;")
   if(actorAttr!=null){
   document.BFApplet.editCompleteNode(actorAttr.name, actorAttr.statelabel);
   }
}
function addAutoNode()
{
	document.BFApplet.addAutoNode();
}


function editAutoNode()
{
   var actorAttr = new Object();
   var oldAttr = document.BFApplet.getCurrToEditAutoNodeProcess();
   var url = contextPath + "core/workflow/billflow/defi/addAutoNode.jsp";
   if (oldAttr == null) return;
   actorAttr=window.showModalDialog(url,oldAttr,"dialogHeight:450px; dialogWidth: 450px; dialogTop: 120px; dialogLeft: 120px; edge: Raised; center: Yes; help: Yes; resizable: Yes; status: no;")
   if(actorAttr!=null){
     document.BFApplet.editAutoNode(actorAttr.name, actorAttr.statelabel);
   }
}


function addRelation()
{
	document.BFApplet.addRelation();
}


function editRelation()
{
   url=contextPath + "core/workflow/billflow/defi/addRelation.jsp";
   var actorAttr = new Object();
   var oldAttr = document.BFApplet.getCurrToEditRelation();
    url = addParam(url, 's_module', '<s:property value="#parameters.s_module"/>');
   if (oldAttr == null) return;
   actorAttr=window.showModalDialog(url, oldAttr,"dialogHeight:440px; dialogWidth: 480px; dialogTop: 120px; dialogLeft: 120px; edge: Raised; center: Yes; help: Yes; resizable: Yes; status: no;");
   
   //alert (actorAttr.validateScript);
   if(actorAttr!=null){
     document.BFApplet.editRelation(actorAttr.name,actorAttr.condition,actorAttr.action,
     								actorAttr.validateScript,actorAttr.filtercondition,actorAttr.editMode,actorAttr.processDescription);
   }
}

function addSubflow(){}


function editSubflow(){
   url=contextPath + "core/workflow/billflow/defi/addSubflow.jsp";
   var actorAttr = new Object();
   var oldAttr = document.BFApplet.getCurrToEditSubflow();
   if (oldAttr == null) return;
   actorAttr=window.showModalDialog(url, oldAttr, "dialogHeight:450px; dialogWidth: 450px; dialogTop: 120px; dialogLeft: 120px; edge: Raised; center: Yes; help: Yes; resizable: Yes; status: no;");
   if(actorAttr!=null){
     document.BFApplet.editSubflow(actorAttr.name,actorAttr.subflowid, actorAttr.subflowname, actorAttr.isreflow,  actorAttr.isstart,actorAttr.isend, actorAttr.issplit, actorAttr.isgather, actorAttr.note, actorAttr.beforescrpt);
   }
}

function removeElement()
{  
  if(document.BFApplet.isAssignBack()){
         alert("{*[It's a specified return-to node,can't delete]*}");
    	 return;
    }else{
  		 document.BFApplet.removeElement();
  }
}

function zoomIn() {
	document.BFApplet.zoomIn();
}

function zoomOut() {
	document.BFApplet.zoomOut();
}

function ev_onsubmit() 
{
  	var modify = document.getElementById('modify').checked;
  	if (!modify) {
		document.getElementById('content.flow').value = document.BFApplet.saveToXML();
	}
}

function ev_switchsheet(id) {
	document.getElementById('appletcontent').style.display="none";
	document.getElementById('xmlcontent').style.display="none";
	//alert(id);
	if (id == 'appletcontent') {
		var xml = document.getElementById('content.flow').value;
		document.BFApplet.loadXML(xml);
		document.getElementById('modify').checked = false;
	} else {
		document.getElementById('content.flow').value = document.BFApplet.saveToXML();
	}
	
	document.getElementById(id).style.display = "";
}

function ev_init() {
	var xml = document.getElementById('content.flow').value;
	document.BFApplet.loadXML(xml);
}

jQuery(document).ready(function(){
	ev_init();
	window.top.toThisHelpPage("application_module_workflows_info");
});
</script>
</head>
<body id="application_module_workflows_info" class="body-back">
<table width="98%" class="list-table">
	<tr class="list-toolbar">
		<td width="10" class="image-label"><img
			src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3"></td>
		<td width="70" class="text-label">{*[Workflow]*}</td>
		<td>
		<table width="100%" border=1 cellpadding="0" cellspacing="0"
			class="line-position">
			<tr>
				<td></td>
				<td class="line-position2" width="60" valign="top">
				<button type="button" class="back-class"
					onClick="ev_onsubmit();forms[0].submit();"><img
					src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
				</td>
				<td class="line-position2" width="70" valign="top">
				<button type="button" class="back-class"
					onClick="if(parent){parent.close();}else{window.close();}"><img
					src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%
	WebUser user = null;
	user = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_USER);
	String username = user.getName();
%>



<table width="98%" name="test">

	<s:form action="save" method="post" id="formItem"
		onsubmit="ev_onsubmit();" theme="simple">
		<%@include file="/common/page.jsp"%>
		<input type="hidden" name="s_module"
			value="<s:property value='#parameters.s_module'/>">
		<input type="hidden" name="_moduleid"
			value="<s:property value='#parameters.s_module'/>">
		<tr>
			<td colspan="2"></td>
		</tr>
		<tr>
			<td colspan="2">
			<table>
				<tr>
					<td>
					<button type="button" class="turn-button"
						onClick="ev_switchsheet('appletcontent')">{*[Diagram]*}</button>
					</td>
					<td>
					<button type="button" class="turn-button" onClick="ev_switchsheet('xmlcontent')">{*[Code]*}</button>
					</td>
					<td>
					<table>
						<tr align="left">

							<td class="content-label">
							<div id="subject">{*[Subject]*}:</div>
							</td>
							<td><s:textfield cssClass="input-cmd" label="{*[Subject]*}"
								name="content.subject" theme="simple" /></td>
							<td class="content-label">{*[Author]*}:</td>
							<td><s:textfield cssClass="input-cmd"
								label="{*[Workflow author]*}" name="content.authorname"
								value="<%=username%>" disabled="true" theme="simple" /></td>
							<s:if test="content.id">
								<td class="content-label">{*[LastModify]*}:</td>
								<td><s:date name="content.lastmodify" format="yyyy/MM/dd" /></td>
							</s:if>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<%@include file="/common/msg.jsp"%>
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<tr id="xmlcontent" style="display:none" height="350">
			<td colspan="2">
			<table>
				<tr>
					<td>{*[Modify]*}: <s:checkbox name="modify" theme="simple"
						onclick="document.getElementById('content.flow').readOnly = !this.checked;document.getElementById('content.flow').style.color = this.checked ? 'black' : 'gray'" /></td>
				</tr>
				<tr>
					<td><s:textarea name="content.flow" readonly="true"
						cssStyle="width:700px;height:350px;color:gray">
					</s:textarea></td>
				</tr>
			</table>

			</td>
		</tr>
		<tr id="appletcontent">
			<td>
			<table>
				<tr>
					<td valign="top">
					<table border=0>

						<tr>
							<td>
							<button type="button" class="button-add" onClick="editElement();"><img
								src="<s:url value="/resource/image/edit.gif"/>"
								alt="{*[Edit]*}"></button>

							</td>
							<td>
							<button type="button" class="button-add" onClick="removeElement();"><img
								src="<s:url value="/resource/image/remove.gif"/>"
								alt="{*[Remove]*}"></button>

							</td>
						</tr>
						<tr>
							<td>
							<button type="button" class="button-add" onClick="addStartNode();"><img
								src="<s:url value="/resource/image/start.gif"/>"
								alt="{*[StartNode]*}"></button>
							</td>
							<td>
							<button type="button" class="button-add" onClick="addManualNode();"><img
								src="<s:url value="/resource/image/actor.gif"/>"
								alt="{*[ManualNode]*}"></button>
							</td>
						</tr>
						<tr>
							<td>
							<button type="button" class="button-add" onClick="addSubflow();"><img
								src="<s:url value="/resource/image/subflow.gif"/>"
								alt="{*[SubNode]*}"></button>
							</td>
							<td>
							<button type="button" class="button-add" onClick="addAutoNode();"><img
								src="<s:url value="/resource/image/timer.gif"/>"
								alt="{*[AutoNode]*}"></button>
							</td>
						</tr>
						<tr>
							<td>
							<button type="button" class="button-add" onClick="addCompleteNode();"><img
								src="<s:url value="/resource/image/complete.gif"/>"
								alt="{*[Complete]*}"></button>
							</td>
							<td>
							<button type="button" class="button-add" onClick="addRelation();"><img
								src="<s:url value="/resource/image/relation2.gif"/>"
								alt="{*[Relation]*}" height="20" width="20"></button>
							</td>
						</tr>
						<tr>
							<td>
							<button type="button" class="button-add" onClick="addSuspendNode();"><img
								src="<s:url value="/resource/image/suspend.gif"/>"
								alt="{*[Suspend]*}"></button>
							</td>
							<td>
							<button type="button" class="button-add" onClick="addAbortNode();"><img
								src="<s:url value="/resource/image/cancel.gif"/>"
								alt="{*[Cancel]*}"></button>
							</td>
						</tr>
						<tr>
							<td>
							<button type="button" class="button-add" onClick="addTerminateNode();"><img
								src="<s:url value="/resource/image/terminate.gif"/>"
								alt="{*[Terminate]*}"></button>
							</td>
							<td>
							<button type="button" class="button-add" onClick="addTerminateNode();"><img
								src="<s:url value="/resource/image/deselect.gif"/>"
								alt="{*[Deselect]*}"></button>
							</td>
						</tr>
						<tr>
							<td>
							<button type="button" class="button-add" onClick="zoomIn();"><img
								src="<s:url value="/resource/image/zoom_in.gif"/>"
								alt="{*[Zoom_In]*}" height="20" width="20"></button>
							</td>
							<td>
							<button type="button" class="button-add" onClick="zoomOut();"><img
								src="<s:url value="/resource/image/zoom_out.gif"/>"
								alt="{*[Zoom_Out]*}" height="20" width="20"></button>
							</td>
						</tr>
					</table>

					</td>
					<td><Script language="JavaScript">
            document.write('<applet');
            document.write('  codebase ="."');
            document.write('  code     = "cn.myapps.core.workflow.applet.BFApplet.class"');
            document.write('  archive  = "WorkFlow.jar,MinML.jar"');
            document.write('  name     = "BFApplet"');
            document.write('  width    = "650"');
            document.write('  height   = "350"');
            document.write('  hspace   = "0"');
            document.write('  vspace   = "0"');
            document.write('  align    = "top"');
            document.write(' MAYSCRIPT');
            document.write('>');
            document.write('</applet>');
            </Script></td>
				</tr>
			</table>
			</td>
		</tr>
	</s:form>
</table>
</body>
</o:MultiLanguage></html>
