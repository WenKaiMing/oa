var OFFICE_CONTROL_OBJ;//控件对象
var IsFileOpened;      //控件是否打开文档
var data;
var fileType ;
var fileTypeSimple;
var fullPath;


var contextPath;
var opentype; //打开方式：默认、弹出窗口、弹出层

function doSave(){
	if(OFFICE_CONTROL_OBJ != null){
		//var content = OFFICE_CONTROL_OBJ.activedocument.content; //读取文件的内
	    var retHTML = null;
	    var isAllowSave = true;
	    var _filename = document.getElementById("filename").value;
	    var _fieldname = document.getElementById("fieldname").value;
	    var _docid = document.getElementById("_docid").value;
	    var formname = document.getElementById("formname").value;
	    var applicationid = document.getElementById("application").value; 
	    var versions = document.getElementById("content.versions").value;
	    var rtn;
	    
		OFFICE_CONTROL_OBJ.IsUseUTF8URL=true;
		OFFICE_CONTROL_OBJ.IsUseUTF8Data=true;

	 	if(!opentype){
	 		var id = document.getElementById('wordid').value;
	 		parent.document.getElementById(id).value = document.getElementById('filename').value;
	 	}
		//var characterCount = OFFICE_CONTROL_OBJ.ActiveDocument.Characters.Count; //文档的长度
		//if(characterCount>1){
	 	DWREngine.setAsync(false);
	 	DocumentUtil.compareAndUpdateItemWord(versions, _fieldname, formname, _docid, applicationid, function(arr){
	 		if(arr == 'false'){
	 			isAllowSave = false;
	 			rtn = versions;
	 		} else {
	 			rtn = arr;
	 		}
	 	});
	 	
	 	if(isAllowSave){
	 		if (OFFICE_CONTROL_OBJ && OFFICE_CONTROL_OBJ!=''){
	 			var retValue = OFFICE_CONTROL_OBJ.SaveToURL(document.forms[0].action,  //url action
	                    "EDITFILE",				//文件输入域名称
	                    "", 						//自定义数据－值对
	                    document.forms[0].filename.value, 	//文件名,从表单输入获取，也可自定义
	                    "wordFrom",
	                    false);
	 		}
	 	}else if(!opentype){
	 		rtn = "$$";
	 	}
		//retHTML = OFFICE_CONTROL_OBJ.StatusCode;
	 	
		if(opentype){
			if(isAllowSave){
				alert(OFFICE_CONTROL_OBJ.StatusMessage);
			} else {
				alert("Word文档已被其他用户更新,请重新加载！");
			}
			document.getElementById("content.versions").value = rtn;
			doReturn();
		}

		//}else{
		//	alert("内容不能为空!");
		//}

		//return retHTML;
		return rtn;
	}else{
		alert("不能当前文档保存");
	}
}


function doReturn() {
	var filename = document.getElementById('filename').value ;//+ ';' + version+'';
   // var _fieldname = document.getElementById("fieldname").value;
	var version = document.getElementById("content.versions").value;
	var rtn = filename + ';' + version;
	
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

function ReAssignData(){
	OFFICE_CONTROL_OBJ.Data = data;
}

function Documentinit(isEdit, isFile, path, opentype, displayType){
   OFFICE_CONTROL_OBJ = document.getElementById("TANGER_OCX");
   this.opentype = opentype;
   var wordid;
   var pathvalue;
   var index;
   if(opentype){
	   pathvalue = document.getElementById('filename').value;
   }else{
	  wordid = document.getElementById('wordid').value;
 	  pathvalue = parent.document.getElementById(wordid).value;
   }
   try{
	   if(pathvalue!=''){
	   		try{
	   			if(isFile=='1'){
	   				if(isEdit!=null && isEdit==4){
	   					OFFICE_CONTROL_OBJ.OpenFromURL(path+pathvalue,true,'Word.Document');
	   				}else{
	   					OFFICE_CONTROL_OBJ.OpenFromURL(path+pathvalue,false,'Word.Document');
	   				}
	   			}else{
	   				OFFICE_CONTROL_OBJ.CreateNew('Word.Document');
	   			 }
	   		}catch(e){
	   			OFFICE_CONTROL_OBJ.CreateNew('Word.Document');
	   		}
	   }else{
		   OFFICE_CONTROL_OBJ.CreateNew('Word.Document');
	   }
   }catch(e){
	   var isIE=navigator.userAgent.toUpperCase().indexOf("MSIE")==-1?false:true;
	   if(isIE){
		   alert(e.message);
	   }
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
  		for(i = 1;i <= 3;i++){
  			var list_sgt = document.getElementById(i).getElementsByTagName("li");
  			for(var k in list_sgt){
				list_sgt[k].disabled = "true";
			}
  		}
  		if(document.getElementById('wordsave')){
  			document.getElementById('wordsave').disabled=true;
  		}
  	}
  	data = OFFICE_CONTROL_OBJ.Data;
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
						OFFICE_CONTROL_OBJ.AddSecSignFromURL("ntko",signUrl);
				}catch(error){}
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
				OFFICE_CONTROL_OBJ.AddSecSignFromLocal("ntko","");
			}catch(error){}
		}else{
			alert("不能在该类型文档中使用安全签名印章.");
		}
	}
	}
}

