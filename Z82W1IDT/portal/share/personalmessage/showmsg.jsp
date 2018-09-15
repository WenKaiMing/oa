<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@page import="cn.myapps.core.personalmessage.action.PersonalMessageHelper"%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[PersonalMessage]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css" />

</head>
<%
PersonalMessageHelper pmh = new PersonalMessageHelper();
request.setAttribute("pmh", pmh);
String retTag = (String) request.getAttribute("retTag");

%>
<script type="text/javascript" src='<s:url value="/dwr/engine.js"/>'></script>
<script type="text/javascript" src='<s:url value="/dwr/util.js"/>'></script>
<script type="text/javascript" src='<s:url value="/dwr/interface/PersonalMessageHelper.js"/>'></script>
<script type="text/javascript">
var checkedList = new Array(); 
var imageSrc = '<s:url value="/resource/images/loading.gif" />';
var text = '{*[page.loading...]*}';
var URL = '<o:Url value="/core/resource/resourcechoice.jsp" />';
function checkSpace(obj) {
	var regex = /[^\w\u4e00-\u9fa5]/g;
	obj.value = obj.value.replace(regex, '');
}
function showReply() {
	var display = jQuery("#reply").css("display");	
	if (display == "none") {
		jQuery("#reply").css("display","");
		if(jQuery.browser.msie)
		{
			OBPM.dialog.resize(document.body.scrollWidth+30, document.body.scrollHeight+100);
		}
		else if(jQuery.browser.mozilla)
		{
			OBPM.dialog.resize(document.documentElement.scrollWidth+30, document.documentElement.scrollHeight+100);
		}
	}else  {
		jQuery("#reply").css("display","none");
		if(jQuery.browser.msie)
		{
			OBPM.dialog.resize(document.body.scrollWidth, document.body.scrollHeight+60);
		}
		else if(jQuery.browser.mozilla)
		{
			OBPM.dialog.resize(document.documentElement.scrollWidth, document.documentElement.scrollHeight+60);
		}
	}
}
function ev_init() {
	var type = '<s:property value="%{type}"/>';
	if(type)
		alert(type);
	var retTag = '<%=retTag%>';
	
	if(retTag == "success"){
		
		OBPM.dialog.doReturn("success");
	}
}

//问卷调查跳转
function wjGoto(){
	var _type = document.getElementsByName("_type")[0];
	var _content = document.getElementsByName("_content")[0];
	if(_type != null && _type.value=="问卷调查"){
		var strs = _content.value.split(":");
		urlwj = "../../portal/share/vote/preview.jsp?oid="+strs[1];
		window.location.href = urlwj;
	}
}

jQuery(document).ready(function(){
	//OBPM.dialog.resize(document.body.scrollWidth+20, document.body.scrollHeight+70);
	if(jQuery.browser.msie)
	{
		OBPM.dialog.resize(document.body.scrollWidth+20, document.body.scrollHeight+120);
	}
	else if(jQuery.browser.mozilla)
	{
		OBPM.dialog.resize(document.documentElement.scrollWidth+20, document.documentElement.scrollHeight+70);
	}
	wjGoto();	//问卷调查跳转
	ev_init();
	cleanHTMLValue();
});

function send(){
	setHTMLValue();
	setHiddenAttachments();
	document.forms[0].action='<s:url action="reply"></s:url>';
	document.forms[0].submit();
}

//初始值 
function cleanHTMLValue(){
	jQuery("[name='content.body.content']").each(function(){
		jQuery(this).parent().find("iframe").contents().find(".editMode").html("");
	});
}
/**
 * 保存时设置值
 * @return
 */
function setHTMLValue(){

	jQuery("[name='content.body.content']").each(function(){
		var str = jQuery(this).parent().find("iframe").contents().find(".editMode").html();
		jQuery(this)[0].value = str;
	});
}

function setHiddenAttachments(){
	var attachObj = document.getElementsByName('_attids');
	var attachments = '';
	if(attachObj){
		for(var i=0;i<attachObj.length;i++){
			if(attachObj[i].value == '' || attachObj[i].value == null ){
				continue;
			}else{
				attachments = attachments + attachObj[i].value + ';';
			}
		}
		attachments = attachments.substring(0,attachments.length-1);
		document.getElementsByName('attachments')[0].value = attachments;
	}
}

function checkIsExist(id){
	var temp = true;
	DWREngine.setAsync(false);
	PersonalMessageHelper.checkIsExist(id, function(res){
		if(res != 'true'){
			alert("{*[file.not.exist]*}{*[OR]*}{*[deleted]*}!");
			temp = false;
		}
	});
	DWREngine.setAsync(true);
	return temp;
}

