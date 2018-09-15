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
	pdfFullPath += pdfFileName;
	
	String swfFullPath = request.getContextPath() + swfPath + swfFileName;
%>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<html>
<head>
<title><%=java.net.URLDecoder.decode(request.getParameter("fileName"), "utf-8")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<s:url value='/km/disk/css/viewer.css'/>" rel="stylesheet" type="text/css" />
<script src='<s:url value="/km/script/jquery-ui/js/jquery-1.8.3.js" />' type="text/javascript"></script>
<script src='<s:url value="/km/disk/js/compatibility.js"/>'></script>
<script src='<s:url value="/km/disk/js/ui/l10n.js"/>'></script>
<script src='<s:url value="/km/disk/js/ui/util.js"/>'></script>
<script src='<s:url value="/km/disk/js/display/api.js"/>'></script>
<script src='<s:url value="/km/disk/js/display/metadata.js"/>'></script>
<script src='<s:url value="/km/disk/js/display/canvas.js"/>'></script>
<script src='<s:url value="/km/disk/js/display/webgl.js"/>'></script>
<script src='<s:url value="/km/disk/js/display/pattern_helper.js"/>'></script>
<script src='<s:url value="/km/disk/js/display/font_loader.js"/>'></script>
<script src='<s:url value="/km/disk/js/display/annotation_helper.js"/>'></script>
<script>PDFJS.workerSrc ='<s:url value="/km/disk/js/pdfjs/worker_loader.js"/>';</script>
<script src='<s:url value="/km/disk/js/ui/ui_utils.js"/>'></script>
<script src='<s:url value="/km/disk/js/default_preferences.js"/>'></script>
<script src='<s:url value="/km/disk/js/preferences.js"/>'></script>
<script src='<s:url value="/km/disk/js/download_manager.js"/>'></script>
<script src='<s:url value="/km/disk/js/view_history.js"/>'></script>
<script src='<s:url value="/km/disk/js/pdfjs/pdf_link_service.js"/>'></script>
<script src='<s:url value="/km/disk/js/pdfjs/pdf_rendering_queue.js"/>'></script>
<script src='<s:url value="/km/disk/js/pdfjs/pdf_page_view.js"/>'></script>
<script src='<s:url value="/km/disk/js/text_layer_builder.js"/>'></script>
<script src='<s:url value="/km/disk/js/annotations_layer_builder.js"/>'></script>
<script src='<s:url value="/km/disk/js/pdfjs/pdf_viewer.js"/>'></script>
<script src='<s:url value="/km/disk/js/pdfjs/pdf_thumbnail_view.js"/>'></script>
<script src='<s:url value="/km/disk/js/pdfjs/pdf_thumbnail_viewer.js"/>'></script>
<script src='<s:url value="/km/disk/js/pdfjs/pdf_outline_view.js"/>'></script>
<script src='<s:url value="/km/disk/js/pdfjs/pdf_attachment_view.js"/>'></script>
<script src='<s:url value="/km/disk/js/pdfjs/pdf_find_bar.js"/>'></script>
<script src='<s:url value="/km/disk/js/pdfjs/pdf_find_controller.js"/>'></script>
<script src='<s:url value="/km/disk/js/pdfjs/pdf_history.js"/>'></script>
<script src='<s:url value="/km/disk/js/secondary_toolbar.js"/>'></script>
<script src='<s:url value="/km/disk/js/pdfjs/pdf_presentation_mode.js"/>'></script>
<script src='<s:url value="/km/disk/js/grab_to_pan.js"/>'></script>
<script src='<s:url value="/km/disk/js/hand_tool.js"/>'></script>
<script src='<s:url value="/km/disk/js/overlay_manager.js"/>'></script>
<script src='<s:url value="/km/disk/js/password_prompt.js"/>'></script>
<script src='<s:url value="/km/disk/js/pdfjs/pdf_document_properties.js"/>'></script>
<script src='<s:url value="/km/disk/js/debugger.js"/>'></script>
<script src='<s:url value="/km/disk/js/viewer.js"/>'></script>
<script type="text/javascript">
DEFAULT_URL="<%=pdfFullPath%>";
jQuery(document).ready(function(){
	if (window.applicationCache) {
		$("#showPdfJs").show();
	} else {
		$("#showFlash").show(); 
	}
});
</script>
</head>
<body tabindex="1" class="loadingInProgress" style="margin: 0px;0px;0px;0px;">
	<div id="showFlash" style="width: 100%;height: 100%;display: none;">
			<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
				id="MyappsFlex" width="100%" height="100%"
				codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
				<param name="movie" value="<s:url value='/km/disk/flexpaper.swf'/>" />
				<param name="wmode" value="transparent" />
				<param name="quality" value="high" />
				<param name="bgcolor" value="#869ca7" />
				<param name="allowFullScreen" value="true" />
				<param name="allowScriptAccess" value="sameDomain" />
				<param name="FlashVars" value="SwfFile=<%=swfFullPath %>&StartAtPage="/>
				<embed src="<s:url value='/km/disk/flexpaper.swf'/>" quality="high" bgcolor="#869ca7" flashVars="SwfFile=<%=swfFullPath %>&StartAtPage="
					width="100%" height="100%" name="DataMap" align="middle"
					play="true"
					loop="false"
					quality="high"
					wmode="transparent"
					allowFullScreen="true"
					allowScriptAccess="sameDomain"
					type="application/x-shockwave-flash"
					pluginspage="http://www.adobe.com/go/getflashplayer">
				</embed>
			</object>
	</div>
	<div id="showPdfJs" style="display: none;">
	<div id="outerContainer">

      <div id="sidebarContainer">
        <div id="toolbarSidebar">
          <div class="splitToolbarButton toggled">
            <button id="viewThumbnail" class="toolbarButton group toggled" title="显示缩略图" tabindex="2" data-l10n-id="thumbs">
               <span data-l10n-id="thumbs_label">Thumbnails</span>
            </button>
            <button id="viewOutline" class="toolbarButton group" title="显示文档大纲" tabindex="3" data-l10n-id="outline">
               <span data-l10n-id="outline_label">Document Outline</span>
            </button>
            <button id="viewAttachments" class="toolbarButton group" title="显示附件" tabindex="4" data-l10n-id="attachments">
               <span data-l10n-id="attachments_label">Attachments</span>
            </button>
          </div>
        </div>
        <div id="sidebarContent">
          <div id="thumbnailView">
          </div>
          <div id="outlineView" class="hidden">
          </div>
          <div id="attachmentsView" class="hidden">
          </div>
        </div>
      </div>  <!-- sidebarContainer -->

      <div id="mainContainer">
        <div class="findbar hidden doorHanger hiddenSmallView" id="findbar">
          <label for="findInput" class="toolbarLabel" data-l10n-id="find_label">Find:</label>
          <input id="findInput" class="toolbarField" tabindex="91">
          <div class="splitToolbarButton">
            <button class="toolbarButton findPrevious" title="" id="findPrevious" tabindex="92" data-l10n-id="find_previous">
              <span data-l10n-id="find_previous_label">Previous</span>
            </button>
            <div class="splitToolbarButtonSeparator"></div>
            <button class="toolbarButton findNext" title="" id="findNext" tabindex="93" data-l10n-id="find_next">
              <span data-l10n-id="find_next_label">Next</span>
            </button>
          </div>
          <input type="checkbox" id="findHighlightAll" class="toolbarField">
          <label for="findHighlightAll" class="toolbarLabel" tabindex="94" data-l10n-id="find_highlight">Highlight all</label>
          <input type="checkbox" id="findMatchCase" class="toolbarField">
          <label for="findMatchCase" class="toolbarLabel" tabindex="95" data-l10n-id="find_match_case_label">Match case</label>
          <span id="findMsg" class="toolbarLabel"></span>
        </div>  <!-- findbar -->

        <div id="secondaryToolbar" class="secondaryToolbar hidden doorHangerRight">
          <div id="secondaryToolbarButtonContainer">
            <button id="secondaryPresentationMode" class="secondaryToolbarButton presentationMode visibleLargeView" title="全屏显示" tabindex="51" data-l10n-id="presentation_mode">
              <span data-l10n-id="presentation_mode_label">Presentation Mode</span>
            </button>

            <div class="horizontalToolbarSeparator visibleLargeView"></div>

            <button id="firstPage" class="secondaryToolbarButton firstPage" title="Go to First Page" tabindex="56" data-l10n-id="first_page">
              <span data-l10n-id="first_page_label">跳转到第一页</span>
            </button>
            <button id="lastPage" class="secondaryToolbarButton lastPage" title="Go to Last Page" tabindex="57" data-l10n-id="last_page">
              <span data-l10n-id="last_page_label">跳转到最后一页</span>
            </button>

            <div class="horizontalToolbarSeparator"></div>

            <button id="pageRotateCw" class="secondaryToolbarButton rotateCw" title="Rotate Clockwise" tabindex="58" data-l10n-id="page_rotate_cw">
              <span data-l10n-id="page_rotate_cw_label">顺时针翻转</span>
            </button>
            <button id="pageRotateCcw" class="secondaryToolbarButton rotateCcw" title="Rotate Counterclockwise" tabindex="59" data-l10n-id="page_rotate_ccw">
              <span data-l10n-id="page_rotate_ccw_label">逆时针翻转</span>
            </button>

            <div class="horizontalToolbarSeparator"></div>

            <button id="toggleHandTool" class="secondaryToolbarButton handTool" title="Enable hand tool" tabindex="60" data-l10n-id="hand_tool_enable">
              <span data-l10n-id="hand_tool_enable_label">启用手动拖拽功能</span>
            </button>

            <div class="horizontalToolbarSeparator"></div>

            <button id="documentProperties" class="secondaryToolbarButton documentProperties" title="Document Properties…" tabindex="61" data-l10n-id="document_properties">
              <span data-l10n-id="document_properties_label">文件简介</span>
            </button>
          </div>
        </div>  <!-- secondaryToolbar -->

        <div class="toolbar">
          <div id="toolbarContainer">
            <div id="toolbarViewer">
              <div id="toolbarViewerLeft">
                <button id="sidebarToggle" class="toolbarButton" title="切换侧边栏" tabindex="11" data-l10n-id="toggle_sidebar">
                  <span data-l10n-id="toggle_sidebar_label">Toggle Sidebar</span>
                </button>
                <div class="toolbarButtonSpacer"></div>
                <button id="viewFind" class="toolbarButton group hiddenSmallView" title="查询" tabindex="12" data-l10n-id="findbar">
                   <span data-l10n-id="findbar_label">Find</span>
                </button>
                <div class="splitToolbarButton">
                  <button class="toolbarButton pageUp" title="上一页" id="previous" tabindex="13" data-l10n-id="previous">
                    <span data-l10n-id="previous_label">Previous</span>
                  </button>
                  <div class="splitToolbarButtonSeparator"></div>
                  <button class="toolbarButton pageDown" title="下一页" id="next" tabindex="14" data-l10n-id="next">
                    <span data-l10n-id="next_label">Next</span>
                  </button>
                </div>
                <label id="pageNumberLabel" class="toolbarLabel" for="pageNumber" data-l10n-id="page_label">Page: </label>
                <input type="number" id="pageNumber" class="toolbarField pageNumber" value="1" size="4" min="1" tabindex="15">
                <span id="numPages" class="toolbarLabel"></span>
              </div>
              <div id="toolbarViewerRight">
                <button id="presentationMode" class="toolbarButton presentationMode hiddenLargeView" title="全屏显示" tabindex="31" data-l10n-id="presentation_mode">
                  <span data-l10n-id="presentation_mode_label">Presentation Mode</span>
                </button>

                <div class="verticalToolbarSeparator hiddenSmallView"></div>

                <button id="secondaryToolbarToggle" class="toolbarButton" title="工具" tabindex="36" data-l10n-id="tools">
                  <span data-l10n-id="tools_label">Tools</span>
                </button>
              </div>
              <div class="outerCenter">
                <div class="innerCenter" id="toolbarViewerMiddle">
                  <div class="splitToolbarButton">
                    <button id="zoomOut" class="toolbarButton zoomOut" title="缩小" tabindex="21" data-l10n-id="zoom_out">
                      <span data-l10n-id="zoom_out_label">Zoom Out</span>
                    </button>
                    <div class="splitToolbarButtonSeparator"></div>
                    <button id="zoomIn" class="toolbarButton zoomIn" title="放大" tabindex="22" data-l10n-id="zoom_in">
                      <span data-l10n-id="zoom_in_label">Zoom In</span>
                     </button>
                  </div>
                  <span id="scaleSelectContainer" class="dropdownToolbarButton">
                     <select id="scaleSelect" title="显示比例" tabindex="23" data-l10n-id="zoom">
                      <option id="pageAutoOption" title="" value="auto" selected="selected" data-l10n-id="page_scale_auto">Automatic Zoom</option>
                      <option id="pageActualOption" title="" value="page-actual" data-l10n-id="page_scale_actual">Actual Size</option>
                      <option id="pageFitOption" title="" value="page-fit" data-l10n-id="page_scale_fit">Fit Page</option>
                      <option id="pageWidthOption" title="" value="page-width" data-l10n-id="page_scale_width">Full Width</option>
                      <option id="customScaleOption" title="" value="custom"></option>
                      <option title="" value="0.5" data-l10n-id="page_scale_percent" data-l10n-args='{ "scale": 50 }'>50%</option>
                      <option title="" value="0.75" data-l10n-id="page_scale_percent" data-l10n-args='{ "scale": 75 }'>75%</option>
                      <option title="" value="1" data-l10n-id="page_scale_percent" data-l10n-args='{ "scale": 100 }'>100%</option>
                      <option title="" value="1.25" data-l10n-id="page_scale_percent" data-l10n-args='{ "scale": 125 }'>125%</option>
                      <option title="" value="1.5" data-l10n-id="page_scale_percent" data-l10n-args='{ "scale": 150 }'>150%</option>
                      <option title="" value="2" data-l10n-id="page_scale_percent" data-l10n-args='{ "scale": 200 }'>200%</option>
                      <option title="" value="3" data-l10n-id="page_scale_percent" data-l10n-args='{ "scale": 300 }'>300%</option>
                      <option title="" value="4" data-l10n-id="page_scale_percent" data-l10n-args='{ "scale": 400 }'>400%</option>
                    </select>
                  </span>
                </div>
              </div>
            </div>
            <div id="loadingBar">
              <div class="progress">
                <div class="glimmer">
                </div>
              </div>
            </div>
          </div>
        </div>

        <menu type="context" id="viewerContextMenu">
          <menuitem id="contextFirstPage" label="First Page"
                    data-l10n-id="first_page"></menuitem>
          <menuitem id="contextLastPage" label="Last Page"
                    data-l10n-id="last_page"></menuitem>
          <menuitem id="contextPageRotateCw" label="Rotate Clockwise"
                    data-l10n-id="page_rotate_cw"></menuitem>
          <menuitem id="contextPageRotateCcw" label="Rotate Counter-Clockwise"
                    data-l10n-id="page_rotate_ccw"></menuitem>
        </menu>

        <div id="viewerContainer" tabindex="0">
          <div id="viewer" class="pdfViewer"></div>
        </div>

        <div id="errorWrapper" hidden='true'>
          <div id="errorMessageLeft">
            <span id="errorMessage"></span>
            <button id="errorShowMore" data-l10n-id="error_more_info">
              更多信息
            </button>
            <button id="errorShowLess" data-l10n-id="error_less_info" hidden='true'>
              更少信息
            </button>
          </div>
          <div id="errorMessageRight">
            <button id="errorClose" data-l10n-id="error_close">
              关闭
            </button>
          </div>
          <div class="clearBoth"></div>
          <textarea id="errorMoreInfo" hidden='true' readonly="readonly"></textarea>
        </div>
      </div> <!-- mainContainer -->

      <div id="overlayContainer" class="hidden">
        <div id="passwordOverlay" class="container hidden">
          <div class="dialog">
            <div class="row">
              <p id="passwordText" data-l10n-id="password_label">输入密码打开PDF文件:</p>
            </div>
            <div class="row">
              <input type="password" id="password" class="toolbarField" />
            </div>
            <div class="buttonRow">
              <button id="passwordCancel" class="overlayButton"><span data-l10n-id="password_cancel">取消</span></button>
              <button id="passwordSubmit" class="overlayButton"><span data-l10n-id="password_ok">确认</span></button>
            </div>
          </div>
        </div>
        <div id="documentPropertiesOverlay" class="container hidden">
          <div class="dialog">
            <div class="row">
              <span data-l10n-id="document_properties_file_name">文件名:</span> <p id="fileNameField">-</p>
            </div>
            <div class="row">
              <span data-l10n-id="document_properties_file_size">文件大小:</span> <p id="fileSizeField">-</p>
            </div>
            <div class="separator"></div>
            <div class="row">
              <span data-l10n-id="document_properties_title">标题:</span> <p id="titleField">-</p>
            </div>
            <div class="row">
              <span data-l10n-id="document_properties_author">作者:</span> <p id="authorField">-</p>
            </div>
            <div class="row">
              <span data-l10n-id="document_properties_subject">主题:</span> <p id="subjectField">-</p>
            </div>
            <div class="row">
              <span data-l10n-id="document_properties_keywords">关键字:</span> <p id="keywordsField">-</p>
            </div>
            <div class="row">
              <span data-l10n-id="document_properties_creation_date">编成日期:</span> <p id="creationDateField">-</p>
            </div>
            <div class="row">
              <span data-l10n-id="document_properties_modification_date">修改日期:</span> <p id="modificationDateField">-</p>
            </div>
            <div class="row">
              <span data-l10n-id="document_properties_creator">创作者:</span> <p id="creatorField">-</p>
            </div>
            <div class="separator"></div>
            <div class="row">
              <span data-l10n-id="document_properties_producer">PDF制作:</span> <p id="producerField">-</p>
            </div>
            <div class="row">
              <span data-l10n-id="document_properties_version">PDF版本:</span> <p id="versionField">-</p>
            </div>
            <div class="row">
              <span data-l10n-id="document_properties_page_count">总页数:</span> <p id="pageCountField">-</p>
            </div>
            <div class="buttonRow">
              <button id="documentPropertiesClose" class="overlayButton"><span data-l10n-id="document_properties_close">关闭</span></button>
            </div>
          </div>
        </div>
      </div>  <!-- overlayContainer -->

    </div> <!-- outerContainer -->
    <div id="printContainer"></div>
    </div>
</body>
	</html>
</o:MultiLanguage>
