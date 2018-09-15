var OFFICE_CONTROL_OBJ;//控件对象
var IsFileOpened;      //控件是否打开文档
var data;
var fileType;
var fileTypeSimple;
var fullPath;
var itemValue;

var contextPath;
var opentype; //打开方式：默认、弹出窗口、弹出层

function doSave(){
	if(OFFICE_CONTROL_OBJ != null){
	    var isAllowSave = true;
	    var _filename = document.getElementById("filename").value;
	    var _fieldname = document.getElementById("fieldname").value;
	    var _docid = document.getElementById("_docid").value;
	    var formname = document.getElementById("formname").value;
	    var applicationid = document.getElementById("application").value; 
	    var versions = document.getElementById("content.versions").value;
	    var rtn = versions;
	    
		OFFICE_CONTROL_OBJ.IsUseUTF8URL=true;
		OFFICE_CONTROL_OBJ.IsUseUTF8Data=true;

 		if (OFFICE_CONTROL_OBJ && OFFICE_CONTROL_OBJ!=''){
 			var retValue = OFFICE_CONTROL_OBJ.SaveToURL(document.forms[0].action,  //url action
                    "EDITFILE",				//文件输入域名称
                    "", 						//自定义数据－值对
                    document.forms[0].filename.value, 	//文件名,从表单输入获取，也可自定义
                    "wordFrom",
                    false);
 		}
	 	
		if(opentype){
			if(isAllowSave){
				alert(OFFICE_CONTROL_OBJ.StatusMessage);
			} else {
				alert("Word文档已被其他用户更新,请重新加载！");
			}
			doReturn();
		}

		return rtn;
	}else{
		alert("不能当前文档保存");
	}
}


function doReturn() {
	var filename = document.getElementById('filename').value ;//+ ';' + version+'';
	var version = document.getElementById("content.versions").value;
	var rtn = {itemValue:itemValue};
	
	DWREngine.setAsync(false);
	WordFieldHelper.doExixt(filename);
	DWREngine.setAsync(true);
    if(opentype==3 || opentype=='3'){
        OBPM.dialog.doReturn(rtn);//118
    }else{
	  	   window.returnValue=filename;
	  	   window.close();
	}
    
}

function hiddenDiv(){
	parent.document.getElementById('PopWindows').style.display = 'none';
	parent.document.getElementById('closeWindow_DIV').style.display = 'none';
}

function Documentinit(isEdit, isFile, path, opentype){
   this.opentype = opentype;
   var filename = document.getElementById('filename').value;
   try{
	   if(filename!='' && isFile=='1'){
		   if(isEdit!=null && isEdit==1){
			   if(OFFICE_CONTROL_OBJ.GetOfficeVer() != 100){
				   OFFICE_CONTROL_OBJ.OpenFromURL(path+filename,true,'Word.Document');
			   } else {
				   alert("目前只支持OFFICE软件，请确认。");
			   }
		   }else{
			   if(OFFICE_CONTROL_OBJ.GetOfficeVer() != 100){
				   OFFICE_CONTROL_OBJ.OpenFromURL(path+filename,false,'Word.Document');
			   } else {
				   alert("目前只支持OFFICE软件，请确认。");
			   }
		   }
	   }else{
		   if(OFFICE_CONTROL_OBJ.GetOfficeVer() != 100){
			   OFFICE_CONTROL_OBJ.CreateNew('Word.Document');
		   } else {
			   alert("目前只支持OFFICE软件，请确认。");
		   }
	   }
   }catch(e){
	   console.log("控件加载失败，请联系您的系统管理员。");
	   var content = jQuery("<div></div>");
	   jQuery('<SPAN STYLE="color:red;font-size:large;">加载文档失败，错误信息: ' + e + '</SPAN></br>').appendTo(content);
	   jQuery('<SPAN STYLE="color:red;font-size:large;">若在装载控件中遇到问题，请您试着按以下步骤解决：</br></SPAN>').appendTo(content);
	   jQuery('<SPAN STYLE="color:red;font-size:large;">1.控件不支持64位浏览器，请使用32位的IE浏览器。</br></SPAN>').appendTo(content);
	   jQuery('<SPAN STYLE="color:red;font-size:large;">2.以管理员身份运行您的IE浏览器，再安装控件。</SPAN></br>').appendTo(content);
	   jQuery('<SPAN STYLE="color:red;font-size:large;">3.将当前站点添加进受信任的站点。</SPAN></br>').appendTo(content);
	   jQuery('<SPAN STYLE="color:red;font-size:large;">若以上方法都未能解决您的问题，可以试着联系您的网站管理员。</SPAN></br>').appendTo(content);
	   jQuery("#TANGER_OCX").replaceWith(content);
   }
   
   //OFFICE_CONTROL_OBJ.EnableFileCommand(1) = false;
   OFFICE_CONTROL_OBJ.Menubar = true;
   OFFICE_CONTROL_OBJ.ToolBars = true;
   OFFICE_CONTROL_OBJ.TitleBar = false;
   OFFICE_CONTROL_OBJ.FileNew = false;
   OFFICE_CONTROL_OBJ.FileOpen = false;
   OFFICE_CONTROL_OBJ.FileClose = false;
   OFFICE_CONTROL_OBJ.FileSave = false;
   OFFICE_CONTROL_OBJ.FileSaveAS = false;
  	
  	if(isEdit==1 || isEdit==4){
  		OFFICE_CONTROL_OBJ.SetReadOnly(true,"");
  		for(i = 1; i <= 3; ++i){
  			var list_sgt = document.getElementById(i).getElementsByTagName("li");
  			for(var k in list_sgt){
				list_sgt[k].disabled = "true";
			}
  		}
  		if(document.getElementById('wordsave')){
  			document.getElementById('wordsave').disabled=true;
  		}
  	}
    if(opentype && (opentype == "2" || opentype == "3")){
    	this.itemValue = OBPM.dialog.getArgs().itemValue;
    }else{
 		var wordid = document.getElementById('wordid').value;
 		this.itemValue = parent.document.getElementById(wordid).value;
    }

    getRootPath();
}

