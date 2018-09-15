<%@ page contentType="text/html; charset=UTF-8" buffer="0kb"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@ include file="/portal/phone/resource/common/js_base.jsp"%>
<%@ include file="/portal/phone/resource/common/js_component.jsp"%>
<s:bean name="cn.myapps.core.department.action.DepartmentHelper" id="dh" />
<%String contextPath = request.getContextPath();
	response.setHeader("Pragma","No-Cache");   
	response.setHeader("Cache-Control","No-Cache");   
	response.setDateHeader("Expires",   0);  
%>

<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[Select]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href='../../js/wtree/wtree.css' type="text/css">
<script src='../../js/wtree/wtree.js' ></script>
</head>
<body style="overflow:hidden;">
<div class="reimburse">
<form name="formList" method="post" action="" >
	<%@include file="/common/page.jsp"%>
	<s:hidden value="_orderby" />
	
	<div id="selDepConDiv" class="selDepConDiv" style="overflow: auto;background: #fff;">
		<div id="deplist" > 
		</div>
	</div>
	<div id="btnbarDiv" class="card_space_fix zindex10">
	<table><tr class="formActBtn">
		<td>
			<a class="btn btn-positive btn-block" id="btn-save" title="{*[Save]*}">{*[Save]*}</a>
		</td>
		<td>
			<a class="btn btn-positive btn-block" onClick="top.OBPM.dialog.doExit();" title="{*[Cancel]*}">{*[Cancel]*}</a>
		</td>
		<td>
			<a class="btn btn-positive btn-block" id="btn-clear" title="{*[Clear]*}">{*[Clear]*}</a>
		</td>
		</tr></table>
	</div>
</form>
</div>
<script type="text/javascript">
var contextPath = '<s:url value="/" />'=='/'? '':'<s:url value="/" />';
var args = OBPM.dialog.getArgs();
var limit = args.limit;
var tree;
(function(){
	$(document).ready(function(){
		var value = args.value;
		var checkedNodes = []
		if (value){
			checkedNodes = value.split(";");
		}
		tree = $("#deplist").wtree({
			data:contextPath+'/portal/component/user/getDepartmentsByParentId.action',
			checkbox:true,
			checkedNodes:checkedNodes,
			multiple:true
		}).bind("checked.wtree",function(e,data){
		}).bind("unchecked.wtree",function(e,data){
		});

		if(typeof top.hideLoadingToast == "function"){
			top.hideLoadingToast();
		}
		
		$("#btn-save").on("click",function(e){
			var nodes = tree.wtree("getSelected");
			  var array = new Array();
			  if (nodes != null && nodes.length > 0) {
				for (var i=0; i<nodes.length; i++) {
					var node = nodes[i];
			    	var rtn = {};
			    	rtn.text = node.name;
			    	rtn.value = node.id;
			    	array.push(rtn);
			 	}
			  }
			  if(array.length<=limit){
			  	OBPM.dialog.doReturn(array);
			  }else{
		   		alert("您最多可选择 "+limit+" 个部门");
			  }
		});
		
		$("#btn-clear").on("click", function(){
			tree.wtree("resetSelected");
		});
		setDivSize();
		$(window).resize(function(){
			setDivSize();
		});
	});
	function setDivSize(){
		var bodyH = document.body.clientHeight;
		var btH = document.getElementById("btnbarDiv").clientHeight;
		document.getElementById("selDepConDiv").style.height = (bodyH - btH)+"px";
	}
})();
</script>
</body>
</o:MultiLanguage></html>
