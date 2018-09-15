<%@ include file="/portal/share/common/head.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<o:MultiLanguage>
	<head>
	<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>"
		type="text/css">
	<title>{*[Role]*}{*[List]*}</title>
	<script src="<s:url value="/portal/share/script/list.js"/>"></script>
	<script type="text/javascript">
function doDelete(){
	var listform = document.forms['formList'];
    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
    	listform.action='<s:url action="delete"/>';
    	listform.submit();
    }
}

jQuery(document).ready(function(){
	cssListTable();
});

</script>
</head>
<body>
<s:actionerror /> 
<s:form theme="simple" name="formList" action="list" method="post">
	<%@include file="/common/list.jsp"%>
	<s:textfield name="tab" cssStyle="display:none;" value="1" />
	<s:textfield name="selected" cssStyle="display:none;" value="%{'btnRole'}" />
	<table cellpadding="0" cellspacing="0" width="100%" style="border-bottom: 1px solid;">
		<tr>
			<td valign="top" align="right">
				<button type="button" class="button-image"
					onClick="forms[0].action='<s:url action="new"></s:url>';forms[0].submit();"><img
					src="<s:url value="/resource/imgnew/act/act_2.gif"></s:url>">{*[New]*}</button>
				<button type="button" class="button-image" onClick="doDelete()"><img
					src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
			</td>
		</tr>
	</table>
		<%@include file="/portal/share/common/msg.jsp"%>
		<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="searchFormTable" class="justForHelp" title="{*[Search]*}{*[Department]*}">
		<table class="table_noborder">
			<tr>
			<td class="head-text">
				{*[Name]*}:<input class="input-cmd" type="text" name="sm_name" value='<s:property value="#parameters['sm_name']" />' size="10" />
				<input class="button-cmd" type="submit" value="{*[Query]*}" />
				<input class="button-cmd" type="button" value="{*[Reset]*}"	onclick="resetAll()" />
			</td></tr>
		</table>
	</div>
	<div id="contentTable" class="listbody">
		<table class="table_noborder">
			<tr>
				<td class="column-head2"><input type="checkbox"
					onclick="selectAll(this.checked)"></td>
				<td class="column-head" scope="col"><o:OrderTag field="name"
					css="ordertag">{*[Name]*}</o:OrderTag></td>
			</tr>
			<s:iterator value="datas.datas" status="index">
				<tr>
				<td class="table-td"><input type="checkbox" name="_selects"
					value="<s:property value="id"/>"></td>
				<td><a
					href='<s:url action="edit">
				<s:param name="_currpage" value="datas.pageNo" />
				<s:param name="_pagelines" value="datas.linesPerPage" />
				<s:param name="_rowcount" value="datas.rowCount" />
				<s:param name="application" value="#parameters.application" />
				<s:param name="id" value="id"/>
				<s:param name="tab" value="1" />
				<s:param name="selected" value="%{'btnRole'}" />
				</s:url>'>
				<s:property value="name" /></a></td>
				</tr>
			</s:iterator>
		</table>
		
		<table class="table_noborder">
			<tr>
				<td align="right" class="pagenav"><o:PageNavigation
					dpName="datas" css="linktag" /></td>
			</tr>
		</table>
	</div>
</s:form>
</body>
</o:MultiLanguage>
</html>
