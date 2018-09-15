<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<o:MultiLanguage>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<META HTTP-EQUIV="expires" CONTENT="0">
<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />' type="text/css">
<link href="../../css/dialog.css" rel="stylesheet" type="text/css" />

<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/Sequence.js"/>'></script>
<script language=JavaScript src="../../dialog/sequence.js"></script>
<script language=JavaScript src="../../dialog/dialog.js"></script>
<script language=JavaScript src="../../dialog/script.js"></script>
<script src="../../dialog/common/fck_dialog_common.js" type="text/javascript"></script>
<SCRIPT language=JavaScript>
var dialog	= window.parent ;
var oEditor = dialog.InnerDialogLoaded();
// Gets the document DOM
var oDOM = oEditor.FCK.EditorDocument;
var oActiveEl = dialog.Selection.GetSelectedElement() ;

function getImageType(){
	  var value= '';
	  var imageType = document.getElementsByName('filePattern');
	  if(imageType.length>0){
		  for(var i=0;i<imageType.length;i++){
			  if(imageType[i].checked){
			     value = imageType[i].value;
			  }
		  }
	  }
	  return value;
	}

function initImageType(value){
	  var imageType = document.getElementsByName('filePattern');
	  if(imageType.length>0){
		  for(var i=0;i<imageType.length;i++){
			  if(imageType[i].value == value){
				  imageType[i].checked=true;
			  }
		  }
	  }
	}

//检查保存目录路径格式

function checkSavefileCatalog(){
	if(document.getElementById("00").checked==true){
		return true;
		}
	if(document.getElementById("fileCatalog").value==''){
		alert("{*[catalog.notexist]*}");
		return false;
	}
	if(document.getElementById("fileCatalog").value.indexOf("uploads")!=-1||document.getElementById("fileCatalog").value.indexOf("UPLOADS")!=-1){
		alert("{*[CanNotHaveKeyword]*} 'uploads'");
		return false;
	}
	if(document.getElementById("fileCatalog").value.substr(0,1) != "/"){
		alert("{*[catalog.startingit]*}");
		return false;
	}
	if(document.getElementById("fileCatalog").value.length<=1){
		alert("{*[Input]*}{*[Save]*}{*[catalog]*}");
		return false;
	}
	return true;
}

//根据模式的选择显示目录输入框
function ev_onTyepch() {
	//npTD.style.display = 'none';
	npDiv.style.display = 'none';
    if (document.getElementById("01").checked==true){
 		//npTD.style.display = '';
 		npDiv.style.display = '';
 	} 
 	//resize();
}

// 选项卡点击事件
function cardClick(cardID){
	var obj;
	for (var i=1;i<7;i++){
		obj=document.all("card"+i);
		if(obj!=null){
		  obj.style.backgroundColor="#3A6EA5";
		  obj.style.color="#FFFFFF";
		}
	}
	obj=document.all("card"+cardID);
	obj.style.backgroundColor="#FFFFFF";
	obj.style.color="#3A6EA5";

	for (var i=1;i<7;i++){
		obj=document.all("content"+i);
		if(obj!=null)
		  obj.style.display="none";
	}
	obj=document.all("content"+cardID);
	obj.style.display="";
}

function getCreateNamedElement() {
	var className="cn.myapps.core.dynaform.form.ejb.FileManagerField";
	var id = oActiveEl ? oActiveEl.getAttribute('id'): getFieldId();
	//alert(createRelStr());
	
	return CreateNamedElement(
		oEditor, oActiveEl, 'img', {
		src:"plugins/filemanagerfield/img.png",
		classname: className,
		id: id,
		type: "filemanager",
		fieldtype: "VALUE_TYPE_TEXT",
		imgh: HTMLEncode(temp.imgh.value)==""?"100":HTMLEncode(temp.imgh.value),
		imgw: HTMLEncode(temp.imgw.value)==""?"100":HTMLEncode(temp.imgw.value),
		limitsize: HTMLEncode(temp.limitsize.value),
		name: HTMLEncode(temp.name.value),
		limitType: HTMLEncode(temp.limitType.value),
		refreshOnChanged:HTMLEncode(temp.refreshOnChanged.checked+""),
		discript: GetE('discript').value,
		hiddenScript:HTMLEncode(temp.hiddenScript.value),
		hiddenValue:HTMLEncode(temp.hiddenValue.value),//////
		hiddenPrintScript:HTMLEncode(temp.hiddenPrintScript.value),
		printHiddenValue:HTMLEncode(temp.printHiddenValue.value),
		readonlyScript:HTMLEncode(temp.readonlyScript.value),
		filePattern: getImageType(),
		fileCatalog: HTMLEncode(temp.fileCatalog.value)
	});
}

