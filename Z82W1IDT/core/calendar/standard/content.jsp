<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css' />"
	type="text/css">
<title>{*[Working-weeks]*}</title>
<script src='<s:url value="/script/datePicker/WdatePicker.js"/>'></script>
<SCRIPT>
function submit()
{ 
	if (checkform()==true){
		document.forms[0].action="<s:url value="save.action"><s:param name="_calendarid" value="_calendarid" /></s:url>";
		//alert(document.forms[0].action);
		document.forms[0].action = document.forms[0].action + "&refresh=true";
		document.forms[0].submit();
	}
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
		
		for(var i=1;i<6;i++){
		   var stElem= document.getElementById("st"+i);
		   stElem.disabled=true;
		   var endElem= document.getElementById("end"+i);
		   endElem.disabled=true;	   
		}
	}else{
		
		for(var i=1;i<6;i++){
		   var stElem= document.getElementById("st"+i);
		   stElem.disabled=false;
		   	   
		   var endElem= document.getElementById("end"+i);
		   endElem.disabled=false;
		   
		}
	}
}

function checkform(){
	var flag=true;
	for(var i=1;i<6;i++){
		   var stElem= document.getElementById("st"+i);
		   var stValue=stElem.value;
		   	   
		   var endElem= document.getElementById("end"+i);
		   var edValue=endElem.value;
		   if(stValue.length > 0){
		   		var patarn=/<<((([0-1]([0-9])):([0-5][0-9]))|([2]([0-3]):([0-5][0-9])))>>/;
		   		//alert(patarn+"  "+stValue);
		   		//alert(patarn.test("<<"+stValue+">>"));
		   		if (!patarn.test("<<"+stValue+">>")){
		   			alert("{*[cn.myapps.core.domain.calendar.standard.edit.patternerror]*}");
		   			stElem.focus();
					flag=false;
					break;
           		}
           }else if(edValue.length > 0){
           		alert("{*[cn.myapps.core.domain.calendar.standard.edit.notempty]*}");
		   		stElem.focus();
				flag=false;
				break;
           }
		   
		   if(edValue.length > 0){
		   		var patarn=/<<((([0-1]([0-9])):([0-5][0-9]))|([2]([0-3]):([0-5][0-9]))|24:00)>>/;
		   		if (!patarn.test("<<"+edValue+">>")){
		   			alert("{*[cn.myapps.core.domain.calendar.standard.edit.endtime.patternerror]*}");
		   			endElem.focus();
					flag=false;
					break;
           		}
           }else if(stValue.length > 0){
           		alert("{*[cn.myapps.core.domain.calendar.standard.edit.endtime.notempty]*}");
		   		endElem.focus();
				flag=false;
				break;
           }
		   if (stValue>edValue){
		   		alert("{*[cn.myapps.core.domain.calendar.standard.edit.overoftime]*}");
		   		endElem.focus();
				flag=false;
				break;
		   }
	  }
	  return flag;
}

jQuery(document).ready(function(){
	window.top.toThisHelpPage("domain_workCalendar_info_workWeek_info");
});

</SCRIPT>
</head>

<body onload="status_onchange()" style="overflow: hidden;">

<table width="100%">
	<tr>
		<td width="10" class="image-label"><img src="<s:url value="/resource/image/email2.jpg"/>" /></td>
		<td width="3">&nbsp;</td>
		<td width="200" class="text-label">{*[cn.myapps.core.domain.standard.list.working_weeks_info]*}</td>
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
<table border=1 width=100% bordercolor="#000000">
	<s:form action="save" method="post">
	<s:hidden name ="content.languageType"></s:hidden>
	<%@include file="/common/page.jsp"%>
		<tr width=100%>
			<th colspan=4>{*[cn.myapps.core.domain.calendar.standard.edit.standard.info]*}:</th>
		</tr>
		<tr width=100%>
			<td class="commFont" align="left">{*[Week]*}:</td>
			<td><s:textfield
				cssClass="input-cmd" name="_strweekDays" readonly="true" size="15"
				theme="simple" /></td>
			<td class="commFont" align="left">{*[cn.myapps.core.domain.calendar.standard.edit.running]*}:</td>
			<td align="left"><s:radio id="status"
				onclick="javascript:status_onchange()" name="_strstatus"
				list="#{'false':'{*[Day-off]*}','true':'{*[Working-day]*}'}"
				theme="simple" /></td>
		</tr>
		<tr>
			<td>{*[cn.myapps.core.domain.calendar.standard.edit.start_time]*}1:</td>
			
			<td align="left">
			<s:textfield id="st1" cssClass="Wdate"
				name="content.startTime1" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'HH:mm'})" size="15"
				theme="simple" 
			/>
			</td>
			<td>{*[cn.myapps.core.domain.calendar.standard.edit.end_time]*}1:</td>
			<td align="left">
			<s:textfield id="end1" cssClass="Wdate"
				name="content.endTime1" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'HH:mm'})" size="15"
				theme="simple" />
			</td>
		</tr>
		<tr>
			<td>{*[cn.myapps.core.domain.calendar.standard.edit.start_time]*}2:</td>
			<td align="left"><s:textfield id="st2" cssClass="Wdate"
				name="content.startTime2" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'HH:mm'})" size="15"
				theme="simple" /></td>
			<td>{*[cn.myapps.core.domain.calendar.standard.edit.end_time]*}2:</td>
			<td align="left"><s:textfield id="end2" cssClass="Wdate"
				name="content.endTime2" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'HH:mm'})" size="15"
				theme="simple" /></td>
		</tr>
		<tr>
			<td>{*[cn.myapps.core.domain.calendar.standard.edit.start_time]*}3:</td>
			<td align="left"><s:textfield id="st3" cssClass="Wdate"
				name="content.startTime3" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'HH:mm'})" size="15"
				theme="simple" /></td>
			<td>{*[cn.myapps.core.domain.calendar.standard.edit.end_time]*}3:</td>
			<td align="left"><s:textfield id="end3" cssClass="Wdate"
				name="content.endTime3" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'HH:mm'})" size="15"
				theme="simple" /></td>
		</tr>
		<tr>
			<td>{*[cn.myapps.core.domain.calendar.standard.edit.start_time]*}4:</td>
			<td align="left"><s:textfield id="st4" cssClass="Wdate"
				name="content.startTime4" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'HH:mm'})" size="15"
				theme="simple" /></td>
			<td>{*[cn.myapps.core.domain.calendar.standard.edit.end_time]*}4:</td>
			<td align="left"><s:textfield id="end4" cssClass="Wdate"
				name="content.endTime4" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'HH:mm'})" size="15"
				theme="simple" /></td>
		</tr>
		<tr>
			<td>{*[cn.myapps.core.domain.calendar.standard.edit.start_time]*}5:</td>
			<td align="left"><s:textfield id="st5" cssClass="Wdate"
				name="content.startTime5" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'HH:mm'})" size="15"
				theme="simple" /></td>
			<td>{*[cn.myapps.core.domain.calendar.standard.edit.end_time]*}5:</td>
			<td align="left"><s:textfield id="end5" cssClass="Wdate"
				name="content.endTime5" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'HH:mm'})" size="15"
				theme="simple" /></td>
		</tr>
		<tr>
			<td>{*[Description]*}:</td>
			<td align="left" colspan=3></td>
		</tr>
		<tr>
			<td></td>
			<td colspan="3"><s:textarea id="remark" cssClass="input-cmd"
				theme="simple" cols="50" rows="4" name="content.remark" /></td>
		</tr>
	</s:form>
</table>
</body>
</o:MultiLanguage></html>