<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<o:MultiLanguage>
<head>
<title>{*[Summary]*}{*[List]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css">
<script src="<s:url value='/script/list.js'/>"></script>
<script>
function ev_submit() {
	var rtnVals = jQuery("input[name='_selects']:checked");
	if(rtnVals.length == 0){
		alert("{*[select_one_at_least]*}");
		return;
	}
	var rtn = rtnVals[0].value;
	var oTD = document.getElementById(rtnVals[0].value); // 根据ID获取对应的TD元素
	var rtn1 = oTD.innerHTML;
	
	for(var i=1; i<rtnVals.length; i++){
		rtn += "|" + rtnVals[i].value;
		//rtn1 += "|" + rtnVals[i].parentNode.nextSibling.innerHTML;
		oTD = document.getElementById(rtnVals[i].value); // 根据ID获取对应的TD元素
		rtn1 += "|" + oTD.innerHTML;
	}
	rtn += "'" + rtn1;
	OBPM.dialog.doReturn(rtn);
}
	
jQuery(document).ready(function(){
	cssListTable();
});

function doExit(){
  	OBPM.dialog.doReturn();
}

function doSelect(id,title){
	OBPM.dialog.doReturn(id+'\''+title);
}
</script>
</head>
<body style="margin: 0;padding: 0;">
<s:form name="summaryCfgForm" action="list" method="post">
	<s:hidden name="s_homepage" value="%{#parameters.s_homepage}" />
	<s:hidden name="n_scope" value="%{#parameters.n_scope}" />
	<%@include file="/common/list.jsp"%>
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[Summary]*}{*[List]*}</div>
			</td>
			<td align="right">
				<!-- <button type="button" class="button-class" onClick="ev_submit()"><img	src="<s:url value='/resource/imgnew/add.gif'/>" />{*[Add]*}</button> -->
				<button type="button" class="button-class" onClick="doExit()"><img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
			</td></tr>
	</table>

	<%@include file="/common/msg.jsp"%>	
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>	
		<div id="searchFormTable">
	<table border="0">
		<tr>
			<td></td>
			<td class="head-text">{*[Name]*}:</td>
			
			<td><input class="input-cmd" type="text" name="sm_title" value='<s:property value="#parameters['sm_title']"/>'
				size="30" /></td>
			<td><input class="button-cmd" type="submit" value="{*[Query]*}" /></td>
			<td><input class="button-cmd" type="button" value="{*[Reset]*}" onclick="resetAll();"/></td>
		<tr>
	</table>
	</div>
	
	
	<div id="main">
		<div id="contentTable">
			<s:if test="hasFieldErrors()">
				<span class="errorMessage"><br>
				<s:iterator value="fieldErrors">
				</s:iterator> </span>
			</s:if>
			<table class="table_noborder">
				<tr>
					<td class="column-head" scope="col"><o:OrderTag field="title"
						css="ordertag">{*[Summary]*}{*[Name]*}</o:OrderTag></td>
					<td class="column-head" scope="col"><o:OrderTag field="title"
						css="ordertag">{*[Summary]*}{*[Type]*}</o:OrderTag></td>
				</tr>
				<s:iterator value="datas.datas" status="index">
					<tr>
					<td id='<s:property value="id" />'>
					<a href="javascript:doSelect('<s:property value="id"/>','<s:property value="title"/>');"> 
					<s:property value="title" /> </a>
					</td>
					<td id='<s:property value="id" />'>
					<a href="javascript:doSelect('<s:property value="id"/>','<s:property value="title"/>');"> 
					<s:if test="scope==0">代办摘要</s:if>
					<s:elseif test="scope==6">抄送摘要</s:elseif>
					 </a>
					</td>
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
	</div>
</s:form>
</body>
</o:MultiLanguage>
</html>