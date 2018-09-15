<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html><o:MultiLanguage>
<head>
<title>{*[Customize app]*}</title>
<script src="<s:url value="/script/list.js"/>"></script>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
</head>
<body id="bodyid">
<div id="tabContainerid">
<s:actionerror />
<s:form name="formList" action="list" method="post">
<input type="hidden" name="_currpage" value='<s:property value="datas.pageNo"/>' />
<input type="hidden" name="_pagelines" value='<s:property value="datas.linesPerPage"/>' />
<input type="hidden" name="_rowcount" value='<s:property value="datas.rowCount"/>' />
<table width="98%" class="list-table" >
		<tr class="list-toolbar">
			<td width="10" class="image-label"><img
				src="<s:url value="/resource/image/email2.jpg"/>" /></td>
			<td width="3"></td>
			<td width="140" class="text-label">{*[Customize]*} {*[app]*}</td>
			<td>
			<table width="100%" border=1 cellpadding="0" cellspacing="0" class="line-position" ><tr><td ></td>
				<td class="line-position2" width="60" valign="top">
				<button type="button" class="back-class" onClick="forms[0].action='<s:url action="new"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"/>">{*[New]*}</button>
				</td>
				<td class="line-position2" width="70" valign="top">
				<button type="button" class="back-class" onClick="forms[0].action='<s:url action="delete"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
				</td>
			</tr></table>
			</td>
		</tr>
	</table>
<table>
<div id="contentTable">
<%@include file="/common/msg.jsp"%>	
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<table class="list-table" border="0" cellpadding="2" cellspacing="0"
		width="100%">
		<tr>
			<td class="column-head2" scope="col"><input type="checkbox"
				onclick="selectAll(this.checked)"></td>
			<td class="column-head" scope="col"><o:OrderTag field="name"
				css="ordertag">{*[Application]*}{*[Name]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="resourcepath"
				css="ordertag">{*[Resource]*} {*[path]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="description"
				css="ordertag">{*[Description]*}</o:OrderTag></td>
			<td class="column-head" scope="col"><o:OrderTag field="activated"
			css="ordertag">{*[State]*}</o:OrderTag></td>
		</tr>
    	<s:iterator value="datas.datas" status="index">
			<tr>
				<td class="table-td"><input type="checkbox" name="_selects"
					value="<s:property value="id" />"></td>
				<td><a
					href="<s:url action="edit"><s:param name="id" value="id"/>
						<s:param name="_currpage" value="datas.pageNo" />
						<s:param name="_pagelines" value="datas.linesPerPage" />
						<s:param name="_rowcount" value="datas.rowCount" />
					</s:url>"><s:property value="name" />
				</a></td>
			<td><s:property value="resourcepath" /></td>
			<td><s:property value="description.length()>40?description.substring(0,40)+'...':description" /></td>
			<td>
				<s:if test="activated">
					{*[core.workflow.storage.runtime.proxy.activation]*}
				</s:if>
				<s:elseif test="!activated">
					{*[core.workflow.storage.runtime.proxy.disable]*}
				</s:elseif>
			</td>
			</tr>
		</s:iterator>
	</table>
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag" /></td>
		</tr>
</table>
</div>
</s:form>
</div>
</body>
</o:MultiLanguage></html>
