<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<% 
	String contextPath = request.getContextPath();
	// 获取扩展字段
	String domain = request.getParameter("domain");
	String orderBy = request.getParameter("_orderby");
	FieldExtendsProcess fieldExtendsProcess = (FieldExtendsProcess) ProcessFactory.createProcess(FieldExtendsProcess.class);
	List<FieldExtendsVO> fieldExtendses = fieldExtendsProcess.queryFieldExtendsByTableAndEnabel(domain, FieldExtendsVO.TABLE_USER, true);
	request.setAttribute("fieldExtendses", fieldExtendses);
%>

<%@page import="cn.myapps.core.fieldextends.ejb.FieldExtendsProcess"%>
<%@page import="cn.myapps.util.ProcessFactory"%>
<%@page import="java.util.List"%>
<%@page import="cn.myapps.core.fieldextends.ejb.FieldExtendsVO"%><html><o:MultiLanguage>
<head>
<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<title>{*[User_List]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<script type="text/javascript">
	var contextPath='<%=contextPath%>';
	var orderBy = '<%=orderBy%>';
</script>
<script src="<s:url value="/script/list.js"/>"></script>
<script type="text/javascript">
	function doDelete(){
		var listform = document.forms['formList'];
	    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
	    	listform.action='<s:url action="delete"><s:param name="id" value="#parameters.id" /></s:url>';
	    	listform.submit();
	    }
	}
	function isEdit(){
		window.parent.document.getElementById("isedit").value="true";
	}
	
	jQuery(document).ready(function(){
		cssListTable();
		window.top.toThisHelpPage("domain_user_list");
		
		initRoleSelect('<s:property value="#parameters['applicationid'][0]"/>', '<s:property value="#parameters['sm_userRoleSets.roleId'][0]"/>');
	});
	function initRoleSelect(applicationid, roleid){
		if(!applicationid){
			applicationid = '<s:property value="#parameters['applicationId'][0]"/>';
		}
		if(applicationid!='' && roleid!=''){
			DWREngine.setAsync(false);
			getRoles(applicationid);
		    var applications = document.getElementById("applicationId");
		    var roles = document.getElementById("roleId");
		    for(i=0;i<applications.options.length;i++){
			    if(applications.options[i].value==applicationid){
				    applications.options[i].selected = true;
				}
			}

			for(i=0;i<roles.options.length;i++){
				if(roles.options[i].value==roleid){
					roles.options[i].selected = true;
				}
			}
		}
	}
    function setSelectOptionsTitle(id){//css限制角色选择框长度,js显示过长的内容
        var obj = document.getElementById(id);
	    for(i=0;i<obj.options.length;i++){
	    	obj.options[i].title = obj.options[i].text;
	    }
    }
    function getRoles(value){
    	UserUtil.getRolesByApplicationid(value, function(arr){
          var roles = document.getElementById("roleId");
          DWRUtil.removeAllOptions("roleId");
          DWRUtil.addOptions("roleId", arr);
		  setSelectOptionsTitle("roleId");
        	});
    }

    function donew(){
		parent.document.getElementById("selectnode").value="";
		parent.document.getElementById("isclick").value ="true";
		var page = contextPath + "/saas/admin/user/new.action?domain=<%=request.getParameter("domain")%>&_currpage=<s:property value="datas.pageNo"/>&_pagelines=<s:property value="datas.linesPerPage"/>&_rowcount=<s:property value="datas.rowCount"/>";
		//window.parent.document.getElementById("userFrame").src=page;
		//===========firefox兼容性修改--start=================
		var parentIframe = window.parent.document.getElementById("userFrame");
		var divParent = jQuery(parentIframe).parent();
		var strIframe = '<iframe width="100%" height="100%" frameborder="0"'; 
			strIframe += ' name="userFrame" id="userFrame" src="' + page  + '"></iframe>';
		jQuery(divParent).html(strIframe);
		//===========firefox兼容性修改--end=================
	}
