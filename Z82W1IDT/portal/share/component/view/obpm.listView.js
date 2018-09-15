/**
 * 	后台预览的时候判断页面是否重构完成
 */
var isComplete = false; 

/**
 * 	判断视图是否设置了列宽
 */
var isSetWidth = false;
/**
 * 	判断视图列数是否超过10
 */
var isOverflow = false;

/**
 * 列表视图公用初始化方法
 * @return
 */
function initListComm(){
	selectData4Doc();	//回选列表数据
	
	setTimeout(function(){
		jqRefactor4ListView();//视图jquery重构
		jQuery("div[moduleType='viewFileManager']").obpmViewFileManager();  	//列表视图文件管理功能
		jQuery("div[moduleType='viewTakePhoto']").obpmViewTakePhoto();  	//列表视图在线拍照功能
		jQuery("div[moduleType='viewImageUpload']").obpmViewImageUpload();  	//列表视图图片上传功能
		jQuery("div[moduleType='viewImageUpload2DataBase']").obpmViewImageUpload2DataBase();  	//列表视图图片上传到数据库功能
	},50);
	
	setTimeout(function(){
		jqRefactor();//表单控件jquery重构
	},10);
	
	refresh4Record();	//刷新对应菜单的总记录数
	ev_reloadParent();	//刷新父窗口树型对象
	setTimeout(function(){
		showPromptMsg();	//显示提示信息
	},300);
	displayActivityTime();	//子文档为编辑模式时才显示activity
	openDownloadWindow(openDownWinStr);	// 打开Excel下载窗口
	jQuery(document).keydown(function(e){
		enterKeyDown(e);
	});
	isComplete = true; //后台预览的时候判断页面是否重构完成
	setTimeout("judgeOperating()",100);	//提示是否可以执行操作
	enterJump(); //回车触发分页跳转

}


/*
 * 固定表头
 */
function tableScroll(viewid,scrollid){  
	var $scroll = $("#"+scrollid);  
	var $th = $("table#"+viewid).find("tr:eq(0)").clone(true);  
	var $bak = $("<div id='bak_table_"+viewid+"'><table class='listDataTable' style='z-index: 1; table-layout: auto;'><tbody></tbody></table></div>");  
	$scroll.append($bak);
	$scroll.css("position","relative");
	$bak.find("tbody").append($th); 
	if(isSetWidth || isOverflow){
		$bak.find(".listDataTable").css("table-layout","fixed");//没有设置任何列宽时，列宽根据内容自动撑大
	}
	$bak.css({
		"position":"absolute",
		"background-color":"#e5edf8",
		"display":"block",
		"left":"0px",
		"top":"0px",
		"height":"24px",
		"width":"100%"
	})
	$scroll.on("scroll",function(){  
		$bak.css("top",this.scrollTop+"px")
	})
}  

/*
 * 修改固定表头单元格宽度
 */
function fixTableScroll(viewid,scrollid){  
	var $scroll = $("#"+scrollid);  
	var $bak = $scroll.find("#bak_table_"+viewid);
	var $th = $("table#"+viewid).find("tr:eq(0)");
	var thSize = $th.find("td").size();
	for(var i = 0; i < thSize; i++){
		var width = parseInt($th.find("td:eq("+i+")").width());
		if(i != 0){
			if(width < 75){
				width = 75;
			}
		}
		$th.find("td:eq("+i+")").css("width", Math.round(width));
		$bak.find("td:eq("+i+")").css("width", Math.round(width));
	}
} 

//给后台preview.jsp视图预览的时候判断页面是否重构完成
function getIsComplete(){
	return isComplete ;
}
/**
 * 列表视图调整布局
 * for:default/fresh/dwz/brisk/gentle
 */
function listViewAdjustLayout(){
	var bodyH=document.body.clientHeight;
	jQuery("#container").height(bodyH);
	jQuery("#container").width(jQuery("body").width());
	var activityTableH=jQuery("#activityTable").height();
	var searchFormTableH;
	if(jQuery("#searchFormTable").attr("id")=="searchFormTable"){
		searchFormTableH=jQuery("#searchFormTable").height()+18;/*20px is the padding height*/
	}else{
		searchFormTableH=0;
	}
	var pageTableH=jQuery("#pageTable").height();
	jQuery("#dataTable").height(bodyH-activityTableH-searchFormTableH-pageTableH-5);
}

/**
 * 子文档为编辑模式时才显示activity
 * for:default/gentle/fresh/dwz/brisk/blue
 */
function displayActivityTime() {
	var activityTable = document.getElementById("activityTable");
	isedit = document.getElementById("isedit") ? document.getElementById("isedit").value : '';
	if (isedit != 'null' && isedit != '') {
		if (isedit == 'true' || isedit) {
			activityTable.style.display = '';
		} else {
			activityTable.style.display = 'none';
		}
	} else {
		activityTable.style.display = '';
	}
	enbled = document.getElementById("isenbled") ? document.getElementById("isenbled").value : '';
	if (enbled != 'null' && enbled != '') {
		activityTable.style.display = 'none';
	}
}

