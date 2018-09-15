<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@page import="java.io.File"%>
<%@page import="cn.myapps.km.util.FileUtils"%>
<%@page import="cn.myapps.km.disk.ejb.NFile"%>
<s:bean name="cn.myapps.km.category.ejb.CategoryHelper"
	id="categoryHelper"></s:bean>

<%@page import="cn.myapps.km.org.ejb.NUser"%><html>
<o:MultiLanguage>
	<head>
<%
	NUser user = (NUser) session
				.getAttribute(NUser.SESSION_ATTRIBUTE_FRONT_USER);
		String userid = user.getId();
		String fileid = (String) request.getParameter("id");
		long count = new cn.myapps.km.comments.ejb.CommentsProcessBean()
				.countBy(fileid, userid);
	String contextPath = request.getContextPath();
%>
<s:bean name="cn.myapps.km.comments.ejb.CommentsProcessBean" id="cpb">
</s:bean>
<s:bean name="cn.myapps.km.permission.ejb.PermissionHelper"
	id="permissionHelper"></s:bean>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:property value="content.name"/></title>
<link href="<s:url value='/km/disk/css/viewer.css'/>" rel="stylesheet"
	type="text/css" />
<link href="<s:url value='/km/disk/css/layout.css'/>" rel="stylesheet"
	type="text/css" />
<link href="<s:url value='/km/disk/css/detail.css'/>" rel="stylesheet"
	type="text/css" />
<link href='<s:url value="/km/disk/css/km.css" />' rel="stylesheet"
	type="text/css" />
	
<script type="text/javascript" >
var contextPath = "<%=contextPath%>";
var serverAddr = '<s:property value="#session.KM_FRONT_USER.serverAddr" />';
</script>

<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/CategoryHelper.js"/>'></script>

<script src='<s:url value="/km/script/jquery-ui/js/jquery-1.8.3.js" />' type="text/javascript"></script>

<!-- 弹出层插件--start -->
<script type="text/javascript" src="<s:url value='/km/script/jquery-ui/artDialog/jquery.artDialog.source.js?skin=aero'/>"></script>
<script type="text/javascript" src="<s:url value='/km/script/jquery-ui/artDialog/plugins/iframeTools.source.js'/>"></script>
<script type="text/javascript" src="<s:url value='/km/script/jquery-ui/artDialog/obpm-jquery-bridge.js'/>"></script>
<!-- 弹出层插件--end -->

<script src='<s:url value="/km/disk/script/share.js"/>'></script>
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
<script
	src='<s:url value="/km/disk/js/pdfjs/pdf_presentation_mode.js"/>'></script>
<script src='<s:url value="/km/disk/js/grab_to_pan.js"/>'></script>
<script src='<s:url value="/km/disk/js/hand_tool.js"/>'></script>
<script src='<s:url value="/km/disk/js/overlay_manager.js"/>'></script>
<script src='<s:url value="/km/disk/js/password_prompt.js"/>'></script>
<script
	src='<s:url value="/km/disk/js/pdfjs/pdf_document_properties.js"/>'></script>
<script src='<s:url value="/km/disk/js/debugger.js"/>'></script>
<script src='<s:url value="/km/disk/js/viewer.js"/>'></script>

<!-- jplayer插件 开始-->
<link
	href='<s:url value="/km/disk/js/jplayer/skin/blue.monday/css/jplayer.blue.monday.min.css"/>'
	rel="stylesheet" type="text/css" />
<script
	src='<s:url value="/km/disk/js/jplayer/js/jquery.jplayer.min.js"/>'></script>
<!-- jplayer插件 结束-->

<script type="text/javascript">
jQuery.noConflict();
DEFAULT_URL='<s:property value="content.title"/>';
function addAssessment(value){
	
	if(confirm("{*[cn.myapps.km.disk.comments_tip]*}")){
		var fileId = '<s:property value="content.id" />';
		if(value=='good'){
			var url = encodeURI(encodeURI(contextPath + "/km/comments/save.action?_evaluate=good&content.fileId="+fileId));
			}else{
			var url = encodeURI(encodeURI(contextPath + "/km/comments/save.action?_evaluate=bad&content.fileId="+fileId));
			}
		
		
		jQuery.ajax({	
			type: 'POST',
			async:false,
			url: url,
			dataType : 'text',
			
			//data: //jQuery("#document_content").serialize(),
			success:function(result) {
				if(result && result.indexOf("-")>=0){
					var rtn = result.split("-");
					document.getElementById("_good").innerHTML=rtn[0];
					document.getElementById("_bad").innerHTML=rtn[1];
					document.getElementById("_score").innerHTML=rtn[2];
					var  score=rtn[2];
					evaluateScore(score);
					jQuery("#good").attr("src","<s:url value='/km/disk/images/disabledGood.gif'/>").removeAttr("onClick");
					jQuery("#notGood").attr("src","<s:url value='/km/disk/images/disabledNotGood.gif'/>").removeAttr("onClick");
					return;
				}
			},
			error: function(x) {
				
			}
		});
	}
}

