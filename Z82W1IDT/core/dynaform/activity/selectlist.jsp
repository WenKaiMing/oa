<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%String contextPath = request.getContextPath();%>

<html><o:MultiLanguage>
<head>
<title>{*[Select]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />"	type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/dtree.css'/>"	type="text/css">
<script src='<s:url value="/script/util.js"/>' ></script>
<script src='<s:url value="/script/dtree.js"/>' ></script>
<script language="JavaScript">
var contextPath = '<%= contextPath %>';

function doReturn() {
  var sis = document.getElementsByName("_selectitem");
  var rtn = new Array();
  var p = 0;

  if (sis.length != null) {
	  for (var i=0; i<sis.length; i++) {
	    var e = sis[i];
	    if (e.type == 'checkbox') {
	      if (e.checked && e.value) {
	        rtn[p++] = e.value;
	      }
	    }
	  }
  }
  else {
    var e = sis;
    if (e.type == 'checkbox') {
      if (e.checked && e.value) {
        rtn[p++] = e.value;
      }
    }
  }
  OBPM.dialog.doReturn(rtn.toString());
}

function doExit() {
	OBPM.dialog.doReturn();
}

function doInit(){
	var args =OBPM.dialog.getArgs();
	if(args) {
		var oField = args["oField"];		
		if (oField.value){
			var sis = document.getElementsByName("_selectitem");
	 		var checkedValues = oField.value.split(',');
	 		if (sis) {
		  		for (var i=0; i < sis.length; i++) {
		    		var e = sis[i];
		    		toggleCheck(e, checkedValues);
		 		}
	  		}
		}
	}
}

function toggleCheck(oEl, checkedValues){
	for (var i=0; i < checkedValues.length; i++) {
		if(oEl.value == checkedValues[i]){
			oEl.checked = true;
			d.openTo(checkedValues[i]);
		}
	}
}
</script>
</head>
<body topmargin="0" onload="doInit()">
<s:form name="formList" method="post" action="/bug/list.action">
	<%@include file="/common/page.jsp"%>
	<s:hidden value="_orderby" />

	<table border="0" cellpadding="4" cellspacing="0">
		<tr>
			<td class="line-position2" width="50"  valign="top">
   				<button type="button" class="button-image" onClick="doReturn();">
   					<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
			</td>
			
			<td class="line-position2" width="50" valign="top">
				<button type="button" class="button-image" onClick="doExit()">
					<img src="<s:url value="/resource/imgnew/act/act_9.gif"/>">{*[Close]*}</button>
			</td>
			
			<td class="line-position2" width="50" valign="top">
				<button type="button" class="button-image" onClick="OBPM.dialog.doReturn('')">
					<img src="<s:url value="/resource/imgnew/act/act_18.gif"/>">{*[Clear]*}</button>
			</td>
		</tr>

		<tr>
			<td colspan="2" class="list-srchbar"></td>
		</tr>

		<tr>
			<td colspan="2">
			<table border="0" cellpadding="0" cellspacing="1">
				<s:bean name="cn.myapps.core.workflow.statelabel.action.StateLabelActionHelper" id="ch" />
				<tr class="row-hd">
					<td>
					<script type="text/javascript">
          				var contextPath = '<%= contextPath %>';
						var d = new dTree('d');
						d.config.multiSelect = true;
						//id, pid, name, url, title, target, icon, iconOpen, open, checked
						d.add('{*[State_Label]*}',
								-1,
								'{*[State_Label]*}',
								'javascript:selectOne(\'"";""\');',
								'')
						
						<s:iterator value="#ch.getStateList(#parameters.application)">
							d.add('<s:property value="value" />',
								'{*[State_Label]*}',
								'<s:property value="name" />',
								'javascript:selectOne(\'<s:property value="value" />;<s:property value="name" />\');',
								'<s:property value="value" />')							
						</s:iterator>
						document.write(d);
					</script>
					</td>
				</tr>
				<!--  
				<s:iterator value="#ch.getStateList(#parameters.application)">
					<tr class="row-content">
						<td width="100%"><a href="javascript:selectOne('<s:property />')" />
						<s:property /></a></td>
					</tr>
				</s:iterator>
				-->
			</table>
			</td>
		</tr>
	</table>
</s:form>
</body>
</o:MultiLanguage></html>
