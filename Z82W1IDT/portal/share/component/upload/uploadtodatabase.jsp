<%@ include file="/portal/share/common/head.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>

<%
String contextPath = request.getContextPath();
String userid = ((WebUser)request.getSession().getAttribute("FRONT_USER")).getId();
%>

<%@page import="cn.myapps.core.user.action.WebUser"%><html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[Upload_File]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src='<s:url value="/dwr/engine.js"/>'></script>
<script type="text/javascript" src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script type="text/javascript">
var fieldValue ='';
var allowedTypes = '';
var fieldId = '';
var maximumSize = '';
var applicationid = '';
var contextPath = '<%=contextPath %>';
var fileDesc = '';
var fileExt = '';
var uploadFileNumber = '';
var applicationid = '';
var limitNumber = '';
var fileType = '';
var customizeType = '';
var userid = '<%=userid %>';

function ev_doEmpty() {
	OBPM.dialog.doClearUpload();
}
function ev_doClose(s) {
	if(fieldValue!=''&&fieldValue!='null'&&fieldValue!=null){
		if(s!=''&&s!='null'&&s!=null){
			if(allowedTypes!="image"){
				OBPM.dialog.doReturn(fieldValue+";"+s);
			}else{
				OBPM.dialog.doReturn(s);
			}
		}else{
			OBPM.dialog.doReturn(fieldValue);
		}
	}else{
		OBPM.dialog.doReturn(s);
	}
}

jQuery(document).ready(function(){
	fieldId = OBPM.dialog.getArgs()['fieldId'];
	fieldValue = OBPM.dialog.getArgs()['fieldValue'];
	maximumSize = OBPM.dialog.getArgs()['maximumSize'];
	allowedTypes = OBPM.dialog.getArgs()['allowedTypes'];
	applicationid = OBPM.dialog.getArgs()['applicationid'];
	limitNumber = OBPM.dialog.getArgs()['limitNumber'];
	fileType = OBPM.dialog.getArgs()['fileType'];
	customizeType = OBPM.dialog.getArgs()['customizeType'];
	
	if(maximumSize == null || maximumSize=="" || maximumSize=="undefined"){
		maximumSize = "10485760";
	}
	
	if(allowedTypes=="image"){
		fileDesc = "jpg/gif/jpeg/png/bmp";
		fileExt = "*.jpg;*.gif;*.jpeg;*.png;*.bmp";
		uploadFileNumber = "1";
	}else if(fileType == "01"){
		DWREngine.setAsync(false);
    	FormHelper.getFileDesc(customizeType,function (res){
    		fileDesc = res;
        });
    	FormHelper.getFileExt(customizeType,function (res){
    		 fileExt = res;
        });
    	DWREngine.setAsync(true);
    	uploadFileNumber = limitNumber;
	}else{
		fileDesc = "*";
		fileExt = "*.*";
		uploadFileNumber = limitNumber;
	}

	//alert(getFlashVars());
});

function getFlashVars(){
	var FlashVars = '{"userid":"'+userid+'","allowedTypes":"'+allowedTypes+'","fieldid":"'+fieldId+'","fileDesc":"'+fileDesc
	+'","fileExt":"'+fileExt+'","uploadFileNumber":"'+uploadFileNumber+'","maximumSize":"'+maximumSize
	+'","contextPath":"'+contextPath+'","applicationid":"'+applicationid
	+'","Browse":"{*[core.dynaform.form.browse]*}","Upload":"{*[Upload]*}","Clear":"{*[core.dynaform.form.clear]*}","Clear_List":"{*[core.dynaform.form.clear_list]*}","Cancel":"{*[Cancel]*}","Delete":"{*[Delete]*}","File_Name":"{*[core.dynaform.form.file_name]*}","File_Size":"{*[core.dynaform.form.file_size]*}","File_Type":"{*[core.dynaform.form.file_type]*}","File_Status":"{*[core.dynaform.form.file_status]*}","Finish":"{*[Finish]*}","Prompt":"{*[Prompt]*}","Prompt_Message":"{*[core.dynaform.form.prompt_message]*}","Prompt_Message1":"{*[core.dynaform.form.prompt_message1]*}","Prompt_Message2":"{*[core.dynaform.form.prompt_message2]*}","Size":"{*[Size]*}","limitsizeText":"{*[cn.myapps.core.dynaform.form.limit_file_size]*}"}';
	return FlashVars;
}

    </script>
    </head>
    <body style="width:'100%';height:'100%';margin:0px">
	<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
			id="UploadToDataBase" width="100%" height="100%"
			codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
			<param name="movie" value="UploadToDataBase.swf" />
			<param name="quality" value="high" />
			<param name="bgcolor" value="#869ca7" />
			<param name="allowScriptAccess" value="sameDomain" />
			<embed src="UploadToDataBase.swf" quality="high" bgcolor="#869ca7"
				width="100%" height="100%" name="UploadToDataBase" align="middle"
				play="true"
				loop="false"
				quality="high"
				allowScriptAccess="sameDomain"
				type="application/x-shockwave-flash"
				pluginspage="http://www.adobe.com/go/getflashplayer">
			</embed>
	</object>
    </body>
</o:MultiLanguage></html>

