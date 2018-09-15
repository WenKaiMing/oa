<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.util.DateUtil"%>
<%@ page import="java.util.Date"%>
<%
	WebUser curUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String signature = curUser.getName() + " " + DateUtil.format(new Date(), "yyyy-MM-dd");
%>

<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<html>
<head>
<%@include file="/portal/share/common/js_base.jsp"%>
<%@include file="/portal/share/common/js_component.jsp"%>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/DocumentUtil.js"/>'></script>
<script src='<s:url value="/portal/share/script/document/document.js"/>'></script>
<style>
	* {margin:0px; padding:0px;}
	.content {
		margin:0px;
		padding:0px;
		width:650px;
		height:165px;
		font-size:16px;
		resize:none;
	}
	fieldset {
		margin:15px;
		padding:5px;
		-moz-border-radius: 5px;
		-webkit-border-radius: 5px;
		border-radius: 5px;
		border:1px solid rgb(169, 169, 169);
		font-family:"微软雅黑","Arial","Microsoft YaHei","黑体","宋体",sans-serif;
		font-size:14px;
	}
	.submit_btn {
		border:0px;
		float:right;
		margin-top:15px;
		margin-right:15px;
	}
	.submit_btn_left,.submit_btn_center,.submit_btn_right {
		float:left;
	}
	.submit_btn_left {
		margin-left:5px;
		width:4px;
		height:30px;
		background:url(images/btn_left.gif) no-repeat;
	}
	.submit_btn_center {
		height:30px;
		line-height:30px;
		background:url(images/btn_center.gif) repeat-x;
	}
	.submit_btn_right {
		width:4px;
		height:30px;
		background:url(images/btn_right.gif) no-repeat;
		
	}
	.submit_btn_center span {
		padding:0 15px;
		color: #000000;
		font-size: 12px;
		cursor:pointer;
	}
</style>	
</head>
<script type="text/javascript">
	var $signature = '<%=signature%>';
	
	
	/**
	 * json对象转string
	 */
	function stringifyJSON(O) { 
	       //return JSON.stringify(jsonobj); 
	       var S = []; 
	       var J = ""; 
	       if (Object.prototype.toString.apply(O) === '[object Array]') { 
	           for (var i = 0; i < O.length; i++) 
	               S.push(stringifyJSON(O[i])); 
	           J = '[' + S.join(',') + ']'; 
	       } 
	       else if (Object.prototype.toString.apply(O) === '[object Date]') { 
	           J = "new Date(" + O.getTime() + ")"; 
	       } 
	       else if (Object.prototype.toString.apply(O) === '[object RegExp]' || Object.prototype.toString.apply(O) === '[object Function]') { 
	           J = O.toString(); 
	       } 
	       else if (Object.prototype.toString.apply(O) === '[object Object]') { 
	           for (var i in O) { 
	               O[i] = typeof (O[i]) == 'string' ? '"' + O[i] + '"' : (typeof (O[i]) === 'object' ? stringifyJSON(O[i]) : O[i]); 
	               S.push('"' + i + '":' + O[i]); 
	           } 
	           J = '{' + S.join(',') + '}'; 
	       } 

	       return J; 
	}; 

	/**
	*	校验反馈信息
	*/
	function ev_check() {
		var content = $("textarea[name='_content']").val();
		if ($.trim(content)=='') {
			alert("反馈内容不能为空！");
			return true;
		}
		return false;
	}
	
	/**
	*	生成反馈信息
	*/
	function buildFeedbackInfo() {
		var info = {"content":"", "attachment":[], "signature":""};
		info.signature = $signature;
		var content = $.trim($("textarea[name='_content']").val());
		var attachment =  $("input[name='_attachment']").val();
		if (!attachment && ($.trim(attachment)=='' || attachment=='undefined')) {
			attachment = [];
		} else {
			attachment = eval('(' + attachment + ')');
		}
		info.content = content
		info.attachment = attachment;
		return info;
	}
	
	/**
	*	确认反馈
	*/
	function doFeedBack() {
		var docid = $("input[name='_docid']").val();
		var fieldname = $("input[name='_filedname']").val();
		var applicationid = $("input[name='_applicationid']").val();
		
		DocumentUtil.getInformationfeedbackInfo(docid, fieldname, applicationid, function(data){
			var jsInfo = new Array();
			if (data=='' || data && data!='undefined') {
				jsInfo = data==''?new Array() : eval('(' + data + ')');
				jsInfo.push(buildFeedbackInfo());
				
				var info =  stringifyJSON(jsInfo);
				//更新反馈 信息
				DocumentUtil.doUpdateInformationfeedbackInfo(docid, fieldname, info, applicationid, function(data){
					if (data && data.indexOf('showError')>=0) {
						alert(data);
					} else {
						OBPM.dialog.doReturn(info);
					}
				});
			//获取信息反馈信息失败	
			} else if (data && data.indexOf('showError')>=0) {
				alert(data);
			} 
		});
	}

	$(document).ready(function() {
		//重新渲染附件上传控件
		$("span[moduleType='uploadFile']").obpmUploadField();
		$("#submit").click(function() {
			if (!ev_check()) {
				doFeedBack();
			} 
		});
	});	
</script>

<body>
	<form action="" method="post">
		<input type="hidden" name="_docid" value="<s:property value='#parameters.docid' />" />
		<input type="hidden" name="_formid" value="<s:property value='#parameters.formid' />" />
		<input type="hidden" name="_applicationid" value="<s:property value='#parameters.applicationid' />" />
		<input type="hidden" name="_filedname" value="<s:property value='#parameters.fieldname' />">
		<fieldset>
    		<legend>内容</legend>
    		<textarea name="_content" class="content"></textarea>
		</fieldset>
		<fieldset>
    		<legend>附件</legend>
    		<span id = '11e5-86df-7d153990-a52e-a7d4adc0c799' moduleType='uploadFile' name='_attachment' tagName='AttachmentUploadField' maxsize='10240' filelabel = '{*[File]*}' uploadlabel ='{*[Upload]*}' deleteLabel ='{*[Delete]*}' discript ='附件' path='ITEM_PATH' limitType ='' uploadList ='uploadList_11e5-86df-7d153990-a52e-a7d4adc0c799_attachment' refreshOnChanged='false' fileSaveMode='00' application ='11e2-809a-99fe60d6-b96a-59e13d804b12' limitNumber ='10' fileType='00' customizeType='' opentype='dialog' imgHeight='null' imgWidth='null'>
    		</span>
		</fieldset>
		<div class="submit_btn">
			<div class="submit_btn_left"></div> 
	   		<div class="submit_btn_center"><span id="submit">确认反馈</span></div>
	   		<div class="submit_btn_right"> </div>
   		</div>
	</form>
</body>
</html>
</o:MultiLanguage>