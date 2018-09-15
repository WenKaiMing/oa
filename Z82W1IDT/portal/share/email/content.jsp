<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%><%@ taglib uri="myapps" prefix="o"%>
<% 
Email email = (Email) request.getAttribute("email");
EmailHelper helper = new EmailHelper(); 
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
<%@page import="cn.myapps.core.email.util.EmailConfig"%>
<%@page import="cn.myapps.core.email.email.ejb.Email"%>
<%@page import="cn.myapps.core.email.email.action.EmailHelper"%><html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[core.email.info]*}</title>
<%@ include file="/portal/share/common/head.jsp"%>
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css">
<link rel="stylesheet" href="<s:url value='/portal/share/email/css/email.css'/>" type="text/css">
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
<script type="text/javascript">
	jQuery(document).ready(function(){
		window.parent.hideLoading();
		function reinitIframe(){
			var iframe = document.getElementById("frame_content");
			try{
				iframe.height =  iframe.contentWindow.document.documentElement.scrollHeight;
			}catch (ex){}
		}
		$("#attLink").click(function(){
			var height = window.document.body.scrollHeight;
			window.scroll(0, height); 
		});
		$("div input").each(function() {
			$(this).click(function(){
				var buttonid = this.id;
				var locUrl = null;
				if (buttonid == "backButton") {
					//window.location.href = "<s:url value='/portal/email/list.action'/>?" + $("#oFormMessage").serialize();
					//return;
					locUrl = "<s:url value='/portal/email/list.action'/>?" + decodeURIComponent(jQuery("form").serialize());
				} else if (buttonid == "replyButton") {
					locUrl = "<s:url value='/portal/email/new.action'/>?id=<s:property value='content.id' />&folderid=" + $("#folderid").val() + "&type=reply";
				} else if (buttonid == "forwardButton") {
					locUrl = "<s:url value='/portal/email/new.action'/>?id=<s:property value='content.id' />&folderid=" + $("#folderid").val() + "&type=forward";
				}
				if (locUrl != null) {
					window.parent.showLoading();
					window.location.href = locUrl;
				}
			});
		});

		////////////////////////
		var clientH = $(window).height();	//浏览器高度
		var contentHeight = $("#content").height();
		if (contentHeight < 160) {
			$("#content").css("height", 160);
		}

		///////////////////////////
		//var lis = parent.document.getElementsByTagName("li");//左侧菜单
		//for (i = 0; i < lis.length; i++) {
		//	lis[i].style.background = '';
		//}
	});

	function download(fileName) {
		document.location.href = "<s:url value="/portal/email/attachment/download.action" />" + "?emailid=" + jQuery("#emailid").val() + "&folderid=" + jQuery("#folderid").val() + "&filename=" + fileName;
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
<style type="text/css">
#tabDiv tr {
	height: 26px;
}
#attWin {
	/*border: 2px solid #99bbe8;*/
	width: 100%;
	margin-bottom: 6px;
	background: #ffffff;
}
#attWin #attTitle {
	background: #EEF0F2;
	font-weight: bold;
	font-size: 14px;
	padding: 8px 10px;
	overflow: hidden;
}
#attWin #attContent {
	border: 2px solid #EEF0F2;
	background: #ffffff;
	padding: 8px 16px;
}
#content {
	line-height: 22px;
}
</style>
</head>
<body style="/*border: 1px solid #99bbe8;*/; margin-left: 1%; width: 97.9%;">
<div class="content" style="background: #FFFFFF;"><s:bean name="cn.myapps.core.email.email.action.EmailHelper" id="emailHelper" />
	<form id="oFormMessage" action="">
		<div class="bar" style="margin-bottom: 4px;">
			<input type="button" name="" value="&nbsp;{*[Back]*}&nbsp;" id="backButton" class="Btn BtnNml" />
			<input type="button" name="" value="&nbsp;{*[Reply]*}&nbsp;" id="replyButton" />
			<input type="button" name="" value="&nbsp;{*[Forward]*}&nbsp;" id="forwardButton" />
		</div>
		<div style="padding-top: 10px; padding-left: 10px; border-bottom: 1px solid #BDC5CC; background: #EEF0F2;" id="tabDiv">
			<table style="width: 100%;">
				<tr>
					<td colspan="2" align="left">
						<b style="font-weight: bold; font-size: 14px;"><s:property value="content.emailBody.subject" /></b>
					</td>
				</tr>
				<tr>
					<td align="right" width="6%">{*[core.email.from]*}&nbsp;:</td>
					<td><s:property value="#emailHelper.showEmailAddress(content.emailBody.from, #session.FRONT_USER)" /></td>
				</tr>
				<tr>
					<td align="right">{*[Time]*}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</td>
					<td><s:date name="content.emailBody.sendDate" format="yyyy-MM-dd HH:mm:ss" /></td>
				</tr>
				<tr>
					<td align="right">{*[core.email.to]*}&nbsp;:</td>
					<td><s:property value="#emailHelper.showEmailAddress(content.emailBody.to, #session.FRONT_USER)" /></td>
				</tr>
				<s:if test="content.emailBody.isSentCc()"><tr>
					<td align="right">{*[core.email.cc]*}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</td>
					<td><s:property value="#emailHelper.showEmailAddress(content.emailBody.cc, #session.FRONT_USER)" /></td>
				</tr></s:if>
				<s:if test="content.emailBody.multipart"><%out.println(helper.getEmailFirstAttachmentHtml(email)); %></s:if>
			</table>
		</div>
		<div id="content" style="padding: 10px 15px; background: #ffffff;">
			<%if (email != null && email.getEmailBody() != null) {
				String content = email.getEmailBody().getContent();
				out.print(content == null ? "" : content);
			}%>
		</div>
		<div id="attWin"><s:if test="content.emailBody.multipart">
			<div id="attTitle">{*[Attachment]*}(<s:property value="content.emailBody.attachments.size()" />&nbsp;{*[core.email.one]*})</div>
			<div id="attContent">
				<table width="100%">
					<tr>
						<td><span><font style="font-weight: bold; font-size: 12px;">{*[core.email.attachment.p]*}</font><br /><!-- (已通过xxxx杀毒引擎扫描) --></span></td>
					</tr>
					<tr>
						<td><s:iterator value="content.emailBody.attachments" status="index">
								<table border="0">
								<tr>
									<td rowspan="2"><img src='<s:url value="/portal/share/email/images/attachment.png" />' border="0" /></td>
									<td><s:property value="realFileName" />&nbsp;(<s:property value="getSizeString()" />)</td>
								</tr>
								<tr>
									<td><a href="javascript:download('<s:property value="#emailHelper.encoder(realFileName)"/>');">{*[core.email.attachment.download]*}</a></td>
									<td><a  href='#' url='<s:property value="path"/>'  onclick='viewAttr(this)' name='<s:property value="realFileName"/>'>{*[Preview]*}</a></td>
								</tr>
							</table>
						</s:iterator></td>
					</tr>
				</table>
			</div>
		</s:if></div>
		<%@include file="/common/basic.jsp" %>
		<input type="hidden" name="folderid" value="<s:property value="content.emailFolder.id" />" id="folderid" />
		<input type="hidden" name="type" value="0" id="type" />
		<input type="hidden" name="emailid" value="<s:property value="content.id" />" id="emailid" />
	</form>
	<s:bean name="cn.myapps.util.Security" id="security"></s:bean>
</div>
</body>
</o:MultiLanguage></html>