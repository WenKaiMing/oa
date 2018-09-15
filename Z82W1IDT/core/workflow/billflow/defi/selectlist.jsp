<%@ page contentType="text/html; charset=UTF-8" buffer="0kb"%>
<%@include file="/common/taglibs.jsp"%>
<%String contextPath = request.getContextPath();
	response.setHeader("Pragma","No-Cache");   
	response.setHeader("Cache-Control","No-Cache");   
	response.setDateHeader("Expires",   0);  
%>

<html><o:MultiLanguage>
<head>
<title>{*[Select]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href='<s:url value="/resource/css/dtree.css" />' type="text/css">
<script src='<s:url value="/script/util.js"/>' ></script>
<script src='<s:url value="/script/dtree.js"/>' ></script>
<script language="JavaScript">
var contextPath = '<s:url value="/" />';

function doReturn() {
  var sis = document.getElementsByName("_selectItem");
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
  window.returnValue = rtn.toString();
  window.close();
}

function doExit() {
  window.close();
}


function doInit(){
	if(window.dialogArguments) {
		var oField = window.dialogArguments;
		if (oField.value){
			var sis = document.getElementsByName("_selectItem");
			var str = oField.value;
			//alert('str  '+str);
			var checkedArray = str.split(";");
			for (var i=0; i < checkedArray.size(); i++) {
				
		 		if (sis) {
			  		for (var j=0; j < sis.length; j++) {
			    		var e = sis[j];
			    		toggleCheck(e, checkedArray);
			 		}
		  		}
			}
	 		
		}
	}
}

function toggleCheck(oEl, checkedValues){
	for (var i=0; i < checkedValues.size(); i++) {
		if(oEl.value == checkedValues[i] && oEl.value != ''){
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
   				<button type="button" class="button-class" onClick="doReturn();">
   					<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
			</td>
			
			<td class="line-position2" width="50" valign="top">
				<button type="button" class="button-class" onClick="doExit()">
					<img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Cancel]*}</button>
			</td>
			
			<td class="line-position2" width="50" valign="top">
				<button type="button" class="button-class" onClick="doEmpty()">
					<img src="<s:url value="/resource/imgnew/remove.gif"/>">{*[Clear]*}</button>
			</td>

		</tr>

		<tr>
			<td colspan="3" class="list-srchbar"></td>
		</tr>
	</table>

	<table border="0" cellpadding="0" cellspacing="1">
				<s:bean name="cn.myapps.core.workflow.storage.definition.action.BillDefiHelper" id="bh" />
				<tr class="row-hd">
					<td><div class="dtree">
					<script type="text/javascript">
          				var contextPath = '<s:url value="/" />';
          				//注意传入生成checkbox的名称
						var d = new dTree('d','','_selectItem');
						d.config.multiSelect = true;
						//id, pid, name, url, title, target, icon, iconOpen, open, checked
						d.add('Nodes',-1,'','','');
						
						<s:iterator value="#bh.get_backNodeList(#parameters.flowid,#parameters.nodeid)" id="bnodelist">
							d.add('<s:property />',
								'Nodes',
								'<s:property value="#bnodelist.name" />',
								'javascript:selectOne(\'<s:property />;<s:property />\');',
								'<s:property value="#bnodelist.id" />|<s:property value="#bnodelist.name" />');
						</s:iterator>
						document.write(d);
					</script>
					</div></td>
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
</s:form>
</body>
</o:MultiLanguage></html>