function setReadSize(){
	var documentH =jQuery(document).height();
	var documentW = jQuery(document).width();
	var readerView_rightW = jQuery(".readerView_right").width();
	jQuery("#mainLeft").width(documentW - readerView_rightW-30);
	jQuery(".readerView_right").height(documentH-10);
	var dbank_titleH = jQuery(".dbank_title").outerHeight();
	var pageNumberH = jQuery(".pageNumber").outerHeight();
	jQuery(".readyContent").height(documentH - pageNumberH- dbank_titleH - 30);
}

function disabledScore(){
	var count = <%=count%>;
	if(count > 0){
		jQuery("#good").attr("src","<s:url value='/km/disk/images/disabledGood.gif'/>").removeAttr("onClick");
		jQuery("#notGood").attr("src","<s:url value='/km/disk/images/disabledNotGood.gif'/>").removeAttr("onClick");
	}
}

function  evaluateScore(score){
	if(!score){
		var score = <s:property value="content.getScore()"/>;
	}
	if(!typeof(score) == "number") return;
	var starHtml = "";
	for(i=1;i <= Math.floor(score);i++){
		starHtml +='<img alt="" src="<s:url value='/km/disk/images/star1.gif'/>">';
	}
	if(parseInt(score)!=score){
		starHtml +='<img alt="" src="<s:url value='/km/disk/images/star3.gif'/>">';		
	}
	for(i=1;i <= (5 - Math.ceil(score));i++){
		starHtml +='<img alt="" src="<s:url value='/km/disk/images/star2.gif'/>">';
	}
	jQuery(".readerStarImg").html(starHtml);
}

//可播放的视频文件和音频文件
function playAble(fileName){
	var fileType = fileName.substr(fileName.lastIndexOf("."));
	switch(fileType){
	case ".webm":case ".mp4":case ".ogg":case ".wav":
	case ".flv":case ".rtmp":case ".m4v":case ".ogv":
		return true;
	default:
		return false;
	}
}

jQuery(document).ready(function(){
	setReadSize();
	evaluateScore();
	disabledScore();
	init_category();
	/*
	if (window.applicationCache) {
		jQuery("#showPdfJs").show();
	} else {
		jQuery("#showFlash").show(); 
	}
	*/
	
	var fileUrl = '<s:property value="fileUrl"/>';
	var fileName = fileUrl.substr(fileUrl.lastIndexOf("/"));
	if(playAble(fileName)){
		jQuery("#jp_container_1").show();
        //视频播放的地址  
        var media = {
        		webmv: '<s:property value="fileUrl"/>'
			};

		jQuery("#jquery_jplayer_1").jPlayer({
			ready: function () {
				jQuery(this).jPlayer("setMedia", media).jPlayer("play");
			},
			swfPath: "./js/jplayer/swf",
			supplied: "webmv",
			size: {
				width: "100%",
				height: "100%",
				cssClass: "jp-video-100"
			},
			useStateClassSkin: true,
			autoBlur: false,
			smoothPlayBar: true,
			keyEnabled: true,
			remainingDuration: true,
			toggleDuration: true
		});
		
		jQuery("#showFlash").hide();
	} else {
		jQuery("#showFlash").show();
	}
});

function init_category(){
	var rootCategory = '<s:property value="content.rootCategoryId"/>';
	if(rootCategory.length>0){
		onRootCategoryChange(rootCategory);
		show_category();
	}
}

function show_category(){
	jQuery("#categoryList").show();
	var _rootCategory = jQuery("#_rootCategory option:selected").text();
	setTimeout(function(){
		var _subCategory = jQuery("#_subCategory option:selected").text();
		if(_rootCategory){
			jQuery("#categoryList").html(_rootCategory + "-"+ _subCategory);
		}else{
			jQuery("#categoryList").html("");
		}
	},300);
}

