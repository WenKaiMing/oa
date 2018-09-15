<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ page import="cn.myapps.core.dynaform.form.action.FormHelper"%>
<%
	//session.setAttribute("perc", new Integer(0));
	FormHelper instance = new FormHelper();

	String applicationid = request.getParameter("applicationid");
	String limitNumber = request.getParameter("limitNumber");
	String fileType = request.getParameter("fileType");
	String customizeType = request.getParameter("customizeType");

	//路径
	String pathtemp = request.getParameter("path");
	String path = null;
	if (pathtemp != null) {
		path = pathtemp;
	} else {
		path = "null";
	}

	//文件保存模式
	String fileSaveModetemp = request.getParameter("fileSaveMode");
	String fileSaveMode = null;
	if (fileSaveModetemp != null) {
		fileSaveMode = fileSaveModetemp;
	} else {
		fileSaveMode = "null";
	}

	//空间id
	String fieldid = request.getParameter("fieldid");

	//拓展名格式
	String allowedTypestemp = request.getParameter("allowedTypes");
	String allowedTypes = null;
	if (allowedTypestemp != null) {
		allowedTypes = allowedTypestemp;
	} else {
		allowedTypes = "null";
	}

	//构建路径
	String contextPath = request.getContextPath();
	String str = null;
	str += "path:" + path + ",";
	str += "fileSaveMode:" + fileSaveMode + ",";
	str += "fieldid:" + fieldid + ",";
	str += "allowedTypes:" + allowedTypes + ",";
	str += "applicationid:" + applicationid;
	String urlUpload = contextPath
			+ "/portal/FrontFileAndImageUploadServlet" + "?data=" + str;

	String uploadFileNumber = null;
	if(limitNumber != null){
		uploadFileNumber = limitNumber;
	}else{
		uploadFileNumber = "1";
	}

	//判断上传格式
	String fileDesc;
	String fileExt;

	if (allowedTypes.equals("image") || allowedTypes == "image") {
		fileDesc = "jpg/gif/jpeg/png/bmp";
		fileExt = "*.jpg;*.gif;*.jpeg;*.png;*.bmp";
		uploadFileNumber = "1";
	} else if (fileType != null && fileType != "") {		
		if (fileType.equals("01") || fileType == "01") {
			fileDesc = null;
			fileExt = customizeType.replaceAll(";", ",");
		} else {
			fileDesc = null;
			fileExt = null;
		}
	} else {
		fileDesc = "*";
		fileExt = "*.*";
	}
	
	if(limitNumber == null){
		limitNumber = "1";
	}
	
	

	String maximumSizetemp = request.getParameter("maximumSize");
	String maximumSize = null;
	if (maximumSizetemp != null) {
		maximumSize = maximumSizetemp;
	} else {
		maximumSize = "10240";
	}
%>

<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[Upload_File]*}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="webuploader/webuploader.css">
<link href='<s:url value="/portal/phone/resource/css/weui.min.css"/>' rel="stylesheet">

<style>
#container {
    color: #838383;
    font-size: 12px;
}

#uploader {
	font-family:"Helvetica Neue","Microsoft Yahei","Hiragino Sans GB","PingHei", "Lucida Grande", "Helvetica","Arial","Verdana""sans-serif",;
}

#uploader .queueList {
    margin: 20px;
    border: 3px dashed #e6e6e6;
}
#uploader .queueList.filled {
    padding: 17px;
    margin: 0;
    border: 3px dashed transparent;
}
#uploader .queueList.webuploader-dnd-over {
    border: 3px dashed #999999;
}

#uploader p {margin: 0;}

.element-invisible {
    position: absolute !important;
    clip: rect(1px 1px 1px 1px); /* IE6, IE7 */
    clip: rect(1px,1px,1px,1px);
}

#uploader .placeholder {
    padding-top: 178px;
    text-align: center;
    background: url(images/image.png) center 93px no-repeat;
    color: #cccccc;
    font-size: 18px;
    position: relative;
}

#uploader .placeholder .webuploader-pick {
    font-size: 18px;
    background: #00b7ee;
    border-radius: 3px;
    line-height: 44px;
    padding: 0 30px;
    *width: 120px;
    color: #fff;
    display: inline-block;
    margin: 0 auto 20px auto;
    cursor: pointer;
    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
}