/***************************Word新增功能!***************************/
//获取项目名方法
function getRootPath(){
	var strFullPath=window.document.location.href;
	var strPath=window.document.location.pathname;
	if(strPath.indexOf("/")!=0)strPath = "/" + strPath;
	var pos=strFullPath.indexOf(strPath);
	var prePath=strFullPath.substring(0,pos);
	contextPath=strPath.substring(0,strPath.substr(1).indexOf('/')+1);
	fullPath = prePath + contextPath;
}

//设置文件是否打开
function setFileOpenedOrClosed(bool){
	IsFileOpened = bool;
	fileType = OFFICE_CONTROL_OBJ.DocType ;
}

//选择服务器电子签章
function addServerSecSign(){
	if(!OFFICE_CONTROL_OBJ.IsReadOnly){
		var secPath = document.getElementById("secSignFileUrl").value;
		if(secPath != ""){
			var signUrl = contextPath + secPath;
			if(IsFileOpened){
				if(OFFICE_CONTROL_OBJ.doctype==1||OFFICE_CONTROL_OBJ.doctype==2){
					try{
						OFFICE_CONTROL_OBJ.AddSecSignFromURL(userName,signUrl);
					}catch(error){
						alert("加盖印章失败 " + error);
					}
				}else{
					alert("不能在该类型文档中使用安全签名印章.");
				}
			}
		}else{
			alert("请选择印章!");
		}
	}
}

//本地签章
function addLocalSecSign(){
	if(!OFFICE_CONTROL_OBJ.IsReadOnly){
		if(IsFileOpened){
			if(OFFICE_CONTROL_OBJ.doctype==1||OFFICE_CONTROL_OBJ.doctype==2){
				try{
					OFFICE_CONTROL_OBJ.AddSecSignFromLocal(userName,"");
				}catch(error){
					alert("加盖印章失败 " + error);
				}
			}else{
				alert("不能在该类型文档中使用安全签名印章.");
			}
		}
	}
}

//电子签章手写签名
function addHandSecSign(){
	if(!OFFICE_CONTROL_OBJ.IsReadOnly && IsFileOpened){
		if(OFFICE_CONTROL_OBJ.doctype==1||OFFICE_CONTROL_OBJ.doctype==2){
			try{
				OFFICE_CONTROL_OBJ.AddSecHandSign(userName);
			}catch(error){
				alert("手写签名失败！" + error);
			}
		}else{
			alert("不能在该类型文档中使用安全签名印章.");
		}
	}
}

//套用红头
function insertRedHeadFromUrl(){
	if(!OFFICE_CONTROL_OBJ.IsReadOnly){
		var headFileURL = document.getElementById("redHeadTemplateFile").value;
		if(headFileURL!=""){
			if(signature.indexOf("3") < 0){
				if(!confirm("套用红头文件会将所有留痕擦除，确认吗？")){
					return false;
				}
			}
			OFFICE_CONTROL_OBJ.ActiveDocument.Application.Selection.HomeKey(6,0);//光标移动到文档开头
			OFFICE_CONTROL_OBJ.addtemplatefromurl(contextPath + headFileURL);//在光标位置插入红头文档
			if(signature.indexOf("3") < 0){
				acceptAllRevisions(true);
			}
		}else{
			alert("请选择套红模板!");
		}
	}
}

