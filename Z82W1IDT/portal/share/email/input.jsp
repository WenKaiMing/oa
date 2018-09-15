<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%><%@ taglib uri="myapps" prefix="o"%>
<% 
String attachmentDir = EmailConfig.getString("attachment.dir", "/" + "email" + "/" + "attachment");
String[] strings = attachmentDir.split("/");  
String string2 = "";  
for (int i = 0; i < strings.length; i++) {  
   if(i==strings.length-1){  
        string2 = string2+strings[i];  
   }  
   else {  
        string2 = string2+strings[i]+"\\\\";  
    }  
         
} 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><o:MultiLanguage>
<%@page import="cn.myapps.core.email.util.EmailConfig"%>
<%@page import="cn.myapps.core.email.util.Constants"%>
<%@page import="cn.myapps.core.email.folder.action.EmailFolderHelper"%>
<%@page import="cn.myapps.core.email.email.action.EmailHelper"%>
<s:bean name="cn.myapps.core.email.folder.action.EmailFolderHelper" id="folderHelper" />
<s:bean name="cn.myapps.core.email.email.action.EmailHelper" id="emailHelper" /><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="jquery-tabs.jsp" %>
<%@ include file="/portal/share/common/head.jsp"%>
<title>{*[core.email.wirte]*}</title>
<script type="text/javascript">
	jQuery(function(){
		if(window.parent.parent.document.getElementById("application")){
			var applicationid=window.parent.parent.document.getElementById("application").value;
			jQuery("#application").val(applicationid);
		}
	});
	
	jQuery(document).ready(function() {
		window.parent.hideLoading();
		var cc = jQuery("#ccText").val();
		if (cc != null && cc != "") {
			jQuery("#cc").css("display", "");
			jQuery("#addCc").empty();
			jQuery("#addCc").append("{*[core.email.delete.cc]*}");
		}
		var cc = jQuery("#bccText").val();
		if (cc != null && cc != "") {
			jQuery("#bcc").css("display", "");
			jQuery("#addBcc").empty();
			jQuery("#addBcc").append("{*[core.email.delete.bcc]*}");
		}
		
		jQuery("#addCc").click(function () {
				var cssValue = jQuery("#cc").css("display");
				if (cssValue == "none") {
					jQuery("#cc").css("display", "");
					jQuery("#addCc").empty();
					jQuery("#addCc").append("{*[core.email.delete.cc]*}");
				} else {
					jQuery("#cc").css("display", "none");
					jQuery("#addCc").empty();
					jQuery("#addCc").append("{*[core.email.add.cc]*}");
					jQuery("#ccText").attr("value", "");
				}
			});
		jQuery("#addBcc").click(function () {
			var cssValue = jQuery("#bcc").css("display");
			if (cssValue == "none") {
				jQuery("#bcc").css("display", "");
				jQuery("#addBcc").empty();
				jQuery("#addBcc").append("{*[core.email.delete.bcc]*}");
			} else {
				jQuery("#bcc").css("display", "none");
				jQuery("#addBcc").empty();
				jQuery("#addBcc").append("{*[core.email.add.bcc]*}");
				jQuery("#bccText").attr("value", "");
			}
		});
		jQuery("input[type='button']").each(function() {
			jQuery(this).click(function(){
				var buttonid = this.id;
				if (buttonid == "sendButton") {
					var folderid = '<s:property value="#folderHelper.getSentEmailFolderId(#session.FRONT_USER)" />';
					jQuery("#folder").attr("value", folderid);
					//submitContent(true);
					window.parent.showLoading();
					jQuery('#mailForm').submit();
				} else if (buttonid == "draftsButton") {
					var folderid = '<s:property value="#folderHelper.getDraftsEmailFolderId(#session.FRONT_USER)" />';
					//var value = jQuery("#folder").val();
					if (folderid == "") {
						alert("{*[core.email.drafts.save.error]*}");
					} else {
						jQuery("#folder").attr("value", folderid);
						submitContent(true);
					}
				} else if (buttonid == "colseButton") {
					//var value = jQuery("#emailId").val();
					//var content1 = document.getElementById("content").value;
					//var content2 = document.getElementById("content").defaultValue;
					//alert(jQuery.trim(content1) == jQuery.trim(content2));
					//if (value == null || value == "") {
						if (jQuery("form").data("changed")) {
							var bool = confirm("{*[core.email.nosave.close]*}？");
							if (bool) {
								window.parent.showLoading();
								window.history.go(-1);
							}
						} else {
							window.parent.showLoading();
							window.history.go(-1);
						}
					//}
				}
			});
		});

		jQuery("form :input").change(function() {
		     jQuery("form").data("changed",true);
		});

		jQuery(".attclass").find("img").each(function() {
			jQuery(this).click(function(){
				var bool = confirm("{*[core.email.attachment.delete.confrm]*}？");
				if (bool) {
					//alert(this.id);
					deleteAttachment(this, "", this.id);
				}
			});
		});
		addAttachment();
	});
	function submitContent(bool) {
		//var value = getEditorHTMLContents("emailContent");
		//jQuery("#econtent").attr("value", value);
		// alert(jQuery('#mailForm').serialize());
		// formSerialize();
		//alert(validateEmail(jQuery("#to").val()));
		window.parent.showLoading();
		jQuery.ajax({
			type: "POST",
			cache: false,
			url: "<s:url value='/portal/email/save.action'/>",
			data: decodeURIComponent(jQuery('#mailForm').serialize()), 
			success:function(result) {
				var strs = result.split("*");
				if (strs[0] == "INFO") {
					if (strs.length == 4) {
						jQuery("#emailId").attr("value", strs[2]);
						jQuery("#body").attr("value", strs[3]);
					}
					//showMsg(strs[1] + "");
					window.parent.hideLoading();
					alert(strs[1]);
				} else if (strs[0] == "ERROR") {
					//showError(strs[1]);
					window.parent.hideLoading();
					alert(strs[1]);
				}
			},
			error: function(result) {
				//showError("发送失败！");
				window.parent.hideLoading();
				alert("{*[core.email.failure]*}");
			}
		});
	}

	function showUploadDialog() {
		// parent.frames["detail"].window.opener
		OBPM.dialog.show({
			//opener : parent.document,
			width : 580,
			height : 360,
			url : '<s:url value='/portal/share/email/upload.jsp' />',
			args : {},
			title : '{*[Upload]*} {*[Attachment]*}',
			close : function(result) {
				if (result != null && result != "clear") {
					var results = result.split(";");
					for (var i = 0; i < results.length; i ++) {
						addAttachment(results[i]);
					}
				}
			}
		});
	}

	function addAttachment(json) {
		if (json == null) {
			return;
		}
		var strs = json.split(",");
		if (strs.length < 1) {
			return;
		}
		var attid = strs[0];
		var attName = strs[1];
		var path = strs[2];
		var content = '<a  href="#" url='+path+'  onclick="viewAttr(this)" name='+attName+'>'+attName+'</a><img id="' + attid + '" src="<s:url value='/portal/share/email/images/close.gif'/>" border="0" title="{*[Delete]*}" />';
		var divElement = document.createElement("div");
		divElement.innerHTML = content;
		jQuery(divElement).find("img").each(function() {
			jQuery(this).click(function(){
				var bool = confirm("{*[core.email.attachment.delete.confrm]*}？");
				if (bool) {
					deleteAttachment(this, "", this.id);
				}
			});
		});
		document.getElementById("attaid").appendChild(divElement);
		var html = "<input id=\"" + attid + "\" type=\"hidden\" name=\"_attids\" value=\"" + attid + "\" />";
		jQuery(".content").append(html);
	}

	function deleteAttachment(object, emailid, attid) {
		window.parent.showLoading();
		jQuery.ajax({
			type: "POST",
			cache: false,
			url: "<s:url value='/portal/email/attachment/delete.action' />",
			data: "id=" + attid + "&emailid" + emailid,
			success: function(result) {
				if (result == "success") {
					jQuery(object).parent().remove();
					jQuery("#" + attid).remove();
					window.parent.hideLoading();
				}
			},
			error: function(result) {
				window.parent.hideLoading();
				alert("{*[core.email.attachment.delete.error]*}！");
			}
		});
	}

	function validateEmail(email){
	    var reg = /^[a-za-z0-9_-]+@[a-za-z0-9_-]+(\.[a-za-z0-9_-]+)+$/;//验证mail的正则表达式,^[a-za-z0-9_-]:开头必须为字母,下划线,数字,
	    if (email != "" && email.match(reg)){
	       return true;
	    }
	    return false;
	}

	function getDatas() {
		var params = "";
		jQuery("input").each(function(){
			//alert(this.value);
			if (this.name != null && this.name != "") {
				if (params.length < 2) {
					params += this.name + "=" + this.value;
				} else {
					params += "&" + this.name + "=" + this.value;
				}
			}
		});
		params += "";
		return params;
	}

	function selectUsers(id,name,email){
		var settings={"valueField":id,"textField":name,"showUserEmail":email};
		showUserSelectNoFlow("",settings,"");
	}

	function showTitle(showInputId,nameInputId){
		var names = document.getElementById(nameInputId).value;
		var emails = document.getElementById(showInputId).value;
		if(emails != null && emails != ''){
			var emailArray = emails.split(";");
			var title = "";
			for(var i=0; i<emailArray.length; i++){
				title += emailArray[i] + "\n";
			}
			document.getElementById(showInputId).title = title;
		}
	}

	function viewAttr(thisvalue){
		var showName= jQuery(thisvalue).attr("name");
		var url =jQuery(thisvalue).attr("url");
		showFileDialog(thisvalue,showName,url,true);
		}
	
	// 弹出层来加载文件为了处理乱码问题
	function showFileDialog(obj, name, webPath,readonly) {
		var a="<%=string2%>";
		webPath = webPath.substring(webPath.indexOf(a));
		var url = "";
		var fileType = name.substring(name.lastIndexOf(".")).toLowerCase();
		if (fileType == ".doc" || fileType == ".docx" || fileType == ".xls"
				|| fileType == ".xlsx") {
			url = contextPath + '/portal/email/attachment/doViewWordFile.action';
			OBPM.dialog.show( {
				opener : window.parent.parent,
				width : 1000,
				height : 550,
				url : url,
				args : {
					"webPath" : contextPath + webPath,
					"readonly" :readonly
				},
				title : name,
				close : function(result) {

				}
			});
		} else {
			url = contextPath + webPath;
			obj.target = "_blank";
			obj.href = url;
		}
	}