#uploader .placeholder .webuploader-pick-hover {
    background: #00a2d4;
}

#uploader .placeholder .flashTip {
    color: #666666;
    font-size: 12px;
    position: absolute;
    width: 100%;
    text-align: center;
    bottom: 20px;
}
#uploader .placeholder .flashTip a {
    color: #0785d1;
    text-decoration: none;
}
#uploader .placeholder .flashTip a:hover {
    text-decoration: underline;
}

#uploader .filelist {
    list-style: none;
    margin: 0;
    padding: 0;
}

#uploader .filelist:after {
    content: '';
    display: block;
    width: 0;
    height: 0;
    overflow: hidden;
    clear: both;
}

#uploader .filelist li {
    width: 110px;
    height: 110px;
    background: url(images/bg.png) no-repeat;
    text-align: center;
    margin: 0 8px 20px 0;
    position: relative;
    display: inline;
    float: left;
    overflow: hidden;
    font-size: 12px;
}

#uploader .filelist li p.log {
    position: relative;
    top: -45px;
}

#uploader .filelist li p.title {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    overflow: hidden;
    white-space: nowrap;
    text-overflow : ellipsis;
    top: 5px;
    text-indent: 5px;
    text-align: left;
}

#uploader .filelist li p.progress {
    position: absolute;
    width: 100%;
    bottom: 0;
    left: 0;
    height: 8px;
    overflow: hidden;
    z-index: 50;
    margin: 0;
    border-radius: 0;
    background: none;
    -webkit-box-shadow: 0 0 0;
}
#uploader .filelist li p.progress span {
    display: none;
    overflow: hidden;
    width: 0;
    height: 100%;
    background: #1483d8 url(images/progress.png) repeat-x;

    -webit-transition: width 200ms linear;
    -moz-transition: width 200ms linear;
    -o-transition: width 200ms linear;
    -ms-transition: width 200ms linear;
    transition: width 200ms linear;

    -webkit-animation: progressmove 2s linear infinite;
    -moz-animation: progressmove 2s linear infinite;
    -o-animation: progressmove 2s linear infinite;
    -ms-animation: progressmove 2s linear infinite;
    animation: progressmove 2s linear infinite;

    -webkit-transform: translateZ(0);
}

@-webkit-keyframes progressmove {
    0% {
       background-position: 0 0;
    }
    100% {
       background-position: 17px 0;
    }
}
@-moz-keyframes progressmove {
    0% {
       background-position: 0 0;
    }
    100% {
       background-position: 17px 0;
    }
}
@keyframes progressmove {
    0% {
       background-position: 0 0;
    }
    100% {
       background-position: 17px 0;
    }
}

#uploader .filelist li p.imgWrap {
    position: relative;
    z-index: 2;
    line-height: 110px;
    vertical-align: middle;
    overflow: hidden;
    width: 110px;
    height: 110px;

    -webkit-transform-origin: 50% 50%;
    -moz-transform-origin: 50% 50%;
    -o-transform-origin: 50% 50%;
    -ms-transform-origin: 50% 50%;
    transform-origin: 50% 50%;

    -webit-transition: 200ms ease-out;
    -moz-transition: 200ms ease-out;
    -o-transition: 200ms ease-out;
    -ms-transition: 200ms ease-out;
    transition: 200ms ease-out;
}

#uploader .filelist li img {
    width: 100%;
}

#uploader .filelist li p.error {
    background: #f43838;
    color: #fff;
    position: absolute;
    bottom: 0;
    left: 0;
    height: 28px;
    line-height: 28px;
    width: 100%;
    z-index: 100;
}

#uploader .filelist li .success {
    display: block;
    position: absolute;
    left: 0;
    bottom: 0;
    height: 34px;
    width: 100%;
    z-index: 200;
    background: url(images/success.png) no-repeat right bottom;
}

#uploader .filelist div.file-panel {
    position: absolute;
    height: 0;
    filter: progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr='#80000000', endColorstr='#80000000')\0;
    background: rgba( 0, 0, 0, 0.5 );
    width: 100%;
    top: 0;
    left: 0;
    overflow: hidden;
    z-index: 300;
}

#uploader .filelist div.file-panel span {
    width: 24px;
    height: 24px;
    display: inline;
    float: right;
    text-indent: -9999px;
    overflow: hidden;
    background: url(images/icons.png) no-repeat;
    margin: 5px 1px 1px;
    cursor: pointer;
}

