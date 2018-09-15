<%@ include file="/portal/share/common/head.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<o:MultiLanguage>
<head>
<title>{*[Summary]*}{*[List]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css">
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css" />
<script src="<s:url value='/portal/share/script/list.js'/>"></script>
<script>
function ev_submit() {
	var rtnVals = jQuery("input[name='_selects']:checked");
	if(rtnVals.length == 0){
		alert("{*[select_one_at_least]*}");
		return;
	}
	var rtn = "";
	var rtn1 = "";
	for(var i=0; i<rtnVals.length; i++){
		if(i!=0){
			rtn += "|";
			rtn1 += "|";
		}
		rtn += rtnVals[i].value;
		rtn1 += rtnVals[i].title;
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
<body style="margin: 0;padding: 0;overflow:auto;">
<s:form name="action" action="addSummaryList" method="post">
	<s:hidden name="s_homepage" value="%{#parameters.s_homepage}" />
	<%@include file="/common/list.jsp"%>
	<div style="margin-top:2px;">
	<table class="act_table" style="width:100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td style="width: 95%;">
				<div class="titleleftdiv">{*[Summary]*}{*[List]*}</div>
				<div class="exitbtn">				
					<div class="button-cmd" style="background:none;">
						<div class="btn_left"></div>
						<div class="btn_mid">
							<a class="addicon" href="###" onClick="ev_submit();">
							{*[Add]*}
							</a>
						</div>
						<div class="btn_right"></div>
					</div>				
					<div class="button-cmd" style="background:none;">
						<div class="btn_left"></div>
						<div class="btn_mid">
							<a class="exiticon" href="###" onClick="doExit()">
							{*[Exit]*}
							</a>
						</div>
						<div class="btn_right"></div>
					</div>	
				</div>			
			</td>
		</tr>
	</table>
	</div>	
	
	<%@include file="/portal/share/common/msg.jsp"%>		
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
					<td class="column-head2" scope="col"><input type="checkbox"
						onclick="selectAll(this.checked)"></td>
					<td class="column-head" scope="col"><o:OrderTag field="title"
						css="ordertag">{*[Summary]*}{*[Name]*}</o:OrderTag></td>
				</tr>
				<s:iterator value="datas.datas" status="index">
					<tr>
					<td class="table-td"><input type="checkbox" name="_selects"
						value="<s:property value="id" />" title="<s:property value='title' />"></td>
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