/**
 * for:default/gentle/fresh/dwz/brisk/blue
 */
function createDoc(activityid) {
	// 查看/script/view.js
	var action = activityAction + "?_activityid=" + activityid;
	openWindowByType(action,selectStr, VIEW_TYPE_NORMAL, activityid); 
}

/**
 * for:default/gentle/fresh/dwz/brisk/blue
 */
function viewDoc(docid, formid ,signatureExist,templateForm,isEdit,instanceId,nodeId) {
	// 查看/script/view.js
	var url = docviewAction;
	url += '?_docid=' + docid;
	if (formid) {
		url += '&_formid=' +  formid;
	}
	if (templateForm) {
		url += '&_templateForm=' +  templateForm;
	}
	if(signatureExist){
		url += '&signatureExist=' +  signatureExist;
	}
	if(instanceId){
		url += '&_targetInstance=' +  instanceId;
	}
	if(nodeId){
		url += '&_targetNode=' +  nodeId;
	}
	
	openWindowByType(url,selectStr, VIEW_TYPE_NORMAL); 
}

/**
 * for:default/gentle/fresh/dwz/birsk/blue
 */
function on_delete(colId){
	var rtn = window.confirm("确定要删除您选择的记录吗？");
	if (!rtn){
		return;
	}
	
	var temps = document.getElementsByName("_selects");
	for(i = 0; i<temps.length; i++){
		if(document.getElementsByName("_selects")[i].value == colId){
			document.getElementsByName("_selects")[i].checked = true;
		}else{
			document.getElementsByName("_selects")[i].checked = false;
		}
	}
	document.forms[0].action = 'delete.action';
	document.forms[0].submit();
}

function doBatchApprove(docId,approveLimit){
		artDialog.prompt('请输入审批意见：',function(val,win){
			jQuery('#_attitude'+ docId).val(val);
			on_doflow1(docId, approveLimit);
		},true);
}

/**
 * for:default/gentle/fresh/dwz/brisk/blue
 */
function on_doflow(colId , approveLimit){
		jQuery('#doFlowRemarkDiv').dialog({
			open:function(){
				jQuery('#doFlowRemarkDiv').css('height','auto');
				var doFlowRemarkDivParentH = jQuery('#doFlowRemarkDiv').parent().height();
				var doFlowRemarkDivParentW = jQuery('#doFlowRemarkDiv').parent().width();
				var bodyH = jQuery('body').height();
				var bodyW = jQuery('body').width();
				var leftVal;
				var topVal;
				topVal = bodyH - doFlowRemarkDivParentH;
				topVal = topVal/2;
				jQuery('#doFlowRemarkDiv').parent().css('top',topVal);
				leftVal = bodyW - doFlowRemarkDivParentW;
				leftVal = leftVal/2;
				jQuery('#doFlowRemarkDiv').parent().css('left',leftVal);
			},
			autoOpen: true,
			width: 800,
			buttons: {okMessage: function() {
				jQuery('#_remark').val(jQuery('#temp_remark').val());
				if(jQuery('#_remark').val()!=''){
					jQuery(this).dialog('close');
					on_doflow1(colId, approveLimit);
			}else{
				alert(someInformation);
			}
			},
			cancelMessage: function(){
				jQuery(this).dialog('close');
				}
			}
			});
		var buttonClass = "ui-button-text";
		for(var i = 0;i < jQuery("."+buttonClass).size();i++){
			if(jQuery("."+buttonClass).eq(i).text() == "okMessage"){
				jQuery("."+buttonClass).eq(i).text(okMessage);
			}
			if(jQuery("."+buttonClass).eq(i).text() == "cancelMessage"){
				jQuery("."+buttonClass).eq(i).text(cancelMessage);
			}
		}
}

