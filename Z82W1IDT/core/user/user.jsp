<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<% 
	String contextPath = request.getContextPath();
%>
<html><o:MultiLanguage>
<head>
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/script/list.js"/>'></script>
<title>{*[Users]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script type="">
	var contextPath='<%=contextPath%>';
</script>
<script src="<s:url value="/script/list.js"/>"></script>
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
	    var roleid=document.getElementById('sm_userRoleSets.roleId').value;
		if(depid!=''){
			document.forms[0].action='<s:url action="removeDepartment" />';
			document.forms[0].submit();
		}else if(roleid!=''){
			document.forms[0].action='<s:url action="removeRole" />';
			document.forms[0].submit();
		}
	}
	
	function addUser(){
		var depid=document.getElementById('sm_userDepartmentSets.departmentId').value;
		var roleid=document.getElementById('sm_userRoleSets.roleId').value;
		
		//部门和角色添加用户都公用此页面，判断单前页面时谁使用。
		if(depid!=null && depid!=""){
			addUserInDept();
		}
		if(roleid!=null && roleid!=""){
			addUserInRole();
		}
	}
	
	function addUserInDept(){
	 	var depid=document.getElementById('sm_userDepartmentSets.departmentId').value;
		var url = "<s:url value='/core/user/userListUnjoinedDept.action'></s:url>?deptid="+depid;
		OBPM.dialog.show({
				opener:window.parent.parent,
				width: 700,
				height: 500,
				url: url,
				args: {},
				title: '{*[cn.myapps.core.domain.listByDepartment.add_user_to_department]*}',
				close: function(rtn) {
					if(rtn=="success"){
						document.forms[0].submit();
					}
					window.top.toThisHelpPage("domain_dept_info");
				}
		});
	}
	
	function addUserInRole(){
	 	var roleid=document.getElementById('sm_userRoleSets.roleId').value;
		var url = "<s:url value='/core/user/userListUnjoinedRole.action'></s:url>?roleid="+roleid;
		OBPM.dialog.show({
				opener:window.parent.parent,
				width: 700,
				height: 500,
				url: url,
				args: {},
				title: '{*[cn.myapps.core.domain.listByDepartment.add_user_to_role]*}',
				close: function(rtn) {
					window.top.toThisHelpPage("application_info_generalTools_role_info");
					if(rtn=="success"){
						document.forms[0].submit();
					}
				}
		});
	}
	function adjustDataIteratorSize() {
		var containerHeight = document.body.clientHeight-50;
		var container = document.getElementById("main");
		container.style.height = containerHeight + 'px';
	}
	
	jQuery(document).ready(function(){
		cssListTable();
		adjustDataIteratorSize();
	});
</script>
</head>
<body style="margin:0px;" align="left">
	<%@include file="/common/msg.jsp"%>
<s:form name="formList" action="listRole" method="post">
	<%@include file="/common/basic.jsp" %>
	<input type="hidden" id="sm_userRoleSets.roleId" name="sm_userRoleSets.roleId" value='<s:property value="#parameters['sm_userRoleSets.roleId']"/>' />
   	<input type="hidden" id="sm_userDepartmentSets.departmentId" name="sm_userDepartmentSets.departmentId" value='<s:property value="#parameters['sm_userDepartmentSets.departmentId']"/>' />
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.domain.listByDepartment.belong_users]*}</div>
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
	<div id="main" style="overflow:auto;">  
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