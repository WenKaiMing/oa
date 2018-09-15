<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	request.setCharacterEncoding("UTF-8");
	String fullPath = request.getParameter("path");
	String name = request.getParameter("name");
	String showName = request.getParameter("showName");	
	String fileType = request.getParameter("fileType");
	
	String action = request.getParameter("action");
	String path = fullPath.substring(0,fullPath.lastIndexOf("/")+1);
	
	//是否显示标题
	String isShowDocName =  request.getParameter("isShowDocName");
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
<link type="text/css" href="./css/normalize.css" rel="stylesheet"/>
<link type="text/css" href="./css/preview.css" rel="stylesheet"/>
<link type="text/css" href="<s:url value='/portal/phone/resource/fonts/awesome/font-awesome.min.css'/>" rel="stylesheet"/>
<link type="text/css" href="<s:url value='/portal/share/common/preview/js/viewer/viewer.min.css'/>"  rel="stylesheet"/>

<link rel="stylesheet" href="<s:url value='/portal/phone/resource/component/upload/js/photoswipe/css/demo.css'/>" />
<link rel="stylesheet" href="<s:url value='/portal/phone/resource/component/upload/js/photoswipe/css/iconfont.css'/>" />
<link rel="stylesheet" href="<s:url value='/portal/phone/resource/component/upload/js/photoswipe/css/photoswipe.css'/>" />
<link rel="stylesheet" href="<s:url value='/portal/phone/resource/component/upload/js/photoswipe/css/default-skin/default-skin.css'/>" />
</head>
<body>
	<div class="preview-modal">
		<div class="preview-container">
			<div class="preview-header">
				<span id="imgPreview" class="my-gallery" data-pswp-uid="1" style="display:none;">
            		<a _href="" data-size="670x912" class="figure"></a>
            	</span>
				<span class="preview-header-name">
					<div class="icon-file"></div>
				</span>
				<span class="preview-header-model"><a id="progress" ></a></span>
				<span class="preview-header-action">
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
				</span>
			</div>
			
			
			<div class="preview-body-container">
				<div class="preview-content">
					<iframe class="preview-content-iframe" style="border: 0; width: 100%; height: 100%;" src=""></iframe>
					<div class="preview-content-picture" style="display:none">
						<img src="" />
					</div>
					<div class="preview-content-unknown" style="display:none">
						<div class="preview-content-icon"><i class="fa fa-plane"></i></div>
						<div class="preview-content-name">该文件无法查看</div>
					</div>
				</div>
				<div class="preview-activity">
					<div class="preview-activity-header">文档属性</div>
					<div class="preview-activity-body ">
						<ul class="preview-activity-list">
							<li class="preview-activity-item"></li>
						</ul>
					</div>
					<div class="preview-activity-footer "></div>
				</div>
			</div>
			
			
			
			<!-- Root element of PhotoSwipe. Must have class pswp. -->
			<div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">
			
			    <!-- Background of PhotoSwipe. 
			         It's a separate element as animating opacity is faster than rgba(). -->
			    <div class="pswp__bg"></div>
			
			    <!-- Slides wrapper with overflow:hidden. -->
			    <div class="pswp__scroll-wrap">
			
			        <!-- Container that holds slides. 
			            PhotoSwipe keeps only 3 of them in the DOM to save memory.
			            Don't modify these 3 pswp__item elements, data is added later on. -->
			        <div class="pswp__container">
			            <div class="pswp__item"></div>
			            <div class="pswp__item"></div>
			            <div class="pswp__item"></div>
			        </div>
			
			        <!-- Default (PhotoSwipeUI_Default) interface on top of sliding area. Can be changed. -->
			        <div class="pswp__ui pswp__ui--hidden">
			
			            <div class="pswp__top-bar">
			
			                <!--  Controls are self-explanatory. Order can be changed. -->
			
			                <div class="pswp__counter"></div>
			
			                <button class="pswp__button pswp__button--close" title="Close (Esc)"></button>
			
			                <button class="pswp__button pswp__button--share" title="Share"></button>
			
			                <button class="pswp__button pswp__button--fs" title="Toggle fullscreen"></button>
			
			                <button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>
			
			                <!-- element will get class pswp__preloader--active when preloader is running -->
			                <div class="pswp__preloader">
			                    <div class="pswp__preloader__icn">
			                      <div class="pswp__preloader__cut">
			                        <div class="pswp__preloader__donut"></div>
			                      </div>
			                    </div>
			                </div>
			            </div>
			
			            <div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
			                <div class="pswp__share-tooltip"></div> 
			            </div>
			
			            <button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)">
			            </button>
			
			            <button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)">
			            </button>
			
			            <div class="pswp__caption">
			                <div class="pswp__caption__center"></div>
			            </div>
			
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
<link rel="stylesheet" href="<s:url value='/portal/phone/resource/component/showMessage/sweetalert/sweetalert.css'/>" />
<link rel="stylesheet" href="<s:url value='/portal/phone/resource/component/showMessage/toastr/toastr.css'/>" />
<script src="<s:url value='/portal/phone/resource/component/showMessage/sweetalert/sweetalert.min.js'/>"></script>
<script src="<s:url value='/portal/phone/resource/component/showMessage/toastr/toastr.min.js'/>"></script> 
<script src="<s:url value='/portal/phone/resource/component/showMessage/obpm.showMessage.js'/>"></script>

