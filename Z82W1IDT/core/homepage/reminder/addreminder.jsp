<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<o:MultiLanguage>
<head>
<title>{*[Reminder]*}{*[List]*}</title>
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
	var rtn1 = rtnVals[0].parentNode.nextSibling.innerHTML;
	for(var i=1; i<rtnVals.length; i++){
		rtn += "|" + rtnVals[i].value;
		rtn1 += "|" + rtnVals[i].parentNode.nextSibling.innerHTML;
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
</script>
</head>
<body style="margin: 0;padding: 0;">
<s:form name="action" action="addreminder" method="post">
	<s:hidden name="s_homepage" value="%{#parameters.s_homepage}" />
	<%@include file="/common/page.jsp"%>
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[Reminder]*}{*[List]*}</div>
			</td>
			<td align="right">
				<button type="button" class="button-class" onClick="ev_submit()"><img	src="<s:url value='/resource/imgnew/add.gif'/>" />{*[Add]*}</button>
				<button type="button" class="button-class" onClick="doExit()"><img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
			</td></tr>
	</table>
	<div id="main">
		<div id="contentTable">
			<s:if test="hasFieldErrors()">
				<span class="errorMessage"><br>
				<s:iterator value="fieldErrors">
				</s:iterator> </span>
			</s:if>
			<table class="table_noborder">
				<tr>
					<td class="column-head2" scope="col"><input type="checkbox"
						onclick="selectAll(this.checked)"></td>
					<td class="column-head" scope="col"><o:OrderTag field="title"
						css="ordertag">{*[Reminder]*}{*[Name]*}</o:OrderTag></td>
				</tr>
				<s:iterator value="datas.datas" status="index">
					<tr>
					<td class="table-td"><input type="checkbox" name="_selects"
						value="<s:property value="id" />"></td>
					<td><s:property value="title" /></td>
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