</script>
<link rel="stylesheet" href="<s:url value='/portal/share/email/css/email.css'/>" type="text/css">
<script type="text/javascript" src="<s:url value='/portal/share/email/script/email.js'/>"></script>
<style type="text/css">
.attclass div {float: left; padding: 1px 5px;}
.attclass div img {padding-left: 3px; cursor: pointer;}
</style>
</head>
<body style="margin-left: 1%; width: 98%;">
<form action="<s:url value='/portal/email/save.action'/>" id="mailForm" method="post">
<div class="content" style="background: #ffffff;">
	<div class="bar">
		<input type="button" name="" value="&nbsp;{*[Send]*}&nbsp;" id="sendButton" />
		<input type="button" name="" value="&nbsp;{*[Draft]*}&nbsp;" id="draftsButton" />
		<input type="button" name="" value="&nbsp;{*[Close]*}&nbsp;" id="colseButton" />
	</div>
	<input id="folder" type="hidden" name="content.emailFolder.id" value="<s:property value="content.emailFolder.id" />" />
	<input id="body" type="hidden" name="content.emailBody.id" value="<s:property value="content.emailBody.id" />" />
	<input id="emailId" type="hidden" name="content.id" value="<s:property value="content.id" />" />
	<input type="hidden" name="content.reply" value="<s:property value="content.reply" />" />
	<input type="hidden" name="content.forward" value="<s:property value="content.forward" />" />
	<input type="hidden" name="content.emailBody.from" value="<s:property value="#emailHelper.showAccount(#session.FRONT_USER.emailUser)"/>" />
	<input type="hidden" name="content.emailBody.fromdep" value="<s:property value="#session.FRONT_USER.emailUser.defaultDepartment" />" />
	<div class="main">
		<table width="80%" align="left" border="0" bgcolor="#ffffff">
			<tbody>
			<tr>
				<td width="8%" align="right" height="26px">{*[core.email.from]*}&nbsp;</td>
				<td><strong><s:property value="#emailHelper.showAccount(#session.FRONT_USER.emailUser)"/></strong>
					<div style="float: right; padding-right: 1px;">
						<a id="addCc" href="javascript:;" title="什么是抄送：&#10;同时将这一封邮件发送给其他联系人。">{*[core.email.add.cc]*}</a>&nbsp;|&nbsp;
						<a id="addBcc" href="javascript:;" title="什么是密送：&#10;同时将这一封邮件发送给其他联系人，但收件人及抄送人不会看到密送人。">{*[core.email.add.bcc]*}</a>
						<!-- &nbsp;|&nbsp;<a id="addTo" href="javascript:;" title="什么是分送：&#10;会对多个人一对一发送。每个人将收到单独发给他/她的邮件。">分别抄送</a> -->
					</div>
				</td>
			</tr>
			<tr>
				<td width="8%" align="right" valign="top">{*[core.email.to]*}&nbsp;</td>
				<td>
					<s:if test="#parameters.type[0] == 'forward'">
					<input type="text" name="content.emailBody.to" style="width: 85%" value="<s:property value='' />" id="to" onmousemove="showTitle(jQuery('#to').attr('id'),jQuery('#receivername').attr('id'));" />
					</s:if>
					<s:else>
					<input type="text" name="content.emailBody.to" style="width: 85%" value="<s:property value='#emailHelper.showEmailAddress(content.emailBody.to, #session.FRONT_USER)' />" id="to" onmousemove="showTitle(jQuery('#to').attr('id'),jQuery('#receivername').attr('id'));" />
					</s:else>
					<input type="button" value="{*[Choose]*}" onclick="selectUsers(jQuery('#receiverid').attr('id'),jQuery('#receivername').attr('id'),jQuery('#to').attr('id'))" style="height:24px; " title="{*[Choose]*}{*[User]*}"/>
					<input type="hidden" class="input-cmd" id="receiverid" name="receiverid" />
					<input type="hidden" class="input-cmd" id="receivername" name="receivername" />
				</td>
			</tr>
			<tr Style="display:none" id="cc">
				<td width="8%" align="right" valign="top"> {*[core.email.cc]*}&nbsp;</td>
				<td>
					<input id="ccText" type="text" name="content.emailBody.cc" style="width: 90%" value="<s:property value='#emailHelper.showEmailAddress(content.emailBody.cc, #session.FRONT_USER)' />" onmousemove="showTitle(jQuery('#ccText').attr('id'),jQuery('#ccName').attr('id'));" />
					<input type="button" value="{*[Choose]*}" onclick="selectUsers(jQuery('#ccId').attr('id'),jQuery('#ccName').attr('id'),jQuery('#ccText').attr('id'))" style="height:24px; " title="{*[Choose]*}{*[User]*}"/>
					<input type="hidden" class="input-cmd" id="ccId" name="ccId" />
					<input type="hidden" class="input-cmd" id="ccName" name="ccName" />
				</td>
			</tr>
			<tr Style="display:none" id="bcc">
				<td width="8%" align="right" valign="top"> {*[core.email.bcc]*}&nbsp;</td>
				<td>
					<input id="bccText" type="text" name="content.emailBody.bcc" style="width: 90%" value="<s:property value='#emailHelper.showEmailAddress(content.emailBody.bcc, #session.FRONT_USER)' />" onmousemove="showTitle(jQuery('#bccText').attr('id'),jQuery('#bccName').attr('id'));" />
					<input type="button" value="{*[Choose]*}" onclick="selectUsers(jQuery('#bccId').attr('id'),jQuery('#bccName').attr('id'),jQuery('#bccText').attr('id'))" style="height:24px; " title="{*[Choose]*}{*[User]*}"/>
					<input type="hidden" class="input-cmd" id="bccId" name="bccId" />
					<input type="hidden" class="input-cmd" id="bccName" name="bccName" />
				</td>
			</tr>
			<tr>
				<td width="8%" align="right" valign="top"> {*[Subject]*}&nbsp;</td>
				<td>
					<input type="text" name="content.emailBody.subject" style="width: 70%;" value="<s:property value="content.emailBody.subject" />" />
					<select name="content.msgLevel">
						<option value="0">一般邮件</option>
						<option value="1" style="color:#FF9900;">重要邮件</option>
						<option value="2" style="color:#FF0000;">非常重要</option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="8%" align="right">&nbsp;</td>
				<td width="92%">
					<table width="100%" border="0" style="table-layout: fixed;WORD-BREAK: break-all; WORD-WRAP: break-word;">
						<tr>
							<td class="attclass" id="attaid">
								<div><a id="addAttr" href="javascript:showUploadDialog();" title="{*[cn.myapps.core.email.write.prompt_add_attachment]*}">{*[core.email.attachment.add]*}</a></div><s:iterator value="content.emailBody.attachments" status="index">
								<input id="<s:property value='id' />" type="hidden" name="_attids" value="<s:property value='id' />" />
								<div><a  href='#' url='<s:property value="path"/>'  onclick='viewAttr(this)' name='<s:property value="realFileName"/>'><s:property value="realFileName"/></a><img id="<s:property value="id"/>" src="<s:url value='/portal/share/email/images/close.gif'/>" border="0" title="{*[Delete]*}" /></div></s:iterator>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td width="8%" align="right" valign="top"> {*[Content]*}&nbsp;</td>
				<td>
					<!-- <div style="border: 1px solid #99bbe8;"> -->
					<input type="hidden" name="content.emailBody.content" id="content" value="<s:property value="content.emailBody.content" />">
					<iframe src="<s:url value='/portal/share/component/htmlEditor/editor.html?id=content'/>" frameborder="0" scrolling="no" width="100%" height="320px"></iframe>
					<!-- </div>	 -->	
				</td>
			</tr>
		</tbody>
		</table>
		<div style="float: right; width: 20%; display: none;">
			<div style="border: 1px solid #99bbe8; height: 100%"></div>
		</div>
		<s:hidden id="domainid" name="content.domainid" value="%{#parameters.domain}" />
		<s:hidden id="application" name="application" value="" />
	</div>
</div>
</form>
</body>
</html>
</o:MultiLanguage></html>