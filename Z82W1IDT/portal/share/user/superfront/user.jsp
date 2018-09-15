<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/portal/share/common/lib.jsp"%>
<%@ include file="/portal/share/common/head.jsp"%>
<% 
	String contextPath = request.getContextPath();
%>
<html><o:MultiLanguage>
<head>
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/portal/share/script/list.js"/>'></script>
<title>{*[Users]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script type="">
	var contextPath='<%=contextPath%>';
</script>
<script src="<s:url value="/portal/share/script/list.js"/>"></script>
<script>
	function removeUser(){
		var checkBlo = false;
		var checkboxs = document.getElementsByName("_selects");
		for(var i=0;i<checkboxs.length;i++){
			if(checkboxs[i].checked == true){
				checkBlo = true;
				break;
			}
		}
		if(checkBlo == false) alert("{*[select_one_at_least]*}!");
	    var depid=document.getElementById('sm_userDepartmentSets.departmentId').value;
		if(depid!=''){
			document.forms[0].action='<s:url action="removeDepartment" />';
			document.forms[0].submit();
		}
	}
	
	function addUser(){
		var depid=document.getElementById('sm_userDepartmentSets.departmentId').value;
		
		//部门添加用户。
		if(depid!=null && depid!=""){
			addUserInDept();
		}
	}
	
	function addUserInDept(){
	 	var depid=document.getElementById('sm_userDepartmentSets.departmentId').value;
		var url = "<s:url value='/portal/user/userListUnjoinedDept.action'></s:url>?deptid="+depid;
		OBPM.dialog.show({
				opener:window.parent.parent,
				width: 650,
				height: 430,
				url: url,
				args: {},
				title: '{*[cn.myapps.core.domain.listByDepartment.add_user_to_department]*}',
				close: function(rtn) {
					if(rtn=="success"){
						document.forms[0].submit();
					}
				}
		});
	}
	
	function FrameResize(){
		var iframe = parent.document.getElementById("frame");
		if(iframe)
			iframe.style.height = jQuery("#listRole .table_noborder").height() +jQuery("#main").height() ;
	}
	jQuery(document).ready(function(){
		cssListTable();
		FrameResize();
	});
</script>
</head>
<body style="margin:0px;" align="left">
<%@include file="/portal/share/common/msg.jsp"%>
<s:form name="formList" action="listRole" method="post">
	<%@include file="/common/basic.jsp" %>
	<input type="hidden" id="sm_userRoleSets.roleId" name="sm_userRoleSets.roleId" value='<s:property value="#parameters['sm_userRoleSets.roleId']"/>' />
   	<input type="hidden" id="sm_userDepartmentSets.departmentId" name="sm_userDepartmentSets.departmentId" value='<s:property value="#parameters['sm_userDepartmentSets.departmentId']"/>' />
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.role.belong_user]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" class="button-image" name="addButton" id="addButton" onClick="addUser()">
						<img src="<s:url value="/resource/imgnew/add.gif"/>">{*[Add]*}
					</button>
					<button type="button" class="button-image" name="removeButton" id="removeButton" onClick="removeUser()">
						<img src="<s:url value="/resource/imgnew/remove.gif"/>">{*[Remove]*}
					</button>
				</div>
			</td></tr>
	</table> 
	<div id="main">  
	<div id="contentTable">
		<table class="table_noborder">
			<tr> 
				<td class="column-head2" scope="col"><input type="checkbox"
					onclick="selectAll(this.checked)"></td>
				<td class="column-head" scope="col">{*[Name]*}</td>
				<td class="column-head" scope="col">{*[Account]*}</td>
				<td class="column-head" scope="col">{*[Email]*}</td>
				<td class="column-head" scope="col">{*[Mobile]*}</td>
			</tr>
			<s:if test="datas.datas.size==0">
				<script>
				document.getElementById("removeButton").style.display='none';
				</script>
			</s:if>
			
			<s:iterator value="datas.datas" status="index">
				<tr>
				<td class="table-td"><input type="checkbox" name="_selects"
					value="<s:property value="id"/>"></td>
				<td>
					<s:property value="name" />
				</td>
				<td><s:property value="loginno" /></td>
				<td><s:property value="email" /></td>
				<td><s:property value="telephone" /></td>
				</tr>
			</s:iterator>
		</table>
		<table class="table_noborder">
			<tr>
				<td align="right" class="pagenav">
					<o:PageNavigation dpName="datas" css="linktag" />
				</td>
			</tr>
		</table>
	</div>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>