function downloadAttachment(id){
	if(checkIsExist(id)){
		var url = '<s:url action='/attachment/download.action' />';
		if(id){
			url += '?attachmentid='+encodeURIComponent(id);
		}
		document.forms[0].action = url;
		document.forms[0].submit();
		//window.open(url);
	}
}

function Upload(){
	var attachObj = document.getElementsByName('_attids');
	if(attachObj){
		if(attachObj.length > 2){
			 alert('{*[core.dynaform.form.prompt_message]*}3{*[Attachments]*}');
			 return false;
		}
	}
	jQuery("#attaid").find("img").each(function() {
		deleteAttachment(this, "", this.id);
	});
	//打开上传窗口
	showUploadDialog();
}

function showUploadDialog() {
	// parent.frames["detail"].window.opener
	OBPM.dialog.show({
		//opener : parent.document,
		width : 580,
		height : 360,
		url : '<s:url value='/portal/share/personalmessage/upload.jsp' />',
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
	var strs = json.split(":");
	if (strs.length < 1) {
		return;
	}
	var attid = strs[0];
	var attName = strs[1];
	var imgAtt = '<img src="<s:url value='/portal/share/email/images/attachment.png'/>" />';
	var content =imgAtt + attName + '<img id="' + attid + '" src="<s:url value='/portal/share/email/images/close.gif'/>" border="0" title="{*[Delete]*}" />';
	var html = "<input id=\"" + attid + "\" type=\"hidden\" name=\"_attids\" value=\"" + attid + "\" />";
	var divElement = document.createElement("div");
	divElement.innerHTML = (content+html);
	jQuery(divElement).find("img").each(function() {
		jQuery(this).click(function(){
			if(this.id){
				var bool = confirm("{*[core.email.attachment.delete.confrm]*}？");
				if (bool) {
					deleteAttachment(this, "", this.id);
				}
			}
		});
	});
	document.getElementById("attaid").appendChild(divElement);


}

function deleteAttachment(object, emailid, attid) {
	//window.parent.showLoading();
	jQuery.ajax({
		type: "POST",
		cache: false,
		url: "<s:url value='/portal/personalmessage/attachment/delete.action' />",
		data: "id=" + attid + "&emailid" + emailid,
		success: function(result) {
			if (result == "success") {
				jQuery(object).parent().remove();
				//window.parent.hideLoading();
			}
		},
		error: function(result) {
			//window.parent.hideLoading();
			alert("{*[core.email.attachment.delete.error]*}！");
		}
	});
}

function UpdateMsgAfterDeleteAttachment(attid) {
	var id = "<s:property value='content.id' />";
	jQuery.ajax({
		type: "POST",
		cache: false,
		url: "<s:url value='/portal/personalmessage/updateMsg.action' />",
		data: "id=" + id + "&attid=" + attid,
		success: function(result) {
			if (result == "success") {

			}
		},
		error: function(result) {
			alert("{*[更新数据失败!]*}");
		}
	});
}

//回撤
function doRetracement(){
	document.forms[0].action='<s:url action="singleRetracement"/>';
	document.forms[0].submit();
	setTimeout(function(){
		OBPM.dialog.doReturn('trash');
	},1);
}
</script>
<style>
#container {border: 1px solid #dddddd;overflow-y:auto; overflow-x:hidden;}
#navigateTable {overflow: hidden;}
#contentTable {overflow-y:auto; overflow-x:hidden;border-top:1px solid #dddddd;}
#navigateTable {height:27px;width:100%;}
.tab {width:68px;height:22px;}
#usersback {background-color: black;opacity:0.1;filter: alpha(opacity:10);left: 0px;top: 0px;
	position: absolute;	z-index: 999;width:104%;height:100%;}
.content_show {z-index:1000;position:absolute;left:20%;top:20%;background-color:white;width:40%;height:40%;}
#activityTable table{border-collapse: collapse;}
</style>

<body class="body-front" style="overflow:hidden;">
<s:bean name="cn.myapps.core.personalmessage.action.PersonalMessageHelper"  id="pmh" />
<div id="container">
<div id="activityTable">
<table class="act_table" width="100%" border=0 cellpadding="0" cellspacing="0">
	<tr>
		<s:if test="content.trash == true">
		<td>
			<div class="button-cmd">
			<div class="btn_left"></div>
			<div class="btn_mid"><a href="#"
				onclick="doRetracement();">{*[Retracement]*}
			</a></div>
			<div class="btn_right"></div>
			</div>
			<div class="exitbtn">
			<div class="button-cmd">
				<div class="btn_left"></div>
				<div class="btn_mid">
					<a class="exiticon" href="#" onclick="forms[0].action='<s:url action="trash" />';forms[0].submit();OBPM.dialog.doReturn();">
						{*[Exit]*}
					</a>
				</div>
				<div class="btn_right"></div>
			</div>
			</div>
		</td>
		</s:if>
		<s:elseif test="content.inbox == true">
		<td>	
			<div class="exitbtn">	
			<div class="button-cmd">
				<div class="btn_left"></div>
				<div class="btn_mid">
					<a class="exiticon" href="#" onclick="forms[0].action='<s:url action="inbox"></s:url>';forms[0].submit();OBPM.dialog.doReturn();">
						{*[Exit]*}
					</a>
				</div>
				<div class="btn_right"></div>
			</div>	
			</div>
		</td>
		</s:elseif>
		<s:elseif test="content.outbox == true">
		<td>
			<div class="exitbtn">		
			<div class="button-cmd">
				<div class="btn_left"></div>
				<div class="btn_mid">
					<a class="exiticon" href="#" onclick="forms[0].action='<s:url action="outbox"/>';forms[0].submit();OBPM.dialog.doReturn();">
						{*[Exit]*}
					</a>
				</div>
				<div class="btn_right"></div>
			</div>	
			</div>
		</td>
		</s:elseif>
		
	</tr>
</table>
</div>
<%@include file="/portal/share/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<s:bean name="cn.myapps.core.user.action.UserUtil"  id="userUtil" />
<div id="contentTable">
	<input type="hidden" name="_currpage" value='<s:property value="datas.pageNo"/>' />
	<input type="hidden" name="_pagelines" value='<s:property value="datas.linesPerPage"/>' />
	<input type="hidden" name="_rowcount" value='<s:property value="datas.rowCount"/>' />
	<input type="hidden" name="_type" value='<s:property value="#pmh.findDisplayText(content.type)" />' />
	<input type="hidden" name="_content" value='<s:property escape="false" value="#pmh.htmlDecodeEncoder(content.body.content)" />' />
	<fieldset> 	
	<table class="table_noborder" style="width:100%;">	
		<tr>	
			<td align="left">
					<table width="100%" border="0">
						<tr>
							<td width="50px" align="right">{*[Message]*}</td>
							<td> {*[From]*} <b><s:if test="content.senderId == null || content.senderId == ''">
						{*[System]*}
						</s:if>
						<s:else><s:property value="#userUtil.findUserName(content.senderId)" /></s:else></b> {*[To]*} <b><s:property value="#pmh.findUserNamesByMsgIds(content.receiverId)" /></b></td>
						</tr>
						
						<tr>
							<td align="right">{*[Type]*}：</td>
							<td style="background-color: white;"><s:property value="#pmh.findDisplayText(content.type)" /></td>
						</tr>
						
						<tr>
							<td align="right">{*[Title]*}：</td>
							<s:if test="#request.content.body.title == '已送出通知'">
								<td style="background-color: white;">{*[cn.myapps.core.workflow.notification.sended]*}</td>
							</s:if>
							<s:elseif test="#request.content.body.title == '待办通知'">
								<td style="background-color: white;">{*[cn.myapps.core.workflow.notification.pending]*}</td>
							</s:elseif>
							<s:elseif test="#request.content.body.title == '待办超期通知'">
								<td style="background-color: white;">{*[cn.myapps.core.workflow.notification.pending.overdue]*}</td>
							</s:elseif>
							<s:elseif test="#request.content.body.title == '回退通知'">
								<td style="background-color: white;">{*[cn.myapps.core.workflow.notification.rollback]*}</td>
							</s:elseif>
							<s:else>
								<td style="background-color: white;"><s:property value='content.body.title' /></td>
							</s:else>
						</tr>
						<tr>
							<td align="right" valign="top">{*[Content]*}：</td>
							<td style="background-color: white;" valign="top"><s:property escape="false" value="#pmh.htmlDecodeEncoder(content.body.content)" /></td>
						</tr>
						<s:if test="content.type == 2">
						<s:form action="vote" method="post" theme="simple">
						<tr>
							<td align="right" valign="top">&nbsp;
								<s:hidden name="content.id" value="%{content.id}" />
								<s:hidden name="content.senderId" value="%{#session.FRONT_USER.id}" />
								<s:hidden name="content.receiverId" value="%{content.receiverId}" />
								<s:hidden name="content.type" value="%{content.type}" />
								<s:hidden name="content.body.title" value="%{content.body.title}" />
								<s:hidden name="content.body.content" value="%{content.body.content}" />
								<s:hidden name="content.voteOptionsId" value="%{content.voteOptionsId}" />
								<s:hidden name="content.checkedOptionsId" value="%{content.checkedOptionsId}" />
								<s:hidden name="content.radioOrCheckbox" value="%{content.radioOrCheckbox}" />
								<s:hidden name="content.inbox" value="%{content.inbox}" />
								<s:hidden name="content.outbox" value="%{content.outbox}" />
								<s:hidden name="content.trash" value="%{content.trash}" />
							</td>
							<td style="background-color: white;" valign="top"><div id="td_options"><s:property escape="false" value="#request.pmh.getVoteOptionsHtml(content.radioOrCheckbox,content.voteOptionsId,content.checkedOptionsId)" />
							</div></td>
						</tr>
						<s:if test="!content.outbox">
						<tr>
							<td align="left" valign="bottom"><input id="td_submit" type="button" disabled="disabled" value="{*[Voted]*}" onclick="forms[0].submit();" /></td>
							<td style="background-color: white;" valign="top">&nbsp;</td>
						</tr>
						<s:if test="content.checkedOptionsId == null || content.checkedOptionsId == ''">
							<s:if test="!content.trash">
								<script type="text/javascript">
									var obj = document.getElementsByName('content.checkedOptionsId');
									if(obj){
										for(var i = 0;i < obj.length; i++){
											obj[i].removeAttribute('disabled');
										}
									}
									document.getElementById('td_submit').removeAttribute('disabled');
								</script>
							</s:if>
							<script type="text/javascript">document.getElementById('td_submit').value = '{*[cn.myapps.core.personalmessage.vote]*}';</script>
						</s:if>
						</s:if>
						</s:form>
						</s:if><s:else>
						<tr>
							<td align="right" valign="top">{*[Attachment]*}：</td>
							<td style="background-color: white;" valign="top"><s:property escape="false" value="#pmh.findAttachmentsByIds(content.attachmentId,content.outbox)" />
							</td>
						</tr></s:else>
					</table>
			</td>
		</tr>

		<s:if test="content.type == 0 || content.type == 1">
		<tr>
			<td colspan="2">
				<div id="users" style="display:none"></div>
					<div id="usersback" style="display:none"></div>
					<s:if test="content.id != null && !content.outbox && content.type != 1">
					<input type="button" id="btn_Reply" value="{*[Reply]*}" onclick="javascript:showReply();" />
							<s:if test="content.trash">
								<script type="text/javascript">
									document.getElementById('btn_Reply').disabled = true;
								</script>
							</s:if>
					<div id="reply" style="display:none;">
					<s:form name="replyForm" action="reply" method="post" theme="simple">
					
						<s:hidden name="content.id" value="%{content.id}" />
						<s:hidden name="content.senderId" value="%{#session.FRONT_USER.id}" />
						<s:hidden name="receiverid" value="%{content.senderId}" />
						<s:hidden name="content.type" value="%{content.type}" />
						<s:hidden name="content.body.title" value="Re:%{content.body.title}" />
						<textarea name="content.body.content" class="xheditor" style="height:240px; width:100%; "><s:property value="content.body.content" /></textarea>
						
						<table id="tb">
						  <tr>
							<td class="commFont commLabel" valign="top">{*[Attachment]*}：
							<a href="#" style="cursor: pointer;" onclick="Upload();"><img src="<s:url value='/resource/images/add.gif'/>" border="0" title="{*[Add]*}"  / >{*[Upload]*}</a></td>
							<td id="attaid">
								<input type="hidden" name="attachments" value="<s:property value="attachments" />" />
							</td>
						  </tr>
						</table><br />
						<input type="button" onclick="send()" value="{*[Send]*}" />
					</s:form>
					</div>
					</s:if><s:else>
							<s:if test="content.outbox">
							<div>{*[IsRead]*}：<b><s:property value="#pmh.findUserNamesByMsgIds(content.isReadReceiverId)" /></b></div>
							<div>{*[NoRead]*}：<b><s:property value="#pmh.findUserNamesByMsgIds(content.noReadReceiverId)" /></b></div>
							</s:if>
					<s:form method="post"><s:hidden name="content.id" value="%{content.id}" /></s:form>
					</s:else>
			</td>
		</tr>
		</s:if>
		<s:elseif test="content.type != 2">
			<s:form method="post"><s:hidden name="content.id" value="%{content.id}" /></s:form>
		</s:elseif>
	</table>
	</fieldset>
	</div>
	</div>
</body>
</o:MultiLanguage></html>