//套红模板
function openTemplateFileFromUrl(){
	if(!OFFICE_CONTROL_OBJ.IsReadOnly){
		var templateFileUrl = document.getElementById("templateFile").value;
		if(templateFileUrl!=""){
			if(signature.indexOf("3") < 0){
				if(!confirm("套用模板文件会将所有内容删除，确认吗？")){
					return false;
				}
			}
			OFFICE_CONTROL_OBJ.ActiveDocument.Content.Delete();//删除所有内容
			OFFICE_CONTROL_OBJ.addtemplatefromurl(contextPath + templateFileUrl);//插入模板
		}else{
			alert("请选择套用模板!");
		}
	}
}

//保留痕迹
function SetReviewMode(boolvalue){
	if(OFFICE_CONTROL_OBJ.doctype==1 && !OFFICE_CONTROL_OBJ.IsReadOnly){
		if(boolvalue) {
			OFFICE_CONTROL_OBJ.ActiveDocument.TrackRevisions = boolvalue;
			OFFICE_CONTROL_OBJ.ActiveDocument.Protect(0, true);
		} else {
			OFFICE_CONTROL_OBJ.SetReadOnly(false);
			OFFICE_CONTROL_OBJ.ActiveDocument.TrackRevisions = boolvalue;
		}
	}
}

//显示痕迹
function setShowRevisions(boolevalue){
	if(!OFFICE_CONTROL_OBJ.IsReadOnly){
		OFFICE_CONTROL_OBJ.ActiveDocument.ShowRevisions =boolevalue;//设置是否显示痕迹
	}
}

//接受所有修订
function acceptAllRevisions(){
	try{
		SetReviewMode(false);
		OFFICE_CONTROL_OBJ.ActiveDocument.AcceptAllRevisions();
		SetReviewMode(true);
	}catch(e){
		alert(e);
	}
}

//上传动作
function upload(index){
	if(!OFFICE_CONTROL_OBJ.IsReadOnly){
		var uploadType = new Array("电子签章", "红头文件", "Word模板");
	    var url = contextPath + "/portal/share/component/wordField/upload.jsp?type=" + index;
	    var sURL = fullPath + '/frame.jsp?title=上传' + uploadType[index];
	    var vArguments = url;
	    var sFeatures = 'resizable=no;help=no;font-size:9pt;dialogWidth:420px;dialogHeight:200px;status:no;scroll:yes;';
		window.showModalDialog(sURL, vArguments, sFeatures);
		updateFileList(index);
	}
}

function updateFileList(index){
	var ids = new Array("secSignFileUrl", "redHeadTemplateFile", "templateFile");
	DocumentUtil.getFileList(index, function(arr){
		jQuery("#"+ids[index]).children().remove();
		jQuery.each(arr,function(i,n){
			jQuery("#"+ids[index]).append("<option value=\""+i+"\">"+n+"</option>");
		});
	});
}

//印章制作
function editSec(){
	if(!OFFICE_CONTROL_OBJ.IsReadOnly){
	    var url = contextPath + "/portal/dynaform/document/editSec.action";
		var retValue = OBPM.dialog.show({
			width : 800,
			height : 600,
			url : url,
			args : {},
			title : "印章管理",
			close : function(){
				updateFileList(0);
			}
		});
	}
}

/***************************印章管理功能!***************************/
//安全电子印章系统函数
var ntkosignctl = null; //初始化印章管理控件对象
var filename = ""; //磁盘印章文件名
var Signname = "";//印章文件名称

//初始化控件对象
function init(){
  ntkosignctl=document.getElementById("ntkosignctl");
  getRootPath();
}

