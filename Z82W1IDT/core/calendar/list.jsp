<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<% 
	String contextPath = request.getContextPath();
	String parentid = (String)request.getAttribute("parentid");
%>
<html><o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.domain.department.department_list]*}</title>
<link rel="stylesheet" type="text/css"	href="<s:url value='/resource/css/main.css' />" />
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<style type="text/css">
/**IE7hack**/
*+html .table-td input {
	padding-top:3px;
}
</style>
<script type="">
	var contextPath='<%=contextPath%>';
</script>
<script src="<s:url value="/script/list.js"/>"></script>
</head>
<script>
	function doDelete(){
	    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
		    if(confirm("确定删除选中项?")){
		    	formList.action='<s:url value="/core/calendar/delete.action" ></s:url>';
		    	formList.submit();
		    }
	    }
	}
	
	function createView(){
		var domainids = document.getElementById("calendarlist_domain").value;
		var domainid=domainids.split(",")[0];
      	var url = '<s:url value="/core/calendar/new.action" ><s:param name="domain" value="#parameters.domain" /></s:url>';
      	//var id=showframe("view",url);
	 	OBPM.dialog.show({
				opener:window.parent,
				width: 600,
				height: 500,
				url: url,
				args: {},
				title: '{*[cn.myapps.core.domain.calendarlist.title.create_workCalendar]*}',
				close: function(id) {
					window.top.toThisHelpPage("domain_workCalendar_list");
					if(id != null){
						var viewurl="<s:url action='displayView'><s:param name="domain" value="#parameters.domain" /></s:url>&_calendarid=" + id;
						window.parent.document.getElementById("frame").src = viewurl; // firefox兼容此模式
	  					//window.location.replace(viewurl); // firefox不兼容此模式
	  				}
				}
		});
	}
	jQuery(document).ready(function(){
		cssListTable();
		window.top.toThisHelpPage("domain_workCalendar_list");
	});
	function ev_view(calid) {
		var domainids = document.getElementById("calendarlist_domain").value;
		var domainid=domainids.split(",")[0];
      	var url = '<s:url value="/core/calendar/edit.action" ><s:param name="domain" value="#parameters.domain" /></s:url>&id=' + calid;
      	//var id=showframe("view",url);
	 	OBPM.dialog.show({
				opener:window.parent,
				width: 600,
				height: 500,
				url: url,
				args: {},
				title: '{*[cn.myapps.core.domain.calendarlist.title.edit_workCalendar]*}',
				close: function() {
					window.top.toThisHelpPage("domain_workCalendar_list");
					// URL拼接
					var viewurl="<s:url action='calendarlist'><s:param name="domain" value="#parameters.domain" /></s:url>";
					viewurl += "&_pagelines=" + document.getElementsByName("_pagelines")[0].value;
					viewurl += "&_currpage=" + document.getElementsByName("_currpage")[0].value;
					
					window.parent.document.getElementById("frame").src = viewurl; // firefox兼容此模式
  					//window.location.replace(viewurl);
				}
		});
	}
</script>
<body id="domain_dept_list" class="listbody">
<div>
<s:form name="formList" action="calendarlist" method="post" theme="simple">
    <%@include file="/common/basic.jsp"%>
    <table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.domain.calendarlist.workCalendar_list]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" id="New_Calendar" title="{*[New]*}" class="button-image" onClick="createView();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[New]*}</button>
					<button type="button" class="button-image" onClick="doDelete()"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
				</div>
			</td></tr>
	</table> 
	<div id="main">   
		<%@include file="/common/msg.jsp"%>	
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
		<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<div id="searchFormTable">
			<table class="table_noborder">
				<tr><td class="head-text">
					{*[cn.myapps.core.domain.calendarlist.calendar_name]*}:
					<input class="input-cmd" type="text" name="sm_name" id="sm_name" value='<s:property value="params.getParameterAsString('sm_name')"/>' size="10" />
					
					<s:hidden id="isclick" value="false"></s:hidden>
					<s:hidden id="selectnode" value=""></s:hidden>
					<s:hidden id="departname" value=""></s:hidden>
					<s:hidden id="isedit" value="false"></s:hidden>
					
					<input class="button-cmd" type="button" onclick="document.forms[0].submit();" value="{*[Query]*}" />
					<input class="button-cmd" type="button" value="{*[Reset]*}" onclick="resetAll()" />
				</td></tr>
			</table>
		</div>
		
		<div id="contentTable">
			<s:hidden name="parentid" id="parentid" value="#request.parentid"></s:hidden>
			<s:hidden name="operation" value="%{#request.operation}" />
			<table class="table_noborder"  border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="column-head2" scope="col"><input type="checkbox"
						onclick="selectAll(this.checked)"></td>
					<td class="column-head" scope="col" width="30%"><o:OrderTag field="name"
						css="ordertag">{*[cn.myapps.core.domain.calendarlist.calendar_name]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag field="superior.name"
						css="ordertag">{*[Description]*}</o:OrderTag></td>
					<td class="column-head" scope="col" style="width:80px;">{*[Actions]*}</td>
				</tr>
				<s:iterator value="datas.datas" status="index">
					<tr>
					<td class="table-td"><input type="checkbox" name="_selects" value="<s:property value="id"/>"></td>
					<td><a
						href="javascript:document.forms[0].action='<s:url value='/core/calendar/displayView.action'>
						<s:param name="domain" value="domainid"/><s:param name="_calendarid" value="id"/></s:url>';
						document.forms[0].submit();">
						{*[<s:property value="name" />]*}</a></td>
					<td>{*[<s:property value="remark" />]*}</td>
					<td class="table-td" scope="col">
						<input title="{*[Edit]*}" type="button" value="{*[Edit]*}" onclick="ev_view('<s:property value="id"/>');" /></td>
					</tr>
				</s:iterator>
			</table>
			<table class="table_noborder">
				<tr>
					<td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag" /></td>
				</tr>
			</table>
		</div>
	</div>
</s:form>
</div>
</body>
</o:MultiLanguage></html>



