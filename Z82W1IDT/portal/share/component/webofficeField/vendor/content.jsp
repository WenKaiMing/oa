<%@page import="java.util.Map.Entry"%>
<%@page import="cn.myapps.support.goldgrid.service.WebOfficeHelper"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,javax.servlet.*,javax.servlet.http.*" %>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%

WebUser user = (WebUser)request.getSession().getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
String mRecordID=request.getParameter("RecordID");
String mTemplate=request.getParameter("Template");
String mFileType=request.getParameter("fileType");
String mEditType=request.getParameter("EditType");//TODO
String mShowType=request.getParameter("ShowType");//TODO
String mFileName=request.getParameter("fullPath");
String path = request.getParameter("path");
String saveable = request.getParameter("saveable");
String signature = request.getParameter("signature");
String showTrace = request.getParameter("showTrace");
String addTemplate = request.getParameter("addTemplate");
String addWaterMark = request.getParameter("addWaterMark");


Map<String,String> templateDocuments = new HashMap<String,String>();
if("true".equals(addTemplate)){
	templateDocuments = WebOfficeHelper.listPublicTemplateDocument();
}
%>







<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <title>金格科技-iWebOffice2015智能文档中间件示例程序</title>
 <meta http-equiv="X-UA-Compatible" content="IE=9" />
 <script src="js/jquery-1.4.2.min.js"></script>
 <script src="js/WebOffice.js"></script>
 <script type="text/javascript">
 $(function(){
    var isNotLoad = true;/**公共方法**/	
	$(".tableAll").click(function(){
        if(isNotLoad){
            isNotLoad = false;	 
			  var noneY = $(this).next().css("display");
			  $(".tableAll").next().css("display","none");
			  $(".tableAll").find('td:eq(0)').css({'background-color':'#E6DBEC'});
			  $(".tableAll").find('span:eq(0)').html('+');
				  if( noneY== 'none'){
					  var s = $(this).find('td:eq(0)').html();                
					  $(this).find('td:eq(0)').html(s.replace("+", "-")) ;                              
					  $(this).find('td:eq(0)').css({'background-color':'#FFFFFF'});
		              $(this).next().slideToggle(function(){isNotLoad = true;});
				  }else{
					  isNotLoad = true;
				  }
            }
	});
	var hide = false;	//下拉
	$("#disPlayNone").click(function(){
		 if(hide){
			 $('#showTD').width('204px');
			 $(this).siblings().css("display", "")
			 hide = false;
		 }else{	
			 $('#showTD').width('25px');
			 $(this).siblings().css("display", "none")
			 hide = true;
		 }
	});		
})
</script>
<link rel='stylesheet' type='text/css' href='css/iWebProduct.css' />


<!-- 以下为2015主要方法 -->
<script type="text/javascript">
	var saveable = <%=saveable%>;
	var signature = <%=signature%>;
	var showTrace = <%=showTrace%>;
	var addTemplate = <%=addTemplate%>;
	var addWaterMark = <%=addWaterMark%>;
 	var WebOffice = new WebOffice2015(); //创建WebOffice对象
