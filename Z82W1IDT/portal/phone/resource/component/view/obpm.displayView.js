/**
 * 	后台预览的时候判断页面是否重构完成
 */
var isComplete = false; 

/**
 * 子视图公用初始化方法
 * @return
 */
function initDispComm(){

	openDownloadWindow(openDownWinStr);	// 打开Excel下载窗口
	setTimeout(function(){
		jqRefactor4DisplayView(); //DisplayView重构
	},50);
	setTimeout(function(){
		jqRefactor();//表单控件jquery重构
	},10);
	selectData4Doc(); //回选列表数据
	setTimeout(function(){
		showPromptMsg();	//显示提示信息
	},300);
	document.ondblclick=handleDbClick;
	setTimeout(function(){
		dataTableSize();
		//ev_resize4IncludeViewPar();	//包含元素包含视图时调整iframe高度
	},300);
	ev_reloadParent();	//刷新父窗口	
	isComplete = true; //后台预览的时候判断页面是否重构完成
}

//给后台preview.jsp视图预览的时候判断页面是否重构完成
function getIsComplete(){
	return isComplete ;
}


function zoompage() {
 	var typeflage = typeof(dialogArguments);
 	if(typeflage != 'undefined' ) {    
    	
    }else if(window.opener){
    	
    }else{
        window.top.IsResize();
    }
 	ev_resize4IncludeViewPar();	//包含元素包含视图时调整iframe高度
}
//设置数据容器的高度。
function dataTableSize(){
	//包含元素固定高度时不重新布局
	var divid = document.getElementsByName("divid")[0].value;
	var pSpan = parent.document.getElementById(divid);
	var pIframe = "";
	var fixation = "false";
	if(pSpan){
		pIframe = pSpan.getElementsByTagName("iframe")[0];
		if(pIframe){
			fixation = pIframe.getAttribute("fixation");
		}
	}
	if(fixation=="true") return;
	
	var dataTableH = jQuery("#dataTable").height();
	if(dataTableH < 100){
		dataTableH = 120;
	}else if(dataTableH >300){
		dataTableH = 300;
	}else{
		dataTableH = dataTableH + 20;
	}
	jQuery("#table_container").height(dataTableH);
}
function handleDbClick(){
	if(event.srcElement.onclick){
	}else if(event.srcElement.type!=null&&(event.srcElement.type.toUpperCase()=='SUBMIT'
		||event.srcElement.type.toUpperCase()=='BUTTON'
		||event.srcElement.type.toUpperCase()=='CHECKBOX'
		||event.srcElement.type.toUpperCase()=='RADIO'
		||event.srcElement.type.toUpperCase()=='SELECT'
		||event.srcElement.type.toUpperCase()=='IMG')){
	  
	}else{
		zoompage();
	}
}

/**
 * 显示提示信息
 * for:default/gentle/fresh/dwz/brisk/blue
 */
function showPromptMsg(){
	var funName = typeName;
	var url = urlValue;
	url+="&_refreshDocument=true";
	var msg = document.getElementsByName("message")[0].value;
	if (msg) {
		try{
			eval("do" + funName + "(msg , url);");
		} catch(ex) {
		}
	}
}

function on_unload() {
	ev_reloadParent();	//刷新父窗口
}

function createDoc(activityid) {
	// 查看/script/view.js
	var action = activityAction + "?_activityid=" + activityid;
	openWindowByType(action,newStr, VIEW_TYPE_SUB, activityid); 
}

/**
 * 包含元素包含视图时调整iframe高度
 * from:blue/brisk/default/dwz/fresh/gentle
 */
function ev_resize4IncludeViewPar(){
	var divid = document.getElementsByName("divid")[0].value;
	var _viewid = document.getElementsByName("_viewid")[0].value;
	ev_resize4IncludeView(divid,_viewid,'DISPLAYVIEW');
}

/**
 * 重构displayView
 */
