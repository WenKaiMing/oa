<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[cn.myapps.core.domain.logger.operation.log]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css" />
<link rel="stylesheet" href="<s:url value='/resource/css/style.css' />" type="text/css" />
<script type="text/javascript" src="<s:url value="/script/datePicker/WdatePicker.js" />"></script>
<script type="text/javascript">
	function doDelete(){
		var listform = document.forms['formList'];
	    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
	    	listform.action='<s:url action="delete"><s:param name="id" value="#parameters.id" /></s:url>';
	    	listform.submit();
	    }
	}
	function doView(id){
		document.forms[0].action='<s:url action="view" />?id=' + id;
		document.forms[0].submit();
	}

	function doQuery() {
		document.forms[0].submit();
	}
	
	jQuery(document).ready(function(){
		cssListTable();
		window.top.toThisHelpPage("domain_log_list");
	});
	function doSave() {
		document.forms[0].action='<s:url action="save" />';
		document.forms[0].submit();
	}
</script>
</head><s:bean name="cn.myapps.core.logger.action.LogHelper" id="logHelper" />
<body id="domain_log_list" class="listbody" style="overflow-y:auto;overflow-x:hidden;">
<div>
<s:form name="formList" action="list" method="post" theme="simple">
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.domain.logger.operation.log]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" class="button-image" onClick="doSave('save');"><img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
					<button type="button" id="delete_Log" title="{*[cn.myapps.core.domain.logger.delete_log_operation_log]*}" class="justForHelp button-image" onClick="doDelete()"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
				</div>
			</td></tr>
	</table>
	<div id="main">	
		<%@include file="/common/basic.jsp" %>
		<%@include file="/common/msg.jsp"%>	
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
		<div id="searchFormTable" class="justForHelp" title="{*[cn.myapps.core.domain.logger.search_log_operation_log]*}">
			<table class="table_noborder">
				<tr><td>
				    <table border="0" width="100%">
				      	<tr>
							<td class="commFont">{*[cn.myapps.core.domain.logger.domain_log]*}: <s:radio label="{*[cn.myapps.core.domain.logger.domain_log]*}" name="_log" theme="simple" list="#{'true':'{*[Record]*}','false':'{*[cn.myapps.core.domain.logger.title.not_record]*}'}" /></td>
						</tr>
				     	<tr>
				        	<td class="head-text">{*[cn.myapps.core.domain.logger.log_operator]*}: <input pid="searchFormTable" title="{*[cn.myapps.core.domain.logger.title.by_log_operator]*}" class="justForHelp input-cmd" type="text" name="sm_operator" id="sm_operator" value='<s:property value="params.getParameterAsString('sm_operator')" />'/>
				        		&nbsp;&nbsp;IP: <input pid="searchFormTable" title="{*[cn.myapps.core.domain.logger.title.by_ip]*}" class="justForHelp input-cmd" type="text" name="sm_ip" id="sm_ip" value='<s:property value="params.getParameterAsString('sm_ip')" />'/>
				        		<!-- {*[Type]*}: <input pid="searchFormTable" title="{*[cn.myapps.core.domain.logger.title.by_type]*}" class="justForHelp input-cmd" type="text" name="sm_type"	id="sm_type" value='<s:property value="params.getParameterAsString('sm_type')" />' /> -->
				        		&nbsp;&nbsp;{*[Date]*}: <input pid="searchFormTable" title="{*[cn.myapps.core.domain.logger.title.by_date]*}" class="justForHelp input-cmd" type="text" name="sm_date"	id="sm_date" value='<s:property value="params.getParameterAsString('sm_date')" />' onfocus="WdatePicker({lang:'<s:property value="#logHelper.getWdatePickerLang(#session.USERLANGUAGE)" />'})" />
					    		&nbsp;&nbsp;<input id="search_btn" pid="searchFormTable" title="{*[cn.myapps.core.domain.logger.search_log_operation_log]*}" class="justForHelp button-cmd" type="button" onclick="doQuery();" value="{*[Query]*}" />
					    		&nbsp;&nbsp;<input id="reset_btn" pid="searchFormTable" title="{*[cn.myapps.core.domain.title.reset_search_form]*}" class="justForHelp button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll();" />
					   		</td>
				      	</tr>
				    </table>
				</td></tr>
			</table>
		</div>
		
		<!-- 用户列表 -->
		<div id="contentTable">
			<table class="table_noborder">
				<tr>
					<td class="column-head2" scope="col"><input type="checkbox"
						onclick="selectAll(this.checked)"></td>
					<td class="column-head" scope="col"><o:OrderTag field="operator"
						css="ordertag">{*[cn.myapps.core.domain.logger.log_operator]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag field="type"
						css="ordertag">{*[Type]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag field="description"
						css="ordertag">{*[Description]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag field="date"
						css="ordertag">{*[Date]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag field="ip"
						css="ordertag">IP</o:OrderTag></td>
				</tr>
				<s:iterator value="datas.datas" status="index" id="bean">
					<tr>
					<td class="table-td"><input type="checkbox" name="_selects"
						value="<s:property value="id"/>"></td>
					<td width="10%"><a href="javascript:doView('<s:property value="id"/>');">
						<!-- <s:property value="#logHelper.getUserName(#bean)" /> -->
						<s:property value="operator" /></a></td>
					<td width="20%"><a href="javascript:doView('<s:property value="id"/>');"><s:property value="type" /></a></td>
					<td width="35%"><a href="javascript:doView('<s:property value="id"/>');"><s:property value="description" /></a></td>
					<td width="20%"><a href="javascript:doView('<s:property value="id"/>');"><s:date name="date" format="yyyy-MM-dd HH:mm:ss" /></a></td>
					<td width="25%"><a href="javascript:doView('<s:property value="id"/>');"><s:property value="ip" /></a></td>
					</tr>
				</s:iterator>
			</table>
		</div>
		<table class="table_noborder">
			<tr>
				<td align="right" class="pagenav"><o:PageNavigation dpName="datas"
					css="linktag" /></td>
			</tr>
		</table>
	</div>
</s:form>
</div>
</body>
</o:MultiLanguage></html>