#uploader .filelist div.file-panel span.rotateLeft {
    background-position: 0 -24px;
}
#uploader .filelist div.file-panel span.rotateLeft:hover {
    background-position: 0 0;
}

#uploader .filelist div.file-panel span.rotateRight {
    background-position: -24px -24px;
}
#uploader .filelist div.file-panel span.rotateRight:hover {
    background-position: -24px 0;
}

#uploader .filelist div.file-panel span.cancel {
    background-position: -48px -24px;
}
#uploader .filelist div.file-panel span.cancel:hover {
    background-position: -48px 0;
}

#uploader .statusBar {
    height: 63px;
    border-top: 1px solid #dadada;
    padding: 0 20px;
    line-height: 63px;
    vertical-align: middle;
    position: relative;
}

#uploader .statusBar .progress {
    border: 1px solid #1483d8;
    width: 198px;
    background: #fff;
    height: 18px;
    position: relative;
    display: inline-block;
    text-align: center;
    line-height: 20px;
    color: #6dbfff;
    position: relative;
    margin: 0 10px 0 0;
}
#uploader .statusBar .progress span.percentage {
    width: 0;
    height: 100%;
    left: 0;
    top: 0;
    background: #1483d8;
    position: absolute;
}
#uploader .statusBar .progress span.text {
    position: relative;
    z-index: 10;
}

#uploader .statusBar .info {
    display: inline-block;
    font-size: 14px;
    color: #666666;
    padding-bottom: 57px;
}

#uploader .statusBar .btns {
    padding: 10px;
    position: fixed;
    bottom: 0px;
    border-top: solid 1px #c9c9c9;
    left: 0px;
    right: 0px;
	background-color: #fff;
    z-index: 2;
}
#uploader .statusBar .btns .btns-box{
	width: 100%;
	border-spacing: 0;
    border-collapse: collapse;
}
#uploader .statusBar .btns .btns-box td:first-child {
    padding-left: 0px;
}
#uploader .statusBar .btns .btns-box td:last-child {
    padding-right: 0px;
}
#uploader .statusBar .btns .btns-box td {
    padding: 0px 5px;
}


#uploader .statusBar .btns .webuploader-pick,
#uploader .statusBar .btns .uploadBtn,
#uploader .statusBar .btns .btn,
#uploader .statusBar .btns .uploadBtn.state-uploading,
#uploader .statusBar .btns .uploadBtn.state-paused {
    background: #ffffff;
    border: 1px solid #cfcfcf;
    color: #565656;
    border-radius: 3px;
    font-size: 14px;
    line-height: 34px;
    text-align: center;
    padding:0px;
}


#uploader .statusBar .btns .webuploader-pick-hover,
#uploader .statusBar .btns .uploadBtn:hover,
#uploader .statusBar .btns .uploadBtn.state-uploading:hover,
#uploader .statusBar .btns .uploadBtn.state-paused:hover {
    background: #f0f0f0;
}

#uploader .statusBar .btns .uploadBtn {
    background: #00b7ee;
    color: #fff;
    border-color: transparent;
}
#uploader .statusBar .btns .uploadBtn:hover {
    background: #00a2d4;
}

#uploader .statusBar .btns .uploadBtn.disabled {
    pointer-events: none;
    opacity: 0.6;
}
</style>

</head>
<body>

<!-- loadingtoast -->
<div id="loadingToast" class="weui_loading_toast" style="display: none;">
	<div class="weui_mask_transparent"></div>
	<div class="weui_toast">
		<div class="weui_loading">
			<div class="weui_loading_leaf weui_loading_leaf_0"></div>
			<div class="weui_loading_leaf weui_loading_leaf_1"></div>
			<div class="weui_loading_leaf weui_loading_leaf_2"></div>
			<div class="weui_loading_leaf weui_loading_leaf_3"></div>
			<div class="weui_loading_leaf weui_loading_leaf_4"></div>
			<div class="weui_loading_leaf weui_loading_leaf_5"></div>
			<div class="weui_loading_leaf weui_loading_leaf_6"></div>
			<div class="weui_loading_leaf weui_loading_leaf_7"></div>
			<div class="weui_loading_leaf weui_loading_leaf_8"></div>
			<div class="weui_loading_leaf weui_loading_leaf_9"></div>
			<div class="weui_loading_leaf weui_loading_leaf_10"></div>
			<div class="weui_loading_leaf weui_loading_leaf_11"></div>
		</div>
		<p class="weui_toast_content">数据加载中</p>
	</div>
