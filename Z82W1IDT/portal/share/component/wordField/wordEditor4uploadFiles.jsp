<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%><html>
<%
WebUser user = (WebUser)request.getSession().getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/javascript">
var OFFICE_CONTROL_OBJ = null;
var path = "";//文件路径
var fieldName = "";//文件名称
var editable = true;//是否可编辑
var userName = '<s:property value="#session.FRONT_USER.name" />';
function init(){
	
	var path = OBPM.dialog.getArgs()['webPath'];
	var readonly = OBPM.dialog.getArgs()['readonly'];
	if(readonly) editable =false;
	if(path.length>0){
		 fieldName = path.substring(path.lastIndexOf("/")+1);
		 document.getElementById("_path").value=path;
	}
	var fileType = path.substring(path.lastIndexOf(".")).toLowerCase();

	if(editable){
		document.getElementById("_toolbar").style.display ="";
	}
	
	try{
	
	if(OFFICE_CONTROL_OBJ == null){
		OFFICE_CONTROL_OBJ = document.getElementById("TANGER_OCX");
		if(fileType==".doc" || fileType == ".docx"){
			OFFICE_CONTROL_OBJ.OpenFromURL(path,!editable,'Word.Document');
		 }else if(fileType==".xls" || fileType == ".xlsx"){
			OFFICE_CONTROL_OBJ.OpenFromURL(path,!editable,'Excel.Sheet');
		 }else if(fileType==".pdf"){
			 OFFICE_CONTROL_OBJ.AddDocTypePlugin(".pdf","PDF.NtkoDocument","4.0.0.0","../wordField/ntkooledocall.cab",51,true);
			OFFICE_CONTROL_OBJ.OpenFromURL(path,!editable,'PDF.NtkoDocument');
		 }
		
		 if(!editable){
			 OFFICE_CONTROL_OBJ.SetReadOnly(true,"");
			 OFFICE_CONTROL_OBJ.FileSave = false;
		 }else{
			 OFFICE_CONTROL_OBJ.SetReadOnly(false,"");
			 OFFICE_CONTROL_OBJ.FileClose = true;
		 }
		OFFICE_CONTROL_OBJ.Menubar = true;
		OFFICE_CONTROL_OBJ.ToolBars = true;
		OFFICE_CONTROL_OBJ.TitleBar = false;
		OFFICE_CONTROL_OBJ.FileNew = false;
		OFFICE_CONTROL_OBJ.FileOpen = false;
		OFFICE_CONTROL_OBJ.FileClose = false;
		OFFICE_CONTROL_OBJ.FileSaveAS = false;
	}
	}catch(e){
	}
}

function doSave(){
	if(OFFICE_CONTROL_OBJ != null){
		OFFICE_CONTROL_OBJ.IsUseUTF8URL=true;
		OFFICE_CONTROL_OBJ.IsUseUTF8Data=true;
	
		if (OFFICE_CONTROL_OBJ && OFFICE_CONTROL_OBJ!=''){
			var action = document.forms[0].action;
			var retValue = OFFICE_CONTROL_OBJ.SaveToURL(action,  //url action
                   "EDITFILE",				//文件输入域名称
                   "", 						//自定义数据－值对
                   fieldName, 	//文件名,从表单输入获取，也可自定义
                   "wordFrom",
                   false);
		}
		alert(OFFICE_CONTROL_OBJ.StatusMessage);
		doReturn();
		}
}
function doReturn() {
        OBPM.dialog.doReturn("");
}
function signtool(){
	var url = '<s:url value="/portal/share/component/wordField/ntkosigntool/signtool.jsp"/>';
	OBPM.dialog.show({
		width: 760,
		height: 480,
		url: url,
		args: {},
		title: '{*[core.usbkey.ekey.signtool.title]*}',
		close: function(result) {
			
		}
	});
}
</script>
</head>
<body onload="init()">
<s:bean name="cn.myapps.util.UsbKeyUtil" id="usbKeyUtil"></s:bean>
<FORM id="wordFrom" method="post" enctype="multipart/form-data"
		action='<s:url action ="uploadword.action"  namespace="/portal/upload"/>'>
<s:hidden name="_path" id="_path" value=""></s:hidden>
<table id="_toolbar" border="0" width="100%" style="display:none;">
		<tr align="left">
			<td width="50%"></td>
			<td width="50%"></td>
			 <td class="line-position2" align="left">
			  <button type="button" class="button-class" onClick="doSave()" id="wordsave">
			<img src="<s:url value="/resource/imgv2/front/act/act_4.gif"/>">{*[Save]*}</button>
			</td>
			<s:if test="#usbKeyUtil.isNtkoUsbKeyEnable()">
			<td class="line-position2" align="left">
			  <button type="button" id="btnUsbkeyCfg" title="{*[core.usbkey.ekey.signtool.title]*}" class="justForHelp button-image" onClick="javascript:signtool()"><img src="<s:url value='/resource/imgnew/act/act_0.gif'/> ">印章管理</button>
			</td>
			</s:if>
			<td class="line-position2" width="50" valign="top" align="left">
			<button type="button" class="button-class" onClick="doReturn();"><img
				src="<s:url value="/resource/imgv2/front/act/act_8.gif"/>">{*[Close]*}</button>
			</td>
		</tr>
	</table>
	<script type="text/javascript" src="../../../script/word/ntkoofficecontrol.js"></script>
	      <div id="statusBar" style="height:20px;width:100%;background-color:#c0c0c0;font-size:12px;"></div>
	      <script language="JScript" for="TANGER_OCX" event="OnDocumentOpened(TANGER_OCX_str,TANGER_OCX_obj)">
	      if(OFFICE_CONTROL_OBJ != null){   
		      OFFICE_CONTROL_OBJ.ActiveDocument.saved=true;//saved属性用来判断文档是否被修改过,文档打开的时候设置成ture,当文档被修改,自动被设置为false,该属性由office提供.
			    //获取文档控件中打开的文档的文档类型
			    fileType = "Word.Document";
			    fileTypeSimple = "wrod";
			    //setFileOpenedOrClosed(true);
	      }
	      </script>
	      <script language="JScript" for=TANGER_OCX event="OnFileCommand(TANGER_OCX_str,TANGER_OCX_obj)">
	        if (TANGER_OCX_str == 3) {
	        	doSave();
			   CancelLastCommand = true;
		    }
	      </script>
</FORM>
</body>
</o:MultiLanguage>
</html>