<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/tags.jsp"%>
<%@ include file="/common/taglibs.jsp"%>
<%String contextPath = request.getContextPath();%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<title>Component Select</title>
<base target="_self">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%= contextPath %>/resource/css/main.css"
	type="text/css">
<script src="<%= contextPath %>/script/util.js"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/DWRHtmlUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/ComponentUtil.js"/>'></script>
<script src="../form/webeditor/editor/dialog/common/fck_dialog_common.js" type="text/javascript"></script>
<script language="JavaScript">
	var dialog	= window.parent ;
	var oEditor = dialog.InnerDialogLoaded() ;
	
	// Gets the document DOM
	var oDOM = oEditor.FCK.EditorDocument ;
	var oActiveEl = dialog.Selection.GetSelectedElement() ;
	
	var contextPath = '<%= contextPath %>';
	var selcomponentid;
	var rtn;
	/**
	function ev_selectOne1(id) {
		//var width='300', height='300';
		alert(1);
		selcomponentid=id;
		alert(2);
		var url = '<s:url namespace="/core/dynaform/component" action="fieldlist" />';
		url = addParam(url, 'id', id);
		alert(3);
		url = addParam(url, 'action', '<s:property value="#parameters.action" />');
		alert("url-->"+url);
		//rtn = showModalDialog(url, window.dialogArguments, "dialogWidth:" + width + "px;dialogHeight:" + height + "px;help:no;scroll:auto;status:no");
		//window.close();
		OBPM.dialog.show({
			width: 500,
			height: 350,
			url: url,
			args: {selcomponentid:id},
			title: 'showModalDialog',
			close: function(result) {
				var rtn = result;
			}
		});
	}
	**/
	function ev_selectOne(id) {
		var width='500', height='350';
		selcomponentid=id;
		var url = '<s:url namespace="/core/dynaform/component" action="fieldlist" />';
		url = addParam(url, 'id', id);
		url = addParam(url, 'action', '<s:property value="#parameters.action" />');
		rtn = showModalDialog(url, window.dialogArguments, "dialogWidth:" + width + "px;dialogHeight:" + height + "px;help:no;scroll:auto;status:no");
		window.close();
	}
	function Ok()
	{
		oEditor.FCKUndo.SaveUndoStep() ;
		var className="cn.myapps.core.dynaform.form.ejb.ComponentTag";
		var type="componentfield";
		var src="images/component.gif";
		var componentid=selcomponentid;
		var results = eval('('+rtn+')');
		var id=results.id;
		var aliases=results.aliases;
		oActiveEl = CreateNamedElement( oEditor, oActiveEl, 'img', {
					classname: className,
					type:type,
					src:src,
					id: id,
					componentid:selcomponentid,
					aliases:aliases
				} 
		   		) ;	
		return true ;
	}
	function InitDocument(){
		var editmode;
		oEditor.FCKLanguageManager.TranslatePage(document) ;
		if ( oActiveEl)
		{
			temp.name.value = HTMLDencode(oActiveEl.name);
		}
		else
			oActiveEl = null ;
		dialog.SetOkButton( true ) ;
		dialog.SetAutoSize( true ) ;
		SelectField( 'name' ) ;
	}
</script>
</head>
<body topmargin="0" onload="InitDocument()">
<s:form name="temp" action="fieldlist" method="post">
	<table border="0" cellpadding="4" cellspacing="0">
		<tr>
			<td colspan="2" class="list-srchbar"></td>
		</tr>

		<tr>
			<td colspan="2">
			<table border="0" cellpadding="0" cellspacing="1">
				<tr class="row-hd">
					<td width="100%">{*[Component]*}
				</tr>

				<s:iterator value="datas.datas">
					<tr class="row-content">
						<td width="100%">
						<a href="#" onclick='ev_selectOne("<s:property value="id"/>")' > 
							<s:property value="name"/></a></td>
					</tr>
				</s:iterator>
			
			</table>
			</td>
		</tr>
	</table>
</s:form>
</body>
</o:MultiLanguage>
</html>