function CreateNewSign() {
    Signname = document.getElementById("SignName").value;
    var Signuser = document.getElementById("SignUser").value;
    var Password1 = document.getElementById("Password1").value;
    var Password2 = document.getElementById("Password2").value;
    var File = document.getElementById("upload");  
    document.getElementById("filename").value = Signname + ".esp";
    
    if ((Signname == '') || (undefined == typeof (Signname))) {
        alert('请输入印章名称');
        return false;
    }

    if ((Signuser == '') || (undefined == typeof (Signuser))) {
        alert('请输入印章使用人');
        return false;
    }

    if ((Password1 == '') || (Password2 == '') || (Password1 != Password2) || (undefined == typeof (Password1))) {
        alert('印章口令不能为空或者不一致');
        return false;
    }

    if ((File.value == '') || (undefined == typeof (File.value))) {
        alert('请选择印章源文件');
        return false;
    }
    //  alert("应该在此处增加代码，判断用户选择的源文件是否是图片文件。");
    if(verifyFile(File)){
        ntkosignctl.CreateNew(Signname, Signuser, Password1, File.value);
        if (0 != ntkosignctl.StatusCode) {
            alert("创建印章错误.");
            return false;
        }
        alert("创建成功 请点击保存到服务器或者本地按钮.");
        return true;
    }else{
        alert("不允许使用该文件类型创建印章!");
    }
}

function savetourl(path) {
    //在后台，可以根据上传文件的inputname是否为"SIGNFILE"来判断
    //是否是印章控件上传的文件
    var Password1 = document.getElementById("Password1").value;
    var Password2 = document.getElementById("Password2").value; 
    filename = document.getElementById("filename").value;
    
    if ((Password1 == '') || (Password2 == '') || (Password1 != Password2) || (undefined == typeof (Password1))) {
        alert('印章口令不能为空或者不一致');
        return false;
    }
    
    ntkosignctl.SignName= document.getElementById("SignName").value;
    ntkosignctl.SignUser = document.getElementById("SignUser").value;
    ntkosignctl.PassWord = Password1;
    //var url = fullPath + "/portal/share/component/wordField/upLoadEsp.jsp?path="+path;
    //SaveToURL方法保存印章文件
    var retStr = ntkosignctl.SaveToURL(document.forms[0].action, "upload", "type=0&isse=true", filename, "secForm");
    //判断是否保存成功，如果成功，刷新窗口
    if(ntkosignctl.StatusCode==0 && retStr.indexOf("成功")!=-1){
    	alert(retStr);
    	location.reload();
    }else{
    	alert("印章保存到服务器失败!");
    }
}

function SaveToLocal() {
    ntkosignctl.SaveToLocal('', true);
    if (0 == ntkosignctl.StatusCode) {
        alert("保存成功!");
    }
    else {
        alert("保存错误.");
    }
    if(window.opener)
    window.opener.location.reload();
}

//编辑印章
function editesp(url) {
	url = contextPath + url;
    ntkosignctl.OpenFromURL(url);
    document.getElementById("filename").value = url.substring(url.lastIndexOf("/") + 1, url.length);
    document.getElementById("SignName").value = ntkosignctl.SignName;
    document.getElementById("SignUser").value = ntkosignctl.SignUser;
    document.getElementById("Password1").value = ntkosignctl.PassWord;
    document.getElementById("Password2").value = ntkosignctl.PassWord;
    //ntkosignctl.height = ntkosignctl.SignHeight;
}

//校验制作签章图片文件类型
function verifyFile(obj){
	var fileExt=obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase(); 
	var AllowExt=".jpg,.gif,.png,.jpeg,.bmp";//允许上传的文件类型 0为无限制 每个扩展名后边要加一个"," 小写字母表示                                                         
	if(AllowExt != 0 && AllowExt.indexOf(fileExt) == -1 ){ //判断文件类型是否允许上传
		obj.value = "";
		return false;
	}else{
		return true;
	}
}

