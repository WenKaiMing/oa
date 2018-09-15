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
var args = OBPM.dialog.getArgs();
var parentObj = args['parentObj'];
/*存放userid*/
var targetid=args['targetid'];
/*存放username*/
var viewName=args['receivername'];

function resetTargetValue(_selects,calendarTypeName){
	if (parentObj.document.getElementById(targetid)) {
		parentObj.document.getElementById(targetid).value=_selects;
	}
	if (parentObj.document.getElementById(viewName)) {
		parentObj.document.getElementById(viewName).value=calendarTypeName;
	}
}

/*初始化返回事件*/
function initDoReturnFunction(){
	jQuery("a[name='doReturn']").click(function(){
		var rtn="";
		rtn+=jQuery(this).attr("id")+",";
		if (rtn && rtn.length > 0) {
			rtn=rtn.substring(0,rtn.length-1);
		}
		OBPM.dialog.doReturn(rtn);
	});
}

	function adjustDataIteratorSize() {
		var containerHeight = document.body.clientHeight-50;
		var container = document.getElementById("main");
		container.style.height = containerHeight + 'px';
	}
	jQuery(document).ready(function(){
		cssListTable();
		setTimeout(function(){
			adjustDataIteratorSize(); //调整工作日历列表高度
		},50);
		initDoReturnFunction();
		window.top.toThisHelpPage("domain_workCalendar_list");
	});
	
</script>
<body id="domain_dept_list" class="listbody">
<div>
<s:form name="formList" action="calendarlistSelect" method="post" theme="simple">
    <%@include file="/common/basic.jsp"%>
    <table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.domain.calendarlist.workCalendar_list]*}</div>
			</td>
			</tr>
	</table> 
	<div id="main" style="overflow-y:auto;overflow-x:hidden;">   
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
			<s:hidden name="parentid" id="parentid" value="%{#request.parentid}"></s:hidden>
			<s:hidden name="operation" value="%{#request.operation}" />
			<table class="table_noborder"  border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="column-head" scope="col" width="30%"><o:OrderTag field="name"
						css="ordertag">{*[cn.myapps.core.domain.calendarlist.calendar_name]*}</o:OrderTag></td>
				</tr>
				<s:iterator value="datas.datas" status="index">
					<tr>
					<td><a name="doReturn" onclick="resetTargetValue('<s:property value="id"/>','{*[<s:property value="name"/>]*}')" >{*[<s:property value="name" />]*}</a></td>
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



