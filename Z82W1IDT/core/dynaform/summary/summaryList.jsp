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
	function doDelete(){
		if(isSelectedOne("_selects","{*[please.choose.one]*}")){
		  document.forms[0].action='<s:url action="delete" />'; 
		  document.forms[0].submit();
		}
	}
	
	function doNew(){
		var formId=document.getElementById('sm_formId').value;
		var application = document.getElementById('_applicationid').value;
		var url = "<s:url value='/core/dynaform/summary/new.action'></s:url>?content.formId="+formId+"&content.applicationid="+application;
		OBPM.dialog.show({
			opener:window.parent.parent,
			width: 700,
			height: 500,
			url: url,
			args: {},
			title: '{*[Add]*}{*[Summary]*}',
			maximized: false, // 是否支持最大化
			close: function(rtn) {
				parent.refreshSummary();
				//document.forms['summaryList'].submit();
			}
	});
	}
	
	jQuery(document).ready(function(){
		cssListTable();
		window.top.toThisHelpPage("application_module_form_reminder");
	});
	
	
	function doEdit(id){
		var url = "<s:url value='/core/dynaform/summary/edit.action'></s:url>?id="+id;
		OBPM.dialog.show({
			opener:window.parent.parent,
			width: 700,
			height: 500,
			url: url,
			args: {},
			title: '{*[Add]*}{*[Summary]*}',
			maximized: false, // 是否支持最大化
			close: function(rtn) {
				parent.refreshSummary();
				//document.forms['summaryList'].submit();
			}
	});
	}
</script>
</head>
<body style="margin:0px;" align="left">
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<s:form name="summaryList" action="summaryList" method="post">
	<%@include file="/common/basic.jsp" %>
	<input type="hidden" id="sm_formId" name="sm_formId" value='<s:property value="#parameters['sm_formId']"/>' />
	<input type="hidden" id="_applicationid" name="_applicationid" value='<s:property value="#parameters['_applicationid']"/>' />
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[Summary]*}{*[List]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" class="button-image" name="addButton" id="addButton" onClick="doNew()"><img src="<s:url value="/resource/imgnew/add.gif"/>">{*[New]*}</button>
					<button type="button" class="button-image" name="removeButton" id="removeButton" onClick="doDelete()"><img src="<s:url value="/resource/imgnew/remove.gif"/>">{*[Delete]*}</button>
				</div>
			</td></tr>
	</table> 
	<div id="main">  
	<div id="contentTable">
		<table class="table_noborder">
			<tr> 
				<td class="column-head2" scope="col"><input type="checkbox"
					onclick="selectAll(this.checked)"></td>
				<td class="column-head" scope="col">{*[Title]*}</td>
				<td class="column-head" scope="col">{*[cn.myapps.core.dynaform.summary.label.scope]*}</td>
			</tr>
			<s:iterator value="datas.datas" status="index">
				<tr>
				<td class="table-td"><input type="checkbox" name="_selects"
					value="<s:property value="id"/>"></td>
				<td>
				<a
					href="javascript:doEdit('<s:property value="id"/>');">
					<s:property value="title" />
					</a>
				</td>
				<td>
				<a
					href="javascript:doEdit('<s:property value="id"/>');">
					<s:if test="scope ==0">{*[cn.myapps.core.dynaform.summary.scope.showDoSummary]*}</s:if>
					<s:elseif test="scope ==1">{*[cn.myapps.core.dynaform.summary.scope.flowNotice]*}</s:elseif>
					<s:elseif test="scope ==6">{*[cn.myapps.core.dynaform.summary.scope.circulatSummary]*}</s:elseif>
					</a>
				</td>
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
		<table class="table_noborder">
			<tr>
				<td align="left"  class="tipsStyle">
					*用于流程通知、表单操作类型为通过邮件或手机分享、首页等
				</td>
			</tr>
		</table>
	</div>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>