<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css">
<title>{*[StateLabel]*}{*[List]*}</title>
<script language="javascript">

	jQuery(document).ready(function(){
		inittab();
		cssListTable();
		adjustDataIteratorSize();
		window.top.toThisHelpPage("application_info_generalTools_stateLabel_list");
	});

	function adjustDataIteratorSize() {
		var containerHeight = document.body.clientHeight-80;
		var container = document.getElementById("main");
		container.style.height = containerHeight + 'px';
	}
	 function doDelete(){
			var listform = document.forms["formList"];
		    if(isSelectedOne("_selects","{*[please.choose.one]*}")){
			    if(confirm("{*[Confirm]*}{*[Delete]*}{*[Current]*}{*[Choose]*}{*[StateLabel]*}?")){  
			    	listform.action='<s:url action="delete"/>';	
			    	listform.submit();
			    }
		    }
		}

</script>
</head>
<body id="application_info_generalTools_stateLabel_list" class="body-back">
<s:form name="formList" theme="simple" action="list" method="post">
<s:textfield name="tab" cssStyle="display:none;" value="1" />
<s:textfield name="selected" cssStyle="display:none;" value="%{'btnStateLabel'}" />
<%@include file="/common/list.jsp"%>
<input type="hidden" name="s_module" value="<s:property value='#parameters.s_module'/>">

<table cellpadding="0" cellspacing="0" width="100%">
	<tr class="nav-td"  style="height:27px;">
		<td rowspan="2"><div class="appsUsualIncludeTab"><%@include file="/common/commontab.jsp"%></div></td>
		<td class="nav-td" width="100%">&nbsp;</td>
	</tr>
	<tr class="nav-s-td">
		<td align="right" class="nav-s-td">
			<table width="100%" border=0 cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" align="right">
						<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
						<button type="button" class="button-image" onClick="forms[0].action='<s:url action="new"></s:url>';forms[0].submit();"><img src="<s:url value="/resource/imgnew/act/act_2.gif"></s:url>">{*[New]*}</button>
						<button type="button" class="button-image" onClick="doDelete()"><img src="<s:url value="/resource/imgnew/act/act_3.gif"/>">{*[Delete]*}</button>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<div class="navigation_title">{*[StateLabel]*}</div>
<div id="main" style="overflow-y:auto;overflow-x:hidden;"> 
	<div id="searchFormTable">
			<table class="table_noborder">
				<tr><td class="head-text">
					{*[Name]*}:<input class="input-cmd" type="text" name="sm_name" value='<s:property value="#parameters['sm_name']" />' />
					{*[cn.myapps.core.workflow.label.value]*}:<input class="input-cmd" type="text" name="sm_value" value='<s:property value="#parameters['sm_value']" />' />
					<input class="button-cmd" type="submit" value="{*[Query]*}" />
					<input class="button-cmd" type="button" value="{*[Reset]*}" onclick="resetAll()"/>
				<tr><td>
			</table>
	</div>
	<div id="contentTable">
		 <table class="table_noborder">
		   	<tr>
		   		<td class="column-head2" scope="col"><input type="checkbox" onclick="selectAll(this.checked)"></td>
				<td class="column-head"><o:OrderTag field="name" css="ordertag">{*[Name]*}</o:OrderTag></td>
				<td class="column-head"><o:OrderTag field="value" css="ordertag">{*[cn.myapps.core.workflow.label.value]*}</o:OrderTag></td>
				<td class="column-head"><o:OrderTag field="description" css="ordertag">{*[Description]*}</o:OrderTag></td>
				<td class="column-head"><o:OrderTag field="orderNo" css="ordertag">{*[OrderNumber]*}</o:OrderTag></td>
			</tr>
			<s:iterator value="datas.datas" status="index">
				<tr>
			   	 	<td class="table-td">
		  	 			<input type="checkbox" name="_selects" value='<s:property value="id"/>'/></td>
		  	 		<td><a href='<s:url value="edit.action">
		  	 					<s:param name="id" value="id"/>
		  	 					<s:param name="_currpage" value="datas.pageNo" />
								<s:param name="_pagelines" value="datas.linesPerPage" />
								<s:param name="_rowcount" value="datas.rowCount" />
		  	 					<s:param name="s_module" value='#parameters.s_module'/>
		  	 					<s:param name="tab" value='1'/>
		  	 					<s:param name="selected" value="%{'btnStateLabel'}"/>
		  	 					<s:param name="application" value="params.getParameter('s_applicationid')"/>
		  	 					<s:param name="sm_name" value="#parameters.sm_name"/>
		  	 					<s:param name="sm_value" value="#parameters.sm_value"/>
		  	 				 </s:url>'>
		  	 			<s:property value="name" />
		  	 		</a></td>
		  	 		<td>
		 				<s:property value="value" />
		 			</td>
		  	 		<td>
		 				<s:property value="description" />
		 			</td>
		 			<td>
		 				<s:property value="orderNo" />
		 			</td>
		 		</tr>
		    </s:iterator>
		</table>
		<table class="table_noborder">
		  <tr>
		    <td align="right" class="pagenav"><o:PageNavigation dpName="datas" css="linktag"/></td>
		  </tr>
		</table>
	</div>
	</div>
</s:form>
</body>
</o:MultiLanguage></html>