//电子签章手写签名
function addHandSecSign(){
	if(!OFFICE_CONTROL_OBJ.IsReadOnly){
	if(IsFileOpened){
		if(OFFICE_CONTROL_OBJ.doctype==1||OFFICE_CONTROL_OBJ.doctype==2){
			try{
				OFFICE_CONTROL_OBJ.AddSecHandSign("ntko");
			}catch(error){
			}
		}else{
			alert("不能在该类型文档中使用安全签名印章.");
		}
	}
	}
}

//套用红头
function insertRedHeadFromUrl(){
	if(!OFFICE_CONTROL_OBJ.IsReadOnly){
	var headFileURL = document.getElementById("redHeadTemplateFile").value;
	if(headFileURL!=""){
		OFFICE_CONTROL_OBJ.ActiveDocument.Application.Selection.HomeKey(6,0);//光标移动到文档开头
		OFFICE_CONTROL_OBJ.addtemplatefromurl(contextPath + headFileURL);//在光标位置插入红头文档
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
		OFFICE_CONTROL_OBJ.openFromUrl(contextPath + templateFileUrl);
	}else{
		alert("请选择套用模板!");
	}
	}
}

//保留痕迹
function SetReviewMode(boolvalue){
	if(OFFICE_CONTROL_OBJ.doctype==1 && !OFFICE_CONTROL_OBJ.IsReadOnly){
		OFFICE_CONTROL_OBJ.ActiveDocument.TrackRevisions = boolvalue;//设置是否保留痕迹
	}
}

//显示痕迹
function setShowRevisions(boolevalue){
	if(!OFFICE_CONTROL_OBJ.IsReadOnly){
		OFFICE_CONTROL_OBJ.ActiveDocument.ShowRevisions =boolevalue;//设置是否显示痕迹
	}
}

//上传动作
function upload(index){
	if(!OFFICE_CONTROL_OBJ.IsReadOnly){
	var uploadType = new Array("电子签章", "红头文件", "Word模板");
    var url = contextPath + "/portal/share/component/wordField/upload.jsp?type=" + index;
	var retValue = window.showModalDialog(
			fullPath + '/frame.jsp?title=上传' + uploadType[index], url,
			'resizable=no;help=no;font-size:9pt;dialogWidth:'
					+ 420 + 'px;dialogHeight:' + 200 + 'px;status:no;scroll:yes;', '');
	if(retValue==0){
		updateFileList(index);
		//window.location.reload();
	}
	}
}

function updateFileList(index){
	var ids = new Array("secSignFileUrl", "redHeadTemplateFile", "templateFile");
	DocumentUtil.getFileList(index, function(arr){
		jQuery("#"+ids[index]).children().remove();
		jQuery.each(arr,function(i,n){
			jQuery("#"+ids[index]).append("<option value=\""+i+"\">"+n+"</option>");
		});
        //DWRUtil.removeAllOptions(document.getElementById(ids[index]));
        //DWRUtil.addOptions(document.getElementById(ids[index]), arr);
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
	/*window.showModalDialog(
			fullPath + '/frame.jsp?title=印章管理', url,
			'resizable=no;help=no;font-size:9pt;dialogWidth:'
					+ 800 + 'px;dialogHeight:' + 600 + 'px;status:no;scroll:yes;', '');*/
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
    	addRow(path);
    	alert(retStr);
    }else{
    	alert("印章保存到服务器失败!");
    }
}

function addRow(path, retStr){
	DWREngine.setAsync(false);
	DWRUtil.removeAllRows("secList");
    var cellFuncs = [//获取行数据
                     function(item) {return item.filename;},
                     function(item) {return item.lastModified;},
                     function(item) {return item.length;},
                     function(item) {return item.link;}
                     ];
	DocumentUtil.getSecFileList(function (obj){
		for(i=0;i<obj.length;i++){
			var link = "<a href=\"javascript:editesp('" + path + obj[i][0] + "')\">编 辑</a>";
			var item = [{"filename":obj[i][0], "lastModified":obj[i][1], "length":obj[i][2], "link":link}];
			DWRUtil.addRows("secList" , item, cellFuncs, {cellCreator:function(options) { //自定义 td 的创建行为
				var td = document.createElement("td");
				td.align = "center";
				return td;
				}
			});
		}
	});
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
	fileExt=obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase(); 
	AllowExt=".jpg,.gif,.png,.jpeg,.bmp";//允许上传的文件类型 0为无限制 每个扩展名后边要加一个"," 小写字母表示                                                         
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

