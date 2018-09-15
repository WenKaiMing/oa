<%@ page contentType="text/html; charset=UTF-8" buffer="0kb"%>
<%@ include file="/portal/share/common/head.jsp"%>
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
<link rel="stylesheet" href='<s:url value="/resource/css/dtree.css" />' type="text/css">
<script src='<s:url value="/portal/share/script/util.js"/>' ></script>
<script src='<s:url value="/portal/share/script/dtree.js"/>' ></script>
<script language="JavaScript">
var contextPath = '<s:url value="/" />';
var args = OBPM.dialog.getArgs();
var limit = args.limit;

//是否重复
function isDuplicate(values , value){
	for (var i=0; i<values.length; i++) {
		if (values[i] == value) {
			return true;
		}
	}
	return false;
}

function doReturn() {
	var sis = document.getElementsByName("_selectitem");

	  var array = new Array();
	  if (sis != null && sis.length > 0) {
		for (var i=0; i<sis.length; i++) {
			var e = sis[i];
			if (e.type == 'checkbox') {
				if (e.checked && e.value) {
			    	var rtn = {};
			    	rtn.text = jQuery(e).attr("text");
			    	rtn.value = e.value;
			    	array.push(rtn);
			    }
			}
	 	}
	  }
	  if(array.length<=limit){
	  	OBPM.dialog.doReturn(array);
	  }else{
   		alert("您最多可选择 "+limit+" 个部门");
	  }
	  
}


function doInit(){
	if(args) {
		var value = args.value;
		var readonly = args.readonly;
		
		// 只读情况下，隐藏按钮条
		if (readonly) {
			var btnbarDiv = document.getElementById("btnbarDiv");
			btnbarDiv.style.display = "none";
		}
		
		if (value){
			var sis = document.getElementsByName("_selectitem");
			var str = value;
			
			var checkedArray = str.split(";");
			var temp = [];
			for (var i=0; i < checkedArray.size(); i++) {
		 		if (sis) {
			  		for (var j=0; j < sis.length; j++) {
			    		var e = sis[j];
			    		if (!isDuplicate(temp, e.value)) {
			    			toggleCheck(e, checkedArray);
			    			temp.push(e.value);
			    		}
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

function doSelect(rtn){
	var array = new Array();
	array.push(rtn);
	
	OBPM.dialog.doReturn(array);
}

function setDivSize(){
	var bodyH = document.body.clientHeight;
	var btH = document.getElementById("btnbarDiv").clientHeight;
	document.getElementById("selDepConDiv").style.height = (bodyH - btH - 40)+"px";
}

jQuery(window).resize(function(){
	setDivSize();
});

window.onload = function(){
	doInit();
	setDivSize();
}

</script>
</head>
<body style="overflow:hidden;">
<form name="formList" method="post" action="">
	<%@include file="/common/page.jsp"%>
	<s:hidden value="_orderby" />
	<div id="btnbarDiv" class="btnbarDiv">
		<div>
			<button type="button" class="button-class" onClick="doReturn();">
				<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}
			</button>
		</div>
		<div>
			<button type="button" class="button-class" onClick="OBPM.dialog.doExit()">
				<img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Cancel]*}
			</button>
		</div>
		<div>
			<button type="button" class="button-class" onClick="OBPM.dialog.doClear()">
				<img src="<s:url value="/resource/imgnew/remove.gif"/>">{*[Clear]*}
			</button>
		</div>
	</div>
	<div id="selDepConDiv" class="selDepConDiv">
		<div id="deplist" style="overflow:auto;" class="commFont"> 
			<script type="text/javascript">
        			var contextPath = '<%=contextPath%>';
			var d = new dTree('d', 'deplist');	
			d.config.multiSelect = args.multiSelect != undefined ? args.multiSelect : true;
			<s:iterator value="#dh.getDepartmentList(#session.FRONT_USER.domainid)">
				<s:set name="dept" />
				// 所有部门列表
				<s:if test="%{superior.id != null && superior.id != ''}">
					d.add(
						'<s:property value="id" />',
						'<s:property value="superior.id" />',
						'<s:property value="name" />',
						'javascript:doSelect({value: \'<s:property value="id" />\', text: \'<s:property value="name" />\'});',
						'<s:property value="id" />',
						'',
						'<%=contextPath%>/resource/images/dtree/dept.gif',
						'<%=contextPath%>/resource/images/dtree/dept.gif',
						'',
						'')
				</s:if>
				
				// 根部门
				<s:else>
					d.add('<s:property value="id" />',
						-1,
						'<s:property value="name" />',
						'javascript:doSelect({value: \'<s:property value="id" />\', text: \'<s:property value="name" />\'});',
						'<s:property value="id" />',
						'',
						'<%=contextPath%>/resource/images/dtree/dept.gif',
						'',
						'',
						'')						
				</s:else>
				
			</s:iterator>
			document.write(d);
			</script>
		</div>
	</div>
</form>
</body>
</o:MultiLanguage></html>