(function($){
	$.fn.obpmDisplayView = function(){
		return this.each(function(){
			
			var $dvid = ajaxPage.getCurPage().find("title").attr("id");
			$(this).next(".ui-content").attr("id","view_"+$dvid);
			
			var Column = {
					COLUMN_TYPE_SCRIPT : 'COLUMN_TYPE_SCRIPT',	//脚本编辑模式
					COLUMN_TYPE_FIELD : 'COLUMN_TYPE_FIELD',	//视图编辑模式
					COLUMN_TYPE_OPERATE : 'COLUMN_TYPE_OPERATE',//操作列
					COLUMN_TYPE_LOGO : 'COLUMN_TYPE_LOGO',		//图标列
					COLUMN_TYPE_ROWNUM : 'COLUMN_TYPE_ROWNUM',	//序号列
					DISPLAY_ALL : '00',//列显示全部文本
					DISPLAY_PART : '01'//列显示部分文本
			},
			ColumnOperaType = {
					BUTTON_TYPE_DELETE : "00",
					BUTTON_TYPE_DOFLOW : "01",
					BUTTON_TYPE_TEMPFORM : "03",
					BUTTON_TYPE_SCRIPT : "04",
					BUTTON_TYPE_JUMP : "05"//操作列增加跳转类型按钮
			},
			View = {
					DISPLAY_TYPE_TEMPLATEFORM : "templateForm"
			},
			Setting = {//
					TABLE_CLASS : 'listDataTable',		//表格class
					TH_CLASS : 'listDataTh',						//标题行class
					TH_FIRST_TD_CLASS : 'listDataThFirstTd',			//标题行第一个单元格class
					TH_TD_CLASS : 'listDataThTd',		//标题行其他单元格class
					TR_FIRST_TD_CLASS : 'listDataTrFirstTd',		//数据行第一个单元格class
					TR_TD_CLASS : 'listDataTrTd',		//数据行其他单元格class
					TR_CLASS : 'listDataTr',				//数据行class
					TR_OVER_CLASS : 'listDataTr_over'	//数据行滑过class
			},
			
			/**
			 * 重构数据行td
			 */
			toDataTdHtml = function($tdField, i){
					var tdAttrs = {};
					tdAttrs.fieldtype = $tdField.attr('fieldtype');
					tdAttrs.displayType = $tdField.attr('displayType');
					tdAttrs.isHidden = $tdField.attr('isHidden');
					tdAttrs.colWidth = $tdField.attr('colWidth');
					tdAttrs.colGroundColor = $tdField.attr('colGroundColor');
					tdAttrs.colColor = $tdField.attr('colColor');
					tdAttrs.colFontSize = $tdField.attr('colFontSize');
					tdAttrs.isVisible = $tdField.attr('isVisible');
					tdAttrs.isReadonly = $tdField.attr('isReadonly');
					tdAttrs.colType = $tdField.attr('colType');
					tdAttrs.fieldInstanceOfWordField = $tdField.attr('fieldInstanceOfWordField');
					tdAttrs.fieldInstanceOfgenericWordField = $tdField.attr('fieldInstanceOfgenericWordField');
					tdAttrs.fieldInstanceOfMapField = $tdField.attr('fieldInstanceOfMapField');
					tdAttrs.displayType = $tdField.attr('displayType');
					tdAttrs.isShowTitle = $tdField.attr('isShowTitle');
					tdAttrs.colDisplayLength = $tdField.attr('colDisplayLength');
					tdAttrs.colFieldName = $tdField.attr('colFieldName');
					tdAttrs.colFlowReturnCss = $tdField.attr('colFlowReturnCss');
					tdAttrs.viewDisplayType = $tdField.attr('viewDisplayType');

					tdAttrs.isSignatureExist = $tdField.attr('isSignatureExist');
					tdAttrs.isEdit = $tdField.attr('isEdit');
					tdAttrs.colButtonType = $tdField.attr('colButtonType');
					tdAttrs.colApproveLimit = $tdField.attr('colApproveLimit');
					tdAttrs.colButtonName = $tdField.attr('colButtonName');
					tdAttrs.colMappingform = $tdField.attr('colMappingform');
					
					tdAttrs.result = $tdField.find("div[name='result']").html();
					tdAttrs.colIcon = $tdField.attr('colIcon');
					tdAttrs.colId = $tdField.attr("colId");
					tdAttrs.colTemplateForm = $tdField.attr("colTemplateForm");
					tdAttrs.showword = $tdField.attr("showword");
				
					var tdHtml = '';
					var pHtml = '';
					var aHtml = '';
				
					//tdAttrs.displayType = (tdAttrs.displayType == 'true'?true:false);
					tdAttrs.isShowTitle = (tdAttrs.isShowTitle == 'true'?true:false);
					tdAttrs.result = (tdAttrs.result?tdAttrs.result:'');
					
					tdAttrs.colWidth = (tdAttrs.colWidth != "null")?tdAttrs.colWidth:'';
					tdAttrs.colGroundColor = (tdAttrs.colGroundColor && tdAttrs.colGroundColor != "null" && tdAttrs.colGroundColor != "FFFFFF")?tdAttrs.colGroundColor:'';
					tdAttrs.colColor = (tdAttrs.colColor && tdAttrs.colColor != "null" && tdAttrs.colColor != "000000")?tdAttrs.colColor:'';
					tdAttrs.colFontSize = (tdAttrs.colFontSize && tdAttrs.colFontSize != "null" && tdAttrs.colFontSize != "12")?tdAttrs.colFontSize:'';
					tdAttrs.isVisible = (tdAttrs.isVisible == 'true'?true:false);
					tdAttrs.isReadonly = (tdAttrs.isReadonly == 'true'?true:false);
					tdAttrs.colType = tdAttrs.colType?tdAttrs.colType:"";
					tdAttrs.fieldInstanceOfWordField = (tdAttrs.fieldInstanceOfWordField == 'true'?true:false);
					tdAttrs.fieldInstanceOfgenericWordField = (tdAttrs.fieldInstanceOfgenericWordField == 'true'?true:false);
					tdAttrs.fieldInstanceOfMapField = (tdAttrs.fieldInstanceOfMapField == 'true'?true:false);
					//tdAttrs.displayType = tdAttrs.displayType?tdAttrs.displayType:"";
					tdAttrs.isShowTitle = (tdAttrs.isShowTitle == 'true'?true:false);

					tdAttrs.colDisplayLength = tdAttrs.colDisplayLength?tdAttrs.colDisplayLength:"";
					tdAttrs.colFieldName = tdAttrs.colFieldName?tdAttrs.colFieldName:"";
					tdAttrs.colFlowReturnCss = (tdAttrs.colFlowReturnCss == 'true'?true:false);
					tdAttrs.viewDisplayType = (tdAttrs.viewDisplayType != "null")?tdAttrs.viewDisplayType:'';
					
					tdAttrs.isSignatureExist = (tdAttrs.isSignatureExist == 'true'?true:false);
					tdAttrs.isEdit = (tdAttrs.isEdit == 'true'?true:false);
					tdAttrs.isHidden = (tdAttrs.isHidden == 'true'?true:false);
					tdAttrs.colButtonType = (tdAttrs.colButtonType != "null")?tdAttrs.colButtonType:'';
					tdAttrs.colApproveLimit = (tdAttrs.colApproveLimit != "null")?tdAttrs.colApproveLimit:'';
					tdAttrs.colButtonName = (tdAttrs.colButtonName != "null")?tdAttrs.colButtonName:'';
					tdAttrs.colMappingform = (tdAttrs.colMappingform != "null")?tdAttrs.colMappingform:'';
					tdAttrs.colIcon = (tdAttrs.colIcon != "null")?tdAttrs.colIcon:'';
					tdAttrs.showIcon =  ($tdField.attr('showIcon') != null) ? $tdField.attr('showIcon'):'';
					
					if(tdAttrs.result.indexOf("[")==0){
						tdAttrs.title = $tdField.find("div[name='result']").text();
					}

				var docId = $tdField.attr('docId');
				docId = docId?docId:'';
				
				//var title = $tdField.attr('title');
				var tip = "";
				//if(title.indexOf("<table>") == -1)
				//	tip = title;
				
				var viewTemplateForm = $tdField.attr('viewTemplateForm');
				viewTemplateForm = (viewTemplateForm != "null")?viewTemplateForm:'';
									
				var docFormid = $tdField.attr('docFormid');
				docFormid = docFormid?docFormid:'';
				
				var jumpMapping = $tdField.find("div[name='jumpMapping']").html();
				jumpMapping = jumpMapping?jumpMapping:'';
				
				var result = $tdField.find("div[name='result']").html();
				result = (result?result:'');
				
				if(tdAttrs.showIcon){
					result = "<img style='' src='../../../lib/icon/" + tdAttrs.showIcon+ "'/>";
				}

				var convert2HTMLEncode = function(str){
					var s = str;
					if(Column.COLUMN_TYPE_FIELD == tdAttrs.colType && !tdAttrs.colFieldName.substr(0,1) == "$" && !tdAttrs.colFlowReturnCss){
						s = s.replace(new RegExp(">","gm"),"&gt;");
						s = s.replace(new RegExp("<","gm"),"&lt;");
					}
					return s;
				};
				//多流程状态时数据处理
				var result2tdHtml = function(){
					var templateForm = "";
					if(View.DISPLAY_TYPE_TEMPLATEFORM == tdAttrs.viewDisplayType){
						templateForm = viewTemplateForm;
					}
					var resHtml = "";
					if("$StateLabel" == tdAttrs.colFieldName && (result.indexOf("[")==0 || result.indexOf("<img")==0)){//视图列绑定流程状态字段类型
						//解析json数据生成html
						resHtml += "<TABLE style=\"width:100%;border:0;\">";
						var instances;
						if(result.indexOf("[")==0){
							instances = JSON.parse(result);
						}else if(result.indexOf("<img")==0){
							var jsonStartIndex = result.indexOf("[{"),
								jsonEndIndex = result.lastIndexOf("}]"),
								imgHtml = result.substring(0,result.indexOf("<font")),
								fontStart = result.substring(result.indexOf("<font"),jsonStartIndex),
								fontEnd = result.substring(jsonEndIndex + 2,result.length);
							instances = result.substring(jsonStartIndex,jsonEndIndex + 2);
							instances = eval("(" + instances + ")");
						}
						for(var i=0;i<instances.length;i++){
							if(i+1==instances.length){
								resHtml += "<tr><td style=\"line-height:16px;border-right-width:0;border-bottom-width:0; border-right-style: none;\">";
							}else{
								resHtml += "<tr><td style=\"line-height:16px;border-right-width: 0px; border-right-style: none;\">";
							}
							var instance = instances[i];
							var instanceId = instance.instanceId;
							
							var nodes = instance.nodes;
							if(result.indexOf("<img")==0){
								resHtml += imgHtml;
							}
							for(var j=0;j<nodes.length;j++){
								var node = nodes[j];
								var nodeId = node.nodeId;
								var stateLable = truncationText(node.stateLabel,tdAttrs.displayType,tdAttrs.colDisplayLength,tdAttrs.showIcon);
								//只读
								if(tdAttrs.isReadonly){
									resHtml += stateLable;
								}else {
									resHtml += "<a href=\"javaScript:DisplayView.viewDoc(this, '";
									resHtml += docId + "', '";
									resHtml += docFormid + "', '";
									resHtml += tdAttrs.isSignatureExist + "', '";
									resHtml += templateForm + "', '";
									resHtml += tdAttrs.isEdit + "', '";
									resHtml += instanceId + "', '";
									resHtml += nodeId + "')\">";
									if(result.indexOf("<img")==0){
										stateLable = fontStart + stateLable + fontEnd;
									}
									resHtml += stateLable+"</a>&nbsp;&nbsp;";
								}
							}
							resHtml += "</td></tr>";
						}
						resHtml += "</TABLE>";
					
					}else if("$PrevAuditNode" == tdAttrs.colFieldName && result.indexOf("[")==0){//视图列绑定上一环节流程处理节点名称字段
						//解析json数据生成html
						resHtml += "<TABLE style=\"width:100%;border:0;\">";
						var instances = JSON.parse(result);
						for(var i=0;i<instances.length;i++){
							var instance = instances[i];
							var instanceId = instance.instanceId;
							var prevAuditNode = instance.prevAuditNode;

							if(i+1==instances.length){
								resHtml += "<tr><td title=\""+prevAuditNode+"\" style=\"line-height:16px;border-right-width:0;border-bottom-width:0; border-right-style: none;\">";
							}else{
								resHtml += "<tr><td title=\""+prevAuditNode+"\" style=\"line-height:16px;border-right-width: 0px; border-right-style: none;\">";
							}
							//只读
							if(tdAttrs.isReadonly){
								resHtml += truncationText(prevAuditNode,tdAttrs.displayType,tdAttrs.colDisplayLength,tdAttrs.showIcon);
							}else {
								resHtml += "<a href=\"javaScript:DisplayView.viewDoc(this, '";
								resHtml += docId + "', '";
								resHtml += docFormid + "', '";
								resHtml += tdAttrs.isSignatureExist + "', '";
								resHtml += templateForm + "', '";
								resHtml += tdAttrs.isEdit + "', '";
								resHtml += instanceId + "')\">";
								resHtml += truncationText(prevAuditNode,tdAttrs.displayType,tdAttrs.colDisplayLength,tdAttrs.showIcon)+"</a>&nbsp;&nbsp;";
							}
							resHtml += "</td></tr>";
						}
						resHtml += "</TABLE>";
					
					}else if("$PrevAuditUser" == tdAttrs.colFieldName && result.indexOf("[")==0){//视图列绑定上一环节流程处理节点名称字段
						//解析json数据生成html
						resHtml += "<TABLE style=\"width:100%;border:0;\">";
						var instances = JSON.parse(result);
						for(var i=0;i<instances.length;i++){
							var instance = instances[i];
							var instanceId = instance.instanceId;
							var prevAuditUser = instance.prevAuditUser;

							if(i+1==instances.length){
								resHtml += "<tr><td title=\""+prevAuditUser+"\" style=\"line-height:16px;border-right-width:0;border-bottom-width:0; border-right-style: none;\">";
							}else{
								resHtml += "<tr><td title=\""+prevAuditUser+"\" style=\"line-height:16px;border-right-width: 0px; border-right-style: none;\">";
							}
							//只读
							if(tdAttrs.isReadonly){
								resHtml += truncationText(prevAuditUser,tdAttrs.displayType,tdAttrs.colDisplayLength,tdAttrs.showIcon);
							}else {
								resHtml += "<a href=\"javaScript:DisplayView.viewDoc(this, '";
								resHtml += docId + "', '";
								resHtml += docFormid + "', '";
								resHtml += tdAttrs.isSignatureExist + "', '";
								resHtml += templateForm + "', '";
								resHtml += tdAttrs.isEdit + "', '";
								resHtml += instanceId + "')\">";
								resHtml += truncationText(prevAuditUser,tdAttrs.displayType,tdAttrs.colDisplayLength,tdAttrs.showIcon)+"</a>&nbsp;&nbsp;";
							}
							resHtml += "</td></tr>";
						}
						resHtml += "</TABLE>";
					
					}else {
						resHtml = truncationText(result,tdAttrs.displayType,tdAttrs.colDisplayLength,tdAttrs.showIcon);
					}
					return resHtml;
				};
				//序号列处理
				var processColumnNum = function(){
					return i + "";
				};
				
				if(!tdAttrs.isHidden){
					// 宽度为0时隐藏
					if((tdAttrs.colWidth && tdAttrs.colWidth == '0') || !tdAttrs.isVisible || tdAttrs.isHidden ){
						tdHtml += "<td class='" + Setting.TR_TD_CLASS + "' style='display: none;'";
					}else if(tdAttrs.colGroundColor != ""){//如果设置了底色,加上底色
						tdHtml += "<td class='" + Setting.TR_TD_CLASS + "' style='background-color:" + tdAttrs.colGroundColor + ";word-break: break-all;'";
					}else{
						tdHtml += "<td class='" + Setting.TR_TD_CLASS + "' style='word-break: break-all;'";
					}
					
					if(!(tdAttrs.isReadonly || tdAttrs.colType == "COLUMN_TYPE_LOGO") && result.indexOf("<TABLE>") == -1){
						tdHtml += " onClick=\"DisplayView.viewDoc(this, '"
							+ docId + "', '"
							+ docFormid + "', '"
							+ tdAttrs.isSignatureExist + "', '"
							+ templateForm + "', '"
							+ tdAttrs.isEdit + "')\"";
					}
					
					tdHtml += ">";
					
					//只读或logo列或列字段或word控件字段
					if(tdAttrs.isReadonly || tdAttrs.colType == "COLUMN_TYPE_LOGO" || tdAttrs.fieldInstanceOfWordField || tdAttrs.fieldInstanceOfMapField || tdAttrs.fieldInstanceOfgenericWordField ){//|| !tdAttrs.isEdit  ) {
						if(!tdAttrs.fieldInstanceOfWordField && !tdAttrs.fieldInstanceOfMapField && !tdAttrs.fieldInstanceOfgenericWordField){
							var pHtml = "";
							pHtml += "<p";
							if(tdAttrs.isShowTitle)
								pHtml += " title='" + title + "'";

							//如果有设置字体大小及颜色
							if((tdAttrs.colColor != "") || (tdAttrs.colFontSize != "")){
								pHtml += " style='";
								if(tdAttrs.colColor != ""){
									pHtml += "color:" + tdAttrs.colColor + ";";
								}
								if(tdAttrs.colFontSize != ""){
									pHtml += "font-size:" + tdAttrs.colFontSize + "px;";
								}
								pHtml += "'";
							}
							pHtml += " >";
							
							//子流程标签和处理人数据处理
							if(tdAttrs.isReadonly){
								if(result != null){
									result = result2tdHtml();
								}
							}
							
							//序号列处理
							if(tdAttrs.colType == Column.COLUMN_TYPE_ROWNUM){
								result = processColumnNum();
							}
							
							if(Column.DISPLAY_ALL == tdAttrs.displayType){
								pHtml += convert2HTMLEncode(result) + "</p>";
							}else{
								pHtml += convert2HTMLEncode(result) + "</p>";
							}
							tdHtml += pHtml;
						}
					}else{
						if(result != null){
							var aHtml = "";
							if(result.toLowerCase().indexOf("<a ") != -1 
									|| result.toLowerCase().indexOf("<a>") != -1
									|| (result.toLowerCase().indexOf("<input ") != -1 
									&& (result.toLowerCase().indexOf("type='button'") != -1 
									|| result.toLowerCase().indexOf("type=button") != -1))
									|| result.toLowerCase().indexOf("viewdoc") != -1){
								aHtml += result;
							}else{
								//子流程标签和处理人数据处理
								result = result2tdHtml();

								//序号列处理
								if(tdAttrs.colType == Column.COLUMN_TYPE_ROWNUM){
									result = processColumnNum();
								}
								
								var templateForm = "";
								if(View.DISPLAY_TYPE_TEMPLATEFORM == tdAttrs.viewDisplayType){
									templateForm = viewTemplateForm;
								}
								if(result.indexOf("<TABLE>") != -1  || !tdAttrs.isEdit){
//									aHtml += "<div style=\"cursor:pointer;\" onclick=\"javaScript:DisplayView.viewDoc(this, '";
									aHtml += "<div style=\"cursor:pointer;\" ";
								}else{
									aHtml += "<a ";
//									aHtml += "<a href=\"javaScript:DisplayView.viewDoc(this, '";
//									aHtml += docId + "', '";
//									aHtml += docFormid + "', '";
//									aHtml += tdAttrs.isSignatureExist + "', '";
//									aHtml += templateForm + "', '";
//									aHtml += tdAttrs.isEdit + "')\"";
								}
								
								//如果有设置字体大小及颜色
								if((tdAttrs.colColor != "") || (tdAttrs.colFontSize != "")){
									aHtml += " style='";
									if(tdAttrs.colColor != ""){
										aHtml += "color:#" + tdAttrs.colColor + ";";
									}
									if(tdAttrs.colFontSize != ""){
										aHtml += "font-size:" + tdAttrs.colFontSize + "px;";
									}
									aHtml += "'";
								}
									
								if(result.indexOf("img") != -1) {
									if(tdAttrs.isShowTitle)
										aHtml += " title='" + tdAttrs.title + "'";
										
									aHtml += " >";
									if(result.indexOf("<TABLE>") != -1){
										aHtml += convert2HTMLEncode(result) + "</div>";
									}else{
										var _result = convert2HTMLEncode(result);
										if($(_result).attr("moduletype") == "viewImageUpload" || ($(_result).attr("moduletype") != null && $(_result).attr("moduletype").indexOf("viewTakePhoto") >= 0)){
											var _url = $(_result).attr("url").replace(/\\'/g,"");
											var _picHtml = "<div class='images-preview' data-index='"+i+"' data-src='"+_url+"' style='display: inline-block;margin:3px;'>" +
															"<img style='max-height:50px;max-width:50px;' src='"+_url+"' />" +
															"</div>";
											aHtml += _picHtml + "</p>";
										}
									}
								}else{
									if(tdAttrs.isShowTitle)
										aHtml += " title='" + tdAttrs.title + "'";
									aHtml += " >";
									if(result.indexOf("<TABLE>") != -1){
										aHtml += convert2HTMLEncode(result) + "</div>";
									}else{
										if(tdAttrs.colType == "COLUMN_TYPE_FIELD"){
											if(tdAttrs.fieldtype=="weixinrecordfield" && jQuery.trim(result).indexOf("{")==0){
												aHtml+='<div class="weixin_record">';
												aHtml+= '<img src="../share/images/view/voice.png" width="21px"/>';
												aHtml+='</div>';
											} else if(tdAttrs.fieldtype=="weixingpsfield" && jQuery.trim(result).indexOf("{")==0){//微信gps定位控件
												var location = jQuery.parseJSON(result);
												aHtml+='<div class="gps_col">';
												if(tdAttrs.showType=="00"){//真实值
													aHtml+='<a href="#" class="gps_col_link" data-location=\''+result+'\'>';
													aHtml+='<span class="gps_col_text">'+location.address+'</span>';
													aHtml+='</a>';
												}else{//显示值
													aHtml+='<span class="gps_col_text">'+location.address+'</span>';
												}
												aHtml+='</div>';
											} else if(tdAttrs.fieldtype=="imageupload"){
												var _result = convert2HTMLEncode(result);
												if(_result && _result != "" && _result != " "){
													var _images = JSON.parse(convert2HTMLEncode(result));
													for(var i = 0; i < _images.length; i++){
														var _url = contextPath + _images[i].path;
														var _picHtml = "<div class='images-preview' data-src='"+_url+"' style='display: inline-block;margin:3px;'>" +
																"<img style='max-height:50px;max-width:50px;' src='"+_url+"' />" +
																"</div>";
														aHtml += _picHtml;
													}
												}
											} else if(tdAttrs.fieldtype=="attachmentupload"){
												var _result = convert2HTMLEncode(result);
												if(_result && _result != "" && _result != " "){
													var _images = JSON.parse(convert2HTMLEncode(result));
													for(var i = 0; i < _images.length; i++){
														var _url = contextPath + _images[i].path;
														var _name = _images[i].name;
														var _picHtml = "<a href='" + _url + "' target='_about'>" + _name + "</a>";
														aHtml += _picHtml;
													}
												}
											} else if(tdAttrs.fieldtype=="onlinetakephoto"){
												var _result = convert2HTMLEncode(result);
												if(_result && _result != "" && _result != " "){
													var _url = $(_result).attr("url");
													var _picHtml = "<div class='images-preview' data-src='"+_url+"' style='display: inline-block;margin:3px;'>" +
															"<img style='max-height:50px;max-width:50px;' src='"+_url+"' />" +
															"</div>";
													aHtml += _picHtml;
												}
											}else {
												aHtml += convert2HTMLEncode(result);
											}
										}else {
											aHtml += convert2HTMLEncode(result);
										}
										aHtml += "</a>";
									}
								}
							}
						}
						tdHtml += aHtml;
					}
					
					//操作列
					if("COLUMN_TYPE_OPERATE" == tdAttrs.colType && ColumnOperaType.BUTTON_TYPE_DELETE == tdAttrs.colButtonType){
						var inputHtml = "<input type=button value='" + tdAttrs.colButtonName;
						
						inputHtml += "' onclick=\"on_delete('"+docId+"')\" ";
						inputHtml += "/>";
						
						tdHtml += inputHtml;
						
					}else if("COLUMN_TYPE_OPERATE" == tdAttrs.colType && ColumnOperaType.BUTTON_TYPE_DOFLOW == tdAttrs.colButtonType){
						var inputHtml = "<input type=button value='" + tdAttrs.colButtonName;

						inputHtml += "' onclick=\"on_doflow('"+docId+"','"+tdAttrs.colApproveLimit+"')\" ";
						inputHtml += "/>";
						
						tdHtml += inputHtml;
						
					}else if("COLUMN_TYPE_OPERATE" == tdAttrs.colType && ColumnOperaType.BUTTON_TYPE_TEMPFORM == tdAttrs.colButtonType){
						var inputHtml = "<input type=button value='" + tdAttrs.colButtonName;
						
						inputHtml += "' onclick=\"DisplayView.viewDoc(this, '"+docId+"','"+docFormid+"','"+tdAttrs.isSignatureExist+"','"+tdAttrs.colTemplateForm+"')\" ";
						inputHtml += "/>";
						
						tdHtml += inputHtml;
						
					}else if("COLUMN_TYPE_OPERATE" == tdAttrs.colType && ColumnOperaType.BUTTON_TYPE_SCRIPT == tdAttrs.colButtonType){
						var inputHtml = "<input type=button value='" + tdAttrs.colButtonName;

						inputHtml += "' onclick=\"runscript('"+docId+"','"+tdAttrs.colId+"')\" ";
						inputHtml += "/>";
						
						tdHtml += inputHtml;
						
					}else if("COLUMN_TYPE_OPERATE" == tdAttrs.colType && ColumnOperaType.BUTTON_TYPE_JUMP == tdAttrs.colButtonType){
						var inputHtml = "<input type=button value='" + tdAttrs.colButtonName;

						inputHtml += "' onclick=\"jumptoform('"+tdAttrs.colMappingform+"',"+jumpMapping+",'"+tdAttrs.colButtonName+"')\" ";
						inputHtml += "/>";
						
						tdHtml += inputHtml;						
					}
					//logo列
					if("COLUMN_TYPE_LOGO" == tdAttrs.colType && tdAttrs.colIcon && tdAttrs.colIcon != ""){
						tdHtml += "<img style='' src='../../../lib/icon/" + tdAttrs.colIcon+ "'/>";
					}
					
					if(tdAttrs.fieldInstanceOfWordField){
						var btnHtml = "<img src='resource/images/view/word.gif'";						
						btnHtml += " onclick=\"showWordDialogWithView('"+tdAttrs.showword+"','WordControl','"+docId+"','"+result+"','"+tdAttrs.colFieldName+"',3,2,false,true)\" ></img>";
						
						tdHtml += btnHtml;					
					}else if(tdAttrs.fieldInstanceOfgenericWordField){//通用word控件
						var btnHtml = "<img src='resource/images/view/genericword.jpg'></img>";
						tdHtml += btnHtml;		
					}else if(tdAttrs.fieldInstanceOfMapField){
						var application = jQuery("body",parent.document).find("#application").val();
						var fieldVal = "";
						var displayType = 1;
						var f_id = docId + "_" + tdAttrs.colFieldName;
						var valhtml = tdAttrs.title == " "?"":"value = '" + tdAttrs.title + "'";
						var btnHtml = "<input type='hidden' id = '" + f_id + "' " + valhtml + ">";
						btnHtml += "<img src='../../share/images/view/map.png' style='margin: 0 5px;'";
						btnHtml += " onclick=\"FormBaiduMap('";
						btnHtml += f_id + "', '";
						btnHtml += application + "', '";
						btnHtml += displayType + "')\"";
						
						tdHtml += btnHtml;
					}else if (result && result.length == 0) {
						tdHtml += "&nbsp;";
					}
					tdHtml += "</td>";
				}
				
				return tdHtml;
			},//重构数据行td----end
			/**
			 * 重构表头
			 */
			toFirstTdHtml = function($tdField,i){
				var tdHtml = "";
				var thAttrs = {};
				thAttrs.upImg = "<img border=\"0\" src='../share/images/view/up.gif'/>";
				thAttrs.downImg = "<img border=\"0\" src='../share/images/view/down.gif'/>";
				
				thAttrs.colName = $tdField.attr("colName");
				thAttrs.colText = $tdField.attr("colText");
				thAttrs.isVisible = $tdField.attr("isVisible");
				thAttrs.isHiddenColumn = $tdField.attr("isHiddenColumn");
				thAttrs.colWidth = $tdField.attr("colWidth");
				thAttrs.colType = $tdField.attr("colType");
				thAttrs.colFieldName = $tdField.attr("colFieldName");
				thAttrs.isOrderByField = $tdField.attr("isOrderByField");
				thAttrs.isVisible = (thAttrs.isVisible == "true")?true:false;
				thAttrs.isHiddenColumn = (thAttrs.isHiddenColumn == "true")?true:false;
				thAttrs.colWidth = (thAttrs.colWidth == "null") ? "" : thAttrs.colWidth;
				if(thAttrs.isVisible && !thAttrs.isHiddenColumn){
					if(thAttrs.colWidth != "0"){
						if(thAttrs.colWidth != ""){
							isSetWidth = true;
						}
						if(i>2){
							i++;
							tdHtml += "<th colFieldName=\"" + thAttrs.colFieldName + "\" isOrderBy=\"" + thAttrs.isOrderByField + "\" isVisible=\"" + thAttrs.isVisible + "\" isHiddenColumn=\"" + thAttrs.isHiddenColumn + "\" class=\"" + Setting.TH_TD_CLASS + "\" data-priority='6'>"+thAttrs.colText+"</th>";
						}else {
							tdHtml += "<th colFieldName=\"" + thAttrs.colFieldName + "\" isOrderBy=\"" + thAttrs.isOrderByField + "\" isVisible=\"" + thAttrs.isVisible + "\" isHiddenColumn=\"" + thAttrs.isHiddenColumn + "\" class=\"" + Setting.TH_TD_CLASS + "\" data-priority='1'>"+thAttrs.colText+"</th>";
						}
					}else{
						tdHtml = "<th colFieldName=\"" + thAttrs.colFieldName + "\" isOrderBy=\"" + thAttrs.isOrderByField + "\" isVisible=\"" + thAttrs.isVisible + "\" isHiddenColumn=\"" + thAttrs.isHiddenColumn + "\" class=\"" + Setting.TH_TD_CLASS + "\" style=\"display:none;\">" + thAttrs.colName + "</th>";
					}
//				}else{
//					tdHtml = "<th isVisible=\"" + thAttrs.isVisible + "\"  isHiddenColumn=\"" + thAttrs.isHiddenColumn + "\" class=\"" + Setting.TH_TD_CLASS + "\" style=\"display:none;\">" + thAttrs.colName + "</th>";
				}
				
				var $tdHtml = jQuery(tdHtml);
				
				if(thAttrs.colType == "COLUMN_TYPE_FIELD"){
					if(_sortCol != "null"){
						if(_sortCol != "" && _sortCol.toUpperCase() == thAttrs.colFieldName.toUpperCase()){
							if(_sortStatus == "ASC"){
								$tdHtml.append(thAttrs.upImg);
							}else if(_sortStatus == "DESC"){
								$tdHtml.append(thAttrs.downImg);
							}
						}
						$tdHtml.bind("click",function(){
							DisplayView.sortTable(this,thAttrs.colFieldName);
						});
					}else{
						if(thAttrs.isOrderByField != "null" && thAttrs.isOrderByField != "" && thAttrs.isOrderByField == "true"){
							//可排序图标
							if(_sortStatus == "ASC"){
								$tdHtml.append(thAttrs.upImg);
							}else if(_sortStatus == "DESC"){
								$tdHtml.append(thAttrs.downImg);
							}
							$tdHtml.bind("click",function(){
								DisplayView.sortTable(this,thAttrs.colFieldName);
							})
						}
					}
				}				
				return $tdHtml;
			};//重构表头----end
			//根据列文本显示方式的配置，截取文本
			truncationText = function(input,displayType,displayLength,isShowIcon){
				if(displayType == Column.DISPLAY_PART && !isShowIcon){
					if(displayLength.match("\\d+") && displayLength < input.length){
						return input.substring(0,displayLength) + "...";
					}
				}
				return input;
			};
			
			var $field = jQuery(this);
			var _sortCol = $field.attr("_sortCol");
			var _sortStatus = $field.attr("_sortStatus");
			var isSum = $field.attr("isSum");
			isSum = (isSum == "true")?true:false;
			var $tableHtml = jQuery("<table data-column-btn-text=\"显示列\" class=\"table-column-toggle ui-responsive table-stroke\" data-role=\"table\" data-mode=\"columntoggle\"></table>");
			var sumTrIsHidden = true;

			//判断是否输出汇总行
			$field.find("#sumTrId").find("td").each(function(){
				if(jQuery(this).attr("isSum") == "true" || jQuery(this).attr("isTotal") == "true"){
					sumTrIsHidden = false;
					return;
				}
			});
			
			$field.children().children().each(function(i){//行<tr>
				var $trHtml = "";
				var $trField = jQuery(this);
				
				if(i == 0){//首行（列头）
					var $head = $("<thead></thead>");
					$trHtml = jQuery("<tr class=\"" + Setting.TH_CLASS + "\"></tr>");
					//首列
					var tdHtml = "";
					tdHtml = "<th class=\"" + Setting.TH_FIRST_TD_CLASS + "\" scope=\"col\"></th>";
					var inputHtml = "";
//						inputHtml += "<input type=\"checkbox\">";
					jQuery(tdHtml).append(jQuery(inputHtml).bind("click",function(){
						selectAll(this.checked);
					})).appendTo($trHtml);
					//其他列
					$trField.children().each(function(i){//单元格<td>
						var $tdField = jQuery(this);
						
						//根据列头的显示隐藏值设置数据行对应列的显示和隐藏值
						$field.find("tr:gt(0)").each(function(){
							$(this).find(" td:eq("+i+")").attr("isHidden", $tdField.attr("isHiddenColumn"));
						});
						
						$trHtml.append(toFirstTdHtml($tdField,i));
					});
					$tableHtml.append($head.append($trHtml));
					$trHtml = null;
					$head = null;
					
				}else if(isSum && !sumTrIsHidden && (i == $field.children().children().size()-1)){//末行(字段值汇总)
					$trHtml = jQuery("<tr class=\"" + Setting.TR_CLASS + "\" >");
					//首列
					var tdHtml = "<th class=\"" + Setting.TR_FIRST_TD_CLASS + "\">";
					tdHtml += "&nbsp;</th>";
					$trHtml.append(tdHtml);
					//其他列
					$trField.children().each(function(i){//单元格<td>
						var tdHtml = "";
						var $tdField = jQuery(this);
						var sumTdAttrs = {};
						sumTdAttrs.isVisible = $tdField.attr("isVisible");
						sumTdAttrs.isHiddenColumn = $tdField.attr("isHiddenColumn");
						sumTdAttrs.isSum = $tdField.attr("isSum");
						sumTdAttrs.isTotal = $tdField.attr("isTotal");
						sumTdAttrs.colName = $tdField.attr("colName");
						sumTdAttrs.sumByDatas = $tdField.attr("sumByDatas");
						sumTdAttrs.sumTotal = $tdField.attr("sumTotal");
						sumTdAttrs.isVisible = (sumTdAttrs.isVisible == "true")?true:false;
						sumTdAttrs.isHiddenColumn = (sumTdAttrs.isHiddenColumn == "true")?true:false;
						sumTdAttrs.isSum = (sumTdAttrs.isSum == "true")?true:false;
						sumTdAttrs.isTotal = (sumTdAttrs.isTotal == "true")?true:false;
						
						if(sumTdAttrs.isVisible && !sumTdAttrs.isHiddenColumn){
							tdHtml += "<td class=\"" + Setting.TR_TD_CLASS + "\" >";
							if(sumTdAttrs.isSum || sumTdAttrs.isTotal)
								tdHtml += sumTdAttrs.colName;
							if(sumTdAttrs.isSum){
								tdHtml += sumTdAttrs.sumByDatas + "&nbsp;";
							}
							if(sumTdAttrs.isTotal){
								tdHtml += sumTdAttrs.sumTotal + "&nbsp;";
							}
							tdHtml += "</td>";
						}
						$trHtml.append(tdHtml);
					});
					$tableHtml.append($trHtml);
					$trHtml = null;
				}else if($trField.attr("trType") =="dataTr"){//数据行
					var dtrHtml = "<tr class=\"" + Setting.TR_CLASS + "\">";
					//首列
					var docId = $trField.attr("docId");
					var tdHtml =  "<th class=\"" + Setting.TR_FIRST_TD_CLASS + "\">";
						tdHtml += "<input data-enhance='false' type=\"checkbox\" name=\"_selects\" value=\"" + docId + "\"/>";

						tdHtml += "</th>";
					dtrHtml += tdHtml;
					$trField.children().each(function(j){//单元格<td>
						var $tdField = jQuery(this);
						//其他列
						dtrHtml += toDataTdHtml($tdField, i);//重构数据单元格
					});
					
					dtrHtml += "</tr>";
					$tableHtml.append(dtrHtml);
					dtrHtml = "";
				}
			});
			
			var $viewID = ajaxPage.getCurPage().find("#view_"+$dvid);
			$tableHtml.attr("id","tableList_"+$dvid);
			$tableHtml.appendTo($viewID);
			if($tableHtml.find(".listDataTr").size()<= 0){
				var contentIsNum = "<div class='content-load-panel'><div class='contentIsNull'></div></div>";
				$viewID.append($(contentIsNum));
			}
			$field.remove();
			tableListColumn();
		});
	};
})(jQuery);



/**
 * jquery重构列表视图
 * for:列表视图
 */
function jqRefactor4DisplayView(){
	jQuery("table[moduleType='viewList']").obpmDisplayView();
	var $subPage = ajaxPage.getCurPage();
	$subPage.find("#searchFormTableSub").html($subPage.find('#searchFormTable').html());
	jqRefactor();
}

/**
 * 
 * @param url
 * @param id
 * @param isQueryButton: 是否查询按钮，子表查询时为tru，子表页面加载时为undefined
 */
function refreshDisplayView(url, id, isQueryButton){
	//获取查询表单数据作为load的参数
	var param = {};
	if(isQueryButton){
		param["isQueryButton"] = isQueryButton;
	}
	var $searchFormTable = ajaxPage.getCurPage().find("#searchFormTableSub");
	if($searchFormTable.size() > 0){
		$searchFormTable.find("input,select,textarea").not("#dy_refreshObj").each(function(){
			param[$(this).attr("name")] = $(this).val();
		});
	}
	ajaxPage.reloadPage(url,param,function(){
		Activity.showMessage(ajaxPage.getCurPage().find("#msg").html(), "error");
		var $tabParameter = ajaxPage.getCurPage().find(".tab_parameter_Display");
		var viewid = id + "_params";
		var $viewDiv = $("<div></div>").attr("id",id+"_params").attr("_action",url).css("display","none");
		//表单元素转成span标签存入dom中
		$.each($tabParameter.find("input[type!=button],select,textarea").serializeArray(),function(){
			$viewDiv.append("<span name='" + this.name + "'>" + this.value + "</span>"); 
		});
	
		//去掉表单元素
		$tabParameter.find("input[type!=button],select,textarea").each(function(){
			if(!$(this).attr("moduleType")) $(this).remove();
		});
		
		ajaxPage.getCurPage().find("title").attr("id",id);
		ajaxPage.getCurPage().append($viewDiv);
		
		//刷新时设置表单包含元素控件badge数字
		var _rowcount = $viewDiv.find("span[name='_rowcount']").text();
		$("[name='display_view']").each(function(){
			if($(this).attr("id") == id){
				$(this).includedView("refresh");
				if(_rowcount == ""){
					_rowcount = 0;
				}
				$(this).find(".weui-cell__ft").find(".weui-badge").text(_rowcount);
			}
		});
		
		setTimeout(function(){
			hideLoadingToast();
		},1000)
		
//		jqRefactor();
		//initDispComm();
	});
}

//子表翻页
function turnPage(act,obj){
	showLoadingToast();
	var url = DisplayView.actPagination(act,obj);
	var id = ajaxPage.getCurPage().find("title").attr("id");
	var isQueryButton = ajaxPage.getCurPage().find("title").attr("isQueryButton");
	refreshDisplayView(url,id,isQueryButton);
}

//===============================重构包含元素去掉iframe改用div--start

/**
* 子视图执行框架
*/
var DisplayView = {
	
	bindEven : function(){
		var $curPage = ajaxPage.getCurPage();
		//点击查询按钮展开查询表单
		$curPage.find(".searchForm_sub").unbind().bind("click", function(){	
			var $subPage = ajaxPage.getCurPage();
			//$subPage.find("#searchFormTableSub").html($subPage.find('#searchFormTable').html());
			//jqRefactor();
			$subPage.find(".searchPanel_sub").addClass("active");
			ajaxPage.addHashPostfix("_searchForm");
		});
		//查询表单界面关闭按钮
		$curPage.find(".searchPanel_sub #btn-modal-close").unbind().bind("click", function(){	
			var $subPage = ajaxPage.getCurPage();
			$subPage.find(".searchPanel_sub").removeClass("active");
			ajaxPage.clearHashPostfix("_searchForm");
		});
		//查询
		$curPage.find(".sub_modifyActionBack").unbind().bind("click",function(){
			var $subPage = ajaxPage.getCurPage();
			$subPage.find(".searchPanel_sub").removeClass("active");
			ajaxPage.clearHashPostfix("_searchForm");
			var url = $subPage.attr("href");
			var id = $subPage.find("title").attr("id");
			var isQueryButton = $subPage.find("title").attr("isQueryButton");
			refreshDisplayView(url, id, isQueryButton);
		});
		//重置
		$curPage.find(".sub_resetAll").unbind().bind("click",function(){
			//if(window.location.hash == "#_searchForm"){
			if(window.location.hash.indexOf("/_searchForm") >= 0){
				DisplayView.reset(this);
	    	}
		});
	},
	//返回子表翻页url
	actPagination : function(act,obj){
		var $thisTab =  ajaxPage.getCurPage();
		var viewId = $thisTab.find("title").attr("id")
		var $pageParameter = $thisTab.find("#"+ viewId + "_params");
		var $_currpage = parseInt($pageParameter.find("span[name='_currpage']").text()),
			$_pagelines = parseInt($pageParameter.find("span[name='_pagelines']").text()),
			$_rowcount = parseInt($pageParameter.find("span[name='_rowcount']").text());
		var totalPage = Math.ceil($_rowcount/$_pagelines);
		
		switch (act){
		case "showNextPage":
			return $thisTab.attr("href")+"&_currpage="+($_currpage+1);
			break;
		case "showFirstPage":
			return $thisTab.attr("href")+"&_currpage=1";
			break;
		case "showPreviousPage":
			return $thisTab.attr("href")+"&_currpage="+($_currpage-1);
			break;
		case "showLastPage":
			return $thisTab.attr("href")+"&_currpage="+totalPage;
			break;
		default:
			break;
		}	
	},
	/**
	 * 是否子页面
	 * @param obj
	 * @returns {Boolean}
	 */
	isSubPage : function(obj){
		//return (typeof ($(obj).parents("div[name='display_view']")[0]) == "object");
		return (ajaxPage.getCurPage().find("title").attr("title") == "displayView");
	},
	
	/**
	 * @param obj
	 * @returns 子表视图Div的js对象
	 */
	getTheView : function(obj){
		var title = ajaxPage.getCurPage().find("title").attr("title");
		return (title == "listView" ? false : ajaxPage.getCurPage());
	},
	//返回原来form中的action属性值
	getAction : function(obj){
		var view = DisplayView.getTheView(obj);
		return $(view).find("#"+$(view).attr("id") + "_params").attr("_action");
	},
	//获取存在dom中的参数，以json格式返回
	span2Json : function(obj){
		var view = DisplayView.getTheView(obj);
		var json = {};
		$(view).find("#"+$(view).find("title").attr("id") + "_params span").each(function(){			
		//$(view).find(".tab_parameter_Display>input").each(function(){
			var name = $(this).attr("name");
			//var val = $(this).val();
			var val = $(this).text();
			if(!json[name] || json[name] == ''){
				json[name] = val;
			}else {
				json[name] += ';' + val;
			}
		});
		return json;
	},
	//在json对象中添加元素值
	addVal2Params : function(json, elems){
		var params = '';
		params = this.json2Params(json);
		$(elems).each(function(){
			var name = this.name;
			var val = this.value;
			if(params == ''){
				params = name + '=' + val;
			}else {
				params += '&' + name + '=' + val;
			}
		});
		return params;
	},
	//获取存在dom中的参数，以params字符串返回
	span2Params : function(obj){
		var view = DisplayView.getTheView(obj);
		var params = '';
		$(view).find("#"+$(view).attr("id") + "_params span").each(function(){
			var name = $(this).attr("name");
			var val = encodeURIComponent($(this).text());
			if(params == ''){
				params = name + '=' + val;
			}else {
				params += '&' + name + '=' + val;
			}
		});
		$(view).find("input[name='_selects']:checked").each(function(){
			var name = $(this).attr("name");
			var val = $(this).val();
			if(params == ''){
				params = name + '=' + val;
			}else {
				params += '&' + name + '=' + val;
			}
		});
		return params;
	},
	//获取存在dom中的参数，以params字符串返回
	input2Span : function(){	
		var $tabParameter = ajaxPage.getCurPage().find(".tab_parameter_Display");
		var viewid = id + "_params";
		var $viewDiv = $("<div></div>").attr("id",id+"_params").attr("_action",url).css("display","none");
		//表单元素转成span标签存入dom中
		$.each($tabParameter.find("input[type!=button],select,textarea").serializeArray(),function(){
			$viewDiv.append("<span name='" + this.name + "'>" + this.value + "</span>"); 
		});
	
		//去掉表单元素
		$tabParameter.find("input[type!=button],select,textarea").each(function(){
			if(!$(this).attr("moduleType")) $(this).remove();
		});

		ajaxPage.getCurPage().find("title").attr("id",id);
		ajaxPage.getCurPage().append($viewDiv);
	},
	//获取存在dom中的参数，以params字符串返回
	refreshSpan : function(obj,name,val){
		var view = DisplayView.getTheView(obj);
		$(view).find("span[name=" + name + "]").each(function(){
			$(this).text(val);
		});
	},
	//把json转换成params字符串
	json2Params : function(json){
		var params = '';
		$.each(json,function(name,val){
			val = encodeURIComponent(val);
			if(params == ''){
				params = name + '=' + val;
			}else {
				params += '&' + name + '=' + val;
			}
		});
		return params;
	},
	//触发重计算
	doCalculation : function(container){
		var isrefreshonchanged = $(container).attr('isrefreshonchanged');
		if(isrefreshonchanged == true || isrefreshonchanged=='true'){
			var name = $(container).attr('getName');
			dy_refresh(name);
		}
	},
	//刷新页面内容
	refreshPage : function(obj,container,html){
		var $this = DisplayView.getTheView(obj);
		var $html = $("<div></div>").append(html);
		var $form = $html.find(".tab_parameter_Display");
		var _includeId = $this.id;
		var includeId = _includeId + "_params";
		var $viewDiv = $("<div></div>").attr("id",includeId).attr("_action",$form.attr("action")).css("display","none");

		//表单元素转成span标签存入dom中
		$.each($form.find("input[type!=button],select,textarea").serializeArray(),function(){
			$viewDiv.append("<span name='" + this.name + "'>" + this.value + "</span>"); 
		});
		$html.append($viewDiv);
		//去掉表单元素
		$form.find("input[type!=button],select,textarea").each(function(){
			if(!$(this).attr("moduleType")) $(this).remove();
		});
		//插入dom中
		$(container).html($html.html());
		if(typeof(initDispComm)=='function'){
			initDispComm();	//子视图公用初始化方法
			this.doCalculation(container);	//执行刷新重计算方法
		}
	},
	//ajax提交
	postForm : function(obj,url,json){
		$.ajax({
			type : 'POST',
			url : url,
			async : false,
			dataType : 'html',
			data : json,
			context : this.getTheView(obj),
			success : function(html){
				DisplayView.refreshPage(obj,this,html);
			}
		});
	},
	//把json数据转成dom元素(导出Excel时模拟form提交)
	json2Textarea : function(json) {
		var html = '';
		$.each(json,function(name,val){
			html += '<textarea name="'+name+'">'+val+'</textarea>';
		});
		return html;
	},
	//文件下载
	downloadFile : function(url,json){
		$('<form></form>').attr('method','post').attr('action',url).append(this.json2Textarea(json)).submit().remove();
	},
	//打印预览
	printView : function(url,json){
		$('<form></form>').attr('action',url).attr('target','_my_submit_win').append(this.json2Textarea(json)).submit();
	},
	//打开查询页面
	openSearch : function(obj){
		var $div = $('<div id="searchFormTableSub"></div>').append($('#searchFormTable').html());
		artDialog({
			content:$('<div></div>').append($div).html(),
			lock:true,
			width:800,
			height:150,
			okVal:'查询'
		    },
		    function(){
		    	DisplayView.search(obj);
		    },
		    function(){
		    	//取消
		    }
		);
	},
	//查询按钮
	search : function(obj){
		var $subPage = obj.parents("[type='includedView']");
		var json = this.span2Json(obj);
		json['_currpage'] = 1;	//重置页码
		//添加控件参数
		$subPage.find("#searchFormTableSub").find("input,select,textarea").each(function(){
			json[this.name] = this.value;
		});
		var url = contextPath + "/portal/dynaform/view/displayView.action";
		this.postForm(obj,url,json);
	},
	//重置按钮
	reset : function(obj){
		var $subPage = ajaxPage.getCurPage();
		$subPage.find('#searchFormTableSub').find("input,select,textarea").each(function(){
			$(this).val("");
			$(this).text("");
		});
	},
	// 改变排序状态
	changeStatus : function(json, oCol, nCol) {
		if (oCol != nCol && oCol.toUpperCase() != nCol.toUpperCase()) {
			json['_sortStatus'] = "ASC";
			json['_sortCol'] = nCol;
		} else {
			if (json['_sortStatus'] == "ASC") {
				json['_sortStatus'] = "DESC";
				json['_sortCol'] = nCol;
			} 
			else {
				json['_sortStatus'] = "ASC";
				json['_sortCol'] = nCol;
			}
		}
		return json;
	},
	//单击列头排序
	sortTable : function(obj,nColName) {
		var json = this.span2Json(obj);
		var oColName = json['_sortCol'];
		json = this.changeStatus(json, oColName, nColName);
		var url = $(DisplayView.getTheView(obj)).attr("src");		
		this.postForm(obj,url,{"_sortStatus":json['_sortStatus'],"_sortCol":json['_sortCol']});
	},
	//设置按钮为灰色且不能再操作
	toggleButton : function(obj,btnName) {
		var theBody = this.getTheBody(obj);
		var isBreak = false;
		var button_acts = $(theBody).find('[name=btnName]');
		$(theBody).find('[name=btnName]').each(function(){
			if($(this).attr("isLoad") == "false"){
				isBreak = true;
			}else{
				$(this).attr('isLoad','false');
				$(this).css('color','gray');
			}
		});
		return isBreak;
	},
	//获取选中的行数据
	getCheckedListStr : function(obj,fldName) {
		var view = this.getTheView(obj);
		var rtn = '';
		var flds = $(view).find('[name='+fldName+']');
		$(view).find('[name='+fldName+']').each(function(){
			if($(this).attr('type') == 'checkbox' || $(this).attr('type') == 'radio'){
				if (this.checked && this.value) {
					if(rtn==''){
						rtn += this.value;
					}else {
						rtn += ';' + this.value;
					}
				}
			}else{
				rtn = this.value;
			}
		});
		return rtn;
	},
	//获取选中值
	getValuesMap : function(obj,json) {
		var valuesMap = {};
		var mapVal = "";
		var mapVals = new Array();
		var view = this.getTheView(obj);
		if ($(view).find('[name=_selects]')) {
			var selects = this.getCheckedListStr(obj,'_selects');
			json['_selectsText'] = selects ? selects : '';
		}
		return this.json2Params(json);
	},
	addSearchFormParams : function(obj,json){
		var view = this.getTheView(obj);
		$(view).find("#searchFormTable").find("input,select,textarea").each(function(){
			json[this.name] = this.value;
		});
		return json;
	},
	//重置backurl
	resetBackURL : function(obj,_backURL){
		var view = this.getTheView(obj);
		//添加控件参数
		var isHasAdd = false;	//url是否已添加参数
		if(_backURL!='' && (_backURL.indexOf('&')>=0 || _backURL.indexOf('?')>=0)){
			isHasAdd = true;
		}
		$(view).find("#searchFormTable").find("input,select,textarea").each(function(){
			if(isHasAdd){
				_backURL += "&";
			}else{
				_backURL += "?";
				isHasAdd = true;
			}
			_backURL += this.name + "=" + this.value;;
		});

		return _backURL;
	},
	//获取选中的列表数据
	getSelects : function(view){
		var oSelects = $(view).find("[name='_selects']");
		var _selects="";
		if(oSelects){
			for(var i=0;i<oSelects.length;i++){
				if(oSelects[i].checked){
					_selects+="&_selects="+oSelects[i].value;
				}
			}
		}
		return _selects;
	},
	//查看数据子方法
	viewDocSub : function(obj,action, title, viewType, actid) {
		var openType = OPEN_TYPE_DIV;	//全部使用弹出层方式打开
		var view = this.getTheView(obj);
		var flag = false;
		var _action = this.getAction(obj);
		var json = this.span2Json(obj);
		//执行前脚本
		if(actid){
			jQuery.ajax({
				type: 'POST',
				async:false, 
				url: contextPath + '/portal/dynaform/activity/runbeforeactionscript.action?_actid=' + actid,
				dataType : 'html',
				timeout: 3000,
				data: json,
				success:function(result) {
					if(result != null && result != ""){
			        	var jsmessage = eval("(" + result + ")");
			        	var type = jsmessage.type;
			        	var content = jsmessage.content;
			        	
			        	if(type == '16'){
			        		this.postForm(obj,_action,json);
			        	}
			        	
			        	if(type == '32'){
			        		var rtn = window.confirm(content);
			        		if(!rtn){
				        		this.postForm(obj,_action,json);
			        		}else {
			        			flag = true;
			        		}
			        	}
			        }else {
			        	flag = true;
			        }
				},
				error: function(result) {
					alert("运行脚本出错");
				}
			});
		} else {
			flag = true;
		}

		if(flag){
			var url = action;
		
			if (viewType == VIEW_TYPE_SUB) {
				url += "&isSubDoc=true";
			}
			
			json['_backURL'] = this.resetBackURL(obj,json['_backURL']);	//添加查询表单中的参数
			this.addSearchFormParams(obj,json);	//添加查询表单中的参数
			
			var _json = json;
			var _backURL = json['_backURL'];
			delete json['_backURL'];
			
			var parameters = this.getValuesMap(obj,json);
		
			if (openType == OPEN_TYPE_DIV) {
				var oSelects = $(view).find("[name='_selects']");
				var _selects="";
				if(oSelects){
					for(var i=0;i<oSelects.length;i++){
						if(oSelects[i].checked){
							_selects+="&_selects="+oSelects[i].value;
						}
					}
				}
				url += "&" + parameters + "&openType=" + openType+_selects;
				ajaxPage.getSubViewFormHash(url);
			}
		}
	},
	//查看数据
	viewDoc : function(obj,docid, formid ,signatureExist,templateForm,isEdit,instanceId,nodeId) {
		// 查看/script/view.js
		var url = docviewAction;
		url += '?_docid=' + docid;
		if (formid) {
			url += '&_formid=' +  formid;
		}
		if (templateForm) {
			url += '&_templateForm=' +  templateForm;
		}
//		if(signatureExist){
//			url += '&signatureExist=' +  signatureExist;
//		}
		if(isedit){
			url += '&isedit=' +  isedit+"";
			//url += '&show_act=' +  isedit+"";
			
		}
		if(instanceId){
			url += '&_targetInstance=' +  instanceId;
		}
		if(nodeId){
			url += '&_targetNode=' +  nodeId;
		}
		this.viewDocSub(obj,url,selectStr, VIEW_TYPE_SUB);
	}
};


//===============================重构包含元素去掉iframe改用div--end