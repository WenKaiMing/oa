<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	request.setCharacterEncoding("UTF-8");
	String fullPath = request.getParameter("path");
	String name = request.getParameter("name");
	String showName = request.getParameter("showName");	
	String fileType = request.getParameter("fileType");
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
					<span class="preview-action-cell activity-edit" style="display:none;">
						<button type="button" class="ant-btn ant-btn-ghost components-btn-nobg">
							<i class="fa fa-pencil components-icons-edit"></i>
						</button>
					</span>
					<span class="preview-action-cell  activity-download">
						<button type="button" href="/obpm/uploads/message/2016/11e6-943f-718ee720-8e52-a55b2b26ef01.jpg" download="123.jpg" class="ant-btn ant-btn-ghost components-btn-nobg">
							<i class="fa fa-download components-icons-download"></i>
						</button>
					</span>
					<span class="preview-action-cell">
						<button type="button" class="ant-btn ant-btn-ghost components-btn-nobg">
							<i class="fa fa-times components-icons-close "></i>
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
<script src="<s:url value='/portal/share/common/preview/js/tray.js'/>"></script>
<link rel="stylesheet" href="<s:url value='/portal/H5/resource/component/showMessage/sweetalert/sweetalert.css'/>" />
<link rel="stylesheet" href="<s:url value='/portal/H5/resource/component/showMessage/toastr/toastr.css'/>" />
<script src="<s:url value='/portal/H5/resource/component/showMessage/sweetalert/sweetalert.min.js'/>"></script>
<script src="<s:url value='/portal/H5/resource/component/showMessage/toastr/toastr.min.js'/>"></script> 
<script src="<s:url value='/portal/H5/resource/component/showMessage/obpm.showMessage.js'/>"></script>

<script type="text/javascript">
var contextPath = '<%=request.getContextPath()%>';
var serverHost = location.protocol + '//' + location.host + contextPath;
var trayHost = "http://127.0.0.1:9001/tray";
var showName = $.trim(decodeURI('<%=showName%>'));
var fileType = '<%=fileType!=null? fileType : ""%>';
var fullPath = '<%=fullPath!=null? fullPath : ""%>';
var path = '<%=path!=null? path : ""%>';
var name = '<%=name!=null? name : ""%>';
var action = '<%=action!=null? action : ""%>';
var curEditUserId = '<%=curEditUserId!=null? curEditUserId : ""%>';
var isOpenCloseBtn = '<%=isOpenCloseBtn%>' == "false"? false:true;
var isShowDocName = '<%=isShowDocName%>' == "false"? false:true;
var waterMarkSetting = '<%=waterMark%>';
var openWaterMark = '<%=openWaterMark%>' == 'true' ? true : false;
var previewUrl = "./viewer.jsp?path="+fullPath+"&fileName="+showName
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
	
	//水印功能，是否开启打印时添加水印
	if(openWaterMark == true && waterMarkSetting != null && waterMarkSetting != undefined && waterMarkSetting != "" && waterMarkSetting != "null"){ 
		var setting  = JSON.parse(waterMarkSetting);
		if(setting.type != null && setting.type.indexOf("print")>-1){ //显示水印功能
			//如果开启打印时添加水印，则显示打印按钮
			$(".activity-print").show().on("click",function(){
				var printUrl = contextPath + "/portal/dynaform/document/filePrintWithWaterMark.action?"
						+ "path=" + fullPath + "&filename=" + showName + "&filepath=" + fullPath
						+ "&waterMarkSetting=" + encodeURI(waterMarkSetting);
				window.open(printUrl);
			});
		}
	}
});
</script>
</html>
</o:MultiLanguage>