jQuery(window).resize(function(){
	setReadSize();
});

//编辑
function ev_editCategory(){
	jQuery(".editCategory").hide();
	jQuery("#categoryList").hide();
	jQuery(".showCategory").show();
}

//保存
function ev_saveCategory(){
	var url ='<s:url value="/km/disk/file/save4ajax.action"/>';
	jQuery.ajax({	
		type: 'POST',
		async:false,
		url: url,
		dataType : 'text',
		data: jQuery("#content").serialize(),
		success:function(result) {
			if(result && result=="success"){
				//回显
				jQuery(".editCategory").show();
				jQuery(".showCategory").hide();
				show_category();
				return;
			}else if(result){
				alert("{*[cn.myapps.km.disk.update_tip]*}");
				}
				
		},
		error: function(x) {
			
		}
	});
}

//取消
function ev_cancel(){
	jQuery(".editCategory").show();
	jQuery("#categoryList").show();
	jQuery(".showCategory").hide();
}

function refreshCategory(){
	var def = document.getElementById("_rootCategory").value;
	var domainId = '<s:property value="content.domainId"/>';
	CategoryHelper.getRootCategoryMap(domainId, function(options) {
		addOptions("_rootCategory", options, def);
	});
	onRootCategoryChange(def);
}

function onRootCategoryChange(value){
	var def =  '<s:property value="content.subCategoryId"/>';
	var domainId = '<s:property value="content.domainId"/>';
	CategoryHelper.getSubCategoryMap(value,domainId, function(options) {
		addOptions("_subCategory", options, def);
	});
}

