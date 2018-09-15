<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<% 
	String contextPath = request.getContextPath();
%>
<html><o:MultiLanguage>
<head>
<s:bean name="cn.myapps.core.domain.action.DomainHelper" id="dh" />
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
	function addUserToDept(btn){
		if(checkSelect()){
			jQuery(btn).attr("disabled",true);
			createCheckbox4submit();
			document.forms[0].action='<s:url value="/core/user/addUserToRole.action"/>';
			document.forms[0].submit();
		}else{
			alert("{*[core.domain.notChoose]*}");
			return;
		}
	}
	
	//为提交到后台创建参数
	function createCheckbox4submit(){
		var selectArr = [];
		var selectedVal = jQuery("#selectParmas").val();
		if(selectedVal){	//把已选值存入数组
			selectArr = selectedVal.split(",");
		}
		if(selectArr.length > 0){
			selectArr.forEach(function(ele, ind, array){
				jQuery("#contentTable").append('<input type="checkbox" name="_selects" value="' + ele + '" checked style="display:none;"/>');
			});
		}
	}
	
	function checkSelect(){
		var rtn=false;
		if(jQuery("#selectParmas").val() != ""){
			rtn = true;
		}
		return rtn;
	}
	
	//设置选中值
	function setCheckValue(curObj){
		var selectArr = [];
		var selectedVal = jQuery("#selectParmas").val();
		if(selectedVal){	//把已选值存入数组
			selectArr = selectedVal.split(",");
		}
		var _selectsAtrr=document.getElementsByName("selects");
		for(var i=0;i<_selectsAtrr.length;i++){
			if(_selectsAtrr[i].checked){	//选中值
				if(!selectedVal || selectedVal.indexOf(_selectsAtrr[i].value) == -1){	//无已选值或已选值中未包含当前选项值
					selectArr.push(_selectsAtrr[i].value);
				}
			}else{
				if(selectedVal && selectedVal.indexOf(_selectsAtrr[i].value) != -1){	//已选值中未包含当前选项值
					selectArr.forEach(function(ele, ind, array){
						if(ele == _selectsAtrr[i].value){	//移除当前值
							selectArr.splice(ind,1);
						}
					});
				}
			}
		}
		if(curObj.value == selectedVal && !curObj.checked){
			selectArr.pop();
			selectedVal = "";
		}
		if(selectArr.length>0){
			var selectStr = selectArr.join(",");	//数组转成字符串
			jQuery("#selectParmas").val(selectStr);
		}else{
			jQuery("#selectParmas").val("");
		}
	}
	
	//事件绑定
	function bindEvent(){
		jQuery("#contentTable").on("click", "input[type=checkbox]", function(){
			setCheckValue(this);
		});
	}
	
	//回选已选值
	function initCheckedVal(){
		var selesVal = jQuery("#selectParmas").val();
		if(selesVal){
			var seles = selesVal.split(",");
			if(seles && seles.length > 0){
				seles.forEach(function(ele, ind, array){
					jQuery("input[name=selects][value="+ele+"]").attr("checked", "true");
				});
			}
		}
	}
	//全选
	function selectAll(b, isRefresh) {
		var c = document.all('selects');
		if (c == null)
			return;
	
		if (c.length != null) {
			for (var i = 0; i < c.length; ++i)
				c[i].checked = b && !(c[i].disabled);
		} else {
			c.checked = b;
		}
	}
	
	jQuery(document).ready(function(){
		cssListTable();
		bindEvent();
		initCheckedVal();
		//window.top.toThisHelpPage("application_info_generalTools_role_info_addUserToRole");
	});
</script>
</head>
<body style="margin:0px;overflow: auto;" align="left">
<s:form name="formList" action="userListUnjoinedRole" method="post">
	<%@include file="/common/basic.jsp" %>
	<input type="hidden" id='roleid' name='roleid' value='<s:property value="#parameters['roleid']"/>' />
	<input type="hidden" id='selectParmas' name='selectParmas' value='<s:property value="#parameters['selectParmas']"/>' />
	<input type="hidden" name="sm_userRoleSets.roleId" value='<s:property value="#parameters['sm_userRoleSets.roleId']"/>' />
   	<input type="hidden" name="sm_userDepartmentSets.departmentId" value='<s:property value="#parameters['sm_userDepartmentSets.departmentId']"/>' />
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.role.belong_user]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" class="button-image" name="addButton" id="addButton" onClick="addUserToDept(this)"><img src="<s:url value="/resource/imgnew/add.gif"/>">{*[Add]*}</button>
					<button type="button" class="button-image" name="removeButton" id="removeButton" onClick="OBPM.dialog.doReturn();"><img src="<s:url value="/resource/imgnew/remove.gif"/>">{*[Exit]*}</button>
				</div>
			</td></tr>
	</table> 
	<div id="main">  
	<div id="searchFormTable">
		<table class="table_noborder">
			<tr><td>
				{*[Name]*}:
				<input class="input-cmd" type="text" name="sm_vo.name"	id="sm_vo.name" value='<s:property value="params.getParameterAsString('sm_vo.name')" />' size="10" />
				{*[Account]*}:
				<input class="input-cmd" type="text" name="sm_loginno" id="sm_loginno" value='<s:property value="params.getParameterAsString('sm_loginno')" />' size="10" />
				{*[Department]*}:
				<input class="input-cmd" type="text" name="sm_de.name" id="sm_de.name" value='<s:property value="params.getParameterAsString('sm_de.name')" />' size="10" />
				{*[Domain]*}:
				<s:set name="domainid" value="%{params.getParameterAsString(\'sm_vo.domainid\')}" />
				<s:select name="sm_vo.domainid" list="#dh.getDomainByStatus()" listKey="id" listValue="name" value='#domainid' theme="simple" emptyOption="true" />
 
				<input id="search_btn" class="button-cmd" type="button" value="{*[Search]*}" onclick="submit()" />
				<input id="reset_btn" class="button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll();" />
				</td>
			</tr>
		</table>
	</div>
	<div id="contentTable">
		<table class="table_noborder">
			<tr> 
				<td class="column-head2" scope="col"><input type="checkbox"
					onclick="selectAll(this.checked)"></td>
				<td class="column-head" scope="col">{*[Name]*}</td>
				<td class="column-head" scope="col">{*[Account]*}</td>
				<td class="column-head" scope="col">{*[Department]*}</td>
				<td class="column-head" scope="col">{*[Email]*}</td>
				<td class="column-head" scope="col">{*[Mobile]*}</td>
			</tr>
			<s:iterator value="datas.datas" status="index">
				<tr>
				<td class="table-td"><input type="checkbox" name="selects"
					value="<s:property value="id"/>"></td>
				<td>
					<s:property value="name" />
				</td>
				<td><s:property value="loginno" /></td>
				<td><s:iterator value="departments" var="dept" status="de">
					<s:property value="#dept.name" />
					<s:if test="!#de.last"> | </s:if>
				</s:iterator>
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