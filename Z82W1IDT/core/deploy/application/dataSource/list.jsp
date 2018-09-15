<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/tags.jsp" %>
<%@include file="/common/taglibs.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<script src="<s:url value="/script/list.js"/>"></script>
<script type="text/javascript">
function doSelect(dataSourceId,dataSourceName){
	var dataSource = new Object();
    dataSource.id = dataSourceId;
    dataSource.name = dataSourceName;
    OBPM.dialog.doReturn(dataSource);
	//window.returnValue = dataSource;
	//window.close();
}
function doDelete(){
	var listform = document.forms['formList'];
	if(isSelectedOne("_selects","{*[please.choose.one]*}")){
    	listform.action='<s:url action="deleteDataSources"/>';
    	listform.submit();
    }
}

function editDataSoure(url){
	if(url!=""){
		window.location.href=url;
	}
}

function doEmpty(){
	var dataSource = new Object();
    dataSource.id = "";
    OBPM.dialog.doReturn(dataSource);
}

jQuery(document).ready(function(){
	cssListTable();
	window.top.toThisHelpPage("application_info_advancedTools_dataSource_list");	
});
</script>
<title>{*[cn.myapps.core.deploy.application.datasource_info_list]*}</title>
</head>
<body id="bodyid" style="overflow: hidden;">
<s:form name="formList" id="listform" theme="simple" action="listAllDts" method="post">
	<input type="hidden" name="_currpage" value='<s:property value="datas.pageNo"/>' />
	<input type="hidden" name="_pagelines" value='<s:property value="datas.linesPerPage"/>' />
	<input type="hidden" name="_rowcount" value='<s:property value="datas.rowCount"/>' />
	<s:textfield name="tab" cssStyle="display:none;" value="1" />
	<s:textfield name="selected" cssStyle="display:none;" value="%{'btnDataSource'}" />
	<input type="hidden" name="s_module" value="<s:property value='#parameters.s_module'/>" />
	<table class="table_noborder">
			<tr><td>
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.core.deploy.application.datasource_info_list]*}</div>
			</td>
			<td>
				<div class="actbtndiv">
					<button type="button" class="button-image" onClick="forms[0].action='<s:url action="newDataSource"/>';forms[0].submit();">
						<img src="<s:url value="/resource/imgnew/act/act_2.gif"></s:url>">{*[New]*}
					</button>
					<button type="button" class="button-image" onClick="doDelete()">
						<img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}
					</button>
					<button type="button" class="button-image" onClick="doEmpty()">
						<img src="<s:url value="/resource/imgnew/remove.gif"/>">{*[Clear]*}
					</button>
					<button type="button" class="button-image" onClick="OBPM.dialog.doReturn();">
						<img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}
					</button>
				</div>
			</td></tr>
	</table>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>	
	<div id="main">
		<div id="searchFormTable" class="justForHelp" title="{*[cn.myapps.core.deploy.application.search_form]*}">
			<table class="table_noborder">
				<tr>
					<td class="head-text">
						{*[Name]*}:<s:hidden name="application" value="%{#parameters.application}" /><input class="input-cmd" type="text" name="sm_name" value='<s:property value="#parameters['sm_name']"/>' size="30" />
						<input class="button-cmd" type="submit" value="{*[Query]*}" />
						<input class="button-cmd" type="button" value="{*[Reset]*}" onclick="resetAll();"/>
					</td>
				</tr>
			</table>
		</div>	
	 	<div id="contentTable">
			 <table class="table_noborder">
			   	<tr>
			   	    <td class="column-head2" scope="col"><input type="checkbox" onclick="selectAll(this.checked)"/></td>
			   		<td class="column-head"><o:OrderTag field="name" css="ordertag">{*[Name]*}</o:OrderTag></td>
			   		<td class="column-head"><o:OrderTag field="useType" css="ordertag">{*[cn.myapps.core.deploy.application.use_type]*}</o:OrderTag></td>
			   		<td class="column-head"><o:OrderTag field="dbType" css="ordertag">{*[cn.myapps.core.deploy.application.database_type]*}</o:OrderTag></td>
			   		<td class="column-head"><o:OrderTag field="dbType" css="ordertag">JNDI/JDBC {*[URL]*}</o:OrderTag></td>
					<td class="column-head" width="50px">{*[Activity]*}</td>
				</tr>
				<s:iterator value="datas.datas" status="index" id="data">
					<tr height="22">
					<td align="center">
					  <input type="checkbox" name="_selects" value='<s:property value="id" />'/>
					</td>
			  	 	<td valign="middle">
			  	 		<a href="javascript:doSelect('<s:property value="id" />','<s:property value="name" />')"><s:property value="name" /></a>
					</td>
			 		<td valign="middle">
			 			<a href="javascript:doSelect('<s:property value="id" />','<s:property value="name" />')"><s:property value="useType" /></a>
			 		</td>
			 		<td valign="middle">
			 			<a href="javascript:doSelect('<s:property value="id" />','<s:property value="name" />')"><s:property value="#data.getDbTypeName()" /></a>
			 		</td>
			 		<td valign="middle">
			 			<a href="javascript:doSelect('<s:property value="id" />','<s:property value="name" />')">
			 				<s:if test="#data.getUseType().equals(\"JDBC\")">
			 					<s:property value="url" />
			 				</s:if>
			 				<s:elseif test="#data.getUseType().equals(\"JNDI\")">
			 					<s:property value="providerUrl" />
			 				</s:elseif>
			 			</a>	
			 		</td>
					<td valign="middle" style="background-image: ">
			 			<button type="button" onclick="editDataSoure('<s:url value="editDataSource.action"><s:param name="id" value="id" /><s:param name="application" value="%{#parameters.application}" /><s:param name="_currpage" value="datas.pageNo" /><s:param name="_pagelines" value="datas.linesPerPage" /><s:param name="_rowcount" value="datas.rowCount" /><s:param name="tab" value="1" /><s:param name="selected" value="%{'btnDataSource'}" /><s:param name="sm_name" value="#parameters.sm_name"/></s:url>')" type="button">{*[Edit]*}</button>
			 		</td>
			 		</tr>
			    </s:iterator>
			</table>
		</div>
		<table class="table_noborder">
				<tr>
					<td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag" /></td>
				</tr>
			</table>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>