// 初始值
function InitDocument(){
	// 修改状态时取值
	if (oActiveEl){
		if(oActiveEl.getAttribute('name')!=null){
			temp.name.value = HTMLDencode(oActiveEl.getAttribute('name'));
		}

		if(oActiveEl.getAttribute('discript')!=null){
			temp.discript.value = HTMLDencode(oActiveEl.getAttribute('discript'));
		}
		if(oActiveEl.getAttribute('hiddenScript')!=null){
			temp.hiddenScript.value = HTMLDencode(oActiveEl.getAttribute('hiddenScript'));
		}

		if(oActiveEl.getAttribute('hiddenValue')!=null){
			temp.hiddenValue.value = HTMLDencode(oActiveEl.getAttribute('hiddenValue'));
		}

		if(oActiveEl.getAttribute('hiddenPrintScript')!=null){
			temp.hiddenPrintScript.value = HTMLDencode(oActiveEl.getAttribute('hiddenPrintScript'));
		}

		if(oActiveEl.getAttribute('printHiddenValue')!=null){
			temp.printHiddenValue.value = HTMLDencode(oActiveEl.getAttribute('printHiddenValue'));
		}

		if(oActiveEl.getAttribute('readonlyScript')!=null){
			temp.readonlyScript.value = HTMLDencode(oActiveEl.getAttribute('readonlyScript'));
		}

		if(oActiveEl.getAttribute('limitType')!=null){
			temp.limitType.value = HTMLDencode(oActiveEl.getAttribute('limitType'));
		}
		
		if(HTMLDencode(oActiveEl.getAttribute('imgh'))==null || HTMLDencode(oActiveEl.getAttribute('imgh'))=="")
		{
			temp.imgh.value="100";
			}
		else{
			temp.imgh.value = HTMLDencode(oActiveEl.getAttribute('imgh'));
			}
		if(HTMLDencode(oActiveEl.getAttribute('imgw'))==null || HTMLDencode(oActiveEl.getAttribute('imgw'))=="")
		{
			temp.imgw.value="100";
			}
		else{
			temp.imgw.value = HTMLDencode(oActiveEl.getAttribute('imgw'));
			}

		if(oActiveEl.getAttribute('limitsize')!=null){
			temp.limitsize.value = HTMLDencode(oActiveEl.getAttribute('limitsize'));
		}
		
		if(oActiveEl.getAttribute('filePattern')!=null){
			temp.filePattern.checked = initImageType(oActiveEl.getAttribute('filePattern'));
		}
		
		if(oActiveEl.getAttribute('filePattern')=="01"){
			temp.fileCatalog.value = HTMLDencode(oActiveEl.getAttribute('fileCatalog'));
		}

		if(oActiveEl.getAttribute('refreshOnChanged')!=null){
			temp.refreshOnChanged.checked = oActiveEl.getAttribute('refreshOnChanged') == "true";
		}else{
			temp.refreshOnChanged.checked = false;
		}
		
		ev_onTyepch();
	}else{
		var imgw = document.getElementsByName("imgw")[0];
		var imgh = document.getElementsByName("imgh")[0];
		if(imgw.value==null || imgw.value==""){
			imgw.value="100";
		}
		if(imgh.value==null || imgh.value==""){
			imgh.value="100";
		}
	}

	dialog.SetOkButton( true ) ;
	dialog.SetAutoSize( true ) ;
	selectType(temp.limitType.value);
	SelectField( 'name' ) ;
	window.top.toThisHelpPage("application_module_form_info_advance_filemanager");
}

// 点击返回
function Ok(){
	if(!ev_check())
		return false;
	if(!checkSavefileCatalog())
		return false;
	oEditor.FCKUndo.SaveUndoStep() ;
	oActiveEl = getCreateNamedElement();
	return true;
}


//检查内容是否完成正确
function ev_check(){
   if(temp.name.value==''){
 	 alert("{*[page.name.notexist]*}");
	  return false;
   }else if(!isSelectType){
	   alert("{*[please.choose.type]*}");
		  return false;
   }
   return !checkStartChar(temp.name.value);
}

function checkStartChar(value){
	return IsDigit(value,"{*[page.name.startingit]*}");
}