function addOptions(relatedFieldId, options, defValues){
	var $el = jQuery("#"+relatedFieldId);
	if($el && relatedFieldId){
		$el.find("option").remove();
		$el.append("<option value='blank'></option>");
		for(var key in options){
			$el.append("<option value='" + key + "'>" + options[key] + "</option>");
		}
	}
	if (defValues) {
		$el.val(defValues);
	}
}
function ev_refreshPreview(){
	var url ='<s:url value="/km/disk/file/refreshPreview.action"/>';
	jQuery.ajax({	
		type: 'POST',
		async:false,
		url: url,
		dataType : 'text',
		data: jQuery("#content").serialize(),
		success:function(result) {
			if(result && result=="success"){
				alert("{*[cn.myapps.km.disk.file_conversion_tip]*}");
			}else if(result=="fault"){
				alert("{*[cn.myapps.km.disk.file_conversion_error]*}");
				}
		},
		error: function(x) {
			
		}
	});
}
</script>
	</head>
	<body>
		<s:set name="isManager"
			value="#permissionHelper.verifyDirManagePermission(content.nDirId,#session.KM_FRONT_USER)" />
		<s:form name="content" id="content" action="" method="post"
			theme="simple">
			<s:hidden name="sharefile" id="sharefile"
				value="{*[cn.myapps.km.disk.share_file]*}" />
			<s:hidden name="content.id" />
			<s:hidden name="content.name" id="_name" />
			<s:hidden name="content.nDirId" />
			<s:hidden name="content.creatorId" />
			<s:hidden name="content.creator" />
			<s:hidden name="content.ownerId" />
			<s:hidden name="content.url" />
			<s:hidden name="content.version" />
			<s:hidden name="content.type" />
			<s:hidden name="content.size" />
			<s:hidden name="content.createDate" />
			<s:hidden name="content.lastmodify" />
			<s:hidden name="content.state" />
			<s:hidden name="content.domainId" />
			<s:hidden name="content.title" />
			<s:hidden name="content.memo" />
			<s:hidden name="content.shareId" />
			<s:hidden name="content.origin" />
			<s:hidden name="_type" />
			<div id="content" class="content" style="min-width: 950px;">
				<div id="mainLeft" class="mainLeft">
					<h3 class="dbank_title">
						<a href="#"><s:property value="content.name" /></a>
					</h3>
					<div class="article">
						<table width="100%" style="overflow: hidden">
							<tr>
								<td class="readyContent" style="margin: 0px; padding: 0px;">
									<div id="showFlash" style="display: none;height: 100%;">
										<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id="MyappsFlex" width="100%" height="100%" codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
											<param name="movie" value="<s:url value='/km/disk/flexpaper.swf'/>" />
											<param name="wmode" value="transparent" />
											<param name="quality" value="high" />
											<param name="bgcolor" value="#869ca7" />
											<param name="allowFullScreen" value="true" />
											<param name="allowScriptAccess" value="sameDomain" />
											<param name="FlashVars" value="SwfFile=<s:property value='swfUrl' />&StartAtPage=<s:property value='#parameters.pageNO' />" />
											<embed src="<s:url value='/km/disk/flexpaper.swf'/>"
												quality="high" bgcolor="#869ca7"
												flashVars="SwfFile=<s:property value='swfUrl' />&StartAtPage=<s:property value='#parameters.pageNO' />"
												width="100%" height="100%" name="DataMap" align="middle"
												play="true" loop="false" quality="high" wmode="transparent"
												allowFullScreen="true" allowScriptAccess="sameDomain"
												type="application/x-shockwave-flash"
												pluginspage="http://www.adobe.com/go/getflashplayer">
											</embed>
										</object>
									</div>
									<div id="showPdfJs" style="display: none;height: 100%;">
										<div id="outerContainer">
											<div id="sidebarContainer">
												<div id="toolbarSidebar">
													<div class="splitToolbarButton toggled">
														<button id="viewThumbnail"
															class="toolbarButton group toggled" title="显示缩略图"
															tabindex="2" data-l10n-id="thumbs">
															<span data-l10n-id="thumbs_label">Thumbnails</span>
														</button>
														<button id="viewOutline" class="toolbarButton group"
															title="显示文档大纲" tabindex="3" data-l10n-id="outline">
															<span data-l10n-id="outline_label">Document
																Outline</span>
														</button>
														<button id="viewAttachments" class="toolbarButton group"
															title="显示附件" tabindex="4" data-l10n-id="attachments">
															<span data-l10n-id="attachments_label">Attachments</span>
														</button>
													</div>
												</div>
												<div id="sidebarContent">
													<div id="thumbnailView"></div>
													<div id="outlineView" class="hidden"></div>
													<div id="attachmentsView" class="hidden"></div>
												</div>
											</div>
											<!-- sidebarContainer -->

											<div id="mainContainer">
												<div class="findbar hidden doorHanger hiddenSmallView"
													id="findbar">
													<label for="findInput" class="toolbarLabel"
														data-l10n-id="find_label">Find:</label> <input
														id="findInput" class="toolbarField" tabindex="91">
													<div class="splitToolbarButton">
														<button class="toolbarButton findPrevious" title=""
															id="findPrevious" tabindex="92"
															data-l10n-id="find_previous">
															<span data-l10n-id="find_previous_label">Previous</span>
														</button>
														<div class="splitToolbarButtonSeparator"></div>
														<button class="toolbarButton findNext" title=""
															id="findNext" tabindex="93" data-l10n-id="find_next">
															<span data-l10n-id="find_next_label">Next</span>
														</button>
													</div>
													<input type="checkbox" id="findHighlightAll"
														class="toolbarField"> <label
														for="findHighlightAll" class="toolbarLabel" tabindex="94"
														data-l10n-id="find_highlight">Highlight all</label> <input
														type="checkbox" id="findMatchCase" class="toolbarField">
													<label for="findMatchCase" class="toolbarLabel"
														tabindex="95" data-l10n-id="find_match_case_label">Match
														case</label> <span id="findMsg" class="toolbarLabel"></span>
												</div>
												<!-- findbar -->

												<div id="secondaryToolbar"
													class="secondaryToolbar hidden doorHangerRight">
													<div id="secondaryToolbarButtonContainer">
														<button id="secondaryPresentationMode"
															class="secondaryToolbarButton presentationMode visibleLargeView"
															title="全屏显示" tabindex="51"
															data-l10n-id="presentation_mode">
															<span data-l10n-id="presentation_mode_label">Presentation
																Mode</span>
														</button>

														<div class="horizontalToolbarSeparator visibleLargeView"></div>

														<button id="firstPage"
															class="secondaryToolbarButton firstPage"
															title="Go to First Page" tabindex="56"
															data-l10n-id="first_page">
															<span data-l10n-id="first_page_label">跳转到第一页</span>
														</button>
														<button id="lastPage"
															class="secondaryToolbarButton lastPage"
															title="Go to Last Page" tabindex="57"
															data-l10n-id="last_page">
															<span data-l10n-id="last_page_label">跳转到最后一页</span>
														</button>

														<div class="horizontalToolbarSeparator"></div>

														<button id="pageRotateCw"
															class="secondaryToolbarButton rotateCw"
															title="Rotate Clockwise" tabindex="58"
															data-l10n-id="page_rotate_cw">
															<span data-l10n-id="page_rotate_cw_label">顺时针翻转</span>
														</button>
														<button id="pageRotateCcw"
															class="secondaryToolbarButton rotateCcw"
															title="Rotate Counterclockwise" tabindex="59"
															data-l10n-id="page_rotate_ccw">
															<span data-l10n-id="page_rotate_ccw_label">逆时针翻转</span>
														</button>

														<div class="horizontalToolbarSeparator"></div>

														<button id="toggleHandTool"
															class="secondaryToolbarButton handTool"
															title="Enable hand tool" tabindex="60"
															data-l10n-id="hand_tool_enable">
															<span data-l10n-id="hand_tool_enable_label">启用手动拖拽功能</span>
														</button>

														<div class="horizontalToolbarSeparator"></div>

														<button id="documentProperties"
															class="secondaryToolbarButton documentProperties"
															title="Document Properties…" tabindex="61"
															data-l10n-id="document_properties">
															<span data-l10n-id="document_properties_label">文件简介</span>
														</button>
													</div>
												</div>
												<!-- secondaryToolbar -->

												<div class="toolbar">
													<div id="toolbarContainer">
														<div id="toolbarViewer">
															<div id="toolbarViewerLeft">
																<button id="sidebarToggle" class="toolbarButton"
																	title="切换侧边栏" tabindex="11"
																	data-l10n-id="toggle_sidebar">
																	<span data-l10n-id="toggle_sidebar_label">Toggle
																		Sidebar</span>
																</button>
																<div class="toolbarButtonSpacer"></div>
																<button id="viewFind"
																	class="toolbarButton group hiddenSmallView" title="查询"
																	tabindex="12" data-l10n-id="findbar">
																	<span data-l10n-id="findbar_label">Find</span>
																</button>
																<div class="splitToolbarButton">
																	<button class="toolbarButton pageUp" title="上一页"
																		id="previous" tabindex="13" data-l10n-id="previous">
																		<span data-l10n-id="previous_label">Previous</span>
																	</button>
																	<div class="splitToolbarButtonSeparator"></div>
																	<button class="toolbarButton pageDown" title="下一页"
																		id="next" tabindex="14" data-l10n-id="next">
																		<span data-l10n-id="next_label">Next</span>
																	</button>
																</div>
																<label id="pageNumberLabel" class="toolbarLabel"
																	for="pageNumber" data-l10n-id="page_label">Page:
																</label> <input type="number" id="pageNumber"
																	class="toolbarField pageNumber" value="1" size="4"
																	min="1" tabindex="15"> <span id="numPages"
																	class="toolbarLabel"></span>
															</div>
															<div id="toolbarViewerRight">
																<button id="presentationMode"
																	class="toolbarButton presentationMode hiddenLargeView"
																	title="全屏显示" tabindex="31"
																	data-l10n-id="presentation_mode">
																	<span data-l10n-id="presentation_mode_label">Presentation
																		Mode</span>
																</button>

																<div class="verticalToolbarSeparator hiddenSmallView"></div>

																<button id="secondaryToolbarToggle"
																	class="toolbarButton" title="工具" tabindex="36"
																	data-l10n-id="tools">
																	<span data-l10n-id="tools_label">Tools</span>
																</button>
															</div>
															<div class="outerCenter">
																<div class="innerCenter" id="toolbarViewerMiddle">
																	<div class="splitToolbarButton">
																		<button id="zoomOut" class="toolbarButton zoomOut"
																			title="缩小" tabindex="21" data-l10n-id="zoom_out">
																			<span data-l10n-id="zoom_out_label">Zoom Out</span>
																		</button>
																		<div class="splitToolbarButtonSeparator"></div>
																		<button id="zoomIn" class="toolbarButton zoomIn"
																			title="放大" tabindex="22" data-l10n-id="zoom_in">
																			<span data-l10n-id="zoom_in_label">Zoom In</span>
																		</button>
																	</div>
																	<span id="scaleSelectContainer"
																		class="dropdownToolbarButton"> <select
																		id="scaleSelect" title="显示比例" tabindex="23"
																		data-l10n-id="zoom">
																			<option id="pageAutoOption" title="" value="auto"
																				selected="selected" data-l10n-id="page_scale_auto">Automatic
																				Zoom</option>
																			<option id="pageActualOption" title=""
																				value="page-actual" data-l10n-id="page_scale_actual">Actual
																				Size</option>
																			<option id="pageFitOption" title="" value="page-fit"
																				data-l10n-id="page_scale_fit">Fit Page</option>
																			<option id="pageWidthOption" title=""
																				value="page-width" data-l10n-id="page_scale_width">Full
																				Width</option>
																			<option id="customScaleOption" title=""
																				value="custom"></option>
																			<option title="" value="0.5"
																				data-l10n-id="page_scale_percent"
																				data-l10n-args='{ "scale": 50 }'>50%</option>
																			<option title="" value="0.75"
																				data-l10n-id="page_scale_percent"
																				data-l10n-args='{ "scale": 75 }'>75%</option>
																			<option title="" value="1"
																				data-l10n-id="page_scale_percent"
																				data-l10n-args='{ "scale": 100 }'>100%</option>
																			<option title="" value="1.25"
																				data-l10n-id="page_scale_percent"
																				data-l10n-args='{ "scale": 125 }'>125%</option>
																			<option title="" value="1.5"
																				data-l10n-id="page_scale_percent"
																				data-l10n-args='{ "scale": 150 }'>150%</option>
																			<option title="" value="2"
																				data-l10n-id="page_scale_percent"
																				data-l10n-args='{ "scale": 200 }'>200%</option>
																			<option title="" value="3"
																				data-l10n-id="page_scale_percent"
																				data-l10n-args='{ "scale": 300 }'>300%</option>
																			<option title="" value="4"
																				data-l10n-id="page_scale_percent"
																				data-l10n-args='{ "scale": 400 }'>400%</option>
																	</select>
																	</span>
																</div>
															</div>
														</div>
														<div id="loadingBar">
															<div class="progress">
																<div class="glimmer"></div>
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
													<menuitem id="contextPageRotateCcw"
														label="Rotate Counter-Clockwise"
														data-l10n-id="page_rotate_ccw"></menuitem>
												</menu>

												<div id="viewerContainer" tabindex="0">
													<div id="viewer" class="pdfViewer"></div>
												</div>

												<div id="errorWrapper" hidden='true'>
													<div id="errorMessageLeft">
														<span id="errorMessage"></span>
														<button id="errorShowMore" data-l10n-id="error_more_info">
															更多信息</button>
														<button id="errorShowLess" data-l10n-id="error_less_info"
															hidden='true'>更少信息</button>
													</div>
													<div id="errorMessageRight">
														<button id="errorClose" data-l10n-id="error_close">
															关闭</button>
													</div>
													<div class="clearBoth"></div>
													<textarea id="errorMoreInfo" hidden='true'
														readonly="readonly"></textarea>
												</div>
											</div>
											<!-- mainContainer -->

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
															<button id="passwordCancel" class="overlayButton">
																<span data-l10n-id="password_cancel">取消</span>
															</button>
															<button id="passwordSubmit" class="overlayButton">
																<span data-l10n-id="password_ok">确认</span>
															</button>
														</div>
													</div>
												</div>
												<div id="documentPropertiesOverlay" class="container hidden">
													<div class="dialog">
														<div class="row">
															<span data-l10n-id="document_properties_file_name">文件名:</span>
															<p id="fileNameField">-</p>
														</div>
														<div class="row">
															<span data-l10n-id="document_properties_file_size">文件大小:</span>
															<p id="fileSizeField">-</p>
														</div>
														<div class="separator"></div>
														<div class="row">
															<span data-l10n-id="document_properties_title">标题:</span>
															<p id="titleField">-</p>
														</div>
														<div class="row">
															<span data-l10n-id="document_properties_author">作者:</span>
															<p id="authorField">-</p>
														</div>
														<div class="row">
															<span data-l10n-id="document_properties_subject">主题:</span>
															<p id="subjectField">-</p>
														</div>
														<div class="row">
															<span data-l10n-id="document_properties_keywords">关键字:</span>
															<p id="keywordsField">-</p>
														</div>
														<div class="row">
															<span data-l10n-id="document_properties_creation_date">编成日期:</span>
															<p id="creationDateField">-</p>
														</div>
														<div class="row">
															<span
																data-l10n-id="document_properties_modification_date">修改日期:</span>
															<p id="modificationDateField">-</p>
														</div>
														<div class="row">
															<span data-l10n-id="document_properties_creator">创作者:</span>
															<p id="creatorField">-</p>
														</div>
														<div class="separator"></div>
														<div class="row">
															<span data-l10n-id="document_properties_producer">PDF制作:</span>
															<p id="producerField">-</p>
														</div>
														<div class="row">
															<span data-l10n-id="document_properties_version">PDF版本:</span>
															<p id="versionField">-</p>
														</div>
														<div class="row">
															<span data-l10n-id="document_properties_page_count">总页数:</span>
															<p id="pageCountField">-</p>
														</div>
														<div class="buttonRow">
															<button id="documentPropertiesClose"
																class="overlayButton">
																<span data-l10n-id="document_properties_close">关闭</span>
															</button>
														</div>
													</div>
												</div>
											</div>
											<!-- overlayContainer -->

										</div>
										<!-- outerContainer -->
										<div id="printContainer"></div>
									</div>
									<div id="jp_container_1" style="display:none;" class="jp-video" role="application"
										aria-label="media player">
										<div class="jp-type-single">
											<div id="jquery_jplayer_1" class="jp-jplayer"></div>
											<div class="jp-gui">
												<div class="jp-interface">
													<div class="jp-progress">
														<div class="jp-seek-bar">
															<div class="jp-play-bar"></div>
														</div>
													</div>
													<div class="jp-current-time" role="timer" aria-label="time">&nbsp;</div>
													<div class="jp-duration" role="timer" aria-label="duration">&nbsp;</div>
													<div class="jp-controls-holder">
														<div class="jp-volume-controls">
															<button class="jp-mute" role="button" tabindex="0">mute</button>
															<button class="jp-volume-max" role="button" tabindex="0">max volume</button>
															<div class="jp-volume-bar">
																<div class="jp-volume-bar-value"></div>
															</div>
														</div>
														<div class="jp-controls">
															<button class="jp-play" role="button" tabindex="0">play</button>
															<button class="jp-stop" role="button" tabindex="0">stop</button>
														</div>
														<div class="jp-toggles">
															<button class="jp-repeat" role="button" tabindex="0">repeat</button>
															<button class="jp-full-screen" role="button" tabindex="0">full screen</button>
														</div>
													</div>
												</div>
											</div>
											<div class="jp-no-solution">
												<span>Update Required</span>
												To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
											</div>
										</div>
									</div>
								</td>
							</tr>
						</table>
					</div>
					<div class="option" style="margin:10px;float:right;width:320px;">
					
					    <!-- 下载按钮 -->
					    <s:if test="download">
							<div class="handle_btn">
								<div class="complete_left"></div>
								<div class="complete_center">
										<a
											href="<s:url value='/km/disk/file/download.action'><s:param name='id' value='content.id' /></s:url>"
											style="cursor: pointer;">{*[cn.myapps.km.disk.download]*}</a>
								</div>
								<div class="complete_right"></div>
							</div>
						</s:if>
						
						<!-- 收藏按钮 -->
						<s:if test="(content.state==1 || content.state==3)&& !_favorited">
							<div class="handle_btn">
									<div class="complete_left"></div>
									<div class="complete_center"
										onclick="show_favorite_page('<s:property value="content.id" />');">
										<a style="cursor: pointer;">{*[cn.myapps.km.disk.favorite]*}</a>
									</div>
									<div class="complete_right"></div>
							</div>
						</s:if>
						
						<!-- 分享按钮 -->
						<s:if test="content.state==2">
							<div  class="handle_btn">
								<div class="complete_left"></div>
									<div class="complete_center goShareDetail"
										id="<s:property  value='content.id'/>">
										<a id="<s:property  value='content.id'/>"
											style="cursor: pointer;">{*[cn.myapps.km.disk.share]*}</a>
									</div>
							
								<div class="complete_right"></div>
							</div>
					    </s:if>
					    
					    <!-- 评论按钮 -->
					    <s:if test="content.state==1">
							<div  class="handle_btn">
									<div class="complete_left"></div>
									<div class="complete_center"
										onclick="show_recommend_page('<s:property value="content.id" />');">
										<a style="cursor: pointer;">{*[cn.myapps.km.disk.recommend]*}</a>
									</div>
										<div class="complete_right"></div>
							</div>
						</s:if>
					</div>
				</div>
				<div class="readerView_right">
					<div class="interest">
						<div>
							<a>{*[cn.myapps.km.disk.document_information]*}</a><img alt=""
								src="<s:url value='/km/disk/images/arrow_icon.gif'/>">
						</div>
						<table cellspacing="0" style="height: 100px; width: 245px;">
							<tr>
								<td colspan="2">{*[cn.myapps.km.disk.type]*}： <span
									class="showCategory" style="display: none; margin-bottom: 5px;">
										<s:select id="_rootCategory" name="content.rootCategoryId"
											list="#categoryHelper.getRootCategory(#session.KM_FRONT_USER.domainid)"
											listKey="id" listValue="name" cssClass="input-cmd"
											emptyOption="true"
											onchange="onRootCategoryChange(this.value);" /> - <s:select
											id="_subCategory" emptyOption="true"
											name="content.subCategoryId" list="{}" />
								</span> <span id="categoryList"></span>
								</td>
							</tr>
							<tr class="editCategory" style="">
								<td colspan="2"><span id="lable_category"></span>&nbsp; <s:if
										test="content.state==1 && #isManager && content.origin==0">
										<span><a href="javascript:ev_editCategory()">【{*[cn.myapps.km.disk.edit]*}】</a></span>
									</s:if></td>
							</tr>
							<tr class="showCategory"
								style="border: 1px dashed #ccc; display: none;">
								<td colspan="2">
									<div>
										<a href="javascript:ev_saveCategory()">【{*[cn.myapps.km.disk.save]*}】</a>
										<a href="javascript:ev_cancel()">【{*[cn.myapps.km.disk.cancel]*}】</a>
									</div>
								</td>
							</tr>
							<tr>
								<td>{*[cn.myapps.km.disk.uploader]*}：</td>
								<td><s:property value="content.creator" /></td>
							</tr>
							<tr>
								<td>{*[Title]*}：</td>
								<td><s:property value="content.title" /></td>
							</tr>
							<tr>
								<td>{*[cn.myapps.km.disk.introduction]*}：</td>
								<td><s:property value="content.memo" /></td>
							</tr>
							<tr>
								<td>{*[cn.myapps.km.disk.time]*}：</td>
								<td><s:date name="content.createDate" format="yyyy-MM-dd" /></td>
							</tr>

							<s:if test="content.state==1 && #isManager">
								<tr>
									<td><span><a href="javascript:ev_refreshPreview()">【{*[cn.myapps.km.disk.rebuild_preview]*}】</a></span>
									</td>
								</tr>
							</s:if>
						</table>
						<table class="interestAct" cellspacing="0">
							<tr>
								<td>
									<div align="center">
										<span>{*[cn.myapps.km.disk.view]*}</span>
									</div>
									<div align="center">
										<s:property value="content.views" />
									</div>
								</td>
								<td>
									<div align="center">
										<span>{*[cn.myapps.km.disk.download]*}</span>
									</div>
									<div align="center">
										<s:property value="content.downloads" />
									</div>
								</td>
								<td>
									<div align="center">
										<span>{*[cn.myapps.km.disk.favorite]*}</span>
									</div>
									<div align="center">
										<s:property value="content.favorites" />
									</div>
								</td>
							</tr>
						</table>
						<div class="readerScoreCenter">
							<div class="readerScoreRight">
								<div>
									<img style="cursor: pointer;" id="good" alt=""
										src="<s:url value='/km/disk/images/good.gif'/>"
										onclick="addAssessment('good');" /> <a id="_good"><s:property
											value="content.good" /></a> <img class="lines2" alt=""
										src="<s:url value='/km/disk/images/V_lines.gif'/>"> <img
										style="cursor: pointer;" id="notGood" alt=""
										src="<s:url value='/km/disk/images/no_good.gif'/>"
										onclick="addAssessment('bad');" /> <a id="_bad"><s:property
											value="content.bad" /></a>
								</div>
							</div>
						</div>
						<div class="readerScoreCenter">
							<div class="readerStarRating">
								<div>
									{*[cn.myapps.km.disk.star_evaluation]*}: <span class="scorenum"><a
										id="_score"><s:property value="content.getScore()" /></a></span>{*[cn.myapps.km.disk.points]*}<span
										class="readerStarImg"></span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</div>
		</s:form>
	</body>
</o:MultiLanguage>
</html>