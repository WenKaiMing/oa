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
		jQuery("div[moduleType='viewFileManager']").obpmViewFileManager();  	//内嵌视图文件管理功能
		jQuery("div[moduleType='viewTakePhoto']").obpmViewTakePhoto();  	//内嵌视图在线拍照功能
		jQuery("div[moduleType='viewImageUpload']").obpmViewImageUpload();  	//内嵌视图图片上传功能
	},50);
	setTimeout(function(){
		jqRefactor();//表单控件jquery重构
	},10);
	selectData4Doc(); //回选列表数据
	document.ondblclick=handleDbClick;
	setTimeout(function(){
		dataTableSize();
	},300);
	ev_reloadParent();	//刷新父窗口	
	DisplayView.init();	//初始化子视图事件
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
}
//设置数据容器的高度。
function dataTableSize(){
	var dataTableH = jQuery("#dataTable").height();
	if(dataTableH >= 400){
		jQuery("#table_container").height(dataTableH);
	}
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

function FormBaiduMap(FieldID,applicationid,displayType){
	var oField = jQuery("#"+ FieldID);
	var url=contextPath+"/portal/share/component/map/form/baiduMap.jsp?type=dialog&applicationid="+applicationid+"&displayType="+displayType;
	OBPM.dialog.show({
		title : title_map,
		url : url,
		args: {"fieldID":FieldID,"mapData":oField.val()},
		width : 1000,
		height : 600,
		close : function(result) {
		}
	});
}

function on_doflow(colId, approveLimit){
	var temps = document.getElementsByName("_selects");
	for(i = 0; i<temps.length; i++){
		if(document.getElementsByName("_selects")[i].value == colId){
			document.getElementsByName("_selects")[i].checked = true;
		}else{
			document.getElementsByName("_selects")[i].checked = false;
		}
	}
	var _approveLimit = document.createElement("input");
	_approveLimit.type = "hidden";
	_approveLimit.name="_approveLimit";
	_approveLimit.value=approveLimit;
	document.forms[0].appendChild(_approveLimit);
	document.forms[0].action = 'doflow.action';
	document.forms[0].submit();
}

/**
 * 重构displayView
 */
(function($){
	$.fn.obpmDisplayView = function(){
		return this.each(function(){
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
			toDataTdHtml = function($tdField,row){
				var tdAttrs = {};
				tdAttrs.fieldType = $tdField.attr('fieldType');
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
				tdAttrs.viewTemplateForm = $tdField.attr('viewTemplateForm');
				tdAttrs.docId = $tdField.attr('docId');
				tdAttrs.docFormid = $tdField.attr('docFormid');
				tdAttrs.isSignatureExist = $tdField.attr('isSignatureExist');
				tdAttrs.isEdit = $tdField.attr('isEdit');
				tdAttrs.colButtonType = $tdField.attr('colButtonType');
				tdAttrs.colApproveLimit = $tdField.attr('colApproveLimit');
				tdAttrs.colButtonName = $tdField.attr('colButtonName');
				tdAttrs.colMappingform = $tdField.attr('colMappingform');
				tdAttrs.jumpMapping = $tdField.find("div[name='jumpMapping']").html();
				tdAttrs.colIcon = $tdField.attr('colIcon');
				tdAttrs.result = $tdField.find("div[name='result']").html();
				tdAttrs.colId = $tdField.attr("colId");
				tdAttrs.colTemplateForm = $tdField.attr('colTemplateForm');
				
				var tdHtml = '';
				var pHtml = '';
				var aHtml = '';

				tdAttrs.isHidden = (tdAttrs.isHidden == 'true'?true:false);
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
				tdAttrs.displayType = tdAttrs.displayType?tdAttrs.displayType:"";
				tdAttrs.isShowTitle = (tdAttrs.isShowTitle == 'true'?true:false);
				tdAttrs.result = (tdAttrs.result?tdAttrs.result:'');
				tdAttrs.colDisplayLength = tdAttrs.colDisplayLength?tdAttrs.colDisplayLength:"";
				tdAttrs.colFieldName = tdAttrs.colFieldName?tdAttrs.colFieldName:"";
				tdAttrs.colFlowReturnCss = (tdAttrs.colFlowReturnCss == 'true'?true:false);
				tdAttrs.viewDisplayType = (tdAttrs.viewDisplayType != "null")?tdAttrs.viewDisplayType:'';
				tdAttrs.viewTemplateForm = (tdAttrs.viewTemplateForm != "null")?tdAttrs.viewTemplateForm:'';
				tdAttrs.docId = tdAttrs.docId?tdAttrs.docId:'';
				tdAttrs.docFormid = tdAttrs.docFormid?tdAttrs.docFormid:'';
				tdAttrs.isSignatureExist = (tdAttrs.isSignatureExist == 'true'?true:false);
				tdAttrs.isEdit = (tdAttrs.isEdit == 'true'?true:false);
				tdAttrs.colButtonType = (tdAttrs.colButtonType != "null")?tdAttrs.colButtonType:'';
				tdAttrs.colApproveLimit = (tdAttrs.colApproveLimit != "null")?tdAttrs.colApproveLimit:'';
				tdAttrs.colButtonName = (tdAttrs.colButtonName != "null")?tdAttrs.colButtonName:'';
				tdAttrs.colMappingform = (tdAttrs.colMappingform != "null")?tdAttrs.colMappingform:'';
				tdAttrs.jumpMapping = tdAttrs.jumpMapping?tdAttrs.jumpMapping:'';
				tdAttrs.colIcon = (tdAttrs.colIcon != "null")?tdAttrs.colIcon:'';
				tdAttrs.showIcon =  ($tdField.attr('showIcon') != null) ? $tdField.attr('showIcon'):'';

				if(tdAttrs.result.indexOf("[") < 0){
					tdAttrs.title = $tdField.find("div[name='result']").text();
				}else{
					tdAttrs.title = "";
				}
				
				if(tdAttrs.showIcon){
					tdAttrs.result = "<img style='' src='../../../lib/icon/" + tdAttrs.showIcon+ "'/>";
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
					if("$StateLabel" == tdAttrs.colFieldName && (tdAttrs.result.indexOf("[")==0 || tdAttrs.result.indexOf("<img")==0)){//视图列绑定流程状态字段类型
						//解析json数据生成html
						resHtml += "<TABLE style=\"width:100%;border:0;\">";
						var instances;
						if(tdAttrs.result.indexOf("[")==0){
							instances = JSON.parse(tdAttrs.result);
						}else if(tdAttrs.result.indexOf("<img")==0){
							var jsonStartIndex = tdAttrs.result.indexOf("[{"),
								jsonEndIndex = tdAttrs.result.lastIndexOf("}]"),
								imgHtml = tdAttrs.result.substring(0,tdAttrs.result.indexOf("<font")),
								fontStart = tdAttrs.result.substring(tdAttrs.result.indexOf("<font"),jsonStartIndex),
								fontEnd = tdAttrs.result.substring(jsonEndIndex + 2,tdAttrs.result.length);
							instances = tdAttrs.result.substring(jsonStartIndex,jsonEndIndex + 2);
							instances = eval("(" + instances + ")");
						}
						for(var i=0;i<instances.length;i++){
							if(i+1==instances.length){
								resHtml += "<tr><td style=\"line-height:16px;border:0px;\">";
							}else{
								resHtml += "<tr><td style=\"line-height:16px;border-right-width: 0px; border-right-style: none;\">";
							}
							var instance = instances[i];
							var instanceId = instance.instanceId;
							
							var nodes = instance.nodes;
							if(result.indexOf("<img") == 0){
								resHtml += imgHtml;
							}
							for(var j=0;j<nodes.length;j++){
								var node = nodes[j];
								var nodeId = node.nodeId;
								var stateLable = truncationText(node.stateLabel,tdAttrs.displayType,tdAttrs.colDisplayLength,tdAttrs.showIcon);
								//只读
								if(tdAttrs.isReadonly){
									resHtml += stateLable;
								}else {
									resHtml += "<a onclick=\"DisplayView.viewDoc(this,'";
									resHtml += tdAttrs.docId + "', '";
									resHtml += tdAttrs.docFormid + "', '";
									resHtml += tdAttrs.isSignatureExist + "', '";
									resHtml += templateForm + "', '";
									resHtml += tdAttrs.isEdit + "', '";
									resHtml += instanceId + "', '";
									resHtml += nodeId + "')\">";
									
									if(tdAttrs.result.indexOf("<img")==0){
										stateLable = fontStart + stateLable + fontEnd;
									}
									resHtml += stateLable+"</a>&nbsp;&nbsp;";
								}
							}
							resHtml += "</td></tr>";
						}
						resHtml += "</TABLE>";
					
					}else if("$PrevAuditNode" == tdAttrs.colFieldName && tdAttrs.result.indexOf("[")==0){//瑙嗗浘鍒楃粦瀹氫笂涓?幆鑺傛祦绋嬪鐞嗚妭鐐瑰悕绉板瓧娈?
						//解析json数据生成html
						resHtml += "<TABLE style=\"width:100%;border:0;\">";
						var instances = JSON.parse(tdAttrs.result);
						for(var i=0;i<instances.length;i++){
							var instance = instances[i];
							var instanceId = instance.instanceId;
							var prevAuditNode = instance.prevAuditNode;

							if(i+1==instances.length){
								resHtml += "<tr><td title=\""+prevAuditNode+"\" style=\"line-height:16px;border:0px;\">";
							}else{
								resHtml += "<tr><td title=\""+prevAuditNode+"\" style=\"line-height:16px;border-right-width: 0px; border-right-style: none;\">";
							}
							//只读
							if(tdAttrs.isReadonly){
								resHtml += truncationText(prevAuditNode,tdAttrs.displayType,tdAttrs.colDisplayLength,tdAttrs.showIcon);
							}else {
								resHtml += "<a onclick=\"DisplayView.viewDoc(this,'";
								resHtml += tdAttrs.docId + "', '";
								resHtml += tdAttrs.docFormid + "', '";
								resHtml += tdAttrs.isSignatureExist + "', '";
								resHtml += templateForm + "', '";
								resHtml += tdAttrs.isEdit + "', '";
								resHtml += instanceId + "')\">";
								resHtml += truncationText(prevAuditNode,tdAttrs.displayType,tdAttrs.colDisplayLength,tdAttrs.showIcon)+"</a>&nbsp;&nbsp;";
							}
							resHtml += "</td></tr>";
						}
						resHtml += "</TABLE>";
					
					}else if("$PrevAuditUser" == tdAttrs.colFieldName && tdAttrs.result.indexOf("[")==0){//瑙嗗浘鍒楃粦瀹氫笂涓?幆鑺傛祦绋嬪鐞嗚妭鐐瑰悕绉板瓧娈?
						//解析json数据生成html
						resHtml += "<TABLE style=\"width:100%;border:0;\">";
						var instances = JSON.parse(tdAttrs.result);
						for(var i=0;i<instances.length;i++){
							var instance = instances[i];
							var instanceId = instance.instanceId;
							var prevAuditUser = instance.prevAuditUser;

							if(i+1==instances.length){
								resHtml += "<tr><td title=\""+prevAuditUser+"\" style=\"line-height:16px;border:0px;\">";
							}else{
								resHtml += "<tr><td title=\""+prevAuditUser+"\" style=\"line-height:16px;border-right-width: 0px; border-right-style: none;\">";
							}
							//只读
							if(tdAttrs.isReadonly){
								resHtml +=  truncationText(prevAuditUser,tdAttrs.displayType,tdAttrs.colDisplayLength,tdAttrs.showIcon);
							}else {
								resHtml += "<a onclick=\"DisplayView.viewDoc(this,'";
								resHtml += tdAttrs.docId + "', '";
								resHtml += tdAttrs.docFormid + "', '";
								resHtml += tdAttrs.isSignatureExist + "', '";
								resHtml += templateForm + "', '";
								resHtml += tdAttrs.isEdit + "', '";
								resHtml += instanceId + "')\">";
								resHtml +=  truncationText(prevAuditUser,tdAttrs.displayType,tdAttrs.colDisplayLength,tdAttrs.showIcon)+"</a>&nbsp;&nbsp;";
							}
							resHtml += "</td></tr>";
						}
						resHtml += "</TABLE>";
					
					}else {
						resHtml = truncationText(tdAttrs.result,tdAttrs.displayType,tdAttrs.colDisplayLength,tdAttrs.showIcon);
					}
					return resHtml;
				};
				if(!tdAttrs.isHidden){

					var templateForm = "";
					if(View.DISPLAY_TYPE_TEMPLATEFORM == tdAttrs.viewDisplayType){
						templateForm = tdAttrs.viewTemplateForm;
					}
					
					// 宽度为0时隐藏
					if((tdAttrs.colWidth && tdAttrs.colWidth == '0') || !tdAttrs.isVisible){
						tdHtml += "<td class='" + Setting.TR_TD_CLASS + "' style='display: none;'";
					}else if(tdAttrs.colGroundColor != ""){//如果设置了底色,加上底色
						tdHtml += "<td class='" + Setting.TR_TD_CLASS + "' width='"
								+ tdAttrs.colWidth + "' style='background-color:" + tdAttrs.colGroundColor + "'";
					}else{
						tdHtml += "<td class='" + Setting.TR_TD_CLASS + "' width='" + tdAttrs.colWidth + "'";
					}

					if(!(tdAttrs.isReadonly || tdAttrs.colType == "COLUMN_TYPE_LOGO"  || tdAttrs.colType == "COLUMN_TYPE_OPERATE") && tdAttrs.result.indexOf("<TABLE>") == -1){
						tdHtml += " onclick=\"DisplayView.viewDoc(this,'";
						tdHtml += tdAttrs.docId + "', '";
						tdHtml += tdAttrs.docFormid + "', '";
						tdHtml += tdAttrs.isSignatureExist + "', '";
						tdHtml += templateForm + "', '";
						tdHtml += tdAttrs.isEdit + "')\"";
					}
					tdHtml += "></td>";
					
					var $tdHtml = jQuery(tdHtml);
					
					if(tdAttrs.isReadonly || tdAttrs.colType == "COLUMN_TYPE_LOGO" || tdAttrs.fieldInstanceOfWordField || tdAttrs.fieldInstanceOfMapField || tdAttrs.fieldInstanceOfgenericWordField){//|| !isEdit  ) {
						if(!tdAttrs.fieldInstanceOfWordField && !tdAttrs.fieldInstanceOfMapField && ! tdAttrs.fieldInstanceOfgenericWordField){
							var pHtml = "";
							pHtml += "<p";
							if(tdAttrs.isShowTitle)
								pHtml += " title='" + tdAttrs.title + "'";

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
								if(tdAttrs.result != null){
									tdAttrs.result = result2tdHtml();
								}
							}
							pHtml += convert2HTMLEncode(tdAttrs.result) + "</p>";
							$tdHtml.append(pHtml);
						}
					}else{
						if(tdAttrs.result != null){
							var aHtml = "";
							var result = tdAttrs.result;
							if("$StateLabel" == tdAttrs.colFieldName && result.indexOf("[")==0){//视图列绑定流程状态字段类型
								//解析json数据生成html
								aHtml += "<div><ul>";
								var instances = JSON.parse(result);
								for(var i=0;i<instances.length;i++){
									aHtml += "<li style=\"list-style-type:none;\">";
									var instance = instances[i];
									var instanceId = instance.instanceId;
									
									var nodes = instance.nodes;
									for(var j=0;j<nodes.length;j++){
										var node = nodes[j];
										var nodeId = node.nodeId;
										var stateLable = node.stateLabel;
										aHtml += "<a onclick=\"DisplayView.viewDoc(this,'";
										aHtml += tdAttrs.docId + "', '";
										aHtml += tdAttrs.docFormid + "', '";
										aHtml += tdAttrs.isSignatureExist + "', '";
										aHtml += templateForm + "', '";
										aHtml += tdAttrs.isEdit + "', '";
										aHtml += instanceId + "', '";
										aHtml += nodeId + "')\">";
										
										aHtml += stateLable+"</a>&nbsp;&nbsp;";
									}
									aHtml += "</li>";
								}
								aHtml += "</ul></div>";
							}
							else if(tdAttrs.result.toLowerCase().indexOf("<a ") != -1 
									|| tdAttrs.result.toLowerCase().indexOf("<a>") != -1
									|| tdAttrs.result.toLowerCase().indexOf("<input ") != -1 
									&& (tdAttrs.result.toLowerCase().indexOf("type='button'") != -1 
									|| tdAttrs.result.toLowerCase().indexOf("type=button") != -1)
									|| tdAttrs.result.toLowerCase().indexOf("viewdoc") != -1){
								aHtml += tdAttrs.result;
							}else{
								//子流程标签和处理人数据处理
								tdAttrs.result = result2tdHtml();
								/*var tdAttrsTitle = '';
								if(tdAttrs.title != undefined ){	//a标签的title属性若为undefined，则显示''
									tdAttrsTitle = tdAttrs.title;
								}*/
								var templateForm = "";
								if(View.DISPLAY_TYPE_TEMPLATEFORM == tdAttrs.viewDisplayType){
									templateForm = tdAttrs.viewTemplateForm;
								}
								if(tdAttrs.result.indexOf("[{") != -1){
									aHtml += "<div style=\"cursor:pointer;\" ";
								}else{
									aHtml += "<a";
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
								
								if(tdAttrs.result.indexOf("img") != -1) {
									if(tdAttrs.isShowTitle){
										
										aHtml += " title='" + tdAttrs.title + "'";
									}
										
									aHtml += " >";
									aHtml += convert2HTMLEncode(tdAttrs.result);
									if(tdAttrs.result.indexOf("[{") != -1){
										aHtml += "</div>";
									}else{
										aHtml += "</a>";
									}
								}else{
									aHtml += " title='" + tdAttrs.title + "'>";

									if(tdAttrs.colType == "COLUMN_TYPE_FIELD"){
										if(tdAttrs.fieldType=="weixinrecordfield" && jQuery.trim(result).indexOf("{")==0){
											aHtml+='<div class="weixin_record">';
											aHtml+= '<img src="../../share/images/view/voice.png" width="21px"/>';
											aHtml+='</div>';
										}
										else if(tdAttrs.fieldType=="weixingpsfield" && jQuery.trim(result).indexOf("{")==0){//微信gps定位控件
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
										}else if(tdAttrs.fieldType=="imageupload"){
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
										}else if(tdAttrs.fieldType=="attachmentupload"){
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
										}else{
											aHtml += convert2HTMLEncode(tdAttrs.result);
										}
									}else{
										aHtml += convert2HTMLEncode(tdAttrs.result);
									}
									if(tdAttrs.result.indexOf("[{") != -1){
										aHtml += "</div>";
									}else{
										aHtml += "</a>";
									}
								}
							}
						}
						$tdHtml.append(aHtml);
					}
					var inputHtml ="";
					if("COLUMN_TYPE_OPERATE" == tdAttrs.colType && ColumnOperaType.BUTTON_TYPE_DELETE == tdAttrs.colButtonType){
						inputHtml += "<input type=button value='" + tdAttrs.colButtonName + "' onclick=\"DisplayView.on_delete(this, '"+tdAttrs.docId+"')\" />";
					}else if("COLUMN_TYPE_OPERATE" == tdAttrs.colType && ColumnOperaType.BUTTON_TYPE_DOFLOW == tdAttrs.colButtonType){
						inputHtml += "<input type=button value='" + tdAttrs.colButtonName + "' onclick=\" on_doflow('"+tdAttrs.docId+"','"+tdAttrs.colApproveLimit+"')\" />";
					}else if("COLUMN_TYPE_OPERATE" == tdAttrs.colType && ColumnOperaType.BUTTON_TYPE_TEMPFORM == tdAttrs.colButtonType){
						inputHtml += "<input type=button value='" + tdAttrs.colButtonName + "' onclick=\"DisplayView.viewDoc(this,'"+tdAttrs.docId+"','"+tdAttrs.docFormid+"','"+tdAttrs.isSignatureExist+"','"+tdAttrs.colTemplateForm+"')\" />";
					}else if("COLUMN_TYPE_OPERATE" == tdAttrs.colType && ColumnOperaType.BUTTON_TYPE_SCRIPT == tdAttrs.colButtonType){
						inputHtml += "<input type=button value='" + tdAttrs.colButtonName + "' onclick=\"runscript('"+tdAttrs.docId+"','"+tdAttrs.colId+"',this)\" />";
					}else if("COLUMN_TYPE_OPERATE" == tdAttrs.colType && ColumnOperaType.BUTTON_TYPE_JUMP == tdAttrs.colButtonType){
						inputHtml += "<input type=button value='" + tdAttrs.colButtonName + "' onclick=\"DisplayView.jumptoform('"+tdAttrs.colMappingform+"',"+tdAttrs.jumpMapping+",'"+tdAttrs.colButtonName+"');event.stopPropagation();\" />";
					}
					$tdHtml.append(inputHtml);
					if("COLUMN_TYPE_LOGO" == tdAttrs.colType && tdAttrs.colIcon && tdAttrs.colIcon != ""){
						$tdHtml.append(jQuery("<img style='' src='../../../lib/icon/" + tdAttrs.colIcon+ "'/>"));
					}
					if("COLUMN_TYPE_ROWNUM" == tdAttrs.colType){
						$tdHtml.append(row);
					}
					if(tdAttrs.fieldInstanceOfWordField){
						var btnHtml = "<img src='../../share/images/view/word.gif' onclick=\"showWordDialogWithView('{*[Show]*} {*[Word]*}','WordControl','"+tdAttrs.docId+"','"+tdAttrs.result+"','"+tdAttrs.colFieldName+"',3,2,false,true)\"></img>";
						$tdHtml.append(btnHtml);
					}else if(tdAttrs.fieldInstanceOfgenericWordField){//通用word控件
						var btnHtml = "<img src='../../share/images/view/genericword.jpg'></img>";
						tdHtml += btnHtml;		
					}else if(tdAttrs.fieldInstanceOfMapField){
						var application = jQuery("body",parent.document).find("#application").val();
						var fieldVal = "";
						var displayType = 1;
						var docId = $tdField.attr('docId');
						docId = docId?docId:'';
						var f_id = docId + "_" + tdAttrs.colFieldName;
						var valhtml = tdAttrs.title == " "?"":"value = '" + tdAttrs.title + "'";
						var btnHtml = "<input type='hidden' id = '" + f_id + "' " + valhtml + ">";
						btnHtml += "<img src='../../share/images/view/map.png' style='margin: 0 5px;'";
						btnHtml += " onclick=\"FormBaiduMap('";
						btnHtml += f_id + "', '";
						btnHtml += application + "', '";
						btnHtml += displayType + "')\"";
						btnHtml +="/>";
						$tdHtml.append(btnHtml);
					}
					else if (tdAttrs.result && tdAttrs.result.length == 0) {
						$tdHtml.append("&nbsp;");
					}
				}
				return $tdHtml;
			},//重构数据行td----end
			/**
			 * 重构表头
			 */
			toFirstTdHtml = function($tdField){
				var tdHtml = "";
				var thAttrs = {};
				thAttrs.upImg = "<img border=\"0\" src='../../share/images/view/up.gif'/>";
				thAttrs.downImg = "<img border=\"0\" src='../../share/images/view/down.gif'/>";
				
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
						tdHtml += "<td width=\"" 
								+ thAttrs.colWidth + "\" title=\"" + thAttrs.colText + "\"";
						if(thAttrs.colWidth == "") tdHtml +=" class=\"" + Setting.TH_TD_CLASS + " nowrap\"";
						else tdHtml +=" nowrap='nowrap' class=\"" + Setting.TH_TD_CLASS + "\"";
						tdHtml +=" ></td>";
						var $tdHtml = jQuery(tdHtml);
						if(thAttrs.colType == "COLUMN_TYPE_FIELD"){
							var aHtml = "<a style=\"cursor:pointer\" href=\"#\" ></a>";
							var $aHtml = jQuery(aHtml);
							if(_sortCol != "null"){
								if(_sortCol != "" && _sortCol.toUpperCase() == thAttrs.colFieldName.toUpperCase()){
									$aHtml.append(thAttrs.colText);
									if(_sortStatus == "ASC"){
										$aHtml.append(thAttrs.upImg);
									}else if(_sortStatus == "DESC"){
										$aHtml.append(thAttrs.downImg);
									}
								}else{
									if(thAttrs.isOrderByField != "null" && thAttrs.isOrderByField != "" && thAttrs.isOrderByField == "true"){
										$aHtml.append(thAttrs.colText);
									}else{//不勾选排序
										$tdHtml.append(thAttrs.colText);
									}
								}
								$aHtml.bind("click",function(){
									DisplayView.sortTable(this,thAttrs.colFieldName);
								}).appendTo($tdHtml);
							}else{
								if(thAttrs.isOrderByField != "null" && thAttrs.isOrderByField != "" && thAttrs.isOrderByField == "true"){
									$aHtml.append(thAttrs.colText);
									//可排序图标
									if(_sortStatus == "ASC"){
										$aHtml.append(thAttrs.upImg);
									}else if(_sortStatus == "DESC"){
										$aHtml.append(thAttrs.downImg);
									}
									$aHtml.bind("click",function(){
										DisplayView.sortTable(this,thAttrs.colFieldName);
									}).appendTo($tdHtml);
								}else{//不勾选排序
									$tdHtml.append(thAttrs.colText);
								}
							}
						}else{//脚本不需要排序
							$tdHtml.append(thAttrs.colText);
						}
					}else{
						$tdHtml = jQuery("<td class=\"" + Setting.TH_TD_CLASS + "\" style=\"display:none;\">" + thAttrs.colName + "</td>");
					}
				}
				return $tdHtml;
			};//重构表头----end
			//根据列文本显示方式的配置，截取文本
			truncationText = function(input,displayType,displayLength,isShowIcon){
				if(displayType == Column.DISPLAY_PART && !isShowIcon){
					displayLength = displayLength.match("\\d+");
					if(displayLength){
						if(input.length > displayLength){
							input = input.substring(0,displayLength) + "...";
						}
					}
				}
				return input;
			};
			
			var $field = jQuery(this);
			var _sortCol = $field.attr("_sortCol");
			var _sortStatus = $field.attr("_sortStatus");
			var isSum = $field.attr("isSum");
			isSum = (isSum == "true")?true:false;
			var $tableHtml = jQuery("<table class=\"" + Setting.TABLE_CLASS + "\" id=\"dataTable\" style=\"z-index:1;\"></table>");
			
			$field.children().children().each(function(i){//行<tr>
				var rowNum = i;
				var $trHtml = "";
				var $trField = jQuery(this);
				
				if(i == 0){//首行（列头）
					$trHtml = jQuery("<tr class=\"" + Setting.TH_CLASS + "\"></tr>");
					//首列
					var tdHtml = "";
					tdHtml = "<td nowrap=\"nowrap\" class=\"" + Setting.TH_FIRST_TD_CLASS + "\" scope=\"col\"></td>";
						var inputHtml = "<input type=\"checkbox\" onclick=\"DisplayView.selectAll(this)\">";
					jQuery(tdHtml).append(inputHtml).appendTo($trHtml);
					//其他列
					$trField.children().each(function(i){//单元格<td>
						var $tdField = jQuery(this);
						
						//根据列头的显示隐藏值设置数据行对应列的显示和隐藏值
						$field.find("tr:gt(0)").each(function(){
							$(this).find(" td:eq("+i+")").attr("isHidden", $tdField.attr("isHiddenColumn"));
						});
						
						$trHtml.append(toFirstTdHtml($tdField));
					});
				}else if(isSum && (i == $field.children().children().size()-1)){//末行(字段值汇总)
					$trHtml = jQuery("<tr class=\"" + Setting.TR_CLASS + "\" onmouseover=\"this.className='" 
							+ Setting.TR_OVER_CLASS + "';\" onmouseout=\"this.className='" + Setting.TR_CLASS + "';\">");
					//首列
					var tdHtml = "<td class=\"" + Setting.TR_FIRST_TD_CLASS + "\">";
					tdHtml += "&nbsp;</td>";
					$trHtml.append(tdHtml);
					
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
						//其他列
						if(sumTdAttrs.isVisible && !sumTdAttrs.isHiddenColumn){
							tdHtml += "<td style=\"word-break: break-all;\">";
							if(sumTdAttrs.isSum || sumTdAttrs.isTotal)
								tdHtml += sumTdAttrs.colName;
							if(sumTdAttrs.isSum)
								tdHtml += sumTdAttrs.sumByDatas + "&nbsp;";
							if(sumTdAttrs.isTotal)
								tdHtml += sumTdAttrs.sumTotal + "&nbsp;";
							tdHtml += "</td>";
						}
						$trHtml.append(tdHtml);
					});
				}else{//数据行
					$trHtml = jQuery("<tr class=\"" + Setting.TR_CLASS + "\" onmouseover=\"this.className='" 
							+ Setting.TR_OVER_CLASS + "';\" onmouseout=\"this.className='" + Setting.TR_CLASS + "';\">");
					//首列
					var docId = $trField.attr("docId");
					var tdHtml =  "<td class=\"" + Setting.TR_FIRST_TD_CLASS + "\">";
						tdHtml += "<input type=\"checkbox\" name=\"_selects\" value=\"" + docId + "\"/>";
					tdHtml += "</td>";
					$tdHtml = jQuery(tdHtml);
					$trHtml.append($tdHtml);
					
					$trField.children().each(function(i){//单元格<td>
						var $tdField = jQuery(this);
						//其他列
						$trHtml.append(toDataTdHtml($tdField,rowNum));//重构数据单元格
					});
				}
				$tableHtml.append($trHtml);
			});

			var includeWidth = $(DisplayView.getTheView(this)).width();
			
			$tableHtml.replaceAll($field).parent().width(includeWidth);
			
			
			
			
		});
	};
})(jQuery);