<script src="<s:url value='/portal/phone/resource/component/upload/js/photoswipe/js/photoswipe.js'/>"></script>
<script src="<s:url value='/portal/phone/resource/component/upload/js/photoswipe/js/photoswipe-ui-default.min.js'/>"></script>
<script src="<s:url value='/portal/phone/resource/component/upload/js/photoswipe/js/photosview.js'/>"></script>

<script type="text/javascript">
/**
 * 禁止iso上界面的缩放（引起Safari崩溃）
 */
function stopZoom(){
    document.addEventListener('touchstart', function (event) {
        if (event.touches.length > 1) {
            event.preventDefault();
        }
    });
    var lastTouchEnd = 0;
    document.addEventListener('touchend', function (event) {
        var now = (new Date()).getTime();
        if (now - lastTouchEnd <= 300) {
            event.preventDefault();
        }
        lastTouchEnd = now;
    }, false);
}

var contextPath = '<%=request.getContextPath()%>';
var serverHost = location.protocol + '//' + location.host + contextPath;
var trayHost = "http://127.0.0.1:9001/tray";
var showName = $.trim(decodeURI('<%=showName%>'));
var fileType = '<%=fileType!=null? fileType : ""%>';
var fullPath = '<%=fullPath!=null? fullPath : ""%>';
var path = '<%=path!=null? path : ""%>';
var name = '<%=name!=null? name : ""%>';
var action = '<%=action!=null? action : ""%>';
var waterMarkSetting = '<%=waterMark%>';
var isOpenCloseBtn = '<%=isOpenCloseBtn%>' == "false"? false:true;
var isShowDocName = '<%=isShowDocName%>' == "false"? false:true;
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
		fileType = name.substr(name.indexOf("."));
	}
	var _fileType;
	switch(fileType.toLowerCase()){
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
			/* _fileType = fileType.substr(1);
			//$container.find("iframe").attr("src",contextPath+fullPath);
			var $picture = $container.find(".preview-content-picture");
			$picture.find("img").attr("src",contextPath+fullPath);
			$picture.viewer({
				inline : true,
				button : false,
				navbar : false,
			});
			$picture.viewer('show');	 */		
			/**
			var prev = '<div id="imgPreview" class="my-gallery" data-pswp-uid="1">'
            	+ '<a _href="" data-size="670x712" class="figure"></a>'
            	+ '</div>';
            	**/
            
            var $prev = $header.find("#imgPreview");
    
            $prev.attr("_href",contextPath+fullPath).show()
            	.find(".figure").attr("_href",contextPath+fullPath).text(showName).trigger("click");
            $headerName.hide();
			$container.hide();
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
	$headerName.append(showName);
	stopZoom();	//禁止iso上界面的缩放（引起Safari崩溃）
});
</script>
</html>
</o:MultiLanguage>