</div>


<div id="uploader" class="wu-example">
    <div class="queueList">
        <div id="dndArea" class="placeholder">
            <div id="filePicker"></div>
        </div>
    </div>
    <div class="statusBar" style="display:none;">
        <div class="progress">
            <span class="text">0%</span>
            <span class="percentage"></span>
        </div><div class="info"></div>
        <div class="btns">
        	<table class="btns-box">
        		<tr>
        			<td><div id="filePicker2"></div></td>
        			<td><div class="uploadBtn">开始上传</div></td>
        			<td style="display:none" ><div class="retry btn btn-default state-ok">重新上传</div></td>
        			<td class="state-ok-td" style="display:none" ><div class="btn btn-default state-ok" onclick="returnResult()">{*[core.dynaform.form.file_confirm]*}</div></td>
        			<td><div class="btn btn-default state-cancel" style="display:none" onclick="cancelResult()">{*[Cancel]*}</div></td>
        		</tr>
	        </table>
        </div>
    </div>
</div>
<script type="text/javascript" src="<s:url value='/portal/phone/resource/js/jquery-1.11.3.min.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/phone/resource/component/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/phone/resource/component/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/phone/resource/component/artDialog/obpm-jquery-bridge.js'/>"></script>
<script type="text/javascript" src="webuploader/webuploader.js"></script>
<script type="text/javascript">

var arg = OBPM.dialog.getArgs();
path =arg['webPath'];

fileMaxText = "{*[core.dynaform.form.file_upload_max]*}";
fileZeroText = "{*[core.dynaform.form.file_size_zero]*}";
fileResidueText = "{*[core.dynaform.form.file_upload_residue]*}";
fileReadyText = "{*[core.dynaform.form.file_ready]*}";
fileLimitText = "{*[cn.myapps.core.dynaform.form.limit_file_size]*}";
fileSuccessText = "{*[core.dynaform.form.upload_success]*}";
fileExceedText =  "{*[core.dynaform.form.file_limit_exceed]*}";
fileMessageText = "{*[core.dynaform.form.prompt_message2]*}";
cancel = "{*[Cancel]*}";
stopped = "{*[Stopped]*}";
unit = "{*[core.email.one]*}";

var webAcceptExtensions  = "<%=fileExt%>";//此处也可以修改成你想限制的类型，比如：*.doc;*.wpd;*.pdf  
var webFileSingleSizeLimit = "<%=maximumSize%>";// 10MB
var file_types_description = "<%=fileDesc%>";
var file_upload_limit = "<%=uploadFileNumber%>";
var file_queue_limit = "<%=uploadFileNumber%>";

if(webAcceptExtensions == 'null'){
	webAcceptExtensions = null;
}

//总上传量
var sunUploadSize = "<%=uploadFileNumber%>";
//已上传数量
var alreadyUpload = 0;
//待上传数
var waitUpload = 0;
//剩余上传数
var residueUpload = "<%=uploadFileNumber%>";
//上传大小
var mamaximumSize = "<%=maximumSize%> * 1024";
//删除文件数
var deleteNumber = 0;

var keys = new Array();
var values = new Array();
var value = "";


if(webAcceptExtensions=="*.*"){
	
}

function showLoadingToast() {
    $('#loadingToast').show();
}

function hideLoadingToast() {
    $('#loadingToast').hide();
}