//自定义菜单功能函数
function initCustomMenus()
{
	var myobj = OFFICE_CONTROL_OBJ;	
	
	for(var menuPos=0;menuPos<3;menuPos++)
	{
		myobj.AddCustomMenu2(menuPos,"菜单"+menuPos+"(&"+menuPos+")"); 
		for(var submenuPos=0;submenuPos<10;submenuPos++)
		{
			if(1 ==(submenuPos % 3)) //主菜单增加分隔符。第3个参数是-1是在主菜单增加
			{
				myobj.AddCustomMenuItem2(menuPos,submenuPos,-1,false,"-",true);
			}
			else if(0 == (submenuPos % 2)) //主菜单增加子菜单，第3个参数是-1是在主菜单增加
			{
				myobj.AddCustomMenuItem2(menuPos,submenuPos,-1,true,"子菜单"+menuPos+"-"+submenuPos,false);
				//增加子菜单项目
				for(var subsubmenuPos=0;subsubmenuPos<9;subsubmenuPos++)
				{
					if(0 == (subsubmenuPos % 2))//增加子菜单项目
					{
						myobj.AddCustomMenuItem2(menuPos,submenuPos,subsubmenuPos,false,
							"子菜单项目"+menuPos+"-"+submenuPos+"-"+subsubmenuPos,false,menuPos*100+submenuPos*20+subsubmenuPos);
					}
					else //增加子菜单分隔
					{
						myobj.AddCustomMenuItem2(menuPos,submenuPos,subsubmenuPos,false,
							"-"+subsubmenuPos,true);
					}
					//测试禁用和启用
					if(2 == (subsubmenuPos % 4))
					{
						myobj.EnableCustomMenuItem2(menuPos,submenuPos,subsubmenuPos,false);
					}
				}				
			}
			else //主菜单增加项目，第3个参数是-1是在主菜单增加
			{
				myobj.AddCustomMenuItem2(menuPos,submenuPos,-1,false,"菜单项目"+menuPos+"-"+submenuPos,false,menuPos*100+submenuPos);
			}
			
			//测试禁用和启用
			if(1 == (submenuPos % 4))
			{
				myobj.EnableCustomMenuItem2(menuPos,submenuPos,-1,false);
			}
		}
	}
	myobj.AddCustomMenu2(3, "套红" + "(&" + 3 + ")");
	myobj.AddCustomMenuItem2(3, 0, -1, true, "模板套红", false);
	myobj.AddCustomMenuItem2(3, 0, 0, false, "模板1", false, menuPos*100+submenuPos*20+subsubmenuPos);
	myobj.AddCustomMenu2(4, "电子签章" + "(&" + 4 + ")"); 
	myobj.AddCustomMenu2(5, "模板" + "(&" + 5 + ")"); 
}

/***************************意见栏相关方法接口!***************************/

//更新Word控件字段，
function initOpinion(){
	$("#content-1").find(".comments").find(".comment-list").remove();
	var itemValueObject = JSON.parse(itemValue);
	$.each(itemValueObject.opinion,function(){
		var comment = '<div class="comment-list">'
			  +'<div class="comment-head"><p class="fl">'
	          +'<span class="comment-name"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="comment-dept">行政专员</span></p>'
	          +'<p class="fr comment-date"></p></div>'
	          +'<div class="comment-txt"></div>'
	          +'</div></div>';
		var $comment = $(comment);
		$comment.find(".comment-name").text(this.userName);
		$comment.find(".comment-dept").text(this.departmentName);
		$comment.find(".comment-date").text(formatDate(this.date));
		$comment.find(".comment-txt").text(this.opinion);
		$("#content-1").find(".comments").append($comment);
	});
	//实现意见初始化，意见内容存放在itemValue
	//itemValue;//{"filename":"1473757656435","opinion":[{"date":1473758440877,"opinion":"opinion","userId":"11e4-63ff-5d9df2ad-9f19-57d7b83ae7be","userName":"nice","departmentId":"11e3-866b-820a6aa1-81ef-b131c495402b","departmentName":"行政部"}]}
}

function updateWordField(){
	var _filename = document.getElementById("filename").value;
	var _opinion = $("#content-2").val();
	var contentObj = $.parseJSON(itemValue);
	var newContentObj = {
				"date":new Date().getTime(),
				"opinion":_opinion,//<--此处应为要添加的意见
				"userId":userId,
				"userName":userName,
				"departmentId":departmentId,
				"departmentName":departmentName
	};
	//若当前没有意见内容，则添加进opinion数组
	if(contentObj.opinion){
		contentObj.opinion.push(newContentObj);
	} else {
		contentObj.opinion = eval('('+'[]'+')');
		contentObj.opinion.push(newContentObj);
	}
	var content = JSON.stringify(contentObj);
	var _fieldname = document.getElementById("fieldname").value;
	var formname = document.getElementById("formname").value;
	var _docid = document.getElementById("_docid").value;
	var applicationid = document.getElementById("application").value; 
	DocumentUtil.updateWordField(content, _fieldname, formname, _docid, applicationid, function(rtn){
		if(rtn == "false"){
			alert("请先保存");
		} else {
			itemValue = rtn;
		    if(opentype && opentype == "3"){
		    }else{
		 		var wordid = document.getElementById('wordid').value;
		 		parent.document.getElementById(wordid).value = itemValue;
		    }
			initOpinion();
		}
	});
	$("#content-2").val("");
}
//把时间戳转化为yyy-mmmm-ddd :hh-ss
function formatDate(time){
	var date = new Date(time);
	var year = date.getFullYear();
	var month = date.getMonth()+1;
	var day = date.getDate();
	var hour = date.getHours();
	var minute = date.getMinutes();
	var second = date.getSeconds();
	var newDate = year+'-'+month+'-'+day+'    '+hour + ':'+minute+':'+second;
	return newDate;
}