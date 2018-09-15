<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	function loadUserByDomainId(domainId) {
		var url = contextPath + "/core/sysconfig/configure.action?domainId=" + domainId;
		window.location.href=url;
	}

	function checkForm() {
		var _selects = document.getElementsByName("_selects");
		if(_selects.length == 0) {
			alert("{*[core.sysconfig.km.role.config.domain.select.alert]*}");
			return false;
		}

		var count = 0;
		for (var i = 0; i < _selects.length; i++) {
			if (_selects[i].checked == true) {
				count++;
			}
		} 
		if (count == 0) {
			alert("{*[core.sysconfig.km.role.config.user.select.alert]*}");
			return false;
		}
		return true;
	}

	function resetAll(){
		jQuery('#sm_name,#sm_loginno').val('');
		jQuery("#departmentId").get(0).selectedIndex=0;
		
	}

	function userlist(sm_name,sm_loginno,departmentId){
		jQuery("#name").attr("value",sm_name);
		jQuery("#loginno").attr("value",sm_loginno);
		
		var targetUrl = "";

		if(sm_loginno != null && sm_loginno != ""){
			targetUrl += "&sm_loginno="+encodeURI(sm_loginno);
		}
		if(departmentId != null && departmentId != ""){
			targetUrl += "&sm_userDepartmentSets.departmentId="+departmentId;
		}
		var page = contextPath + "/core/sysconfig/configure.action?domainId=<%=request.getParameter("domainId")%>" + targetUrl;
		 var f= document.createElement('form');
		 f.action = page;
		 f.method = 'post';
		 document.body.appendChild(f);
		 if(sm_name != null && sm_name != ""){
			 var temp=document.createElement('input');
			 temp.type= 'hidden';
			 temp.value=sm_name; 
			 temp.name='sm_name';
			 f.appendChild(temp);
			}
		 f.submit();
	}
	
</script>
<title>Insert title here</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<style type="text/css">
	.moduleSpace {
		margin: 5px 0px;
	}
</style>
</head>
<body>
	<%@include file="/common/msg.jsp"%>	
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<form action="saveConfig.action" method="post">
	<div style="text-align:right;" class="moduleSpace">
		<input type="submit" value="{*[OK]*}" onclick="return checkForm();"/>&nbsp;&nbsp;
		<input type="button" value="{*[Cancel]*}" onclick="OBPM.dialog.doExit();"/>&nbsp;&nbsp;
	</div>
	<div class="moduleSpace">
		<fieldset>
			<legend>{*[cn.myapps.core.sysconfig.user_role_select]*}<s:property value="kmConfig" /></legend>
			<table>
				<tr>
					<s:iterator value="datas.datas">
					<td>
						<input type="checkbox" name="_kmRoleSelectItem" value="<s:property value="id" />"/>
						{*[<s:property value="name" />]*}
					</td>
					</s:iterator>
					<span class="tipsStyle">（{*[core.sysconfig.km.role.config.tips]*}）</span>
				</tr>
			</table>
		</fieldset>
	</div>
	<div class="moduleSpace" style="display:none;">
		<fieldset>
			<legend>{*[core.sysconfig.km.role.config.domain.select]*}</legend>
			<select onchange="loadUserByDomainId(this.value);">
				<option value="0">--{*[core.sysconfig.km.role.config.select]*}--</option>
				<s:iterator value="domains">
				<s:if test='id==params.getParameterAsString("domainId")'>
				<option value="<s:property value="id"/>" selected="selected"><s:property value="name"/></option>
				</s:if>
				<s:else>
				<option value="<s:property value="id"/>"><s:property value="name"/></option>
				</s:else>
				</s:iterator>
			</select>
			<span class="tipsStyle">（{*[core.sysconfig.km.role.config.tips]*}）</span>
		</fieldset>
	</div>
	
	<s:if test='null!=params.getParameterAsString("domainId")'>	
	<div class="moduleSpace">
	  <table border="0" style="width: 790px;">
		<tr>
			<td class="head-text">{*[Name]*}:</td>
		    <td>
		    <input pid="searchFormTable" title="{*[cn.myapps.core.domain.userlist.title.by_name]*}" class="justForHelp input-cmd" type="text" id="sm_name" value='<s:property value="params.getParameterAsString('sm_name')" />' size="10" />  
		    </td>
		    <td class="head-text">{*[Department]*}:</td>
			     <td>
    			<select id="departmentId" name="departmentId" style="width: 152">
    			<option value=""></option>
    			<s:iterator value="departments">
    				<s:if test="valid == 1">
   						<option value="<s:property value="id"/>" <s:if test='id==params.getParameterAsString("sm_userDepartmentSets.departmentId")'> selected="selected" </s:if>><s:property value="name"/></option>
   					</s:if>
   				</s:iterator>
   				</select>
    		</td>	   
		    <td class="head-text">{*[Account]*}:</td>
			<td>
		    <input pid="searchFormTable" title="{*[cn.myapps.core.domain.userlist.title.by_account]*}" class="justForHelp input-cmd" type="text" id="sm_loginno" value='<s:property value="params.getParameterAsString('sm_loginno')" />' size="10" />
		    </td>	
		    <td rowspan="2" align="left">
				<input id="search_btn" pid="searchFormTable" title="{*[cn.myapps.core.domain.userlist.title.search_user]*}" class="justForHelp button-cmd" type="button" onclick="userlist(jQuery('#sm_name').attr('value'),jQuery('#sm_loginno').attr('value'),jQuery('#departmentId').attr('value'));" value="{*[Query]*}" />
				<input id="reset_btn" pid="searchFormTable" title="{*[cn.myapps.core.domain.title.reset_search_form]*}" class="justForHelp button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll()" />
			</td>	      
		 </tr>
		</table>
	</div>
	</s:if>
	
	<!-- 用户列表 -->
	<div id="contentTable" class="moduleSpace">
	<table class="list-table" border="0" cellpadding="2" cellspacing="2"
		width="100%">
		<tr>
			<td class="column-head2" scope="col"><input type="checkbox"
				onclick="selectAll(this.checked)"></td>
			<td class="column-head" scope="col"><o:OrderTag field="name"
				css="ordertag">{*[Name]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="loginno"
				css="ordertag">{*[Account]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="email"
				css="ordertag">{*[Email]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="telephone"
				css="ordertag">{*[Mobile]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="departments"
				css="ordertag">{*[Department]*}</o:OrderTag></td>
		</tr>
		<s:iterator value="users" status="index">
			<s:if test="#index.odd == true">
				<tr class="table-text">
			</s:if>
			<s:else>
				<tr class="table-text2">
			</s:else>
			<td class="table-td">
				<input type="checkbox" name="_selects"value="<s:property value="id"/>">
			</td>
			<td><s:property value="name" /></td>
			<td><s:property value="loginno" /></td>
			<td><s:property value="email" /></td>
			<td><s:property value="telephone"/></td>
			<td>
				<s:iterator value="departments">
					<s:property value="name" />
				</s:iterator>
			</td>
		</s:iterator>
	</table>
	</div>
	</form>
</body>
</o:MultiLanguage>
</html>