<%@ page contentType="text/html; charset=UTF-8" buffer="0kb"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%String contextPath = request.getContextPath();
	response.setHeader("Pragma","No-Cache");   
	response.setHeader("Cache-Control","No-Cache");   
	response.setDateHeader("Expires",   0);  
%>

<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[Select]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href='<s:url value="/resource/css/dtree.css" />' type="text/css">
<script src='<s:url value="/portal/share/script/util.js"/>' ></script>
<script src='<s:url value="/portal/share/script/dtree.js"/>' ></script>
<script language="JavaScript">
var contextPath = '<s:url value="/" />';
var args = OBPM.dialog.getArgs();

// 是否重复
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
		    	rtn.text = e.text;
		    	rtn.value = e.value;
		    	array.push(rtn);
		    }
		}
 	}
  }
  
  OBPM.dialog.doReturn(array);
}

function doInit(){
	if(args) {
		var value = args.value;
		var readonly = args.readonly;
		
		// 只读情况下，隐藏按钮条
		if (readonly) {
			var btnbarTR = document.getElementById("btnbarTR");
			btnbarTR.style.display = "none";
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

jQuery(document).ready(function(){
	doInit();
	OBPM.dialog.resize(jQuery(window).width()+20, jQuery(window).height()+75);
});

function doSelect(rtn){
	var array = new Array();
	array.push(rtn);
	
	OBPM.dialog.doReturn(array);
}
</script>
</head>
<body topmargin="0">
<s:form name="formList" method="post" action="">
	<%@include file="/common/page.jsp"%>
	<s:hidden value="_orderby" />
	<table width="100%" border="0" cellpadding="4" cellspacing="0">
		<tr id="btnbarTR">
			<td>
				<fieldset> 
	    			<legend></legend>
					<table width="100%">
						<tr>
							<td class="line-position2" width="50"  valign="top">
				   				<button type="button" class="button-class" onClick="doReturn();">
				   					<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
							</td>
							
							<td class="line-position2" width="50" valign="top">
								<button type="button" class="button-class" onClick="OBPM.dialog.doExit()">
									<img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Cancel]*}</button>
							</td>
							
							<td class="line-position2" width="50" valign="top">
								<button type="button" class="button-class" onClick="OBPM.dialog.doClear()">
									<img src="<s:url value="/resource/imgnew/remove.gif"/>">{*[Clear]*}</button>
							</td>
						</tr>
					</table>
				</fieldset>
			</td>
		</tr>
		<tr>
			<td colspan="3" class="list-srchbar"></td>
		</tr>
	</table>
	
	<table border="0" width="100%" cellpadding="0" cellspacing="1">
			<s:bean name="cn.myapps.core.department.action.DepartmentHelper" id="dh" />
				<tr class="row-hd">
					<td>
						<fieldset  height="100%"> 
			    			<legend></legend>
							<table width="100%" height="230px">
								<tr>
									<td valign="top">
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
														'',
														'',
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
														'',
														'',
														'',
														'<%=contextPath%>/resource/images/dtree/dept.gif',
														'',
														'',
														'')						
												</s:else>
												
												// 部门中包含的用户列表
												<s:iterator value="#dh.getUsersByDptIdAndRoleId(#dept.id,#parameters.roleid)">
													<s:set name="user" />
													<s:if test="#user.status==1">
													d.add(
														'<s:property value="id" />',
														'<s:property value="#dept.id" />',
														'<s:property value="name" />',
														'javascript:doSelect({value: \'<s:property value="id" />\', text: \'<s:property value="name" />\'});',
														'<s:property value="id" />',
														'',
														'<%=contextPath%>/resource/images/dtree/user.gif',
														'<%=contextPath%>/resource/images/dtree/user.gif',
														'',
														'')
														</s:if>
												</s:iterator>
											</s:iterator>
											document.write(d);
											</script>
											</div>
										</td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
		</table>
</s:form>
</body>
</o:MultiLanguage></html>
