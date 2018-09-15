<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	request.setCharacterEncoding("UTF-8");
	String fullPath = request.getParameter("fullPath");
	String _path = request.getParameter("path");
	String name = request.getParameter("fileName");
	String showName = request.getParameter("showName");	
	String fileType = request.getParameter("fileType");
	String saveable = request.getParameter("saveable");
	String jsessionid = request.getParameter("jsessionid");
	String id = request.getParameter("id");
	String applicationId = request.getParameter("applicationId");
	String signature = request.getParameter("signature");
	String showTrace = request.getParameter("showTrace");
	String addTemplate = request.getParameter("addTemplate");
	String addWaterMark = request.getParameter("addWaterMark");
	String mHttpUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	String curEditUserId = request.getParameter("curEditUserId");
	String path = fullPath.substring(0,fullPath.lastIndexOf("/")+1);
	
	//是否显示标题
	String isShowDocName =  request.getParameter("isShowDocName");
	//编辑按钮
	String action = request.getParameter("action");
	//是否显示关闭按钮
	String isOpenCloseBtn = request.getParameter("isOpenCloseBtn");
	//水印json
	String waterMark =  request.getParameter("waterMark");
	//是否开启水印
	String openWaterMark =  request.getParameter("openWaterMark");
%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<html>
<head>
<meta name="renderer" content="webkit">
<meta content="always" name="referrer">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta charset="utf-8">
<title></title>
<link rel="shortcut icon" type="images/x-icon" href="<s:url value='../../images/logo/logo32x32.ico'/>" media="screen" />
<link type="text/css" href="<s:url value='/portal/share/common/preview/normalize.css'/>" rel="stylesheet"/>
<link type="text/css" href="<s:url value='/portal/share/common/preview/preview.css'/>" rel="stylesheet"/>
<link type="text/css" href="<s:url value='/portal/share/fonts/awesome/font-awesome.min.css'/>" rel="stylesheet"/>
<link type="text/css" href="<s:url value='/portal/share/common/preview/js/viewer/viewer.min.css'/>"  rel="stylesheet"/>

</head>
<body>
	<div class="preview-modal">
		<div class="preview-container">
			<div class="preview-header">
				<span class="preview-header-name">
					<div class="icon-file"></div>
				</span>
				<span class="preview-header-model"><a id="progress" ></a></span>
				<span class="preview-header-action">
					<span class="preview-action-cell activity-print" style="display:none;">
						<button type="button" class="ant-btn ant-btn-ghost components-btn-nobg">
							<i class="fa fa-print components-icons-print"></i>
						</button>
					</span>
					<span id="activity-edit" class="preview-action-cell activity-edit" style="display:none;">
						<button type="button" class="ant-btn ant-btn-ghost components-btn-nobg">
							<i class="fa fa-pencil components-icons-edit"></i>
						</button>
					</span>
				</span>
			</div>
			<div class="preview-body-container">
				<div class="preview-content">
					<iframe class="preview-content-iframe" scrolling="no" style="border: 0; width: 100%; height: 100%;" src=""></iframe>
					<div class="preview-content-picture" style="display:none">
						<img src="" />
					</div>
					<div class="preview-content-unknown" style="display:none">
						<div class="preview-content-icon"><i class="fa fa-plane"></i></div>
						<div class="preview-content-name">该文件无法查看</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
//消息组件对象
var OBPM = {};
</script>
<script src="<s:url value='/portal/share/common/preview/js/jquery.min.js'/>"></script> 
<script src="<s:url value='/portal/share/common/preview/js/viewer/viewer.min.js'/>"></script>

<script type="text/javascript">
var contextPath = '<%=request.getContextPath()%>';
var mHttpUrl = '<%=mHttpUrl%>';
var serverHost = location.protocol + '//' + location.host + contextPath;
var showName = $.trim(decodeURI('<%=showName%>'));
var fileType = '<%=fileType!=null? fileType : ""%>';
var fullPath = '<%=fullPath!=null? fullPath : ""%>';
var saveable = '<%=saveable%>'
var path = '<%=path!=null? path : ""%>';
var name = '<%=name!=null? name : ""%>';
var action = '<%=action!=null? action : ""%>';
var curEditUserId = '<%=curEditUserId!=null? curEditUserId : ""%>';
var isOpenCloseBtn = '<%=isOpenCloseBtn%>' == "false"? false:true;
var isShowDocName = '<%=isShowDocName%>' == "false"? false:true;
var waterMarkSetting = '<%=waterMark%>';
var openWaterMark = '<%=openWaterMark%>' == 'true' ? true : false;
var previewUrl = "../../../common/preview/viewer.jsp?path="+fullPath+"&fileName="+showName
		+"&openWaterMark="+openWaterMark+"&waterMark="+encodeURI(waterMarkSetting)
		+"&t=<%=System.currentTimeMillis()%>";
