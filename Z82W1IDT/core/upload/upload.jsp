<%@include file="/common/tags.jsp"%>
<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%
//session.setAttribute("perc", new Integer(0));
String contextPath = request.getContextPath();
String applicationid = request.getParameter("applicationid");

String pathtemp=request.getParameter("path");
String path=null;
    if(pathtemp!=null){
    	path=pathtemp;
    }else{
    	path="null";
    }
    
String fieldid=request.getParameter("fieldid");

String fileSaveModetemp=request.getParameter("fileSaveMode");
String fileSaveMode=null;
    if(fileSaveModetemp!=null){
    	fileSaveMode=fileSaveModetemp;
    }else{
    	fileSaveMode="null";
    }


String allowedTypestemp=request.getParameter("allowedTypes");
String allowedTypes=null;
    if(allowedTypestemp!=null){
    	allowedTypes=allowedTypestemp;
    }else{
    	allowedTypes="null";
    }

String maximumSizetemp=request.getParameter("maximumSize");
String maximumSize=null;
    if(maximumSizetemp!=null){
    	maximumSize=maximumSizetemp;
    }else{
    	maximumSize="10485760";
    }
    
//判断上传格式
String fileDesc;
String fileExt;
String uploadFileNumber;
    if(allowedTypes.equals("image" )|| allowedTypes=="image"){
    	fileDesc="jpg/gif/jpeg/png/bmp";
    	fileExt="*.jpg;*.gif;*.jpeg;*.png;*.bmp";
    	uploadFileNumber="1";
    }else{
    	fileDesc="*";
    	fileExt="*.*";
    	uploadFileNumber="10";
    }
    String str=null;
    str+="path:"+path+",";
    str+="fileSaveMode:"+fileSaveMode+",";
    str+="fieldid:"+fieldid+",";
    str+="allowedTypes:"+allowedTypes+",";
    str+="applicationid:"+applicationid;
    
%>

<html>
<o:MultiLanguage>
<head>
<title>{*[Upload_File]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/common/head.jsp"%>   
<script src='<s:url value="/script/AC_OETags.js"/>'></script>
<script type="text/javascript">

function ev_doEmpty() {
    //window.returnValue = "";
	//window.close();
	OBPM.dialog.doReturn("");
}
function ev_doClose(s) {
	//window.returnValue = s;
	//window.close();
	OBPM.dialog.doReturn(decodeURIComponent(s));
}

    </script>
    </head>
    <body style="width:'100%';height:'100%';margin:0px">
    <script language="JavaScript" type="text/javascript">
	<!--
	//Globals
	//Major version of Flash required
	var requiredMajorVersion = 9;
	//Minor version of Flash required
	var requiredMinorVersion = 0;
	//Minor version of Flash required
	var requiredRevision = 124;
	// Version check for the Flash Player that has the ability to start Player Product Install (6.0r65)
	// Version check based upon the values defined in globals
	var hasRequestedVersion = DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision);
	
	if (!hasRequestedVersion) {
	var alternateContent = '{*[Flash_Player_Install]*} '
	   	+ '<a href=http://www.adobe.com/go/getflash/>Get Flash</a>';
	    document.write(alternateContent);  // insert non-flash content
	  }
	// -->
	</script>
    <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
			id="moreUploadFile" width="100%" height="100%"
			codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
			<param name="movie" value="../common/flash/moreUploadFile.swf" />
			<param name="quality" value="high" />
			<param name="bgcolor" value="#869ca7" />
			<param name="FlashVars" value="str=<%=str %>&fileDesc=<%=fileDesc %>&fileExt=<%=fileExt %>&maximumSize=<%=maximumSize %>&contextPath=<%=contextPath %>&uploadFileNumber=<%=uploadFileNumber %>&Browse={*[core.dynaform.form.browse]*}&Upload={*[Upload]*}&Clear={*[core.dynaform.form.clear]*}&Clear_List={*[core.dynaform.form.clear_list]*}&Cancel={*[Cancel]*}&Delete={*[Delete]*}&File_Name={*[core.dynaform.form.file_name]*}&File_Size={*[core.dynaform.form.file_size]*}&File_Type={*[core.dynaform.form.file_type]*}&File_Status={*[core.dynaform.form.file_status]*}&Finish={*[Finish]*}&Prompt={*[Prompt]*}&Prompt_Message={*[core.dynaform.form.prompt_message]*}&Prompt_Message1={*[core.dynaform.form.prompt_message1]*}&Prompt_Message2={*[core.dynaform.form.prompt_message2]*}&Size={*[Size]*}&limitsizeText={*[cn.myapps.core.dynaform.form.limit_file_size]*}" /> 
			<param name="allowScriptAccess" value="sameDomain" />
			<embed src="../common/flash/moreUploadFile.swf" quality="high" bgcolor="#869ca7"
				width="100%" height="100%" name="moreUploadFile" align="middle"
				play="true" 
				loop="false"
				quality="high"
				allowScriptAccess="sameDomain"
				FlashVars="str=<%=str %>&fileDesc=<%=fileDesc %>&fileExt=<%=fileExt %>&maximumSize=<%=maximumSize %>&contextPath=<%=contextPath %>&uploadFileNumber=<%=uploadFileNumber %>&Browse={*[core.dynaform.form.browse]*}&Upload={*[Upload]*}&Clear={*[core.dynaform.form.clear]*}&Clear_List={*[core.dynaform.form.clear_list]*}&Cancel={*[Cancel]*}&Delete={*[Delete]*}&File_Name={*[core.dynaform.form.file_name]*}&File_Size={*[core.dynaform.form.file_size]*}&File_Type={*[core.dynaform.form.file_type]*}&File_Status={*[core.dynaform.form.file_status]*}&Finish={*[Finish]*}&Prompt={*[Prompt]*}&Prompt_Message={*[core.dynaform.form.prompt_message]*}&Prompt_Message1={*[core.dynaform.form.prompt_message1]*}&Prompt_Message2={*[core.dynaform.form.prompt_message2]*}&Size={*[Size]*}&limitsizeText={*[cn.myapps.core.dynaform.form.limit_file_size]*}"
				type="application/x-shockwave-flash"
				pluginspage="http://www.adobe.com/go/getflashplayer">
			</embed>
	</object>
    </body>
</o:MultiLanguage></html>