</script>
</head>
<body id="domain_user_list" class="listbody" style="overflow: auto;">
<div>
<s:form id="formList" name="formList" action="treelist" method="post" theme="simple">
	<table class="table_noborder">
		<tr>
			<td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[User_List]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button"  id="new_User" title="{*[New]*}{*[User]*}" class="justForHelp button-image" onClick="donew();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[New]*}</button>
					<button type="button" id="delete_User" title="{*[Delete]*}{*[User]*}" class="justForHelp button-image" onClick="doDelete()"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
				</div>
			</td>
		</tr>
	</table>
	<div id="main">	
		<%@include file="/common/basic.jsp" %>
		<%@include file="/common/msg.jsp"%>	
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<div id="searchFormTable" class="justForHelp" title="{*[Search]*}{*[User]*}">
			<table class="table_noborder">
				<tr><td>
				    <table border="0" style="width: 790px;">
				      	<tr>
					      	<td class="head-text">{*[Name]*}:</td>
					       	<td>
				       			<input pid="searchFormTable" title="{*[cn.myapps.core.user.by_name]*}" class="justForHelp input-cmd" type="text" id="sm_name" value='<s:property value="params.getParameterAsString('sm_name')" />' size="10" /></td>
					        <td class="head-text">{*[Application]*}:</td>
					        <td>
					        	<s:select cssClass="input-cmd" theme="simple" value="#parameters['applicationId'][0]" id="applicationId" name="applicationId" list="_applicationlist" listKey="id" listValue="name" onchange="getRoles(this.value)" emptyOption="true" cssStyle="width:130px;" />
					        </td>
					        <td class="head-text">{*[Department]*}:</td>
					        <td>
					        	<s:select cssClass="input-cmd" theme="simple" value="params.getParameterAsString('sm_userDepartmentSets.departmentId')" id="departmentId" label="%{getText('core.user.department')}" list="_departmentTree" emptyOption="true" cssStyle="width:130px;"/>
					        </td>
						    <td rowspan="2" align="left">
						      	<input id="search_btn" pid="searchFormTable" title="{*[Query]*}{*[User]*}" class="justForHelp button-cmd" type="button" onclick="parent.userlist(jQuery('#sm_name').attr('value'),jQuery('#sm_loginno').attr('value'),jQuery('#departmentId').attr('value'),jQuery('#roleId').attr('value'),jQuery('#applicationId').attr('value'));" value="{*[Query]*}" />
						      	<input id="reset_btn" pid="searchFormTable" title="{*[Reset]*}{*[Search]*}{*[Form]*}" class="justForHelp button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll();jQuery('#applicationId').val('');DWRUtil.removeAllOptions('roleId');" />
						    </td>
				      	</tr>
				      	<tr>
					        <td class="head-text">{*[Account]*}:</td>
					        <td>
						        <input pid="searchFormTable" title="{*[cn.myapps.core.user.by_account]*}" class="justForHelp input-cmd" type="text" id="sm_loginno" value='<s:property value="params.getParameterAsString('sm_loginno')" />' size="10" />
					        </td>
					        <td class="head-text">{*[Role]*}:</td>
					        <td>
				          		<select class="input-cmd" id="roleId" style="width:130px;">
					        		<option value="" ></option>
					      		</select>
						   </td>
						   <td></td>
						   <td></td>
				      	</tr>
				    </table>
					
					<script type="text/javascript">
					  setSelectOptionsTitle("applicationId");
					  setSelectOptionsTitle("departmentId");
					</script>
					
					<s:hidden id="isclick" value="false"></s:hidden>
					<s:hidden id="selectnode" value=""></s:hidden>	
					<s:hidden id="name" value=""></s:hidden>
					<s:hidden id="loginno" value=""></s:hidden>
					<s:hidden id="roleid" value=""></s:hidden>
				</td></tr>
			</table>
		</div>
		
		<!-- 用户列表 -->
		<div id="contentTable">
			<table class="table_noborder tableTOver">
				<tr>
					<td class="column-head2" scope="col"><input type="checkbox"
						onclick="selectAll(this.checked)"></td>
					<td class="column-head" scope="col" title="{*[Name]*}"><o:OrderTag field="name"
						css="ordertag">{*[Name]*}</o:OrderTag></td>
					<td class="column-head" scope="col" title="{*[Account]*}"><o:OrderTag field="loginno"
						css="ordertag">{*[Account]*}</o:OrderTag></td>
					<td class="column-head" scope="col" title="{*[Email]*}"><o:OrderTag field="email"
						css="ordertag">{*[Email]*}</o:OrderTag></td>
					<td class="column-head" scope="col" title="{*[Mobile]*}"><o:OrderTag field="telephone"
						css="ordertag">{*[Mobile]*}</o:OrderTag></td>
					<td class="column-head" scope="col" title="{*[Department]*}">{*[Department]*}</td>
					
					<!-- 扩展字段头 -->
					<s:iterator value="#request.fieldExtendses">
						<td class="column-head" scope="col" title='<s:property value="label"/>'><s:property value="label"/></td>
					</s:iterator>
				</tr>
				<s:iterator value="datas.datas" status="index" id="uservo">
					<tr>
					<td class="table-td"><input type="checkbox" name="_selects"
						value="<s:property value="id"/>"></td>
					<td title='<s:property value="name" />'>
						<a href="javascript: isEdit();document.forms[0].action='<s:url action="edit">
								<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
							<s:property value="name" />
						</a>
					</td>
					<td title='<s:property value="loginno" />'>
						<a href="javascript: isEdit();document.forms[0].action='<s:url action="edit">
								<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
							<s:property value="loginno" />
						</a>
					</td>
					<td title='<s:property value="email" />'>
						<a href="javascript: isEdit();document.forms[0].action='<s:url action="edit">
								<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
							<s:property value="email" />
						</a>
					</td>
					<td title='<s:property value="telephone"/>'>
						<a href="javascript: isEdit();document.forms[0].action='<s:url action="edit">
								<s:param name="id" value="id"/></s:url>';document.forms[0].submit();">
							<s:property value="telephone"/>
						</a>
					</td>
					<td title='<s:iterator value="departments" status="index"><s:property value="name"/><s:if test="!#index.last">|</s:if></s:iterator>'>
						<a href="javascript: isEdit();document.forms[0].action='<s:url action="edit">
								<s:param name="id" value="#uservo.id"/></s:url>';document.forms[0].submit();">
							<s:iterator value="departments" status="index">
			              		<s:property value="name"/><s:if test="!#index.last">&nbsp;&nbsp;|&nbsp;&nbsp;</s:if>			
							</s:iterator>
						</a>
					</td>
					
					<!-- 扩展字段内容 -->
					<s:iterator value="#request.fieldExtendses" id="field">
						<td title='<s:property value="#field.getValue(#uservo)"/>'>
							<a href="javascript: isEdit();document.forms[0].action='<s:url action="edit">
									<s:param name="id" value="#uservo.id"/></s:url>';document.forms[0].submit();">
								<s:property value="#field.getValue(#uservo)"/>
							</a>
						</td>
					</s:iterator>
					
					</tr>
				</s:iterator>
			</table>
		</div>
		<table class="table_noborder">
			<tr>
				<td align="right" class="pagenav">
					<o:PageNavigation dpName="datas" css="linktag" />
				</td>
			</tr>
		</table>
	</div>
</s:form>
</div>
</body>
</o:MultiLanguage></html>
