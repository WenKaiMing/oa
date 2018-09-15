<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getParameter("path");
	String dirPath = path.substring(0, path.lastIndexOf("/"));		//上传文件的真实路径	
	String swfPath = dirPath + "/swf";											//swf文件存储路径
	String fileName = path.substring(path.lastIndexOf("/"));
	String fileType = fileName.substring((fileName.lastIndexOf(".") +1));
	
	String pdfFileName = fileName.substring(0,
			fileName.lastIndexOf("."))
			+ ".pdf";
	String swfFileName = fileName.substring(0,
			fileName.lastIndexOf("."))
			+ ".swf";
	//上传文件格式为pdf时swftools不会在swf文件夹下生成对应的pdf文件
	String pdfFullPath = request.getContextPath();
	if("pdf".equals(fileType)){
		pdfFullPath += dirPath;		//上传文件格式为pdf时使用真实上传路径
	}else{
		pdfFullPath += swfPath;	//上传文件格式非pdf时使用swftools转换路径，与swf文件相同
	}
	pdfFullPath += pdfFileName+"?t="+System.currentTimeMillis();
	String swfFullPath = request.getContextPath() + swfPath + swfFileName;
	
	//水印
	String waterMark =  request.getParameter("waterMark");
	
%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<html>
<head>
<title><%=java.net.URLDecoder.decode(request.getParameter("fileName"), "utf-8")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Pragma" content="no-cache"> 
<meta http-equiv="Cache-Control" content="no-cache"> 
<meta http-equiv="Expires" content="0"> 
<script src="<s:url value='/portal/share/common/preview/js/jquery.min.js'/>"></script>
<link rel="stylesheet" href="./js/pdf/web/viewer.css">
<script src="./js/pdf/web/compatibility.js"></script>
<link rel="resource" type="application/l10n" href="./js/pdf/web/locale/locale.properties">
<script src="./js/pdf/web/l10n.js"></script>
<script src="<s:url value='/portal/share/common/preview/js/pdf/build/pdf.js'/>"></script>
    <script src="./js/pdf/web/debugger.js"></script>
    <script src="./js/pdf/web/viewer.js"></script>
    <script src="./js/watermark.js"></script>
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

var path ="<%=request.getContextPath()%>";
DEFAULT_URL="<%=pdfFullPath%>";
var pdfPath = "<%=pdfFullPath%>";

var waterMarkSetting = '<%=waterMark%>';
jQuery(document).ready(function(){
	if (window.applicationCache) {
		$("#showPdfJs").show();
		//PDFJS.getDocument(pdfPath);
		$("#toolbarViewerRight").hide();
	} else {
		$("#showFlash").show();
	}
	//是否显示水印
	if(waterMarkSetting != null && waterMarkSetting != undefined && waterMarkSetting != "" && waterMarkSetting != "null"){ 
		var setting  = JSON.parse(waterMarkSetting);
		if(setting.type != null && setting.type.indexOf("preview")>-1){ //显示水印功能
			var url = path + "/portal/dynaform/document/previewWaterMark.action?waterMarkSetting="+encodeURI(waterMarkSetting);
			$.ajax({
				url : url,
				dataType : "text",
				success : function(result){
					watermark({ watermark_txt: result});
				}
			});
		}
	}
	stopZoom();	//禁止iso上界面的缩放（引起Safari崩溃）
});
</script>
<style>
@media print {
  #printContainer div {
    page-break-after: always;
    page-break-inside: avoid;
  }
}
</style>
<style scoped>
#mozPrintCallback-shim {
  position: fixed;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
  z-index: 9999999;

  display: block;
  text-align: center;
  background-color: rgba(0, 0, 0, 0.5);
}
#mozPrintCallback-shim[hidden] {
  display: none;
}
@media print {
  #mozPrintCallback-shim {
    display: none;
  }
}

#mozPrintCallback-shim .mozPrintCallback-dialog-box {
  display: inline-block;
  margin: -50px auto 0;
  position: relative;
  top: 45%;
  left: 0;
  min-width: 220px;
  max-width: 400px;

  padding: 9px;

  border: 1px solid hsla(0, 0%, 0%, .5);
  border-radius: 2px;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.3);

  background-color: #474747;

  color: hsl(0, 0%, 85%);
  font-size: 16px;
  line-height: 20px;
}
#mozPrintCallback-shim .progress-row {
  clear: both;
  padding: 1em 0;
}
#mozPrintCallback-shim progress {
  width: 100%;
}
#mozPrintCallback-shim .relative-progress {
  clear: both;
  float: right;
}
#mozPrintCallback-shim .progress-actions {
  clear: both;
}
</style>
</head>
<body tabindex="1" class="loadingInProgress" style="margin: 0px;0px;0px;0px;">
	<iframe src="<%=pdfFullPath%>" style="height: 100%;width: 100%;border: 0;"></iframe>
    <div id="printContainer"></div>
	<div id="mozPrintCallback-shim" hidden>
		<div class="mozPrintCallback-dialog-box">
	    <!-- TODO: Localise the following strings -->
	    Preparing document for printing...
			<div class="progress-row">
				<progress value="0" max="100"></progress>
	      		<span class="relative-progress">0%</span>
	    	</div>
	    	<div class="progress-actions">
	      		<input type="button" value="Cancel" class="mozPrintCallback-cancel">
	    	</div>
	  	</div>
	</div>
    <div id="printContainer"></div>
</div>
</body>
</html>
</o:MultiLanguage>