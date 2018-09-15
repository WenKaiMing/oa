<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<script src='<s:url value="/script/datePicker/WdatePicker.js"/>'></script>
<html><o:MultiLanguage>
<head>
<title>{*[cn.myapps.core.domain.displayView.special_day]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">


<SCRIPT>

function submit()
{ 
	//if (checkform()){
		document.forms[0].action="<s:url value="/core/calendar/special/save.action"/>";
		document.forms[0].action = document.forms[0].action + "?refresh=true&_calendarid=" + "<s:property value='_calendarid'/>";
		document.forms[0].submit();
		//window.returnValue = "1";
	//}
}

function status_onchange()
{
	var obj=document.getElementsByName("_strstatus");	
	var intValid = document.getElementsByName("_strstatus").length;  
	var value="";
	for(var i =0;i<intValid;i++){
		       
        if (obj[i].checked== true ){   
        	value = obj[i].value;                 
        }        
    }
  
	if (value=="false"){
		for(var i=1;i<=5;i++){
			var stElem= document.getElementById("st"+i);
			stElem.disabled="disabled";
			var endElem= document.getElementById("end"+i);
			endElem.disabled="disabled";
			   
			var stElem= document.getElementById("worktime"+i);
			stElem.style.display="none";
		}
	}else{
		for(var i=1;i<=5;i++){
			var stElem= document.getElementById("worktime"+i);
			stElem.style.display="";

			var stElem= document.getElementById("st"+i);
			stElem.disabled=false;
			var endElem= document.getElementById("end"+i);
			endElem.disabled=false;
		}
	}
	
}

jQuery(document).ready(function(){
	window.top.toThisHelpPage("domain_workCalendar_info_exceptionDay_info");
//	var arrs = document.getElementsByName("_strstatus");//_strstatus
//	if (arrs != null) {
//		for (var n = 0; n < arrs.length; n++) {
//			if (arrs[n].checked == "checked" && arrs[n].value = "false") {
//				
//			}
//		}
//	}
	status_onchange();
});


</SCRIPT>
</head>

<body onload="status_onchange()">
<table width="100%">
	<tr>
		<td width="10" class="image-label"><img src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3">&nbsp;</td>
		<td width="200" class="text-label">{*[cn.myapps.core.domain.displayView.special_day]*}</td>
		<td>
			<table width="100%" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td >&nbsp;</td>
					<td width="60" valign="top">
						<button type="button" class="button-image"
					onClick="submit();"><img
					src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
					</td>
					</td>
					<td class="line-position2" width="70" valign="top">
						<button type="button" class="button-image"
					onClick="OBPM.dialog.doReturn();"><img
					src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="4" style="border-top: 1px solid dotted; border-color: black;">
		&nbsp;
		</td>
	</tr>
</table>
<%@include file="/common/msg.jsp"%>	
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
	<%@include file="/portal/share/common/msgbox/msg.jsp"%>
</s:if>
<s:form action="save" method="post">
<table border="0" width="100%"  align="center">
	<s:hidden name ="content.languageType"></s:hidden>
	<%@include file="/common/page.jsp"%>
		<tr>
			<th colspan=4>{*[cn.myapps.core.domain.calendar.special.new.info]*}</th>
		</tr>
		<tr>
			<td class="commFont" align="left">{*[cn.myapps.core.domain.calendar.standard.edit.running]*}:</td>
			<td align="left"><s:radio
				id="status" onclick="javascript:status_onchange()" name="_strstatus"
				list="#{'false':'{*[Day-off]*}','true':'{*[Working-day]*}'}"
				theme="simple" /></td>
			<td colspan=2></td>
		</tr>
		<tr id="worktime1">
			<td class="commFont">{*[cn.myapps.core.domain.calendar.standard.edit.start_time]*}1:</td>
			<td align="left"><s:textfield id="st1" cssClass="Wdate"
				name="content.startTime1" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})" size="15"
				theme="simple" /></td>
			<td class="commFont">{*[cn.myapps.core.domain.calendar.standard.edit.end_time]*}1:</td>
			<td align="left"><s:textfield id="end1" cssClass="Wdate"
				name="content.endTime1" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})" size="15"
				theme="simple" /></td>
		</tr>
		<tr id="worktime2">
			<td class="commFont">{*[cn.myapps.core.domain.calendar.standard.edit.start_time]*}2:</td>
			<td align="left"><s:textfield id="st2" cssClass="Wdate"
				name="content.startTime2" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})" size="15"
				theme="simple" /></td>
			<td class="commFont">{*[cn.myapps.core.domain.calendar.standard.edit.end_time]*}2:</td>
			<td align="left"><s:textfield id="end2" cssClass="Wdate"
				name="content.endTime2" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})" size="15"
				theme="simple" /></td>
		</tr>
		<tr id="worktime3">
			<td class="commFont">{*[cn.myapps.core.domain.calendar.standard.edit.start_time]*}3:</td>
			<td align="left"><s:textfield id="st3" cssClass="Wdate"
				name="content.startTime3" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})" size="15"
				theme="simple" /></td>
			<td class="commFont">{*[cn.myapps.core.domain.calendar.standard.edit.end_time]*}3:</td>
			<td align="left"><s:textfield id="end3" cssClass="Wdate"
				name="content.endTime3" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})" size="15"
				theme="simple" /></td>
		</tr>
		<tr id="worktime4">
			<td class="commFont">{*[cn.myapps.core.domain.calendar.standard.edit.start_time]*}4:</td>
			<td align="left"><s:textfield id="st4" cssClass="Wdate"
				name="content.startTime4" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})" size="15"
				theme="simple" /></td>
			<td class="commFont">{*[cn.myapps.core.domain.calendar.standard.edit.end_time]*}4:</td>
			<td align="left"><s:textfield id="end4" cssClass="Wdate"
				name="content.endTime4" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})" size="15"
				theme="simple" /></td>
		</tr>
		<tr id="worktime5">
			<td class="commFont">{*[cn.myapps.core.domain.calendar.standard.edit.start_time]*}5:</td>
			<td align="left"><s:textfield id="st5" cssClass="Wdate"
				name="content.startTime5" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})" size="15"
				theme="simple" /></td>
			<td class="commFont">{*[cn.myapps.core.domain.calendar.standard.edit.end_time]*}5:</td>
			<td align="left"><s:textfield id="end5" cssClass="Wdate"
				name="content.endTime5" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})" size="15"
				theme="simple" /></td>
		</tr>
		<tr>
			<td class="commFont" colspan=4>{*[cn.myapps.core.domain.calendar.special.new.Time_Range]*}:</td>
		</tr>
		<tr>
			<td class="commFont"><s:date id="startDate" name="content.startDate"
				format="yyyy-MM-dd" /> {*[cn.myapps.core.domain.special.list.start_date]*}:</td>
			<td align="left">
				<s:textfield cssClass="Wdate" size='15'
					name="content.startDate" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"
					value="%{startDate}" theme="simple" /> 
				<s:textfield
					cssClass="Wdate" name="_stime" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})"
					size="10" theme="simple" />
			</td>
			<td class="commFont"><s:date id="endDate" name="content.endDate"
				format="yyyy-MM-dd" /> {*[cn.myapps.core.domain.special.list.end_date]*}:</td>
			<td align="left"><s:textfield cssClass="Wdate" size='15'
				name="content.endDate" value="%{endDate}" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"
				theme="simple" /> <s:textfield cssClass="Wdate" name="_etime"
				onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})" size="10" theme="simple" />
			</td>
		</tr>
		<tr>
			<td class="commFont">{*[Description]*}:</td>
			<td class="commFont" align="left" colspan=3></td>
		</tr>
		<tr>
			<td></td>
			<td colspan="3"><s:textarea id="remark" cssClass="input-cmd"
				theme="simple" cols="50" rows="4" name="content.remark" /></td>
		</tr>
</table>
</s:form>
</body>
<script src='<s:url value="/script/datePicker/WdatePicker.js" />'></script>
</o:MultiLanguage></html>