//文件上传
jQuery(function() {
	showLoadingToast();
	var $ = jQuery,    
    	$wrap = $('#uploader'),
    	$queue = $('<ul class="filelist"></ul>').appendTo( $wrap.find('.queueList') ),
    	$statusBar = $wrap.find('.statusBar'),
    	$info = $statusBar.find('.info'),
    	$upload = $wrap.find('.uploadBtn'),
    	$placeHolder = $wrap.find('.placeholder'),
    	$progress = $statusBar.find('.progress').hide(),

    	fileCount = 0,
    	fileSize = 0,
		ratio = window.devicePixelRatio || 1,
    	thumbnailWidth = 110 * ratio,
    	thumbnailHeight = 110 * ratio,
    	state = 'pedding',
    	percentages = {},

	    supportTransition = (function(){
	        var s = document.createElement('p').style,
	            r = 'transition' in s ||
	                  'WebkitTransition' in s ||
	                  'MozTransition' in s ||
	                  'msTransition' in s ||
	                  'OTransition' in s;
	        s = null;
	        return r;
	    })(),

	    uploader;

	if ( !WebUploader.Uploader.support() ) {
	    alert( 'Web Uploader 不支持您的浏览器！如果你使用的是IE浏览器，请尝试升级 flash 播放器');
	    throw new Error( 'WebUploader does not support the browser you are using.' );
	}
	
	// 实例化
	uploader = WebUploader.create({
	    pick: {
	        id: '#filePicker',
	        label: '点击选择文件'
	    },
	    dnd: '#uploader .queueList',
	    paste: document.body,	    
	    accept : {
			title : 'File Type',
			extensions : webAcceptExtensions,
			mimeTypes : file_types_description
		},
	    // swf文件路径
	    swf: 'webuploader/Uploader.swf',
	
	    disableGlobalDnd: true,
	
	    chunked: true,
	    // server: 'http://webuploader.duapp.com/server/fileupload.php',
	    server: '<%=urlUpload%>',
	    fileNumLimit: sunUploadSize,
	    fileSizeLimit: mamaximumSize * 1024 ,    // 200 M
	    fileSingleSizeLimit: webFileSingleSizeLimit * 1024   // 50 M
	});
	
	// 添加“添加文件”的按钮，
	uploader.addButton({
	    id: '#filePicker2',
	    label: '继续添加'
	});
	
	// 当有文件添加进来时执行，负责view的创建
	function addFile( file ) {
	    var $li = $( '<li id="' + file.id + '">' +
	            '<p class="title">' + file.name + '</p>' +
	            '<p class="imgWrap"></p>'+
	            '<p class="progress"><span></span></p>' +
	            '</li>' ),
	
	        $btns = $('<div class="file-panel">' +
	            '<span class="cancel">删除</span></div>').appendTo( $li ),
	        $prgress = $li.find('p.progress span'),
	        $wrap = $li.find( 'p.imgWrap' ),
	        $info = $('<p class="error"></p>'),
	
	        showError = function( code ) {
	    	
	            switch( code ) {
	                case 'exceed_size':
	                    text = '文件大小超出';
	                    break;
	
	                case 'interrupt':
	                    text = '上传暂停';
	                    break;
	
	                default:
	                    text = '上传失败，请重试';
	                    break;
	            }
	
	            $info.text( text ).appendTo( $li );
	        };
	
	    if ( file.getStatus() === 'invalid' ) {
	        showError( file.statusText );
	    } else {
	        // @todo lazyload
	        $wrap.text( '预览中' );
	        uploader.makeThumb( file, function( error, src ) {
	            if ( error ) {
	                $wrap.text( '不能预览' );
	                return;
	            }
	
	            var img = $('<img src="'+src+'">');
	            $wrap.empty().append( img );
	        }, thumbnailWidth, thumbnailHeight );
	
	        percentages[ file.id ] = [ file.size, 0 ];
	        file.rotation = 0;
	    }
	
	    file.on('statuschange', function( cur, prev ) {
	        if ( prev === 'progress' ) {
	            $prgress.hide().width(0);
	        } else if ( prev === 'queued' ) {
	            $li.off( 'mouseenter mouseleave' );
	            $btns.remove();
	        }
	
	        // 成功
	        if ( cur === 'error' || cur === 'invalid' ) {
	            console.log( file.statusText );
	            showError( file.statusText );
	            percentages[ file.id ][ 1 ] = 1;
	        } else if ( cur === 'interrupt' ) {
	            showError( 'interrupt' );
	        } else if ( cur === 'queued' ) {
	            percentages[ file.id ][ 1 ] = 0;
	        } else if ( cur === 'progress' ) {
	            $info.remove();
	            $prgress.css('display', 'block');
	        } else if ( cur === 'complete' ) {
	            $li.append( '<span class="success"></span>' );
	        }
	        $li.removeClass( 'state-' + prev ).addClass( 'state-' + cur );
	    });
	
	    $li.on( 'mouseenter', function() {
	        $btns.stop().animate({height: 30});
	    });
	
	    $li.on( 'mouseleave', function() {
	        $btns.stop().animate({height: 0});
	    });
	
	    $btns.on( 'click', 'span', function() {
	        var index = $(this).index(),
	            deg;
	
	        switch ( index ) {
	            case 0:
	                uploader.removeFile( file );
	                if($queue.find("li").size() < sunUploadSize){
	        			$("#filePicker2").show();
	        		}
	                return;
	
	            case 1:
	                file.rotation += 90;
	                break;
	
	            case 2:
	                file.rotation -= 90;
	                break;
	        }
	
	        if ( supportTransition ) {
	            deg = 'rotate(' + file.rotation + 'deg)';
	            $wrap.css({
	                '-webkit-transform': deg,
	                '-mos-transform': deg,
	                '-o-transform': deg,
	                'transform': deg
	            });
	        } else {
	            $wrap.css( 'filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation='+ (~~((file.rotation/90)%4 + 4)%4) +')');
	        }
	
	
	    });
	
	    $li.appendTo( $queue );
		
		if($queue.find("li").size()==sunUploadSize){
			$("#filePicker2").parent().width($("#filePicker2").width());
			$("#filePicker2").hide();
			
		}
	}
	
	// 负责view的销毁
	function removeFile( file ) {
	    var $li = $('#'+file.id);
	
	    delete percentages[ file.id ];
	    updateTotalProgress();
	    $li.off().find('.file-panel').off().end().remove();
	}
	
	function updateTotalProgress() {
	    var loaded = 0,
	        total = 0,
	        spans = $progress.children(),
	        percent;
	
	    $.each( percentages, function( k, v ) {
	        total += v[ 0 ];
	        loaded += v[ 0 ] * v[ 1 ];
	    } );
	
	    percent = total ? loaded / total : 0;
	
	    spans.eq( 0 ).text( Math.round( percent * 100 ) + '%' );
	    spans.eq( 1 ).css( 'width', Math.round( percent * 100 ) + '%' );
	    updateStatus();
	}
	
	function updateStatus() {
	    var text = '', stats;
	    if ( state === 'ready' ) {    	
	        text = '选中 ' + fileCount + '/' + sunUploadSize  + ' 个文件，共' +
	                WebUploader.formatSize( fileSize ) + '。';
	    } else if ( state === 'confirm' ) {
	    	debugger
	        stats = uploader.getStats();
	        if ( stats.uploadFailNum ) {
	            text = '已成功上传' + stats.successNum+ '个文件，'+
	                stats.uploadFailNum + '个文件上传失败';
	            
	            $(".btns-box").find(".retry").parent().show();
	            
	        }else{
	        	$(".btns-box").find(".retry").parent().hide();
	        }
	
	    } else {
	        stats = uploader.getStats();
	        text = '共' + fileCount + '个（' +
	                WebUploader.formatSize( fileSize )  +
	                '），已上传' + stats.successNum + '个';
	
	        if ( stats.uploadFailNum ) {
	            text += '，失败' + stats.uploadFailNum + '个';
	        }
	    }
	    
	    $info.html( text );
	    
		//没有已选择但未上传的文件时不要显示“开始上传”按钮
		if ($(".uploadBtn").hasClass("disabled")) {
			$(".uploadBtn").css("display", "none");
		} else {
			$(".uploadBtn").css("display", "");
		}
	}
	
	function setState( val ) {
	    var file, stats;
	
	    if ( val === state ) {
	        return;
	    }
	
	    $upload.removeClass( 'state-' + state );
	    $upload.addClass( 'state-' + val );
	    state = val;
	
	    switch ( state ) {
	        case 'pedding':
	            $placeHolder.removeClass( 'element-invisible' );
	            $queue.parent().removeClass('filled');
	            $queue.hide();
	            //$statusBar.addClass( 'element-invisible' );
	            $statusBar.hide();
	            uploader.refresh();
	            break;
	
	        case 'ready':
	            $placeHolder.addClass( 'element-invisible' );
	            $( '#filePicker2' ).removeClass( 'element-invisible');
	            $queue.parent().addClass('filled');
	            $queue.show();
	            $statusBar.removeClass('element-invisible');
	            $('.state-cancel').show();
	            uploader.refresh();
	            break;
	
	        case 'uploading':
	            $( '#filePicker2' ).addClass( 'element-invisible' );
	            $progress.show();
	            $upload.text( '暂停上传' );
	            break;
	
	        case 'paused':
	            $progress.show();
	            $upload.text( '继续上传' );
	            break;
	
	        case 'confirm':
	            $progress.hide();
	            $('.state-cancel').show();
	            $('.state-ok-td').hide();
	            $upload.text( '开始上传' ).addClass( 'disabled' );
	            stats = uploader.getStats();
	            if ( stats.successNum && !stats.uploadFailNum ) {
	                setState( 'finish' );
	                return;
	            }
	            break;
	        case 'finish':
	            stats = uploader.getStats();
	            if ( stats.successNum ) {
	            	$('.state-cancel').hide();
	            	$('.state-ok-td').show();
	            } else {
	                // 没有成功的图片，重设
	                state = 'done';
	                location.reload();
	            }
	            break;
	    }
	
	    updateStatus();
	}
	
	
	
	uploader.onUploadProgress = function( file, percentage ) {
	    var $li = $('#'+file.id),
	        $percent = $li.find('.progress span');
	
	    $percent.css( 'width', percentage * 100 + '%' );
	    percentages[ file.id ][ 1 ] = percentage;
	    updateTotalProgress();
	};
	
	uploader.onFileQueued = function( file ) {
	    fileCount++;
	    fileSize += file.size;
	
	    if ( fileCount === 1 ) {
	        $placeHolder.addClass( 'element-invisible' );
	        $statusBar.show();
	    }
	
	    addFile( file );
	    setState( 'ready' );
	    updateTotalProgress();
	};
	
	uploader.onFileDequeued = function( file ) {
	    fileCount--;
	    fileSize -= file.size;
	
	    if ( !fileCount ) {
	        setState( 'pedding' );
	    }
	
	    removeFile( file );
	    updateTotalProgress();
	
	};
	
	uploader.on( 'all', function( type, file, response ) {
	    var stats;
	    
	    if(type == "uploadSuccess"){
	    	keys.push(file.id);
	    	values.push(response._raw);
	    }
	
	    switch( type ) {
	        case 'uploadFinished':
	            setState( 'confirm' );
	            break;
	
	        case 'startUpload':
	            setState( 'uploading' );
	            break;
	
	        case 'stopUpload':
	            setState( 'paused' );
	            break;
	
	    }
	});
	
	uploader.onError = function( code ) {
		setTimeout(function(){
			if(code == "Q_EXCEED_NUM_LIMIT"){
				alert( '上传文件数量超出限制' );
			}else if(code == "Q_EXCEED_SIZE_LIMIT"){
				alert( '上传文件总大小超出限制' );
			}else if(code == "Q_TYPE_DENIED"){
				if(webAcceptExtensions != null){
					alert('文件类型(仅支持\''+webAcceptExtensions+'\'格式)或大小错误');
				}else{
					alert('文件类型或大小错误');
				}
			}else if(code == "F_DUPLICATE"){
				alert( '上传文件重复' );
			}else if(code == "F_EXCEED_SIZE"){
				alert( '上传文件大小超出限制' );
			}else{
				alert( 'Error: ' + code );
			}
		},1);
		
	};
	
	$upload.on('click', function() {
	    if ( $(this).hasClass( 'disabled' ) ) {
	        return false;
	    }
	
	    if ( state === 'ready' ) {
	        uploader.upload();
	    } else if ( state === 'paused' ) {
	        uploader.upload();
	    } else if ( state === 'uploading' ) {
	        uploader.stop();
	    }
	});
	
	$(".retry").on( 'click', function() {
	    uploader.retry();
	} );
	
	$info.on( 'click', '.ignore', function() {
	    alert( 'todo' );
	} );
	
	$upload.addClass( 'state-' + state );
	updateTotalProgress();

	$("#dndArea").css("min-height",$(window).height()-46-178);
	hideLoadingToast();
});


//完成操作
function returnResult(){
	value = "";
	for(var obj in values) { // 这个是关键
		if(value != ""){
			value +=";"+ values[obj];
		}else{
			value += values[obj];
		}
	}
	OBPM.dialog.doReturn(decodeURIComponent(value));
}

//取消操作
function cancelResult() {
	OBPM.dialog.doExit();
}
</script>
</body>
</o:MultiLanguage>
</html>

