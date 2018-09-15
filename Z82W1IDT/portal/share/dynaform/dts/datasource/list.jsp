<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/portal/share/common/head.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
<script src="<s:url value="/portal/share/script/list.js"/>"></script>
<script type="text/javascript">
function doDelete(){
	var listform = document.forms['formList'];
    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
    	listform.action='<s:url action="delete"/>';
    	listform.submit();
    }
}
</script>
<title>{*[DataSource]*}{*[Info]*}{*[List]*}</title>
</head>
<body class="body-back" onload="inittab()">
<s:form name="formList" theme="simple" action="list" method="post">
<s:textfield name="tab" cssStyle="display:none;" value="3" />
<s:textfield name="selected" cssStyle="display:none;" value="%{'btnDataSource'}" />
<%@include file="/common/list.jsp"%>
<input type="hidden" name="s_module" value="<s:property value='#parameters.s_module'/>">

<table cellpadding="0" cellspacing="0" width="100%">
	<tr style="height:27px;">
		<td rowspan="2"><%@include file="/common/commontab.jsp"%></td>
		<td class="nav-td">&nbsp;
		</td>
	</tr>
	<tr>
		<td class="nav-s-td" align="right">
			<table width="100%" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top">
						<button type="button" class="button-image" onClick="forms[0].action='<s:url action="new"/>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"></s:url>">{*[New]*}</button>
					</td>
					<td valign="top">
						<button type="button" class="button-image" onClick="doDelete()"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%@include file="/portal/share/common/msg.jsp"%>		
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<table border="0">
		<tr>
			<td></td>
			<td class="head-text">{*[Name]*}:</td>
			<td><input class="input-cmd" type="text" name="sm_name" value='<s:property value="#parameters['sm_name']"/>'
				size="30" /></td>
			<td><input class="button-cmd" type="submit" value="{*[Query]*}" /></td>
			<td><input class="button-cmd" type="button" value="{*[Reset]*}" onclick="resetAll();"/></td>
		<tr>
	</table>
 <table width="100%" cellpadding="0" cellspacing="2">
   	<tr class="column-head" scope="col">
   		<td class="column-head2" width="30"><input type="checkbox" onclick="selectAll(this.checked)"></td>
   		<td class="column-head"><o:OrderTag field="name" css="ordertag">{*[Name]*}</o:OrderTag></td>
		<td class="column-head"><o:OrderTag field="driverClass" css="ordertag">{*[DriverClass]*}</o:OrderTag></td>
		<td class="column-head"><o:OrderTag field="url" css="ordertag">{*[URL]*}</o:OrderTag></td>
		<td class="column-head"><o:OrderTag field="username" css="ordertag">{*[User]*}{*[Name]*}</o:OrderTag></td>
		<td class="column-head"><o:OrderTag field="password" css="ordertag">{*[Password]*}</o:OrderTag></td>
	</tr>
	<s:iterator value="datas.datas" status="index">
			<s:if test="#index.odd == true">
				<tr class="table-text">
			</s:if>
			<s:else>
				<tr class="table-text2">
			</s:else>
	   	 	<td class="table-td">
  	 	<input type="checkbox" name="_selects" value='<s:property value="id"/>'/></td>
  	 	<td><a href='<s:url value="edit.action">
  	 					<s:param name="id" value="id"/>
  	 					<s:param name="application" value="#parameters.application" />
  	 					<s:param name="_currpage" value="datas.pageNo" />
						<s:param name="_pagelines" value="datas.linesPerPage" />
						<s:param name="_rowcount" value="datas.rowCount" />
  	 					<s:param name="s_module" value='#parameters.s_module'/>
  	 					<s:param name="tab" value="3" />
						<s:param name="selected" value="%{'btnDataSource'}" />
  	 				 </s:url>'>
  	 			<s:property value="name" />
  	 		</a></td>
 			<td>
 				<s:property value="driverClass" />
 			</td>
 			<td>
 				<s:property value="url" />
 			</td>
 			<td>
 				<s:property value="username" />
 			</td>
 			<td>
 				<s:property value="password" />
 			</td>
 		</tr>
    </s:iterator>
</table>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag"/></td>
  </tr>
</table>
</body>
</s:form>
</o:MultiLanguage></html>