function on_doflow1(colId, approveLimit){
	var temps = document.getElementsByName("_selects");
	for(var i = 0; i<temps.length; i++){
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

/**刷新对应菜单的总记录数
 * for:default/gentle/fresh/dwz/brisk/blue
 */
function refresh4Record(){
	var atrr=jQuery("#resourceid").val();
	var resourceid=atrr.split(",")[0];
	var viewid=jQuery("#viewid").val();
	if(resourceid!=null && resourceid!=''){
		if(typeof(window.parent.reflashTotalRow) == "function")
			window.parent.reflashTotalRow(resourceid,viewid);
	}
}

/**
 * for:default/gentle/fresh/dwz/brisk/blue
 */
function on_unload() {
	ev_reloadParent();
}

/**
 * 显示提示信息
 * for:default/gentle/fresh/dwz/brisk/blue
 */
function showPromptMsg(){
	var funName = typeName;
	var url = urlValue;
	var msg = document.getElementsByName("message")[0].value;
	if (msg) {
		try{
			eval("do" + funName + "(msg , url);");
		} catch(ex) {
		}
	}
}

/**
 * 提示是否可以执行操作
 * for:default/gentle/dwz
 */
function judgeOperating(){
    var query = location.search.substring(1);    
    var index = query.indexOf("isopenablescript=");               
    var isopenablescript=query.substring(index+17,index+23);
    if(isopenablescript=='false;'){
        alert(isOpenAbleScriptShow);
    }
}
/**
 * for:dwz 通用word控件列预览
 * @param {string} title 弹出层的标题
 * @param {string} fileName 文档的名字
 * @param {string} path 文档存储的路径，不包括文件名
 * @param {string} type 文档的扩展名
 * @param {string} colFieldName 列名
 */
function showNewWordDialogWithView(title, fileName, path, type, colFieldName) {
	var application = document.getElementById("ApplicationID").value;
	var fullPath = path + fileName;
	var url ="../share/common/preview/preview.jsp";
	url+="?applicationId=" + application + "";
	url+="&path="+fullPath +"";
	url+="&name="+fileName +"";
	url+="&showName="+fileName +"";
	url+="&fileType="+ ".doc" +"";
	url+="&isOpenCloseBtn=false";
	url+="&isShowDocName=false";
	url+="&curEditUserId="+WebUser.id;
	url+="&action=readOnly";	

	OBPM.dialog.show({
				width : 1200,
				height : 700,
				url : url,
				title : title,
				close : function() {
					
				}
			});
	event.stopPropagation();
}
/**
 * for:dwz 旧word控件列预览
 */
function showWordDialogWithView(title, str, docid, value, fieldname, opentype, displayType, saveable, isSignature) {
	wx = '900px';
	wy = '700px';
	var base64 = new Base64();
	var getItemValue = base64.decode(value);
	//旧数据兼容，原getItemValue即为filename，现filename存为getItemValue里的一个 "filename" 字段
	var content = {"filename":getItemValue,"opinion":[]};
	var filename;
	var	contentTemp = jQuery.parseJSON(getItemValue);
	if(typeof(contentTemp.filename) == "string"){
		filename = contentTemp.filename;
		content = contentTemp;
	} else {
		filename = getItemValue;
		content.filename = filename;
	}
	getItemValue = JSON.stringify(content);

	var application = document.getElementById("ApplicationID").value;
	var url = contextPath + '/portal/dynaform/document/newword.action?_docid='
		+ docid + "&type=word&_fieldname=" + fieldname + "&_opentype="
		+ opentype+"&_displayType="+displayType
		+ "&saveable=" + saveable
		+ "&application=" + application
		+ "&isSignature=" + isSignature
		+ "&filename=" + filename;

	OBPM.dialog.show({
				width : 1200,
				height : 700,
				url : url,
				args : {itemValue:getItemValue},
				title : title,
				close : function() {
					
				}
			});
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

/**
 * 重构列表视图
 */
(function($){
	$.fn.obpmListView = function(){
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
					tdAttrs.fieldType = $tdField.attr('fieldType');//字段类型
					tdAttrs.showType = $tdField.attr('showType');//真实值：00|显示值：01
					tdAttrs.displayType = $tdField.attr('displayType');
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
					tdAttrs.isHidden = $tdField.attr('isHidden');
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
					
					tdAttrs.colIcon = $tdField.attr('colIcon');
					tdAttrs.colId = $tdField.attr("colId");
					tdAttrs.colTemplateForm = $tdField.attr("colTemplateForm");
					tdAttrs.showword = $tdField.attr("showword");
				
					//tdAttrs.displayType = (tdAttrs.displayType == 'true'?true:false);
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
					tdAttrs.visible4PagePrint = (tdAttrs.visible4PagePrint == 'true'?true:false);
					tdAttrs.colButtonType = (tdAttrs.colButtonType != "null")?tdAttrs.colButtonType:'';
					tdAttrs.colApproveLimit = (tdAttrs.colApproveLimit != "null")?tdAttrs.colApproveLimit:'';
					tdAttrs.colButtonName = (tdAttrs.colButtonName != "null")?tdAttrs.colButtonName:'';
					tdAttrs.colMappingform = (tdAttrs.colMappingform != "null")?tdAttrs.colMappingform:'';
					tdAttrs.colIcon = (tdAttrs.colIcon != "null")?tdAttrs.colIcon:'';
					tdAttrs.showIcon =  ($tdField.attr('showIcon') != null) ? $tdField.attr('showIcon'):'';
					
				
				var tdHtml = '';
				var pHtml = '';
				var aHtml = '';
				
				var pointerClass =tdAttrs.isReadonly;
				pointerClass = pointerClass?'':'pointer';
				
				var docId = $tdField.attr('docId');
				docId = docId?docId:'';
				
				var viewTemplateForm = $tdField.attr('viewTemplateForm');
				viewTemplateForm = (viewTemplateForm != "null")?viewTemplateForm:'';
									
				var docFormid = $tdField.attr('docFormid');
				docFormid = docFormid?docFormid:'';
				
				var jumpMapping = $tdField.find("div[name='jumpMapping']").html();
				jumpMapping = jumpMapping?jumpMapping:'';
				
				var result = $tdField.find("div[name='result']").html();
				result = (result?result:'');

				var title = "";
				if(result && result != "" && result.indexOf("[{") == -1){
					title = $tdField.find("div[name='result']").text();
				}
			
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
									resHtml += "<a href=\"javaScript:viewDoc('";
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
								resHtml += "<a href=\"javaScript:viewDoc('";
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
								resHtml += "<a href=\"javaScript:viewDoc('";
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
				if(tdAttrs.displayType){

					var templateForm = "";
					if(View.DISPLAY_TYPE_TEMPLATEFORM == tdAttrs.viewDisplayType){
						templateForm = viewTemplateForm;
					}
					
					// 宽度为0时隐藏
					if((tdAttrs.colWidth && tdAttrs.colWidth == '0') || !tdAttrs.isVisible || tdAttrs.isHidden ){
						tdHtml += "<td class='" + pointerClass +' '+ Setting.TR_TD_CLASS + "' style='display: none;'";
					}else if(tdAttrs.colGroundColor != ""){//如果设置了底色,加上底色
						tdHtml += "<td class='" + pointerClass +' '+ Setting.TR_TD_CLASS + "' style='background-color:" + tdAttrs.colGroundColor + ";word-break: break-all;'";
					}else{
						tdHtml += "<td class='" + pointerClass +' '+ Setting.TR_TD_CLASS + "' style='word-break: break-all;'";
					}

					if(!(tdAttrs.isReadonly || tdAttrs.colType == "COLUMN_TYPE_LOGO"|| tdAttrs.colType == "COLUMN_TYPE_OPERATE" ||tdAttrs.fieldType=="attachmentupload") && result.indexOf("<TABLE>") == -1){
						if(tdAttrs.fieldType=="imageupload" || tdAttrs.fieldType=="attachmentupload"
							 || tdAttrs.fieldType=="onlinetakephoto"){

						}else{
							tdHtml += " onClick=\"viewDoc ('"
								+ docId + "', '"
								+ docFormid + "', '"
								+ tdAttrs.isSignatureExist + "', '"
								+ templateForm + "', '"
								+ tdAttrs.isEdit + "')\"";
						}
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

//							if(Column.DISPLAY_ALL == tdAttrs.displayType){
//								pHtml += convert2HTMLEncode(result) + "</p>";
//							}else{
//								pHtml += convert2HTMLEncode(result) + "</p>";
//							}
							if(result.indexOf("img") != -1){
								if(result.indexOf("<TABLE>") != -1){
									pHtml += convert2HTMLEncode(result) + "</p>";
								}else{
									var _result = convert2HTMLEncode(result);
									if($(_result).attr("moduletype") == "viewImageUpload" || ($(_result).attr("moduletype") != null && $(_result).attr("moduletype").indexOf("viewTakePhoto") >= 0)){
										var _url = $(_result).attr("url").replace(/\\'/g,"");
										var _picHtml = "<div class='images-preview' data-index='"+i+"' data-src='"+_url+"' style='display: inline-block;margin:3px;'>" +
														"<img style='max-height:50px;max-width:50px;' src='"+_url+"' />" +
														"</div>";
										pHtml += _picHtml + "</p>";
									}
								}
							}else{
								if(result.indexOf("<TABLE>") != -1){
									pHtml += convert2HTMLEncode(result) + "</p>";
								}
								else{
									if(tdAttrs.colType == "COLUMN_TYPE_FIELD"){
										if(tdAttrs.fieldType=="weixinrecordfield" && jQuery.trim(result).indexOf("{")==0){
											pHtml+='<div class="weixin_record">';
											pHtml+= '<img src="../../share/images/view/voice.png" width="21px"/>';
											pHtml+='</p>';
										}else if(tdAttrs.fieldType=="weixingpsfield" && jQuery.trim(result).indexOf("{")==0){//微信gps定位控件
											var location = jQuery.parseJSON(result);
											pHtml+='<div class="gps_col">';
											if(tdAttrs.showType=="00"){//真实值
												pHtml+='<a href="#" class="gps_col_link" data-location=\''+result+'\'>';
												pHtml+='<span class="gps_col_text">'+location.address+'</span>';
												pHtml+='</a>';
											}else{//显示值
												pHtml+='<span class="gps_col_text">'+location.address+'</span>';
											}
											pHtml+='</p>';
										}else if(tdAttrs.fieldType=="imageupload"){
											var _result = convert2HTMLEncode(result);
											if(_result && _result != "" && _result != " "){
												var _images = JSON.parse(convert2HTMLEncode(result));
												for(var i = 0; i < _images.length; i++){
													var _url = contextPath + _images[i].path;
													var _picHtml = "<div class='images-preview' data-index='"+i+"' data-src='"+_url+"' style='display: inline-block;margin:3px;'>" +
															"<img style='max-height:50px;max-width:50px;' src='"+_url+"' />" +
															"</div>";
													pHtml += _picHtml + "</p>";
												}
											}
										}else if(tdAttrs.fieldType=="attachmentupload"){
											var _result = convert2HTMLEncode(result);
											if(_result && _result != "" && _result != " "){
												var _images = JSON.parse(_result);
												for(var i = 0; i < _images.length; i++){
													var _name = _images[i].name;
													var url = encodeURI(contextPath + "/portal/dynaform/document/fileDownload.action?filename="+ encodeURI(_name) + "&filepath=" + _images[i].path);
													var _picHtml = "<a class='file-download' _url='" + url + "' target='_about'>" + _name + "</a>";
													pHtml += _picHtml + "</p>";
												}
											}
										}else{
											pHtml += convert2HTMLEncode(result)+ "</p>";
										}
									}else{
										pHtml += convert2HTMLEncode(result)+ "</p>";
									}
								}
							}
							tdHtml += pHtml;
						}
					}else{
						var aHtml = "";
						if(result != null){
							/*if(tdAttrs.fieldType=="onlinetakephoto"){//在线拍照控件类型
								var id = result.substring(result.lastIndexOf("/")+1,result.lastIndexOf("."));
								aHtml+='<div class="photo_col">';
								aHtml+='<a href="#'+id+'">';
								if(tdAttrs.showType=="00"){//真实值
									
									aHtml+='<img style="height:40px;" src="../../..'+result+'" />';
								}else{//显示值
									aHtml+='<span>'+result+'</span>';
								}
								aHtml+='</a><div>';
								aHtml+='<div id="'+id+'" style="display:none;"><img style="height:320px;" src="../../..'+result+'" /></div>';
							}*/

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
										var _images = JSON.parse(_result);
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
										var _images = JSON.parse(_result);
										for(var i = 0; i < _images.length; i++){
											var _name = _images[i].name;
											var url = encodeURI(contextPath + "/portal/dynaform/document/fileDownload.action?filename="+encodeURI(_name) + "&filepath=" + _images[i].path);
											var _picHtml = "<a href='" + url + "' target='_about'>" + _name + "</a>";
											aHtml += _picHtml;
										}
									}
								}else{
									//子流程标签和处理人数据处理
									result = result2tdHtml();
									
									var templateForm = "";
									if(View.DISPLAY_TYPE_TEMPLATEFORM == tdAttrs.viewDisplayType){
										templateForm = viewTemplateForm;
									}
									if(result.indexOf("<TABLE>") != -1){
	//									aHtml += "<div style=\"cursor:pointer;\" onclick=\"javaScript:viewDoc('";
										aHtml += "<div style=\"cursor:pointer;\" ";
									}else{
										if(tdAttrs.fieldType=="imageupload" || tdAttrs.fieldType=="attachmentupload"
											 || tdAttrs.fieldType=="onlinetakephoto"){
											aHtml += "<a ";
										}else{
											aHtml += "<a href=\"javaScript:viewDoc('";
											aHtml += docId + "', '";
											aHtml += docFormid + "', '";
											aHtml += tdAttrs.isSignatureExist + "', '";
											aHtml += templateForm + "', '";
											aHtml += tdAttrs.isEdit + "')\"";
										}
									}
									
									//如果有设置字体大小及颜色
									if((tdAttrs.colColor != "") || (tdAttrs.colFontSize != "")){
										aHtml += " style='";
										if(tdAttrs.colColor != ""){
											aHtml += "color:" + tdAttrs.colColor + ";";
										}
										if(tdAttrs.colFontSize != ""){
											aHtml += "font-size:" + tdAttrs.colFontSize + "px;";
										}
										aHtml += "'";
									}
										
									if(result.indexOf("img") != -1) {
										if(tdAttrs.isShowTitle)
											aHtml += " title='" + title + "'";
											
										aHtml += " >";
										if(result.indexOf("<TABLE>") != -1){
											aHtml += convert2HTMLEncode(result) + "</div>";
										}else{
											var _result = convert2HTMLEncode(result);
											if($(_result).attr("moduletype") == "viewImageUpload" || ($(_result).attr("moduletype") != null && $(_result).attr("moduletype").indexOf("viewTakePhoto") >= 0)){
												var _url = $(_result).attr("url").replace(/\\'/g,"");
												var _picHtml = "<div class='images-preview' data-src='"+_url+"' style='display: inline-block;margin:3px;'>" +
																"<img style='max-height:50px;max-width:50px;' src='"+_url+"' />"+
																"</div>";
												_result += _picHtml;
											}
											aHtml += _result + "</a>";
										}
									}else{
										if(tdAttrs.isShowTitle)
											aHtml += " title='" + title + "'";
										aHtml += " >";
										if(result.indexOf("<TABLE>") != -1){
											aHtml += convert2HTMLEncode(result) + "</div>";
										}else{
	
											if(tdAttrs.fieldType=="imageupload" || tdAttrs.fieldType=="attachmentupload"){
												var _result = convert2HTMLEncode(result);
												if(_result && _result != "" && _result != " "){
													var _images = JSON.parse(_result);
													for(var i = 0; i < _images.length; i++){
														var _url = contextPath + _images[i].path;
														var _picHtml = "<div class='images-preview' data-src='"+_url+"' style='display: inline-block;margin:3px;'>" +
																"<img style='max-height:50px;max-width:50px;' src='"+_url+"' />" +
																"</div>";
														aHtml += _picHtml;
													}
												}
											}else{
											aHtml += convert2HTMLEncode(result);
											}
											aHtml += "</a>";
										}
									}
								}

							}else if(result.toLowerCase().indexOf("<a ") != -1 
									|| result.toLowerCase().indexOf("<a>") != -1
									|| (result.toLowerCase().indexOf("<input ") != -1 
									&& (result.toLowerCase().indexOf("type='button'") != -1 
									|| result.toLowerCase().indexOf("type=button") != -1))
									|| result.toLowerCase().indexOf("viewdoc") != -1){
								aHtml += result;
							}else{

								aHtml += "<a href=\"javaScript:viewDoc('";
								aHtml += docId + "', '";
								aHtml += docFormid + "', '";
								aHtml += tdAttrs.isSignatureExist + "', '";
								aHtml += templateForm + "', '";
								aHtml += tdAttrs.isEdit + "')\"";

								//如果有设置字体大小及颜色
								if((tdAttrs.colColor != "") || (tdAttrs.colFontSize != "")){
									aHtml += " style='";
									if(tdAttrs.colColor != ""){
										aHtml += "color:" + tdAttrs.colColor + ";";
									}
									if(tdAttrs.colFontSize != ""){
										aHtml += "font-size:" + tdAttrs.colFontSize + "px;";
									}
									aHtml += "'";
								}
								if(tdAttrs.isShowTitle)
									aHtml += " title='" + title + "'";
									
								aHtml += " >";
								
								aHtml += result + "</a>";
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

						inputHtml += "' onclick=\"doBatchApprove('"+docId+"','"+tdAttrs.colApproveLimit+"')\" ";
						inputHtml += "/>";
						
						tdHtml += inputHtml;
						
					}else if("COLUMN_TYPE_OPERATE" == tdAttrs.colType && ColumnOperaType.BUTTON_TYPE_TEMPFORM == tdAttrs.colButtonType){
						var inputHtml = "<input type=button value='" + tdAttrs.colButtonName;
						
						inputHtml += "' onclick=\"viewDoc('"+docId+"','"+docFormid+"','"+tdAttrs.isSignatureExist+"','"+tdAttrs.colTemplateForm+"')\" ";
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
					
					//序号列
					if("COLUMN_TYPE_ROWNUM" == tdAttrs.colType){
						tdHtml += row;
					}
					
					if(tdAttrs.fieldInstanceOfWordField){
						var base64 = new Base64();
						var btnHtml = "<img src='../../share/images/view/word.gif'";
						btnHtml += " onclick=\"showWordDialogWithView('"+tdAttrs.showword+"','WordControl','"+docId+"','"+base64.encode(result)+"','"+tdAttrs.colFieldName+"',3,2,false,true);event.stopPropagation();\" ></img>";
						tdHtml += btnHtml;					
					}else if(tdAttrs.fieldInstanceOfgenericWordField){//通用word控件
						var btnHtml = "";
						if(jQuery.trim(result).indexOf("{")==0){
							var resultObj = JSON.parse(result);
							btnHtml = "<img class='genericword' src='../../share/images/view/genericword.jpg' "+
											"data-title='"+tdAttrs.showword+"' "+
											"data-fileName='"+resultObj.filename+"' "+
											"data-path='"+resultObj.path+"' "+
											"data-type='"+resultObj.type+"' "+
											"data-colFieldName='"+tdAttrs.colFieldName+"'/>";
						}
						tdHtml += btnHtml;		
					}else if(tdAttrs.fieldInstanceOfMapField){
						var application = jQuery("body",parent.document).find("#application").val();
						var fieldVal = "";
						var displayType = 1;
						var f_id = docId + "_" + tdAttrs.colFieldName;
						var valhtml = title == " "?"":"value = '" + title + "'";
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
			toFirstTdHtml = function($tdField){
				var tdHtml = "";
				var thAttrs = {};
				thAttrs.upImg = "<img border=\"0\" src='../../share/images/view/up.gif'/>";
				thAttrs.downImg = "<img border=\"0\" src='../../share/images/view/down.gif'/>";
				
				thAttrs.colName = $tdField.attr("colName");
				thAttrs.colText = $tdField.attr("colText");
				thAttrs.isVisible = $tdField.attr("isVisible");
				thAttrs.isHiddenColumn = $tdField.attr("isHiddenColumn");
				thAttrs.visible4PagePrint = $tdField.attr("visible4PagePrint");
				thAttrs.colWidth = $tdField.attr("colWidth");
				thAttrs.colType = $tdField.attr("colType");
				thAttrs.colFieldName = $tdField.attr("colFieldName");
				thAttrs.isOrderByField = $tdField.attr("isOrderByField");
				thAttrs.isVisible = (thAttrs.isVisible == "true")?true:false;
				thAttrs.isHiddenColumn = (thAttrs.isHiddenColumn == "true")?true:false;
				thAttrs.visible4PagePrint = (thAttrs.visible4PagePrint == "true")?true:false;
				thAttrs.colWidth = (thAttrs.colWidth == "null") ? "" : thAttrs.colWidth;
				if(thAttrs.isVisible && !thAttrs.isHiddenColumn && !(isprint == undefined || isprint == 'true' && !thAttrs.visible4PagePrint)){
					if(thAttrs.colWidth != "0"){
						if(thAttrs.colWidth != ""){
							isSetWidth = true;
						}
						tdHtml += "<td width=\"" 
								+ thAttrs.colWidth + "\" title=\"" + thAttrs.colText + "\"";
						if(thAttrs.colWidth == "") tdHtml +=" class=\"" + Setting.TH_TD_CLASS + " nowrap\"";
						else tdHtml +=" nowrap='nowrap' class=\"" + Setting.TH_TD_CLASS + "\"";
						tdHtml +=" style=\"overflow:hidden;white-space: normal;\" ></td>";
						var $tdHtml = jQuery(tdHtml);
						if(thAttrs.colType == "COLUMN_TYPE_FIELD"){
							var aHtml = "<a style=\"cursor:pointer\"></a>";
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
									sortTable(thAttrs.colFieldName);
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
										sortTable(thAttrs.colFieldName);
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
					if(displayLength.match("\\d+")){
						displayLength = displayLength.match("\\d+");
						if(displayLength){	//显示部分列名
							if(input != "" && input.indexOf("<img") != -1){	//包含流程回退标识时
								var $resultDiv = $("<div></div>");
								$resultDiv.html(input);
								var $textFont = $resultDiv.find("font");
								var text = $textFont.text();
								if(text.length > displayLength){
									text = text.substring(0,displayLength) + "...";
								}
								$textFont.text(text);
								input = $resultDiv.html();
							}else{
								if(input.length > displayLength){
									input = input.substring(0,displayLength) + "...";
								}
							}
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
			var $tableHtml = jQuery("<table class=\"" + Setting.TABLE_CLASS + "\" id=\"dataTable\" style=\"table-layout:auto;\"></table>");
			var sumTrIsHidden = true;

			//判断是否输出汇总行
			$field.find("#sumTrId").find("td").each(function(){
				if(jQuery(this).attr("isSum") == "true" || jQuery(this).attr("isTotal") == "true"){
					sumTrIsHidden = false;
					return;
				}
			});
			$field.children().children().each(function(i){//行<tr>
				var rowNum = i;
				var $trHtml = "";
				var $trField = jQuery(this);
				
				if(i == 0){//首行（列头）
					$trHtml = jQuery("<tr class=\"" + Setting.TH_CLASS + "\"></tr>");
					//首列
					var tdHtml = "";
					tdHtml = "<td class=\"" + Setting.TH_FIRST_TD_CLASS + "\" scope=\"col\"></td>";
					var inputHtml = "";
						inputHtml += "<input type=\"checkbox\" onclick=\"selectAll(this.checked)\">";
					jQuery(tdHtml).append(jQuery(inputHtml).bind("click",function(){
						selectAll(this.checked);
					})).appendTo($trHtml);
					//其他列
					$trField.children().each(function(i){//单元格<td>
						var $tdField = jQuery(this);
						//根据列头的显示隐藏值设置数据行对应列的显示和隐藏值
						$field.find("tr:gt(0)").each(function(){
							var hidden = $tdField.attr("isHiddenColumn") == "true" || (isprint != undefined && isprint == 'true' && !($tdField.attr("visible4PagePrint") == "true"));
							$(this).find(" td:eq("+i+")").attr("isHidden", hidden);
						});
						
						$trHtml.append(toFirstTdHtml($tdField));
					});
					$tableHtml.append($trHtml);
					$trHtml = null;
					
				}else if(isSum && !sumTrIsHidden && (i == $field.children().children().size()-1)){//末行(字段值汇总)
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
							tdHtml += "<td>";
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
					var dtrHtml = "<tr class=\"" + Setting.TR_CLASS + "\" onmouseover=\"this.className='" 
					+ Setting.TR_OVER_CLASS + "';\" onmouseout=\"this.className='" + Setting.TR_CLASS + "';\" >";
					//首列
					var docId = $trField.attr("docId");
					var tdHtml =  "<td class=\"" + Setting.TR_FIRST_TD_CLASS + "\">";
						tdHtml += "<input type=\"checkbox\" name=\"_selects\" value=\"" + docId + "\"/>";

						tdHtml += "</td>";
					dtrHtml += tdHtml;
					
					$trField.children().each(function(i){//单元格<td>
						var $tdField = jQuery(this);
						//其他列
						dtrHtml += toDataTdHtml($tdField,rowNum);//重构数据单元格
					});
					
					dtrHtml += "</tr>";
					$tableHtml.append(dtrHtml);
					dtrHtml = "";
				}
			});
			if($field.find(".header").find("td").length > 10 ){
				isOverflow = true;
			}
			if(isSetWidth || isOverflow){
				$tableHtml.css("table-layout","fixed");//没有设置任何列宽时，列宽根据内容自动撑大
			}
			$tableHtml.find(".gps_col_link").on("click",function(){//GPS控件注册点击事件
				openGpsDialog(this);
			});
			$tableHtml.replaceAll($field);
		});
	};
	
	//打开GSP位置显示层
	function openGpsDialog(t){
		var location = $(t).data("location");
		OBPM.dialog.show({
			url: contextPath+'/portal/share/component/weixinGpsField/view.jsp',
			args:{location:location},
			title:location.address,
			width: 500,
			height: 280,
			ok: true,
			okVal: 'Close',
			close: function(result) {
			}
		});
	}
	
})(jQuery);

/**
 * jquery重构列表视图
 * for:列表视图
 */
function jqRefactor4ListView(){
	jQuery("table[moduleType='viewList']").obpmListView();
	var $photoCol = $(".photo_col a");
	if($photoCol && $photoCol.size()>0){
		$photoCol.fancyZoom({scaleImg: true, closeOnClick: true});
	}
	//通用word文档点击预览事件
	$(".genericword").on("click",function(){
		var title = $(this).attr("data-title");
		var fileName = $(this).attr("data-fileName"); 
		var path = $(this).attr("data-path"); 
		var type = $(this).attr("data-type"); 
		var colFieldName = $(this).attr("data-colFieldName"); 
		showNewWordDialogWithView(title, fileName, path, type, colFieldName)         
		return false;
	});
	//图片上传控件点击事件
	$(".images-preview").on("click",function(){
		var _src = $(this).data("src");
		var tmp = "<div id='images-preview-panel' style='position: fixed;width: 100%;top: 0px;bottom: 0px;z-index: 10;display:none'>" +
			"<div class='images-preview-pic' style='position: absolute;width:100%;top:0;bottom:0;z-index: 11;text-align: center;'>" +
			"<img style='display:none;position: absolute;top:50%;left:50%;max-width:90%;max-height:90%;overflow:hidden;' /></div>" +
			"<div class='images-preview-mask' style='position: absolute;width: 100%;top: 0px;bottom: 0px;background-color: rgba(0, 0, 0, 0.6);'></div>" +
			"</div>";
		$("body").append(tmp);
		$("#images-preview-panel").find("img").attr("src",_src);
		$("#images-preview-panel").show();
		var picHeight = $("#images-preview-panel").find("img").height();
		var picWidth = $("#images-preview-panel").find("img").width();
		$("#images-preview-panel").find("img").css({"display":"block","marginTop":-(picHeight/2),"marginLeft":-(picWidth/2)});
		$("#images-preview-panel").on("click",function(){
			$("#images-preview-panel").remove();
		});
		return false;
	});
	
	tableScroll("dataTable","dataTable"); //固定表头
	fixTableScroll("dataTable","dataTable"); //计算固定表头单元格宽度
	$(window).resize(function(){
		fixTableScroll("dataTable","dataTable"); //计算固定表头单元格宽度
	});
}