$(document).ready(function(){
	$("title").html(showName);
	var $header = $(".preview-header");
	var $headerName = $(".preview-header").find(".preview-header-name");
	var $container = $(".preview-body-container");
	if(!fileType && name){
		fileType = name.substr(name.lastIndexOf(".")).toLowerCase();
	}
	var _fileType;
	switch(fileType){
		case ".doc":
		case ".docx":
		case ".xls":
		case ".xlsx":
		case ".pdf":
		case ".txt":
		case ".rtf":
		case ".et":
		case ".ppt":
		case ".pptx":
		case ".dps":
		case ".pot":
		case ".pps":
		case ".wps":
		case ".html":
		case ".htm":
			_fileType = fileType.substr(1);
			$container.find("iframe").attr("src",previewUrl);
			break;
		case ".jpg":
		case ".jpeg":
		case ".png":
		case ".gif":
		case ".bmp":
			_fileType = fileType.substr(1);
			//$container.find("iframe").attr("src",contextPath+fullPath);
			var $picture = $container.find(".preview-content-picture");
			$picture.find("img").attr("src",contextPath+fullPath);
			$picture.viewer({
				inline : true,
				navbar : false
			});
			$picture.viewer('show');			
			break;	
		default:
			_fileType = "unknown";
			$container.find("iframe").hide();
			$container.find(".preview-content-icon");
			$container.find(".preview-content-name");
			$container.find(".preview-content-unknown").show();
			break;
	}
	
	$headerName.find(">.icon-file").addClass("icon-file-"+_fileType);
	
	//显示标题
	if(isShowDocName){
		$headerName.append(showName);
	}else{
		$headerName.append("word文档");
	}
	//显示关闭按钮
	if(isOpenCloseBtn){
		$(".components-icons-close").on("click",function(){
			window.close();
		})
	}else{
		$(".components-icons-close").parent().hide();
	}
	
	if(saveable=='true'){
		$("#activity-edit").show();
	}
	$("#activity-edit").bind("click",function(){
		var url = contextPath + "/portal/share/component/webofficeField/vendor/content.jsp?jsessionid=<%=jsessionid%>&FileType=.doc&fullPath=<%=fullPath%>";
		url+="&id=<%=id%>";
		url+="&saveable=<%=saveable%>";
		url+="&applicationId=<%=applicationId%>";
		url+="&fileType=<%=fileType%>";
		url+="&path=<%=_path%>";
		url+="&fileName=<%=name%>";
		url+="&signature=<%=signature%>";
		url+="&showTrace=<%=showTrace%>";
		url+="&addTemplate=<%=addTemplate%>";
		url+="&addWaterMark=<%=addWaterMark%>";
		_open(url);
	})
	
});

/**
 * 用金格浏览器打开office在线编辑页面
 * @param aurl
 * 		文件地址
 */
function _open(aurl) {
			$.ajax({
				type: "get",  
				async: false,  
				url: "http://127.0.0.1:9588/LongListen?id=111", 
				jsonp: "hookback",
				dataType: "jsonp",  
				success: function(data){
					//Link(aurl, 4);
					_startBrowser(aurl,1);
				},  
				error: function(){  
					alert('金格浏览器没有安装,请下载安装！');
					window.open(mHttpUrl+contextPath + "/portal/share/component/webofficeField/vendor/KGBrowserV1.0.0.72.msi"); 
				}  
			}); 
			
			// ie 8+, chrome and some other browsers
			var head = document.head || $('head')[0] || document.documentElement;// code from jquery
			var script = $(head).find('script')[0];
			script.onerror = function(evt) 
			{ 
				alert('金格浏览器没有安装,请下载安装！');
				window.open(mHttpUrl+contextPath + "/portal/share/component/webofficeField/vendor/KGBrowserV1.0.0.72.msi"); 
				// do some clean  
				// delete script node  
				if (script.parentNode) 
				{     
					script.parentNode.removeChild(script);
				}
				// delete jsonCallback global function
				var src = script.src || '';  
				var idx = src.indexOf('hookback='); 
				if (idx != -1) 
				{
					var idx2 = src.indexOf('&');
					if (idx2 == -1)
					{     
						idx2 = src.length;
					}      
					var hookback = src.substring(idx + 13, idx2);
					delete window[hookback];
				}
			}; 					
			 
}
  
function _link(url,skin) {
	var  link = "KGBrowser://$link:<%=mHttpUrl%>"+url+"$skin="+skin+"$tabshow=1";   // skin  0灰色 1蓝色 2黄色 3绿色 4红色 
	location.href = link;
	//_connect();
}
function _startBrowser(weburl, skin){
//	var mHttpUrl = "http://localhost:8080";
	urlString = "http://127.0.0.1:9588/StartBrowser?weburl="+mHttpUrl+weburl+"$skin="+skin+"$tabshow=1";

	$.ajax({  
		type: "get",  
		async: false,  
		url: urlString, 
		jsonp: "hookback",
		dataType: "jsonp",  
		success: function(data){ 
			var jsonobj = eval(data);
			_connect();
		},  
		error: function(){  
		}  
	});  
}

/**
 * 与金格浏览器页面通讯使用
 */
function _connect()	{
	$.ajax({
		type: "get",
		async: false,
		url: "http://127.0.0.1:9588/LongListen?id=111", //此代码ip固定，端口号与Edit页面该方法一致，其他固定。
		jsonp: "hookback",
		dataType: "jsonp",
		success: function (data) {
			var jsonobj = eval(data);
			console.log(jsonobj.ret);
			if (jsonobj.ret == "save")
			{ //此判断处理Edit页面Msg传过来的值，判断之后下面做响应处理即可
			//	alert("save");
				setTimeout("location.reload();", 100);
			}
			if (jsonobj.ret == "returnlist")
			{ //此判断处理Edit页面Msg传过来的值，判断之后下面做响应处理即可
			//alert("returnlist");
				setTimeout("location.reload();", 100);
			} 
			else if (jsonobj.ret == "none") 
			{
				_connect();    //这里一定要调用，不可删除
			}
		},
		error: function (a, b, c) {
		}
	});
}
</script>
</html>
</o:MultiLanguage>
