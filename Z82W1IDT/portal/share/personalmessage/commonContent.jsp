<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<link rel="stylesheet"	href="css/base.css" type="text/css" />
<link rel="stylesheet"	href="<s:url value='/portal/share/script/jquery-ui/jquery-ui.css'/>" type="text/css" />
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/js/jquery-1.8.3.js'/>"></script>
<script src='<s:url value="/portal/share/script/jquery-ui/jquery-ui.js"/>'></script>
<!-- 弹出层插件--start -->
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/component/artDialog/obpm-jquery-bridge.js'/>"></script>
<script type="text/javascript" src="scripts/action.js"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/interface/PersonalMessageHelper.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script>
var checkedList = new Array(); 
var imageSrc = '<s:url value="/resource/images/loading.gif" />';
var text = '{*[page.loading]*}...';
var URL = '<s:url value="/core/resource/resourcechoice.jsp" />';

function checkSpace(obj) {
	var regex = /[^\w\u4e00-\u9fa5]/g;
	obj.value = obj.value.replace(regex, '');
}

function chooseName() {
	var url = '<s:url value="/portal/user/listuser.action">';
		url += '<s:param name="t_domainid" value="#session.FRONT_USER.domainid"/>';
		url += '<s:param name="xi_id" value="#session.USER.id" />';
		url += '</s:url>';
	
	showfrontframe({
		title : "{*[Choose]*}{*[User]*}",
		url : url,
		callback : function(result) {
			jQuery("#receiverid").val(result);
			PersonalMessageHelper.findUserName(result, insertName);
		}
	});
}

function selectUsers(id,name){
	var settings={"valueField":id,"textField":name};
	showUserSelectNoFlow("",settings,"");
}

function findUserName(result){
	PersonalMessageHelper.findUserName(result, insertName);
}

function insertName(data) {
	jQuery("#receivername").val(data);
}

jQuery(function(){
	var applicationid=window.document.getElementById("application").value;
	jQuery("#application").val(applicationid);
});

function setHTMLValue(){
	jQuery("[name='content.body.content']").each(function(){
		var str = jQuery(this).parent().find("iframe").contents().find(".editMode").html();
		jQuery(this)[0].value = str;
	});
}

function cleanHTMLValue(){
	jQuery("[name='content.body.content']").each(function(){
		jQuery(this).parent().find("iframe").contents().find(".editMode").html("");
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
	var content = imgAtt + attName + '<img id="' + attid + '" src="<s:url value='/portal/share/email/images/close.gif'/>" border="0" title="{*[Delete]*}" />';
	var html = "<input id=\"" + attid + "\" type=\"hidden\" name=\"_attids\" value=\"" + attid + "\" />";
	var divElement = document.createElement("span");
	divElement.setAttribute("style", "font-size:9px;padding-left:4px;padding-top:5px");
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

function Upload(){
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
				//jQuery("#" + attid).remove();
				//window.parent.hideLoading();
			}
		},
		error: function(result) {
			//window.parent.hideLoading();
			alert("{*[core.email.attachment.delete.error]*}！");
		}
	});
}


function send(){
	setHTMLValue();
	setHiddenAttachments();
	var  details = document.getElementsByName('content.body.content')[0].value;
	if( details == ''){
		//showMessage("error", '{*[page.content.notexist]*}');
		return false;
	}
	
	$.ajax({
        cache: true,
        type: "POST",
        url:contextPath+"/portal/personalmessage/save.action",
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

	$(function(){
		$(".operation").bind("click", function(){
			if($(this).attr("operation") == 'submit') {
				send();	
			} else if($(this).attr("operation") == 'cancel') {
				OBPM.dialog.doExit();
			}
		});
		
		//jquery-ui-button
		$(".operation").button();
	});
</script>