<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<o:MultiLanguage>
<%
	String templateStyle =(String)request.getParameter("templateStyle");
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>{*[Select.Template]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>" type="text/css">
</head>
<script type="text/javascript">
jQuery(document).ready(function(){	
	var templateStyle="<%=templateStyle%>";
	if(templateStyle != null || templateStyle != "")
		document.getElementById(templateStyle).checked = true;
});

function doReturn(){
	var rtn = jQuery("input[name=templateStyle]:checked").attr("id");
	OBPM.dialog.doReturn(rtn.toString());
}

function doExit(){
  	OBPM.dialog.doReturn();
}

</script>
<body style="overflow-y: auto; overflow-x: hidden;">
<div style="border: 1px solid #d8dadc; float: left; padding: 10px; width: 99%;">
	<div style="width: 100%; margin-bottom: 10px;">
	<table border="0" cellpadding="4" cellspacing="0">
		<tr>
			<td width="120px" style="font-size: 14;"><b/>{*[Select.Template]*}</b></td>
			<td width="60%"></td>
			<td align="right">
   				<button type="button" class="button-class" onClick="doReturn();">
   					<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
			</td>
			<td align="right">
				<button type="button" class="button-class" onClick="doExit()">
					<img src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
			</td>
		</tr>
	</table>
	</div>
	<div id="templateDivSwitch" style="background-color: #d8dadc">{*[Select.Template.For.Homepage.Reminder]*}：
	</div>
	<!-- ww:hidden name="content.userSetup.templateStyle" id="templateStyle" /-->
	<div id="templateDiv" style="padding: 10px;" align="center">
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1|td2|td3|td4|td5|td6" value="template1" checked="checked" />template1
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td rowspan="2" style="border: 1px;">&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1-y2|td2|td3|td5|td6" value="template2" />template2
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td>&nbsp;</td>
					<td rowspan="2" style="border-right: 1px;">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1|td2-y2|td3|td4|td6" value="template3" />template3
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td rowspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1|td2|td3-y2|td4|td5" value="template4" />template4
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td colspan="2">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1-x2|td3|td4|td5|td6" value="template5" />template5
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1|td2|td3|td4-x2|td6" value="template6" />template6
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td>&nbsp;</td>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1|td2-x2|td4|td5|td6" value="template7" />template7
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td colspan="2">&nbsp;</td>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1|td2|td3|td4|td5-x2" value="template8" />template8
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td colspan="2">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1-x2|td3|td4-x2|td6" value="template9" />template9
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td>&nbsp;</td>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td colspan="2">&nbsp;</td>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1|td2-x2|td4|td5-x2" value="template10" />template10
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td rowspan="2">&nbsp;</td>
					<td rowspan="2" style="border-right: 1px;">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1-y2|td2-y2|td3|td6" value="template11" />template11
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td rowspan="2" style="border: 1px;">&nbsp;</td>
					<td>&nbsp;</td>
					<td rowspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1-y2|td2|td3-y2|td5" value="template12" />template12
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td>&nbsp;</td>
					<td rowspan="2">&nbsp;</td>
					<td rowspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1|td2-y2|td3-y2|td4" value="template13" />template13
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td colspan="2">&nbsp;</td>
					<td rowspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1-x2|td3-y2|td4-x2" value="template14" />template14
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td rowspan="2" style="border-right: 1px;">&nbsp;</td>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1-y2|td2-x2|td5-x2" value="template15" />template15
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td rowspan="2">&nbsp;</td>
					<td rowspan="2">&nbsp;</td>
					<td rowspan="2">&nbsp;</td>
				</tr>
				<tr>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1-y2|td2-y2|td3-y2" value="template16" />template16
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td colspan="2">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1-x2|td3|td4-x3" value="template17" />template17
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td>&nbsp;</td>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1|td2-x2|td4-x3" value="template18" />template18
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1-x3|td4-x2|td5" value="template19" />template19
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td colspan="2">&nbsp;</td>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1-x3|td4|td5-x2" value="template20" />template20
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1-x3|td4-x3" value="template21" />template21
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td rowspan="2">&nbsp;</td>
					<td rowspan="2">&nbsp;</td>
				</tr>
				<tr>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1-y2|td2-y2" value="template22" />template22
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td colspan="2" rowspan="2">&nbsp;</td>
					<td rowspan="2">&nbsp;</td>
				</tr>
				<tr>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1-x2-y2|td3-y2" value="template23" />template23
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td rowspan="2">&nbsp;</td>
					<td rowspan="2" colspan="2">&nbsp;</td>
				</tr>
				<tr>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1-y2|td2-x2-y2" value="template24" />template24
		</div>
		<div class="templateDivSub">
			<table align="center" border="1px">
				<tr>
					<td colspan="3" rowspan="3">&nbsp;</td>
				</tr>
				<tr>
				</tr>
			</table>
			<input type="radio" name="templateStyle" id="td1-x3-y2" value="template25" />template25
		</div>	
	</div>
</div>

</body>
</o:MultiLanguage>
</html>