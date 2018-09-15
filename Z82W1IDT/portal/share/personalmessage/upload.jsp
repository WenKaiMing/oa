<%@ include file="/portal/share/common/head.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page import="cn.myapps.core.dynaform.form.action.FormHelper"%>
<%
	//session.setAttribute("perc", new Integer(0));
	FormHelper instance = new FormHelper();

	String applicationid = request.getParameter("applicationid");
	String limitNumber = request.getParameter("limitNumber");
	String fileType = request.getParameter("fileType");
	String customizeType = request.getParameter("customizeType");

	//路径
	String pathtemp = request.getParameter("path");
	String path = null;
	if (pathtemp != null) {
		path = pathtemp;
	} else {
		path = "null";
	}

	//文件保存模式
	String fileSaveModetemp = request.getParameter("fileSaveMode");
	String fileSaveMode = null;
	if (fileSaveModetemp != null) {
		fileSaveMode = fileSaveModetemp;
	} else {
		fileSaveMode = "null";
	}

	//空间id
	String fieldid = request.getParameter("fieldid");

	//拓展名格式
	String allowedTypestemp = request.getParameter("allowedTypes");
	String allowedTypes = null;
	if (allowedTypestemp != null) {
		allowedTypes = allowedTypestemp;
	} else {
		allowedTypes = "null";
	}

	//构建路径
	String contextPath = request.getContextPath();
	String str = null;
	str += "path:" + path + ",";
	str += "fileSaveMode:" + fileSaveMode + ",";
	str += "fieldid:" + fieldid + ",";
	str += "allowedTypes:" + allowedTypes + ",";
	str += "applicationid:" + applicationid;
	String urlUpload = contextPath
			+ "/portal/personalmessage/attachment/uploadServlet" + "?data=" + str;

	String uploadFileNumber = null;
	if(limitNumber != null){
		uploadFileNumber = limitNumber;
	}else{
		uploadFileNumber = "1";
	}

	//判断上传格式
	String fileDesc;
	String fileExt;

	if (allowedTypes.equals("image") || allowedTypes == "image") {
		fileDesc = "jpg/gif/jpeg/png/bmp";
		fileExt = "*.jpg;*.gif;*.jpeg;*.png;*.bmp";
		uploadFileNumber = "1";
	} else if (fileType != null && fileType != "") {
		if (fileType.equals("01") || fileType == "01") {
			fileDesc = instance.getFileDesc(customizeType);
			fileExt = instance.getFileExt(customizeType);
		} else {
			fileDesc = "*";
			fileExt = "*.*";
		}
	} else {
		fileDesc = "*";
		fileExt = "*.*";
	}
	
	if(limitNumber == null){
		limitNumber = "1";
	}
	
	

	String maximumSizetemp = request.getParameter("maximumSize");
	String maximumSize = null;
	if (maximumSizetemp != null) {
		maximumSize = maximumSizetemp;
	} else {
		maximumSize = "10240";
	}
%>

<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<head>
<title>{*[Upload_File]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
@charset "UTF-8";

.button{
height: 32px;
text-align: center;
font-weight: bold;
font-size: 12px;
position: relative;
overflow: hidden;
width: 80px;
font-family: NSimSun;
border-style:none;
cursor:pointer
}

//
进度条样式
#graphbox {
	border: 1px solid #e7e7e7;
	padding: 10px;
	width: 250px;
	background-color: #f8f8f8;
	margin: 5px 0;
}

#graphbox h2 {
	color: #666666;
	font-family: Arial;
	font-size: 18px;
	font-weight: 700;
}

.graph {
	position: relative;
	background-color: #F0EFEF;
	border: 1px solid #cccccc;
	padding: 2px;
	font-size: 13px;
	font-weight: 700;
}

.graph .green {
	position: relative;
	text-align: left;
	color: #ffffff;
	height: 18px;
	line-height: 18px;
	font-family: Arial;
	display: block;
}

.graph .green {
	background-color: #66CC33;
}

object {
	position: absolute;
	left: 0px;
	top: 0px;
}

.grid {
	width: 100%;
	text-align: center;
}

.grid tbody tr {
	line-height: 18px;
	height: 22px;
}

.grid tbody td {
	word-break: break-all;
	text-align: left;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
	font-size: 12px;
	font-family: NSimSun;
}

.even {
	background-color: #FEF8F4;
}

.over {
	background-color: #ffc;
}

.prompt{
	width:100%;
	height:200px;
	line-height:200px;
	text-align:center;
	overflow:hidden;
	font-family:SimHei;
	font-size:30;
	color:#dcdbdc
}

.imageWarning{
	height: 38px;
	top: 8px;
	right: 8px;
	position: relative;
}
</style>
<script type="text/javascript" src="swfupload.js"></script>
<script type="text/javascript" src="fileUpload.js"></script>
<script src='<s:url value="/portal/share/script/AC_OETags.js"/>'></script>
<script type="text/javascript">

