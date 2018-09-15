<%@ page contentType="text/html; charset=UTF-8" buffer="0kb"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
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
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css">
<link rel="stylesheet" href='../../script/wtree/wtree.css' type="text/css">
<style type="text/css">
.btnbarDiv {
	text-align: center;
}
</style>
<script src='<s:url value="/portal/share/script/util.js"/>' ></script>
<script src='../../script/wtree/wtree.js' ></script>

</head>
<body style="overflow:hidden;">
<form name="formList" method="post" action="">
	<%@include file="/common/page.jsp"%>
	<s:hidden value="_orderby" />
	<div id="btnbarDiv" class="btnbarDiv">
		<div>
			<button type="button" id="btn-save" >
				<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}
			</button>
		</div>
		<div>
			<button type="button" onClick="OBPM.dialog.doExit()">
				<img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Exit]*}
			</button>
		</div>
	</div>
	<div id="selDepConDiv" class="selDepConDiv">
		<div id="deplist" class="commFont"> 
		</div>
	</div>
</form>
<script type="text/javascript">
var contextPath = '<s:url value="/" />'=='/'? '':'<s:url value="/" />';
var args = OBPM.dialog.getArgs();
var limit = args.limit;
var tree;
(function(){
	window.onload = function(){
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
		setTimeout(function(){
			setDivSize();
		}, 300);
		
		$(window).resize(function(){
			setDivSize();
		});
	};
	function setDivSize(){
		var bodyH = document.body.clientHeight;
		var btH = document.getElementById("btnbarDiv").clientHeight+20;
		document.getElementById("selDepConDiv").style.height = (bodyH - btH)+"px";
	}
})();
</script>
</body>
</o:MultiLanguage></html>
