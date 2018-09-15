<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%
	WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String domainid = webUser.getDomainid();
%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<head>
	<title>{*[ShortMessage]*}</title>
	<script src='<s:url value="/dwr/interface/UserUtil.js"/>'></script>
	<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css" />
	<link rel="stylesheet"	href="<s:url value='/portal/share/script/jquery-ui/jquery-ui.css'/>" type="text/css" />
	<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
	<script src='<s:url value="/portal/share/script/jquery-ui/jquery-ui.js"/>'></script>
	</head>
	<script type="text/javascript">
	var checkedList = new Array();
	var imageSrc = '__tag_14$18_';
	var text = '{*[page.loading]*}...';
	var URL = '__tag_16$13_';

	function checkSpace(obj) {
		var regex = /[^\w\u4e00-\u9fa5]/g;
		obj.value = obj.value.replace(regex, '');
	}

	function adjustDataIteratorSize() {
		var container = jQuery("#container");
		var activityTable = jQuery("#activityTable");
		var dataTable = jQuery("#dataTable");
		var containerHeight = document.body.clientHeight;
		container.height(containerHeight + 'px');
		var dataTableHeight = containerHeight;
		if (activityTable) {
			dataTableHeight = dataTableHeight - activityTable.height();
		}
		dataTable.height(dataTableHeight + 'px');
		dataTable.width(document.body.clientWidth - 3 + 'px');
	}

	jQuery(window).load(function(){ 
		adjustDataIteratorSize();
	}).resize(function(){ 
		adjustDataIteratorSize();
	});

	function selectUsers(id, name, receiver) {
		var settings = {
			"valueField" : id,
			"textField" : name,
			"showUserTelephone":receiver
		};
		showUserSelectNoFlow("", settings,"");
	}
	
	$(function(){
		$(".dialog-operation").bind("click", function(){
			if($(this).attr("operation") == 'submit') {
				$.ajax({
			        cache: true,
			        type: "POST",
			        url:contextPath+"/portal/shortmessage/submission/save.action",
			        data:$('#newMsgForm').serialize(),// 你的formid
			        async: false,
			        error: function(request) {
			            alert("Connection error");
			        },
			        success: function(data) {
			        	OBPM.dialog.doExit();
			        }
			    });
			} else if($(this).attr("operation") == 'cancel') {
				OBPM.dialog.doExit();
			}
		}).button();
	});
	
</script>
	<link rel="stylesheet"	href="<%=request.getContextPath()%>/portal/share/personalmessage/css/base.css" type="text/css" />
<body style="overflow:hidden;margin:0px;background-color:rgb(242,242,242)" class="body-front">
<div id="container">
	<s:form id='newMsgForm' action="save" method="post" theme="simple">
		<input type="hidden" id="receiverNames" name="receiverNames" value="" />
		<input type="hidden" id="user" name="receiverUserID" value="" />
		<input type="hidden" id="domian" name="domain" value="<%=domainid%>"/>
		<table width="90%" align="center" border="0">
			<tr>
				<td class="tdClass " >{*[Receiver]*}:
				<input type="text"  id="receiver"  name="content.receiver" value="<s:property value="content.receiver" />"  
					style="width: 78%;" title="{*[core.shortmessage.sender.split.comma]*}" readonly="readonly"/>
				<input type="button" value="&nbsp;{*[Choose]*}&nbsp;" class="select-button" onclick="selectUsers(jQuery('#user').attr('id'), jQuery('#receiverNames').attr('id'), jQuery('#receiver').attr('id'));" 
					style="height: 24px;" width="25%" title="{*[Choose]*}{*[User]*}" /></td>
			</tr>
		
			<tr id="tr_content">
				<td class="trClass">
					<s:textarea id="content" cssClass="input-cmd" wrap="true" 
						theme="simple" cols="8" rows="10" name="content.content" cssStyle="width: 95%" />
				</td>
			</tr>
			<tr id="tr_operations">
				<td class="commFont trClass" style="padding-left:40%">	
					<a class="confirm-button dialog-operation" href="###" operation="submit">{*[Send]*}</a>&nbsp;&nbsp;&nbsp;
					<a class="dialog-operation" href="###" operation="cancel">{*[Cancel]*}</a>
				</td>
			</tr>
		</table>
		
	</s:form>
	
</div>
</body>
</o:MultiLanguage>
</html>
