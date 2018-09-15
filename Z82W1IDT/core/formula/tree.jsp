<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.formula.FormulaTree"%>
<%@include file="/common/tags.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns:v="urn:schemas-microsoft-com:vml">
<o:MultiLanguage>
<HEAD>
<link rel="stylesheet" href='<s:url value="/resource/css/popupmenu.css" />' type="text/css">
<script src="<s:url value='/script/check.js'/>"></script>
<script src="<s:url value='/script/util.js'/>"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/DWRHtmlUtil.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormulaTree.js"/>'></script>

<META http-equiv='Content-Type' content='text/html;charset=UTF-8'>
<Meta name='Gemeratpr' content='formula tree'>
<TITLE>tree</TITLE>
<STYLE>
v\:*{behavior:url(#default#VML);}
</STYLE>
<script>
  var contextPath = '<%= request.getContextPath()%>';
  wx = '600px';
  wy = '500px';
  function showTreeDialog(fieldName, valuetype, value) {
	var url = contextPath + '/core/formula/treeDialog.jsp';
	var moduleid = '<s:property value="#parameters.s_module" />';
	if (fieldName != null) {
		url = url + '?fieldName=' + fieldName;
		if(valuetype != null && valuetype != '' && valuetype != undefined) {
			url += '&valuetype=' + valuetype;
		}
		if(value != null && value != '' && value != undefined) {
			if (value.indexOf('$') != -1) {
				value = value.substring(1, value.length);
			}
			url += '&value=' + value;
		}
	}
	if (moduleid != null && moduleid != '') {
		url +=  fieldName != null ? '&' : '?';
		url += 's_module=' + moduleid;
	}	
	
	//alert(url);
	
	var rtn = showframe('tree', url);
	
	if (rtn != undefined && rtn != '' && rtn != null) {
		return rtn;
	} else {
		return '';
	}
}

</script>
</HEAD>
<BODY leftmargin="0" topmargin="0" bottommargin="0" rightmargin="0" onload="ev_init()">


<form name="treeForm" value="/core/formula/tree.jsp method="post">
<div id="ie5menu" class=menu style="text-align: left;position: absolute; visibility: hidden; width: 120px; z-index: 200;padding:1px">
</div>	
	<table border="0" width="100%" height="100%">
	<tr><td width="15%" valign="top">
	<button type="button" class="button-image" onclick="createTree();" >{*[CreateTree]*}</button>
	<button type="button" class="button-image" onClick="doReturn();">{*[Confirm]*}</button>
	<p>FilterScript:<br/>
	<div id="formulaDiv" style="font-size:18px;color:gray">
	</div></p>
	</td>
	<td valign="top"><div id="treeDiv" style="height:500;overflow:auto">
	</div></td></tr>
	<s:hidden name="selected" />
	<!--  
	<v:oval id="test" style="position:relative;left:5;top:5;width:100;height:80" oncontextmenu="showmenuie5(this);return false;"/>
	-->	
</form>
</BODY>
</HTML>
<script>
	var map;
	function createTree() {
		var rtn = showTreeDialog('create');
		if (rtn != null && rtn != '') {
			FormulaTree.addNode(map, '', rtn.text, rtn.valuetype, toHtml);
		}
	}
	
	function addTreeElement(element,type) {
		if (!element.disabled) {
			var rtn = '';		
			var id = document.all['selected'].value;	
				switch (type) {
			case 0:
				rtn = showTreeDialog('relation');
				addNode(rtn, id);
				break;
			case 1:
				rtn = showTreeDialog('operator');
				addNode(rtn, id);
				break;
			case 2:
				rtn = showTreeDialog('compare');
				addNode(rtn, id);
				break;
			case 3:
				rtn = showTreeDialog('fieldname');
				addNode(rtn, id);
				break;
			case 4:
				FormulaTree.getNodeInfo(map, id, 
					function(str){var r = showTreeDialog('express', str[0], str[1]);addNode(r, id);});
				break;
			default:
				break;
			}
			//alert(id);
		}
	}
	
	function addNode(rtn, id) {
		if (rtn != null && rtn != '') {
				FormulaTree.addNode(map, id, rtn.text, rtn.valuetype, toHtml);
			}
	}
	
	function deleteSel() {
		var id = document.all['selected'].value;
		//alert(id);
		FormulaTree.delNode(map, id, toHtml);
		return false;
	}
	
	function toHtml(nodeMap) {
		map = nodeMap;
		FormulaTree.toTreeHtml(nodeMap, 50, 50, 350, 0, 120, 50, 60, function(str){eval(str);});
		FormulaTree.dparse(map, function(str){formulaDiv.innerText = str;});
	}
	
	function showmenuie5(element){
	//alert(document.all['ie5menu']);
	document.all['selected'].value = element.id;
	FormulaTree.refreshMenu(map, element.id, function(str){eval(str);});
	
	var rightedge=document.body.clientWidth-event.clientX;
	var bottomedge=document.body.clientHeight-event.clientY-25;
	if (rightedge<ie5menu.offsetWidth){
		ie5menu.style.left=document.body.scrollLeft+event.clientX-ie5menu.offsetWidth;
	}else{
		ie5menu.style.left=document.body.scrollLeft+event.clientX;
	}
	if (bottomedge<ie5menu.offsetHeight){
		ie5menu.style.top=document.body.scrollTop+event.clientY-ie5menu.offsetHeight;
	}else{
		ie5menu.style.top=document.body.scrollTop+event.clientY;
	}
	ie5menu.style.visibility="visible";
	return false;
}

	function hidemenuie5(){
		ie5menu.style.visibility="hidden";
	}
	
	function rightFunction(appid,moduleid){
		if(event.button==0||event.button==2){
			document.getElementById('nowappid').value=appid;
			document.getElementById('nowmoduleid').value=moduleid;
		}
	}
		
	document.body.onclick=hidemenuie5;
	/*document.oncontextmenu = function() {
		showmenuie5();		
		return false; 
	}*/
	function doReturn() {	
  	FormulaTree.dparse(map,function(str){window.returnValue=str;window.close();});
  }

	function ev_init() {
		var content = "<s:property value='#parameters.content[0]' />";
		//alert(content);
		FormulaTree.parse(content, toHtml);
	}
</script><o:MultiLanguage>