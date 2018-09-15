<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ page import="cn.myapps.core.personalmessage.action.PersonalMessageHelper"%>
<%@ page import="cn.myapps.base.action.ParamsTable"%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[Message]*}</title>
<%
PersonalMessageHelper pmh = new PersonalMessageHelper();
request.setAttribute("pmh", pmh);
ParamsTable params = ParamsTable.convertHTTP(request);
%>
<link rel="stylesheet"	href="../share/personalmessage/css/base.css" type="text/css" />	
<%@include file="commonContent.jsp" %>
<script>
	(function(){
		jQuery.ajax({
			type: "POST",
			cache: false,
			url: "<s:url value='/portal/personalmessage/show.action' />",
			data: "id=<%=params.getParameterAsString("id")%>&read=true&messageType=3",
			success: function(result) {
				jQuery(".sender").text(result.senderName);
				jQuery(".content").html(result.body.content);
				var voteOptionsType = result.radioOrCheckbox;
				
				var voteInputType = "radio";
				if(voteOptionsType == '0') {
					voteInputType = "radio"	;		
				} else {
					voteInputType = "checkbox";
				}
				var voteOptions = [];
				if(result.voteOptions != null && result.voteOptions.indexOf(";") != -1) {
					voteOptions = result.voteOptions.split(";");
				} else {
					voteOptions.push(result.voteOptions);
				}
				var voteOptionsId = [];
				if(result.voteOptionsId != null && result.voteOptionsId.indexOf(";") != -1) {
					voteOptionsId = result.voteOptionsId.split(";");
				} else {
					voteOptionsId.push(result.voteOptionsId);
				}
				var voteHtml = "<ul class='vote_list'>";
				for(var item = 0; item < voteOptions.length; item++) {
					voteHtml += "<li><input type='" + voteInputType + "' name='vote_item' id='" + voteOptionsId[item] + "'><label for='" + voteOptionsId[item] + "'>" + voteOptions[item] + "</label></li>";
				}		
				voteHtml += "</ul>";
				jQuery(".options").html(voteHtml);
			},
			error: function(result) {
				alert("{*[core.email.attachment.delete.error]*}！");
			}
		});
	})();
	
	function doVote() {
		$.ajax({
	        cache: true,
	        type: "POST",
	        url:contextPath+"/portal/personalmessage/vote.action",
	        data:$('#subNewMsg').serialize(),// 你的formid
	        async: false,
	        error: function(request) {
	            alert("Connection error");
	        },
	        success: function(data) {
	        	OBPM.dialog.doExit();
	        }
	    });
	}
</script>
</head>

<body style="padding: 20px;background-color:rgb(242,242,242)">
	<s:form id="subNewMsg" action="vote" method="post" theme="simple">
	<div>
		<div><span class="sender" style="font-size:13px;color:#0066cc"></span><span class="noread" style="font-size:13px">&nbsp;邀请你投票：&nbsp;</span></div>
		<div class="line-style"></div>
		<div class="content" style="font-size:14px;font-weight:bold"></div>
		<div class="line-style"></div>
		<div class="options options-box"></div>
		<div class="line-style"></div>
		<div class="center_operation">
			<a class="confirm-button operation" href="###"  onclick="doVote();">投票</a>&nbsp;&nbsp;&nbsp;
			<a class="operation" href="###" operation="cancel">{*[Cancel]*}</a>
		</div>
		<s:hidden id="domainid" name="content.domainid"	value="" />
				<s:hidden id="application" name="application" value="11de-f053-df18d577-aeb6-19a7865cfdb6" />
	</div>
	</s:form>
</body>
</o:MultiLanguage></html>