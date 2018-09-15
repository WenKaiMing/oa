<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="cn.myapps.base.dao.DataPackage"%>
<%@ page import="cn.myapps.core.role.ejb.RoleVO"%>
<%@ page import="java.util.*"%>
<%
	String roleList = (String) request.getParameter("tempRoles");
%>
<html>
<o:MultiLanguage>
<head>
<title>{*[Role]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />"	type="text/css">
<script src="<s:url value="/script/list.js"/>"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>

<script type="text/javascript" language="javascript">  
	

 function ev_selectAll(b, isRefresh){
    var c = document.getElementsByName('_selects');
    if(c==null)
    return;
    
    if (c.length!=null){
      for(var i = 0; i < c.length ;++i) {
      	c[i].checked = b && !(c[i].disabled);
      	autoDisposeOrder(c[i]);
      }
        
    }else{
      c.checked = b;
	}
}
 
 function autoDisposeOrder(checkObj)  
 {  
	 if(checkObj.checked)  
	 selOrder(checkObj.value);  
	 else  
	 delOrder(checkObj.value);  
 }  
 function selOrder(orderID) {  
	 var mslObj = document.formList.tempRoles;  
	 var i,isExists = false,orders;  
	 if(mslObj.value == "")  
	 orders = new Array();  
	 else  
	 orders = mslObj.value.split(",");  
	 for(i = 0;i < orders.length;i++)  
	 {  
	 if(orders[i] == orderID)  
	 isExists = true;  
 }  
 if(!isExists) orders[orders.length] = orderID;  
 mslObj.value = orders.join(",");  
 }  
 function delOrder(orderID)  
 {  
	 var mslObj = document.formList.tempRoles;  
	 var i,orders;  
	 if(mslObj.value  ==  "")  
	 orders = new Array();  
	 else  
	 orders = mslObj.value.split(",");  
	 for(i = 0;i < orders.length;)  
	 {  
	 if(orders[i] == orderID)  
	 orders.splice(i,1);  
 else  
 i++;  
 }  
 mslObj.value = orders.join(",");  
 }  
</script>

<script>
function doReturn() {
	addCheckBox();
 	var sis = document.getElementsByName("selects");
 	var rtn = new Array();
 	var p = 0;

 	if (sis.length >= 1 ) {
	 	for (var i=0; i<sis.length; i++) {
	  		var e = sis[i];
	  		if (e.type == 'checkbox') {
	   			if (e.checked && e.value) {
	    			rtn[p++] = e.value;
	   			}
	  		}
	 	}
 	}else {
 		showMessage("error", "请选择角色!");
		return false;
 	}
  	OBPM.dialog.doReturn(rtn.toString());
}

function addCheckBox(){ 
	var list = document.formList.tempRoles.value;
	var roles = list.split(",");
	
	if(roles.length && roles[0] == "") return;
	
	for( var i=0;i<roles.length;i++) {
		if (roles[i] != null && roles[i] != 'null') {
			// firefox不支持insertAdjacentHTML
			// hiddenCheckBox.insertAdjacentHTML("beforeEnd","<input type=checkbox name='selects' value='"+ roles[i] +"' checked='checked'><br>"); 
			jQuery("#hiddenCheckBox").append("<input type=checkbox name='selects' value='"+ roles[i] +"' checked='checked'><br>");
		}
	}
} 
jQuery(document).ready(function(){
	cssListTable(); /*in list.js*/
	window.top.toThisHelpPage("application_info_generalTools_homePage_linkRole");	
});
</script>
</head>
<body class="body-back">
<s:form theme="simple" name="formList" action="linkRole" method="post">
	<%@include file="/common/list.jsp"%>
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.role.role_list]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" class="button-image" onClick="doReturn();"><img
							src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[Confirm]*}</button>
					<button type="button" class="button-image" onClick="OBPM.dialog.doReturn('clear');"><img
							src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[Clear]*}</button>
					<button type="button" class="button-image" onClick="OBPM.dialog.doReturn();"><img
							src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[Exit]*}</button>
				</div>
			</td></tr>
	</table>
	<div id="main">
		<div id="searchFormTable">
			<table class="table_noborder">
				<tr><td class="head-text">
					{*[Name]*}:	<input class="input-cmd" type="text" name="sm_name" value='<s:property value="#parameters['sm_name']" />' size="10" />
					<input class="button-cmd" type="submit" value="{*[Query]*}" />
					<input class="button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll();" />
				</td>
				</tr>
			</table>
		</div>
		<%@include file="/common/msg.jsp"%>
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<div id="contentTable">
			<table class="table_hasborder"  border="1" cellpadding="0" cellspacing="0">
				<tr>
					<td class="column-head2"><input type="checkbox" onclick="ev_selectAll(this.checked)"></td>
					<td class="column-head" scope="col"><o:OrderTag field="name" css="ordertag">{*[Name]*}</o:OrderTag></td>
				</tr>
				<s:iterator value="datas.datas" status="index">
				<tr>
					<td class="table-td">
						<s:set name="roleid" value="id" scope="page" />
					   <% if(roleList.indexOf(pageContext.getAttribute("roleid").toString())!=-1){%>
					    	<input type="checkbox" name="_selects" value="<s:property value="id" />"  onclick="autoDisposeOrder(this);" checked="checked"/>
					    
					   <% }else{%>
					    	<input type="checkbox" name="_selects" value="<s:property value="id" />"  onclick="autoDisposeOrder(this);"/>
					  <% }%>
					</td>
					<td><s:property value="#parameters.tempRoles.indexOf(id)" />
						<s:property value="name" />
					</td>
				</tr>
				</s:iterator>
			</table>
			<div>
				<input type="hidden" name="tempRoles" id="tempRoles" value="<%=roleList %>" size="100" />
				<div id="hiddenCheckBox" style="display:none"></div>
			</div>
		</div>
		<table class="table_hasborder">
			<tr>
				<td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag" /></td>
			</tr>
		</table>
</s:form>
</body>
</o:MultiLanguage>
</html>