/**
 * jquery重构列表视图
 * for:列表视图
 */
function jqRefactor4DisplayView(){
	if(typeof(isSubGridView) != "undefined"){
		
	}else{
		jQuery("table[moduleType='viewList']").obpmDisplayView();
	}
}


//===============================重构包含元素去掉iframe改用div--start

/**
 * 子视图执行框架
 */
var DisplayView = {
	//初始化方法
	init : function(){

		//隐藏查询表单内容
		$("#searchFormTable").each(function(){	//只能用移动查询表单内容的方法，避免日期、下拉提示等控件事件丢失无法操作
			$('<script></script>').attr('type','text/obpm').attr('id',($(this).attr('id') + '_hide')).append($(this).children()).insertAfter($(this));
			$(this).remove();
		});
	},
	/**
	 * 显示提示消息
	 */
	showMsg : function(container){
		
		var $msgDivObj = $(container).find("#msg").find(".msgSub");
		var msgType = $msgDivObj.attr("msgType");	//消息类型
		showMessage(msgType, $msgDivObj.html());
	},
	//添加监听事件
	bindEvent : function($this){
		//重置按钮
		$this.find("#resetBtn").unbind("click").bind("click",function(){
			DisplayView.reset(this);
		});
		//打开查询弹出层
		$this.find("#searchBtn").unbind("click").bind("click", function(){
			DisplayView.openSearch(this);
		});
		
		$(window).on("resize",function(){
			var $tableContainer = $("#table_container");
			var $includedView = $tableContainer.parents("div[type='includedView']");
			$tableContainer.find(">table").css("display","none"); 
			$tableContainer.width("auto").width($includedView.width());
			$tableContainer.find(">table").css("display","table");
		});
		
		$(".showNextPage").on("click",function(e){
			var json = DisplayView.span2Json(this);
			var rowCount = json["_rowcount"];
			if(rowCount){
				var pageCount = Math.ceil(parseInt(rowCount)
						/ parseInt(json["_pagelines"]));
				var _currpage = parseInt(json["_currpage"])+1;
				if(_currpage>pageCount) return;
				json["_currpage"] = _currpage;
				var url = DisplayView.getAction(this);
				DisplayView.postForm(this,url,json);
			}
		});
		$(".showFirstPage").on("click",function(e){
			var json = DisplayView.span2Json(this);
			json["_currpage"] = 1;
			var url = DisplayView.getAction(this);
			DisplayView.postForm(this,url,json);
		});
		$(".showPreviousPage").on("click",function(e){
			var json = DisplayView.span2Json(this);
			var _currpage = parseInt(json["_currpage"])-1;
			if(_currpage<=0) return;
			json["_currpage"] = _currpage
			var url = DisplayView.getAction(this);
			DisplayView.postForm(this,url,json);
		});
		$(".showLastPage").on("click",function(e){
			var json = DisplayView.span2Json(this);
			var rowCount = json["_rowcount"];
			if(rowCount){
				var pageCount = Math.ceil(parseInt(json["_rowcount"])
						/ parseInt(json["_pagelines"]));
				if(pageCount<=0) return;
				json["_currpage"] = pageCount;
				var url = DisplayView.getAction(this);
				DisplayView.postForm(this,url,json);
			}
		});
		$(".btn-jumppage").on("click",function(e){
			var json = DisplayView.span2Json(this);
			var pageCount = Math.ceil(parseInt(json["_rowcount"])
					/ parseInt(json["_pagelines"]));
			if(!pageCount || pageCount<=0){
				return;
			}
			var _currpage = parseInt($(this).parent().siblings("[name='_jumppage']").val());
			if(!_currpage || _currpage<=0){
				return;
			}
			if(_currpage>pageCount) return;
			json["_currpage"] = _currpage;
			var url = DisplayView.getAction(this);
			DisplayView.postForm(this,url,json);
		});
	},
	/**
	 * @param obj
	 * @returns 子表视图Div的js对象
	 */
	getTheView : function(obj){
		return $(obj).parents("div[type=includedView]")[0];
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
		$(view).find("#"+$(view).attr("id") + "_params span").each(function(){
			var name = $(this).attr("name");
			var val = $(this).text();
			if(!json[name] || json[name] == ''){
				json[name] = val;
			}else {
				json[name] += ';' + val;
			}
		});
		
		var $searchPanel = $(view).find("#searchFormTable_hide");
		$searchPanel.find('input,select,textarea').each(function(){
			var name = $(this).attr("name");
			var val = $(this).val();
			if(!json[name] || json[name] == ''){
				json[name] = val;
			}else {
				json[name] += ';' + val;
			}
		})
		
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
	refreshPage : function(obj,container,html,url){
		var $html = $("<div></div>").append(html);
		if($html.find("#gridview-container").size() > 0){
			$(container).css("padding","0").html("<iframe src='"+url+"' height='"+$(container).height()+"px' width='100%'></iframe>");
		}else{
			var $form = $html.find("form");
			var _viewid = $form.find('input[name=_viewid]').val();
			var viewid = _viewid + "_params";
			var $viewDiv = $("<div></div>").attr("id",viewid).attr("_action",$form.attr("action")).css("display","none");
			//表单元素转成span标签存入dom中
			$.each($form.serializeArray(),function(){
				$viewDiv.append("<span name='" + this.name + "'>" + this.value + "</span>"); 
			});
			$(container).html($viewDiv);
			//去掉表单元素
			$form.find("input[type!=button],select,textarea").not("input[name='_jumppage']").each(function(){
				if(!$(this).attr("moduleType")) $(this).remove();
			});
			//保留form中元素并去掉form
			$form.after($form.html()).remove();
			//插入dom中
			$(container).append($html.html());
		}
		if(typeof(initDispComm)=='function'){
			initDispComm();	//子视图公用初始化方法
			this.showMsg(container);
			DisplayView.bindEvent($(container));
			DisplayView.displayWaterMark($(container));
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
				DisplayView.refreshPage(obj,this,html,url);
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
		$('<form></form>').attr('method','post').attr('action',url).append(this.json2Textarea(json)).appendTo("body").submit().remove();
	},
	//打印预览
	printView : function(url,json){
		var $printView =$('<form id="printView"></form>');
		$printView.appendTo($("body"));
		$printView.attr('action',url).attr('target','_my_submit_win').append(this.json2Textarea(json)).submit();
		$printView.remove();
	},
	//打开查询页面
	openSearch : function(obj){
		var view = this.getTheView(obj);
		var $fromDiv = $(view).find('#searchFormTable_hide');
		$fromDiv.find("input,textarea,select").attr("isSubSearch",true);	//子表查询表单中的刷新识别用
		//只能用移动查询表单内容的方法，避免日期、下拉提示等控件事件丢失无法操作
		var $div = $('<div id="searchFormTableSub"></div>').append($fromDiv.children());
		var dialog = artDialog({
			title:'查询',
//			content:$('<div></div>').append($div).html(),
			content : $div,
			lock:true,
			fixed: true,
			width:800,
			height:'auto',
			okVal:'查询'
		    },
		    function(){	//查询
		    	DisplayView.search(obj);
		    },
		    function(){	//取消
		    	$fromDiv.append($div.children());	//查询表单内容插回界面中
		    }
		);
		if($("#searchFormTableSub").parents(".aui_state_focus").height() > $(window).height()){
			dialog.size(800, $(window).height()-100);
		}
	},
	//查询按钮
	search : function(obj){
		var json = this.span2Json(obj);
		json['_currpage'] = 1;	//重置页码
		//添加控件参数
		$(document).find("#searchFormTableSub").find("input,select,textarea").each(function(){
			json[this.name] = this.value;
		});
		var url = contextPath + "/portal/dynaform/view/subFormView.action?isQueryButton=true";
		this.postForm(obj,url,json);
	},
	//重置按钮
	reset : function(obj){
		var json = this.span2Json(obj);
		var view = this.getTheView(obj);
		var $div = $('<div></div>').append($(view).find('#searchFormTable_hide').html());
		$div.find("input,select,textarea").each(function(){
			json[this.name] = '';
		});
		json['_currpage'] = 1;	//重置页码
		var url = contextPath + "/portal/dynaform/view/subFormView.action?isQueryButton=true";
		this.postForm(obj,url,json);
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
		var url = this.getAction(obj);
		this.postForm(obj,url,json);
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
		$(view).find("#searchFormTable_hide").find("input,select,textarea").each(function(){
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
		$(view).find("#searchFormTable_hide").find("input,select,textarea").each(function(){
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
	//全选
	selectAll : function(obj){
		var $selects = $(obj).parents("table#dataTable").find("input[name=_selects]");
		$selects.prop("checked", $(obj).prop("checked"));
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
				dataType : 'text',
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
//				url = appendApplicationidByView(url);	//不再需要
				var w = document.body.clientWidth - 25;
				var h = document.body.clientHeight;
				if(h<600){h=600}
				showfrontframe({
							title : "",
							url : url,
							w : w,
							h : h,
							windowObj : window.parent,
							callback : function(result) {
								setTimeout(function(){//通过右上角的关闭图标关闭弹出层后会显示加载进度条，加延迟后没有这个问题
									_json['_backURL'] = _backURL;
					        		DisplayView.postForm(obj,_action,_json);
								},1);
							}
						});
			}
		}
	},
	//查看数据
	viewDoc : function(obj,docid, formid ,signatureExist,templateForm,isEdit,instanceId,nodeId) {
		// 查看/script/view.js
		event.stopPropagation();
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
	},
	//操作列跳转按钮的方法
	jumptoform : function(formId, jumpMapping, title){
		var showW = top.document.documentElement.clientWidth;
		showW = showW - showW/10;
		var showH = top.document.documentElement.clientHeight;
		showH = showH - showH/10;
		var obj = eval(jumpMapping);
		var str = "";
		if(obj){
			str += "&";
			for(var i=0; i<obj.length; i++){
				var agr = obj[i].name;
				var colValue = obj[i].value;
				str += encodeURIComponent(agr) + "=" + encodeURIComponent(colValue) + "&";
			}
			str = str.substring(0, str.length-1);
		}

		var applicationid = document.getElementById("applicationid").value;
		var view_id = document.getElementsByName("_viewid")[0].value;
		var newAction = contextPath + '/portal/dynaform/document/newWithJump.action';
		var url = newAction + "?applicationid=" + applicationid + "&application=" + applicationid 
					+ "&_formid=" + formId + "&view_id=" + view_id + "&_isJump=1" + str
					+ "&_backURL="
					+ "&openType=16";
		
		showfrontframe({
			title : title,
			url : url,
			w : showW,
			h : showH,
			windowObj : window.parent,
			callback : function(result) {
			}
		});
	},
	on_delete : function(obj, colId){
		var rtn = window.confirm("确定要删除您选择的记录吗？");
		if (!rtn){
			return;
		}
		var json = this.span2Json(obj);
		
		var temps = document.getElementsByName("_selects");
		for(i = 0; i<temps.length; i++){
			if(document.getElementsByName("_selects")[i].value == colId){
				json["_selects"] = document.getElementsByName("_selects")[i].value;
			}
		}
		
		this.postForm(obj, (contextPath + '/portal/dynaform/view/delete.action'), json);
	},
	//子视图水印是否显示
	displayWaterMark : function($this){
		var waterMarkClass = $this.attr("watermark");
		var $waterMark = $("."+waterMarkClass);
	    if($waterMark.size()>0 && $waterMark.attr("show") ==　"true" && $waterMark.attr("content")){
	    	$waterMark.parent(".thisDisplay").watermark({
	            texts : [$waterMark.attr("content")] //水印文字,[]数组形式
	        })
		};
	}
};


//===============================重构包含元素去掉iframe改用div--end