function IsDigit(s,msg){
	var text = s.substring(0,1);
	var patrn=/^[0-9]{1}$/; 
	var patrn1=/^[.,?~!@#$%^&*()+|`=\-/;<>:]{1}$/;
	if(s=="action"){
	   	alert("action为关键字，不能作为字段名！");
	   	return;
   	}else if (patrn.exec(text)){
   	   	
		alert(msg);
		return true;
	}
	if(patrn1.exec(text)){
		alert(msg);
		return true;
	}
	return false;
} 
//检查选择类型，以做出相应的显示
var isSelectType=false;
function selectType(value){
	
	if(value=="image"){
		isSelectType=true;
		document.getElementById("isShowImgInput").style.display="";
	}else if(value=="file"){
		isSelectType=true;
		document.getElementById("isShowImgInput").style.display="none";
	}else{
		isSelectType=false;
		document.getElementById("isShowImgInput").style.display="none";
	}
}
</script>

</HEAD>

<BODY bgcolor=menu onload="InitDocument()">

<form name="temp">
<table border=0 cellpadding=0 cellspacing=0 width="100%"><tr valign=top><td>


<table border=0 cellpadding=3 cellspacing=0 width="100%">
<tr align=center>
	<td class="card" onclick="cardClick(1)" id="card1">{*[Basic]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(4)" id="card4">{*[Hidden_Script]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(5)" id="card5">{*[Hidden_Print_Script]*}</td>
	<td width=2></td>
	<td class="card" onclick="cardClick(6)" id="card6">{*[ReadOnly_Script]*}</td>
	<td width=2></td>
</tr>
<tr>
	<td  align=center valign=middle colspan=10>
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content1">
	<tr><td colspan="2" style="text-align: center;color: #008000;">{*[cn.myapps.core.dynaform.activity.not_recommended]*}</td></tr>
	<tr>
		<td class="commFont commLabel">{*[Name]*}:</td>
		<td><input type=text name="name" onchange="checkStartChar(this.value);" ></td>
	</tr>
	<tr>
	    <td class="commFont commLabel">{*[Type]*}</td>
	    <td>
	        <select onchange="selectType(this.value)" name="limitType">
	          <option value="select">---请选择---</option>
	          <option value="image">图片</option>
	          <option value="file">文件</option>
	        </select>
	   </td>
	</tr>
	<tr id="isShowImgInput" style="display:none">
	    <td class="commFont commLabel">{*[Show]*}{*[Size]*}:</td>
	    <td>{*[Height]*}:
		  <input type="text" name="imgh" id="imgh" onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" size="5" >&nbsp;<b>px</b>
		    &nbsp;
		    &nbsp;
	        {*[Width]*}:
		<input type="text" name="imgw"  id="imgw" onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" size="5" >&nbsp;<b>px</b>
	    </td>
	</tr>
	<tr>
	<td class="commFont commLabel">{*[Limit]*}{*[Size]*}:</td>
		<td>
		<input type="text" name="limitsize"/>KB<font color="red">&nbsp;&nbsp;{*[Default]*} 10M</font>
		</td>
	</tr>
	<tr>
		<td colspan="5" align="center">
			<input type=checkbox name="refreshOnChanged" value="true">{*[cn.myapps.core.dynaform.activity.reflash]*}&nbsp;
		</td>
	</tr>
	<tr>
		<td class="commFont commLabel">{*[cn.myapps.core.dynaform.form.webeditor.label.rootPath]*}:</td>
		<td>
		<input type=radio id="00" name="filePattern" value='00' checked onclick="ev_onTyepch();"/>默认
		<input type=radio id="01" name="filePattern" value='01' onclick="ev_onTyepch();"/>自定义
		</td>
	</tr>
	<tr id ='npDiv' style="display: none">
		<td class="commFont commLabel" >{*[Image]*}{*[catalog]*}:</td>
		<td ><input type=text id="fileCatalog" name="fileCatalog" onblur="checkSavefileCatalog();"></td>
	</tr>
	<tr>
		<td class="commFont commLabel">{*[Description]*}:</td>
		<td><textarea name="discript" style="width:100%"  rows="5"></textarea></td>
	</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content4">
	<tr>
		<td>
			<textarea name="hiddenScript" style="width:96%"  rows="6"></textarea>
			<button type="button" style="border:0px;cursor: pointer;width:16px;padding:0px;" onclick="openIscriptEditor('hiddenScript','{*[Script]*}{*[Editor]*}','{*[Hidden_Script]*}','name','{*[Save]*}{*[Success]*}');">
				<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		</td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.dynaform.form.webeditor.label.hiddenValue]*}：<input id="hiddenValue" type="text" name="hiddenValue" /></td>
	</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=1 class="content" id="content5" >
	<tr>
		<td>
			<textarea name="hiddenPrintScript" style="width:96%"  rows="6"></textarea>
			<button type="button" style="border:0px;cursor: pointer;width:16px;padding:0px;" onclick="openIscriptEditor('hiddenPrintScript','{*[Script]*}{*[Editor]*}','{*[Hidden_Print_Script]*}','name','{*[Save]*}{*[Success]*}');">
				<img alt="Open with IscriptEditor" src="<s:url value='/resource/image/editor.png' />"/>
			</button>
		</td>
	</tr>
	<tr>
		<td>{*[cn.myapps.core.dynaform.form.webeditor.label.printHiddenValue]*}：<input  type="text" name="printHiddenValue" /></td>
	</tr>
	</table>
	<table border=1 cellpadding=3 cellspacing=0 class="content" id="content6">
		<tr>
			<td>
				<textarea name="readonlyScript" style="width:95%" rows="10"></textarea>
				<button type="button" style="border:0px;cursor: pointer;width:16px;padding:0px;" onclick="openIscriptEditor('readonlyScript','{*[Script]*}{*[Editor]*}','{*[ReadOnly_Script]*}','name','{*[Save]*}{*[Success]*}');">
					<img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/>
				</button>
			</td>
		</tr>
	</table>
	</td>
</tr>
</table>


</td><td width=10></td><td>

</td></tr></table>
</form>

<script language=javascript>
cardClick(1);
</script>

</BODY>
</o:MultiLanguage>
</HTML>
                                                                                              