</script>
<script type="text/javascript">
 	function Load(){
 	  try{
	 		var fs = WebOffice.obj.FileSystem; //WebOffice外面对象名称：
	        var filePath = fs.GetSpecialFolderPath(0x1a) + WebOffice.UP+"<%=path%>";
	        fs.CreateDirectory(filePath);
 	  		WebOffice.WebUrl="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/support/goldgrid/server"%>";           //WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件
 	  		WebOffice.RecordID="<%=mRecordID%>";            //RecordID:本文档记录编号
 			WebOffice.FileName="<%=mFileName%>";            //FileName:文档名称
 			WebOffice.FileType="<%=mFileType%>";            //FileType:文档类型  .doc  .xls
 			WebOffice.UserName="<%=user.getName()%>";       //UserName:操作用户名，痕迹保留需要
		   /*  WebOffice.AppendMenu("1","打开本地文件(&L)");    //多次给文件菜单添加
		    WebOffice.AppendMenu("2","保存本地文件(&S)");
			WebOffice.AppendMenu("3","-");
			WebOffice.AppendMenu("4","打印预览(&C)");
			WebOffice.AppendMenu("5","退出打印预览(&E)");
			WebOffice.AddCustomMenu();  */                      //一次性多次添加包含二次菜单
			WebOffice.Skin('blue');                        //设置皮肤
		    WebOffice.ShowTitleBar(true); //隐藏标题栏
		    WebOffice.ShowMenuBar(false);  //隐藏工具栏菜单
		    WebOffice.ShowCustomToolbar(false); //隐藏手写签批工具栏
		    WebOffice.ShowToolBars(true);  //Office工具栏
		    WebOffice.HookEnabled();
		    WebOffice.SetCaption(); 
		    if(WebOffice.WebOpen()){                             //打开该文档    交互OfficeServer  调出文档OPTION="LOADFILE"
		    	if(!saveable){
		    		document.getElementById("functionBox").display = 'none';
					WebOffice.setEditType("0");//设置文档编辑权限   0 、只读不能复制  1、无痕迹打开 2、有痕迹打开
					WebOffice.ShowToolBars(false);
					WebOffice.SaveEnabled(false);
				}else{
					WebOffice.setEditType("1");
					WebOffice.SaveEnabled(true);
				}
		    	if(showTrace){//留痕，显示痕迹
		    		WebOffice.setEditType("2");
		    		WebOffice.WebShow(true);
		    	}else{
		    		WebOffice.WebShow(false);
		    	}
		    
			    //WebOffice.VBASetUserName(WebOffice.UserName);    //设置用户名
				//getEditVersion();//判断是否是永中office
			    //WebOffice.AddToolbar();//打开文档时显示手写签批工具栏
			    //WebOffice.ShowCustomToolbar(false);//隐藏手写签批工具栏
			    //StatusMsg(WebOffice.Status);
		    }
 	  }catch(e){
 	     alert(e.description);       
 	  }
 	}
	 //作用：保存文档
	function SaveDocument(){
	  if (WebOffice.WebSave()){    //交互OfficeServer的OPTION="SAVEFILE"
		  alert("文档保存成功!");
		  Load();
	     //document.getElementById("iWebOfficeForm").submit();
	     $.ajax({
			type: "get",
			async: false,
			url: "http://127.0.0.1:9588/SendMsg?targetid=111$msg=save",
			jsonp: "hookback",
			dataType: "jsonp",
			success: function(data){
				var jsonobj = eval(data);
				//window.close();
			},
			error: function(a,b,c){
			}
		  });

	     return true;
	  }else{
	     StatusMsg(WebOffice.Status);
	     return false;
	  }
	}
 	
 	
 	//设置页面中的状态值
 	function StatusMsg(mValue){
 	   try{
	   document.getElementById('state').innerHTML = mValue;
	   }catch(e){
	     return false;
	   }
	}
	
	//作用：获取文档Txt正文
	function WebGetWordContent(){
	  try{
	    alert(WebOffice.WebObject.ActiveDocument.Content.Text);
	  }catch(e){alert(e.description);}
	}
	
	//作用：写Word内容
	function WebSetWordContent(){
	  var mText=window.prompt("请输入内容:","测试内容");
	  if (mText==null){
	     return (false);
	  }else{
	     WebOffice.WebObject.ActiveDocument.Application.Selection.Range.Text= mText+"\n";
	  }
	}

	//作用：获取文档页数
	function WebDocumentPageCount(){
	    if (WebOffice.FileType==".doc"||WebOffice.FileType==".docx"){
		var intPageTotal = WebOffice.WebObject.ActiveDocument.Application.ActiveDocument.BuiltInDocumentProperties(14);
		intPageTotal = WebOffice.blnIE()?intPageTotal:intPageTotal.Value();
		alert("文档页总数："+intPageTotal);
	    }
	    if (WebOffice.FileType==".wps"){
			var intPageTotal = WebOffice.WebObject.ActiveDocument.PagesCount();
			alert("文档页总数："+intPageTotal);
	    }
	}
	
	//作用：显示或隐藏痕迹[隐藏痕迹时修改文档没有痕迹保留]  true表示隐藏痕迹  false表示显示痕迹
	function ShowRevision(mValue){
	  if (mValue){
	     WebOffice.WebShow(true);
	     StatusMsg("显示痕迹...");
	  }else{
	     WebOffice.WebShow(false);
	     StatusMsg("隐藏痕迹...");
	  }
	}
	
	//接受文档中全部痕迹
	function WebAcceptAllRevisions(){
	  WebOffice.WebObject.ActiveDocument.Application.ActiveDocument.AcceptAllRevisions();
	  var mCount = WebOffice.WebObject.ActiveDocument.Application.ActiveDocument.Revisions.Count;
	  if(mCount>0){
	    return false;
	  }else{
	    return true;
	  }
	}
	
	//作用：VBA套红
	function WebInsertVBA(){
		alert('开发中...');
		return;
		//画线
		try{
		var object=WebOffice.WebObject.ActiveDocument;
		var myl=object.Shapes.AddLine(100,60,305,60);
		var myl1=object.Shapes.AddLine(326,60,520,60);
	   	var myRange=WebOffice.WebObject.ActiveDocument.Range(0,0);
		myRange.Select();
		var mtext="★";
		WebOffice.WebObject.ActiveDocument.Application.Selection.Range.InsertAfter (mtext+"\n");
	   	var myRange=WebOffice.WebObject.ActiveDocument.Paragraphs(1).Range;
	   	myRange.ParagraphFormat.LineSpacingRule =1.5;
	   	myRange.font.ColorIndex=6;
	   	myRange.ParagraphFormat.Alignment=1;
	   	myRange=WebOffice.WebObject.ActiveDocument.Range(0,0);
		myRange.Select();
		mtext="[2017]xx号";
		WebOffice.WebObject.ActiveDocument.Application.Selection.Range.InsertAfter (mtext+"\n");
		myRange=WebOffice.WebObject.ActiveDocument.Paragraphs(1).Range;
		myRange.ParagraphFormat.LineSpacingRule =1.5;
		myRange.ParagraphFormat.Alignment=1;
		myRange.font.ColorIndex=1;
		mtext="xx单位政务文件";
		WebOffice.WebObject.ActiveDocument.Application.Selection.Range.InsertAfter (mtext+"\n");
		myRange=WebOffice.WebObject.ActiveDocument.Paragraphs(1).Range;
		myRange.ParagraphFormat.LineSpacingRule =1.5;
		myRange.Font.ColorIndex=6;
		myRange.Font.Name="仿宋_GB2312";
		myRange.font.Bold=true;
		myRange.Font.Size=50;
		myRange.ParagraphFormat.Alignment=1;
		WebOffice.WebObject.ActiveDocument.PageSetup.LeftMargin=70;
		WebOffice.WebObject.ActiveDocument.PageSetup.RightMargin=70;
		WebOffice.WebObject.ActiveDocument.PageSetup.TopMargin=70;
		WebOffice.WebObject.ActiveDocument.PageSetup.BottomMargin=70;
		}catch(e){
		 alert(e);
		}
	}

	//作用：设置书签值  vbmName:标签名称，vbmValue:标签值   标签名称注意大小写
	function SetBookmarks(){
		try{
			var mText=window.prompt("请输入书签名称和书签值，以','隔开。","例如：book1,book2");
			var mValue = mText.split(",");
			BookMarkName = mValue[0];
			BookMarkValue = mValue[1];
			WebOffice.WebSetBookmarks(mValue[0],mValue[1]);
			StatusMsg("设置成功");
			return true;
		}catch(e){
			StatusMsg("书签不存在");
			return false;
		}
	}
	//打开书签窗口
	function WebOpenBookMarks(){	
			WebOffice.WebOpenBookMarks();
		 }
	//添加书签
	function WebAddBookMarks(){//书签名称，书签值
		WebOffice.WebAddBookMarks("JK","KingGrid");
	}
	 //定位书签
	function WebFindBookMarks(){
		WebOffice.WebFindBookMarks("JK");
	 }
	 //删除书签
	function WebDelBookMarks(){//书签名称，
	    WebOffice.WebDelBookMarks("JK");//删除书签
	 }
         
	function DelFile(){
	   var mFileName = WebOffice.FilePath+WebOffice.FileName;
       WebOffice.Close(); 
       WebOffice.WebDelFile(mFileName);
	}
	
	//根据当空打开的文档类型保存文档
	function WebOpenLocal(){
	   WebOffice.WebOpenLocal();
	   //WebOffice.WebDelFile(WebOffice.FilePath+WebOffice.FileName);
	   //WebOffice.FileType = WebOffice.WebGetDocSuffix();
	   //WebOffice.FileName = WebOffice.FileName.substring(0,WebOffice.FileName.lastIndexOf("."))+WebOffice.FileType;
	   //document.getElementById('FileType').value = WebOffice.FileType;
	}
	//调用模板
	function WebUseTemplate(fileName){
	    var currFilePath;
	    if(WebOffice.WebAcceptAllRevisions()){//清除正文痕迹的目的是为了避免痕迹状态下出现内容异常问题。
	       currFilePath = WebOffice.getFilePath(); //获取2015特殊路径
	       WebOffice.WebSaveLocalFile(currFilePath+WebOffice.iWebOfficeTempName);//将当前文档保存下来
	       if(WebOffice.DownloadToFile(fileName,currFilePath)){//下载服务器指定的文件
	          WebOffice.OpenLocalFile(currFilePath+fileName);//打开该文件
	          if(!WebOffice.VBAInsertFile("Content",currFilePath+WebOffice.iWebOfficeTempName)){//插入文档
	           StatusMsg("插入文档失败"); 
	           return;
	          }
	          StatusMsg("模板套红成功"); 
	          return; 
	       }
	       StatusMsg("下载文档失败"); 
	       return;
	    }
	    StatusMsg("清除正文痕迹失败，套红中止"); 
	}
	//手写签批
	function HandWriting(){
	 	var penColor=document.getElementById("PenColor").value;
	 	var penWidth=document.getElementById("PenWidth").value;
	 	WebOffice.HandWriting(penColor,penWidth);
	}
	function getEditVersion(){
		var getVersion=WebOffice.getEditVersion(); //获取当前编辑器软件版本
		if (getVersion == "YozoWP.exe" || getVersion == "YozoSS.exe")  //如果是永中office,隐藏手写功能等
		{
		    document.getElementById("handWriting1").style.display='none';
		    document.getElementById("handWriting2").style.display='none';
		    document.getElementById("expendFunction").style.display='none';
		    document.getElementById("enableCopy1").style.display='none';
		    document.getElementById("enableCopy2").style.display='none';
		    document.getElementById("OpenBookMarks").style.display='none';
		    document.getElementById("areaProtect").style.display='none';
		    document.getElementById("areaUnprotect").style.display='none';
		    
		}else if(getVersion == "WINWORD.EXE" || getVersion == "wps.exe") {
			WebOffice.ShowWritingUser(true);
		}
		
	}
	//全屏
	function FullSize(mValue){
		WebOffice.FullSize(mValue);
	}
	//添加区域保护
	function WebAreaProtect(){	
		var mText = window.prompt("请输入书签名称", "KingGrid","");
		if(mText!=null)	WebOffice.WebAreaProtect(mText);
	}
	//取消区域保护
	function WebAreaUnprotect(){
		var mText = window.prompt("请输入书签名称", "KingGrid","");
		if(mText!=null) WebOffice.WebAreaUnprotect(mText);
	}
	//执行宏命令
	function WebRunMacro(){		
		window.open("MacroForm.htm",'','height=250px,width=450px,top=300,left=350,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
		
	}
</script>
<script language="javascript" for="WebOffice2015" event="OnReady()">
   WebOffice.setObj(document.getElementById('WebOffice2015'));//给2015对象赋值
   Load();//避免页面加载完，控件还没有加载情况
</script>
<script language="javascript" for="WebOffice2015" event="OnRightClickedWhenAnnotate()">
   WebOffice.ShowToolBars(true);//停止签批时显示工具栏
   WebOffice.ShowMenuBar(true);//停止签批时显示菜单栏
</script>
<script language="JavaScript" for=WebOffice2015 event="OnFullSizeBefore(bVal)">
    if(bVal == true){
    	var getVersion=WebOffice.getEditVersion();
    	if(getVersion == "WINWORD.EXE" || getVersion == "wps.exe") {
		//	WebOffice.ShowCustomToolbar(true);//显示手写签批工具栏
		}
    }
</script>
<script language="JavaScript" for=WebOffice2015 event="OnFullSizeAfter(bVal)">
    if(bVal == false){
    	WebOffice.ShowCustomToolbar(false);	//隐藏控件的手写签批工具栏
    }
</script>

<script language="javascript" for=WebOffice2015 event="OnRecvStart(nTotleBytes)">
    nSendTotleBytes = nTotleBytes;
    nSendedSumBytes = 0;
</script>
<script language="javascript" for=WebOffice2015 event="OnSendStart(nTotleBytes)">
    nSendTotleBytes = nTotleBytes;
    nSendedSumBytes = 0;
</script>
<script language="javascript" for=WebOffice2015 event="OnSending(nSendedBytes)">
    nSendedSumBytes += nSendedBytes;
</script>

<!--以下是多浏览器的事件方法 -->
<script >
function OnReady(){
 WebOffice.setObj(document.getElementById('WebOffice2015'));//给2015对象赋值
 //Load();//避免页面加载完，控件还没有加载情况
 window.onload = function(){Load();} //IE和谷歌可以直接调用Load方法，火狐要在页面加载完后去调用
}
//停止签批时显示工具栏和菜单栏
function OnRightClickedWhenAnnotate(){
	WebOffice.ShowToolBars(true);
    WebOffice.ShowMenuBar(true);
}
//全屏显示控件的手写签批工具栏
function OnFullSizeBefore(bVal){
	 if(bVal == true){
    	var getVersion=WebOffice.getEditVersion();
    	if(getVersion == "WINWORD.EXE" || getVersion == "wps.exe") {
			//WebOffice.ShowCustomToolbar(true);//显示手写签批工具栏
		}	
    }
}
//退出全屏隐藏控件的手写签批工具栏
function OnFullSizeAfter(bVal){
	if(bVal == false){
    	WebOffice.ShowCustomToolbar(false);	
    }
}
//上传下载回调用事件
function OnSendStart(nTotleBytes){
 nSendTotleBytes = nTotleBytes;nSendedSumBytes = 0;
}
function OnSending(nSendedBytes){
        nSendedSumBytes += nSendedBytes;
}
//异步上传
function OnSendEnd() {
    if(WebOffice.sendMode == "LoadImage"){
    	var httpclient = WebOffice.WebObject.Http;
    	WebOffice.hiddenSaveLocal(httpclient,WebOffice,false,false,WebOffice.ImageName);
     	WebOffice.InsertImageByBookMark();
        WebOffice.ImageName = null;
        WebOffice.BookMark = null;
        StatusMsg("插入图片成功");
        return;
	} 
	StatusMsg("插入图片失败"); 
}
function OnRecvStart(nTotleBytes){
    nSendTotleBytes = nTotleBytes;nSendedSumBytes = 0;
}
function OnRecving(nRecvedBytes){
   nSendedSumBytes += nRecvedBytes;
}
//异步下载
function OnRecvEnd() {
}
function OnCommand(ID, Caption, bCancel){
   switch(ID){
	    case 1:WebOpenLocal();break;//打开本地文件
	    case 2:WebOffice.WebSaveLocal();break;//另存本地文件
		case 4:WebOffice.PrintPreview();break;//启用
		case 5:WebOffice.PrintPreviewExit();WebOffice.ShowField();break;//启用
		case 17:WebOffice.SaveEnabled(true);StatusMsg("启用保存");break;//启用保存
		case 18:WebOffice.SaveEnabled(false);StatusMsg("关闭保存");break;//关闭保存
		case 19:WebOffice.PrintEnabled(true);StatusMsg("启用打印");break;//启用打印
		case 20:WebOffice.PrintEnabled(false);StatusMsg("关闭打印");break;//关闭打印
		case 301:WebOffice.HandWriting("255","4");StatusMsg("手写签批");break;//手写签批
		case 302:WebOffice.StopHandWriting();StatusMsg("停止手写签批");break;//停止手写签批
		case 303:WebOffice.TextWriting();StatusMsg("文字签名");break;//文字签名
		case 304:WebOffice.ShapeWriting();StatusMsg("图形签批");break;//图形签批
		case 305:WebOffice.RemoveLastWriting();StatusMsg("取消上一次签批");break;//取消上一次签批
		case 306:WebOffice.ShowWritingUser(false,WebOffice.UserName);StatusMsg("显示签批用户");break;//显示签批用户
		default:;return;  
  }   
}
     
</script>
<!--End以下是多浏览器的事件方法 -->

<!--End 为2015主要方法 -->


</head>
<body KGBrowser="KGBrowser金格浏览器[演示版];V5.0S0xGAAEAAAAAAAAAEAAAACoBAAAwAQAALAAAAM/zb5ulYQkqzvwZSDl3DSi2EclgeIGPO6pF08gqWqK/FyTQTk2GZfztDWBBRVLOrniHPfrwu+v0r1Dr0gNcltSYdTt5Gk5HUuDDkfgQPTGj5DRmh1ljmiuaQ88WrRmuSzaBrPMb2KjM7ONVRTkPJY1PB4mSPFSwCqxTTnFR7IyHwjqXGScORVHFLhI1wMLX2b/MVRAG5uImtZQ9oVIUfQqfmiapuVvRsw9dVEQemUxceFe1c3roqAijg+7tDl7Tbsj/xJBdHc6vR1SAfUgLhSoMYRHzLpvZCMZ6/GgRixdgbIcuF9j14uZtlmVG3Iew+e/W4ZXe3E6FDUyF5c/7EZnWbbp5iiQ8QZAs/mfrPxSZ1WK2sSFzdMLDrSZgKxVveQCKK8WKoPinlYvNLJzdS5VvjkCKBNm5Bm1VvfSi3ewa" onresize="init()"  style="overflow-y:hidden;overflow-x:hidden" onUnload="WebOffice.WebClose()">
<table id="maintable"  cellspacing='0' cellpadding='0' >
 <!-- showList -->
 <tr><td id="showtr" colspan="2"  valign="top">
  <table id="functionBox" border="0">
  
    <tr>
     <td  id="showTD" width="128px" height="30px"  valign="top">
       <table id="functionTable" cellspacing='4' cellpadding='0'  >    
        <tr  id="disPlayNone"><td height="30px" class="tableFather" >    功能列表  </td></tr>
    
        <tr  class="test"><td valign="middle" class="tableFather">
  		  <table class="tableAll" cellspacing='0' style="height:30px" cellpadding='0'><tr><td class="titleStyle"> 文件　　<span>+</span></td></tr></table>
	       <div id="read0"  class="hideDiv" >
				<table id="readT0"   width="100%" cellspacing='0' cellpadding='0'><!-- 文档阅读功能子菜单 -->
					<!-- <tr ><td class="dot-size"><a href="#" onclick='WebOffice.CreateFile();'>新建文件</a></td></tr> -->
					<!-- <tr ><td class="dot-size"><a href="#" onclick="WebOpenLocal();">打开本地文件</a></td></tr> -->
					<!-- <tr><td class="dot-size"><a href="#" onClick="WebOffice.WebSaveLocal();">另存为</a></td></tr>-->
					<!-- <tr ><td   class="dot-size"><a href="#" onClick="WebOffice.WebPageSetup()">页面设置</a></td></tr>-->
					<!-- <tr><td class="dot-size"><a href="#" onClick="WebOffice.WebOpenPrint()">打印文档</a></td></tr> -->
					<!-- <tr><td class="dot-size"><a href="#" onClick="WebOffice.Close()">关闭文档</a></td></tr> -->
					<tr><td class="dot-size"><a href="#" onClick="SaveDocument();">保存文档</a></td></tr>
					<tr><td class="dot-size"><a href="#"  onClick="WebOffice.WebSavePDF();">保存为PDF </a></td></tr>
				 </table><!--END 文档阅读功能子菜单 -->
		   </div>
		  </td></tr> 
		 <%-- <tr class="" class="test" ><td valign="middle" class="tableFather">
		   <table class="tableAll" cellspacing='0' style="height:30px" cellpadding='0'><tr><td class="titleStyle"> 插入　　<span>+</span></td></tr></table>
	       <div id="read1"  class="hideDiv">
				       <table id="readT1" width="100%" cellspacing='0' cellpadding='0'>
					          <tr  class=""><td class="dot-size" ><a href="#"   onClick="WebOffice.WebInsertImage('image','GoldgridLogo.jpg');">插入远程图片</a></td></tr>
					          <tr  class=""><td class="dot-size"  ><a href="#"   onClick="WebGetWordContent();">取Word内容</a></td></tr>
					          <tr  class=""><td class="dot-size"  ><a href="#"  onClick="WebSetWordContent();">写Word内容</a></td></tr>
					          <tr  class=""><td class="dot-size"><a href="#"    onClick="WebOffice.WebObject.ActiveDocument.ActiveWindow.ActivePane.View.SeekView=9;">插入页眉</a></td></tr>
					          <tr  class=""><td class="dot-size"><a href="#"  onClick="WebOffice.WebPageCode()">插入页码</a></td></tr>
					          <tr  class=""><td class="dot-size"><a href="#"  onclick="WebDocumentPageCount();">文档页数</a></td></tr>	
					          <tr  class=""><td class="dot-size"><a href="#"  onclick="WebInsertVBA();">VBA套红定稿</a></td></tr>
					    </table>
		  </div>
		  </td></tr> --%>
		 <% if("true".equals(showTrace)){ %>
		 <tr  class="" class="test" ><td valign="middle" class="tableFather">
		   <table class="tableAll" cellspacing='0' style="height:30px" cellpadding='0'><tr><td class="titleStyle"> 痕迹　　<span>+</span></td></tr></table>
	       <div id="read1"  class="hideDiv">
				       <table id="readT1" width="100%" cellspacing='0' cellpadding='0'>
					          <tr><td class="dot-size"><a href="#" style="height:30px"  onClick="ShowRevision(true)">显示痕迹</a></td></tr>
					          <tr><td class="dot-size"><a href="#" style="height:30px"  onClick="ShowRevision(false)">隐藏痕迹</a></td></tr>
					          <!-- <tr  class="" style="height:30px"><td class="dot-size"><a href="#" style="height:30px"  onClick="WebAcceptAllRevisions()">清除痕迹</a></td></tr> --> 
					    </table>
		  </div>
		  </td></tr>
		  <%} %>	  
		 <%-- <tr class="test"><td valign="middle" class="tableFather">
		   <table class="tableAll" cellspacing='0'  style="height:30px" cellpadding='0'><tr><td class="titleStyle"> 视图　　<span>+</span></td></tr></table>
	       <div id="read3"  class="hideDiv">
			 <table id="readT3" width="100%" cellspacing='0' cellpadding='0'>
	          <tr><td class="dot-size"><a href="#"  onclick="WebOffice.ShowTitleBar(true)">显示标题栏</a></td></tr>
	          <tr><td class="dot-size"><a href="#"  onclick="WebOffice.ShowTitleBar(false)">隐藏标题栏</a></td></tr>
	          <tr><td class="dot-size"><a href="#"  onclick="WebOffice.ShowMenuBar(true);">显示菜单栏</a></td></tr>
	          <tr><td class="dot-size"><a href="#"  onclick="WebOffice.ShowMenuBar(false);">隐藏菜单栏</a></td></tr>
	          <tr><td class="dot-size"><a href="#"  onclick="WebOffice.ShowToolBars(true)">显示工具栏</a></td></tr>
	          <tr><td class="dot-size"><a href="#"  onclick="WebOffice.ShowToolBars(false)">隐藏工具栏</a></td></tr>
	          <tr><td class="dot-size"><a href="#"  onclick="WebOffice.ShowStatusBar(true)">显示状态栏</a></td></tr>
	          <tr><td class="dot-size"><a href="#"  onclick="WebOffice.ShowStatusBar(false)">隐藏状态栏</a></td></tr>
	          <tr><td class="dot-size"><a href="#"  onclick="FullSize(true)">全屏切换</a></td></tr>
 			 </table>
		  </div>
		  </td>
		  </tr>   --%>
       <%-- <tr class="" class="test"><td valign="middle" class="tableFather">
		   <table class="tableAll" cellspacing='0'  style="height:30px" cellpadding='0'><tr><td class="titleStyle"> 权限　　<span>+</span></td></tr></table>
	       <div id="read4"  class="hideDiv">
			 <table id="readT4" width="100%" cellspacing='0' cellpadding='0'>
				<tr><td class="dot-size"><a href="#"  onclick="WebOffice.WebSetProtect(true,'123')">保护文档</a></td></tr>
				<tr><td class="dot-size"><a href="#" onclick="WebOffice.WebSetProtect(false,'123')">解除保护</a></td></tr>
				<tr id="enableCopy1"><td class="dot-size"><a href="#" onclick="WebOffice.WebEnableCopy(true)">允许拷贝</a></td></tr>
				<tr id="enableCopy2"><td class="dot-size"><a href="#" onclick="WebOffice.WebEnableCopy(false)">禁止拷贝</a></td></tr>
				<tr id="areaProtect"><td class="dot-size"><a href="#" onclick="WebAreaProtect()">添加区域保护</a></td></tr>
				<tr id="areaUnprotect"><td class="dot-size"><a href="#" onclick="WebAreaUnprotect()">取消区域保护</a></td></tr>
 			 </table>
		  </div>
		  </td></tr> --%>
		  <% if("true".equals(addTemplate)){ %>
		   <tr class="" class="test" ><td valign="middle" class="tableFather">
		   <table class="tableAll" cellspacing='0' style="height:30px" cellpadding='0'><tr><td class="titleStyle"> 套红　　<span>+</span></td></tr></table>
	       <div id="read2"  class="hideDiv">
				       <table id="readT2" width="100%" cellspacing='0' cellpadding='0'><!-- 文档制功能子菜单 -->
				       		 <!--  <tr ><td class="dot-size"><a href="#"  onclick="WebInsertVBA();">VBA套红定稿</a></td></tr> -->
				       		 <%for(Iterator<Entry<String, String>> iter = templateDocuments.entrySet().iterator();iter.hasNext();){
				       			Entry<String, String> entry = iter.next();
				       		 %>
				       			 <tr ><td class="dot-size"><a href="#"  onClick="WebUseTemplate('<%=entry.getValue()%>')"><%=entry.getKey()%></a></td></tr>
				       		 <%}%>
					    </table><!--END 文档控制功能子菜单 -->
		  </div>
		  </td></tr>
		  <%} %>	        
 		  <%-- <tr class="" class="test" ><td valign="middle" class="tableFather">
		   <table class="tableAll" cellspacing='0'  style="height:30px" cellpadding='0'><tr><td class="titleStyle"> 书签　　<span>+</span></td></tr></table>
	       <div id="read6"  class="hideDiv">
			 <table id="readT6" width="100%" cellspacing='0' cellpadding='0'>
				<tr><td class="dot-size"><a href="#"  onClick="SetBookmarks();">书签填充</a></td></tr>
				<tr id="OpenBookMarks"><td class="dot-size"><a href="#"  onClick="WebOpenBookMarks();">打开书签窗体</a></td></tr>
				<tr><td class="dot-size"><a href="#"  onClick="WebAddBookMarks();">添加书签</a></td></tr>
 			    <tr><td class="dot-size"><a href="#"  onClick="WebFindBookMarks();">定位书签</a></td></tr>
 			 <!--    <tr><td class="dot-size"><a href="#"  onClick="WebDelBookMarks();">删除书签</a></td></tr> -->
 			 </table>
		  </div>
		  
		  </td></tr> --%>
		  
	    <%-- <tr id="expendFunction" class="" class="test" ><td valign="middle" class="tableFather">
			   <table class="tableAll" cellspacing='0'  style="height:30px" cellpadding='0'><tr><td class="titleStyle"> 扩展功能　　<span>+</span></td></tr></table>
		       <div id="read9"  class="hideDiv">
				 <table id="readT9" width="100%" cellspacing='0' cellpadding='0'>
					<tr><td class="dot-size"><a href="#"  onClick="WebOffice.WebSavePDF();">保存为PDF </a></td></tr>
					<tr><td class="dot-size"><a href="#"  onClick="WebOffice.WebSaveHtml();">保存为本地html</a></td></tr>
	 			 	<tr class=""><td class="dot-size"><a href="#"  onClick="WebRunMacro();">运行宏</a></td></tr>
	 			 </table>
			  </div>
			  </td></tr>  --%>
		  <tr><td>&nbsp;</td></tr>     
        		   	<!-- <tr>
					<td style="border: 0">&nbsp;
					<form id="iWebOfficeForm"   method="post" action="DocumentSave.jsp" >
					    <input type="hidden" name="RecordID" value="1511761398368"/>
					    <input type="hidden" name="Template" value=""/>
					    <input type="hidden" id="FileType" name="FileType" value=".doc"/>
					    <input type="hidden" name="EditType" value="1"/>
					    <input type="hidden" name="HTMLPath" value=""/>
					    <input type="hidden" id="Subject" name="Subject" value="请输入主题"/>
					    <input type="hidden" id="Author" name="Author" value="体验用户10"/> 
					    <input type="hidden" name="FileDate" value=""/>
                   </form></td>
				  </tr> -->
       </table>

     </td>
     <td id="activeBox">        
      <table id="activeTable">
        <tr>
		<td colspan="8" id="activeTd" >&nbsp;<script src="js/iWebOffice2015.js"></script></td>
	    </tr>
	    <tr>
			<td colspan="6" height="10px" align="left" class="statue">状态：<span id="state"></span></td>
			<td colspan="2" align="right"  style="time"></td>
		</tr>
	   </table>
     </td>
    </tr>
  </table>
 </td></tr>
 <!-- end showList -->
</table>
</body> 
</html>
 <script language="javascript">
 
 $(document).ready(function(){
	 //OnReady();
	 self.moveTo(0,0);
	 self.resizeTo(screen.availWidth,screen.availHeight);
	 init();
 })
 
 function init(){
   document.getElementById('WebOffice2015').height =document.documentElement.clientHeight- 30 +"px";
   var functionTableLength = getHeight('showTD')-document.getElementById("functionTable").rows.length*32;
   for(var i =0;i<document.getElementById("functionTable").rows.length;i++){
       try{
        var readivLength = document.getElementById("readT"+i).rows.length*30;
      
	    if(readivLength+30 < functionTableLength){
	      document.getElementById('readT'+i).style.height =  readivLength+ 8 + "px";
	      document.getElementById('read'+i).style.height =  readivLength+ 8 + "px";
	    }else{
	        document.getElementById('readT'+i).style.height =  functionTableLength-50 + "px";
	        document.getElementById('read'+i).style.height =  functionTableLength -50 + "px";
	    }
	   }catch(e){
         continue;
        }
    }
    $("tr").remove(".disabled");
  }
  //获取id的高度
  function  getHeight(id){
    return document.getElementById(id).offsetHeight; 
  }

 </script>