window.onload = function() {
	var arg = OBPM.dialog.getArgs();
	path =arg['webPath'];
	
	fileMaxText = "{*[core.dynaform.form.file_upload_max]*}";
	fileZeroText = "{*[core.dynaform.form.file_size_zero]*}";
	fileResidueText = "{*[core.dynaform.form.file_upload_residue]*}";
	fileReadyText = "{*[core.dynaform.form.file_ready]*}";
	fileLimitText = "{*[cn.myapps.core.dynaform.form.limit_file_size]*}";
	fileSuccessText = "{*[core.dynaform.form.upload_success]*}";
	fileExceedText =  "{*[core.dynaform.form.file_limit_exceed]*}";
	fileMessageText = "{*[core.dynaform.form.prompt_message2]*}";
	cancel = "{*[Cancel]*}";
	stopped = "{*[Stopped]*}";
	unit = "{*[core.email.one]*}";
	
	sunUploadSize = <%=uploadFileNumber%>;
	residueUpload = <%=uploadFileNumber%>;
	mamaximumSize = <%=maximumSize%> * 1024;
	var selectFile;
	if(sunUploadSize == 1){
		selectFile = SWFUpload.BUTTON_ACTION.SELECT_FILE;
	}else{
		selectFile = SWFUpload.BUTTON_ACTION.SELECT_FILES;
	}
	
	upload = new SWFUpload(
			{
				
				//处理文件上传的url  
				upload_url : "<%=urlUpload%>",
				//上传文件限制设置  
				file_size_limit : "<%=maximumSize%>", // 10MB  
				file_types : "<%=fileExt%>", //此处也可以修改成你想限制的类型，比如：*.doc;*.wpd;*.pdf  
				file_types_description : "<%=fileDesc%>",
				file_upload_limit : "<%=uploadFileNumber%>",
				file_queue_limit : "<%=uploadFileNumber%>",
				file_queued_handler : fileQueued,
				file_queue_error_handler : fileQueueError,
				upload_progress_handler : uploadProgress,
	
				file_dialog_start_handler : fileDialogStart,
				file_dialog_complete_handler : fileDialogComplete,
				upload_success_handler : uploadSuccess,
				upload_error_handler : uploadError,
				upload_complete_handler : uploadComplete,
				/* upload_complete_handler : uploadComplete, */
				/* //事件处理设置（所有的自定义处理方法都在handler.js文件里）  
				
				upload_start_handler : uploadStart,
				upload_error_handler : uploadError, */
				//按钮设置  
				//swf设置  
				button_width : "80",
				button_height : "30",
				button_text_style : "float:left;left:0px;height:0px;cursor:pointer;",
				button_cursor : SWFUpload.CURSOR.HAND,
				button_action : selectFile,
				button_placeholder_id : "swf_upload",
				flash_url : "swfupload.swf",
				button_window_mode : SWFUpload.WINDOW_MODE.TRANSPARENT,
				custom_settings : {
					progressTarget : "fsUploadProgress",
					cancelButtonId : "btnCancel"
				},
				// Debug 设置  
				debug : false
			});
			changeNotice();
		}

</script>
	</head>
	<body style="overflow: hidden;">
		<div style="border: 1px #000 solid">
			<div
				style="background-color: #ffffff; width: 100%; height: 50px; color: #FFFFFF; text-align: left; font-style: normal; border-bottom: 1px #990000 solid; align-content: center;">
				<div
					style="position: relative; width: 80px; height: 30px; top: 10px; left: 10px; width: 100%;">
					<Button id="swf_upload_button" class="button blue" style="border-style:none;background:url(images/upload_blue.png);background-size:100% 100%;">{*[core.dynaform.form.file_select]*}</Button>
					<Button id="swf_upload_OK" class="button green" style="display:none;border-style:none;background:url(images/upload_green.png);background-size:100% 100%;" onclick="returnResult()" >{*[core.dynaform.form.file_confirm]*}</Button>
					<Button id="swf_upload_Cancel" class="button gray" style="display:none;border-style:none;background:url(images/upload_gray.png);background-size:100% 100%;" onclick="cancelResult()">{*[Cancel]*}</Button>
					<div id="swf_upload"></div>
				</div>
			</div>
			<div style="height: 320px; overflow: auto;">
				<table id="infoTable" class="grid"
					style="table-layout: fixed; padding: 5px; WORD-BREAK: break-all; WORD-WRAP: break-word">
					<col width="100%" />
					<col width="40px" />
					<col width="40px" />
				</table>
				<div id="promptDiv" class="prompt"><img src="images/warning.png" class="imageWarning"/><B>{*[core.dynaform.form.file_remind_description]*}</B>
				</div>
			</div>
		</div>

		<div id="swf_upload_notice"
			style="width: 100%; float: left; font-size: 12px; padding: 5px"></div>
	</body>
</o:MultiLanguage>
</html>

