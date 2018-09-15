<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>

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
			+ "/portal/FrontFileAndImageUploadServlet" + "?data=" + str;

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
		fileDesc = "image/*";
		fileExt = "jpg,gif,jpeg,png,bmp";
		//uploadFileNumber = "1";
	} else if(fileType != null && fileType != ""){
		if (fileType.equals("01") || fileType == "01") {
			fileDesc = null;
			fileExt = customizeType.replaceAll(";", ",");
		} else {
			fileDesc = null;
			fileExt = null;
		}
	} else {
		fileDesc = null;
		fileExt = null;
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
<!DOCTYPE HTML>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[Upload]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../../../css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="../webuploader/webuploader.css">
<link rel="stylesheet" type="text/css" href="./selectFile.css">
</head>
<body>
<div id="uploader" class="wu-example">
    <div class="queueList">
        <div id="dndArea" class="placeholder">
            <div id="filePicker"></div>
            <p>或将文件拖到这里</p>
            <p>或ctrl+v直接粘贴截图</p>
            
            <div class="limitSize"><span></span></div>
        </div>
    </div>
    <div class="statusBar" style="display:none;">
        <div class="progress">
            <span class="text">0%</span>
            <span class="percentage"></span>
        </div><div class="info"></div>
        <div class="btns">
            <div id="filePicker2"></div>
            <div class="uploadBtn">开始上传</div>
            <div class="btn btn-default state-ok" style="display:none">{*[core.dynaform.form.file_confirm]*}</div>
            <div class="btn btn-default state-cancel" style="display:none">{*[Cancel]*}</div>
        </div>
    </div>
</div>

<script src="<s:url value='/portal/H5/resource/js/jquery-1.11.3.min.js'/>"></script>
<script src="<s:url value='/portal/H5/resource/component/artDialog/jquery.artDialog.source.js?skin=aries'/>"></script>
<script src="<s:url value='/portal/H5/resource/component/artDialog/plugins/iframeTools.source.js'/>"></script>
<script src="<s:url value='/portal/H5/resource/component/artDialog/obpm-jquery-bridge.js'/>"></script>
<script src="../webuploader/webuploader.js"></script>
<script src="./selectFile.js"></script>
<script>

var arg = OBPM.dialog.getArgs();
//path = arg['webPath'];
path = "<%=path %>";

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

var webAcceptExtensions  = "<%=fileExt%>";
var webFileSingleSizeLimit = "<%=maximumSize%>";// 10MB
var file_types_description = "<%=fileDesc%>";
var file_upload_limit = "<%=uploadFileNumber%>";
var file_queue_limit = "<%=uploadFileNumber%>";

if(webAcceptExtensions == 'null'){
	webAcceptExtensions = null;
}

//总上传量
var sunUploadSize = "<%=uploadFileNumber%>";
//已上传数量
var alreadyUpload = 0;
//待上传数
var waitUpload = 0;
//剩余上传数
var residueUpload = "<%=uploadFileNumber%>";
//上传大小
var mamaximumSize =parseInt("<%=maximumSize%> ")  * 1024;
//删除文件数
var deleteNumber = 0;

var keys = new Array();
var values = new Array();
var value = "";
var urlUpload = '<%=urlUpload%>';
var uploader;	// WebUploader实例

//文件上传
jQuery(function() {
	FU.init();
	
	var text = "单个文件大小限制：" + WebUploader.formatSize( mamaximumSize ) + " , 最大上传数："+ sunUploadSize ;
	$("#uploader .limitSize").find("span").text(text);
});

</script>
</body>
</o:MultiLanguage>
</html>

