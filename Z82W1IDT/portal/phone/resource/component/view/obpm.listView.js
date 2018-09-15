/**
 * 	后台预览的时候判断页面是否重构完成
 */
var isComplete = false; 

/**
 * 	判断视图是否设置了列宽
 */
var isSetWidth = false;

//视图委托事件
function listViewBindEvent(){
	$("#_searchForm").bind("click", function(){	//点击查询按钮展开查询表单
		$("#_searchPanel").addClass("active");
		ajaxPage.addHashPostfix("_searchForm");
	});
	
	$("#_searchPanel #btn-modal-close").bind("click", function(){	//查询表单界面关闭按钮
		$("#_searchPanel").removeClass("active");
		ajaxPage.clearHashPostfix("_searchForm");
	});
}


function filterList(header, list) {
	$("input.search")
	.change(function(){
    	var filter = $(this).val();
    	if(filter) {
			$matches = $(list).find('a:Contains(' + filter + ')').parent();
			$('li', list).not($matches).slideUp();
			$matches.slideDown();
	    } else {
			$(list).find("li").slideDown();
		}
    	return false;
  	})
	.keyup( function () {
		$(this).change();
	});
}

/**
 * 列表视图公用初始化方法
 * @return
 */
function initListComm(){
	jqRefactor();			//表单控件jquery重构
	jqRefactor4ListView();	//视图jquery重构
	tableListColumn();		//table列显示隐藏操作
	listViewBindEvent();	//事件委托

	$(window).on("orientationchange",function(){
		$(".dataTableDiv").width($(window).width());
	}).on("resize",function(){
		$(".dataTableDiv").width($(window).width());
	})
}

/**
 * 重构列表视图
 */
(function($){
	$.fn.obpmListView = function(){
		return this.each(function(){
			
			var config = {
					viewId : "",			//视图id
					isSetWidth : false,		//判断视图是否设置了列宽
					hideCol : {},			//隐藏列配置信息
					sortCol : "",			//排序字段
					sortStatus : "",		//排序状态
					isSum : "",				//是否汇总
					sumTrIsHidden : true	//汇总行是否隐藏
			},
			Column = {
					COLUMN_TYPE_SCRIPT : 'COLUMN_TYPE_SCRIPT',	//脚本编辑模式
					COLUMN_TYPE_FIELD : 'COLUMN_TYPE_FIELD',	//视图编辑模式
					COLUMN_TYPE_OPERATE : 'COLUMN_TYPE_OPERATE',//操作列
					COLUMN_TYPE_LOGO : 'COLUMN_TYPE_LOGO',		//图标列
					COLUMN_TYPE_ROWNUM : 'COLUMN_TYPE_ROWNUM',	//序号列
					DISPLAY_ALL : '00',//列显示全部文本
					DISPLAY_PART : '01'//列显示部分文本
			},
			Setting = {
					TABLE_CLASS : 'listDataTable',		//表格class
					TH_CLASS : 'listDataTh',						//标题行class
					TH_FIRST_TD_CLASS : 'listDataThFirstTd',			//标题行第一个单元格class
					TH_TD_CLASS : 'listDataThTd',		//标题行其他单元格class
					TR_FIRST_TD_CLASS : 'listDataTrFirstTd',		//数据行第一个单元格class
					TR_TD_CLASS : 'listDataTrTd',		//数据行其他单元格class
					TR_CLASS : 'listDataTr',				//数据行class
					TR_OVER_CLASS : 'listDataTr_over'	//数据行滑过class
			},
			View = {
					DISPLAY_TYPE_TEMPLATEFORM : "templateForm"
			},
			ColumnOperaType = {
					BUTTON_TYPE_DELETE : "00",
					BUTTON_TYPE_DOFLOW : "01",
					BUTTON_TYPE_TEMPFORM : "03",
					BUTTON_TYPE_SCRIPT : "04",
					BUTTON_TYPE_JUMP : "05"//操作列增加跳转类型按钮
			},

			//查看表单
			openDoc = function($me){
				var docid = $me.attr("docId");
				var formid = $me.attr("docFormid");
				var signatureExist = $me.attr("isSignatureExist");
				var viewDisplayType = $me.find(".listDataTrTd").attr("viewDisplayType");
				var viewTemplateForm = $me.find(".listDataTrTd").attr("viewTemplateForm");
				var isEdit = $me.attr("isEdit");
				var instanceId = $me.attr("instanceId");
				var nodeId = $me.attr("nodeId");
				
				var url = docviewAction;
				url += '?_docid=' + docid;
				if (formid) {
					url += '&_formid=' +  formid;
				}
				if (viewDisplayType === "templateForm" && viewTemplateForm) {
					url += '&_templateForm=' +  viewTemplateForm;
				}
				if(signatureExist){
					url += '&signatureExist=' +  signatureExist;
				}
				if(isedit){
					url += '&isedit=' +  isedit+"";
				}
				if(instanceId){
					url += '&_targetInstance=' +  instanceId;
				}
				if(nodeId){
					url += '&_targetNode=' +  nodeId;
				}
				ajaxPage.useFormAction(url);
			},

			//操作列跳转按钮的方法
			jump2form = function(formId, jumpMapping, title){
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

				var applicationid = document.getElementById("ApplicationID").value;
				var view_id = document.getElementsByName("_viewid")[0].value;
				var newAction = contextPath + '/portal/dynaform/document/newWithJump.action';
				var url = newAction + "?applicationid=" + applicationid + "&application=" + applicationid 
							+ "&_formid=" + formId + "&view_id=" + view_id + "&_isJump=1" + str
							+ "&_backURL=isJumpToForm";
				
				ajaxPage.routerLoadPage(url);
			},
			/**
			 * 脚本类型操作列
			 */
			runScript = function(docid, colid, obj){
				var data = {};
				var url = contextPath + '/portal/dynaform/view/runScript.action' + '?docid=' + docid + '&columnId=' + colid;
				if(obj){
					var view = jQuery(obj).parents("div[type=includedView]");
					var data = DisplayView.span2Json(obj);
				}else{
					data = jQuery(document.forms[0]).serialize();
				}
				
				jQuery.post(url,data,function(result){
					if(result && result.length>0){
						alert(result);
					}
					if(obj){
						var action = DisplayView.getAction(obj);
						DisplayView.postForm(obj,action,json);
					}else{
						document.forms[0].submit();
					}
					
				});
			},

			//查看模板表单
			openTemplateDoc = function(docid, formid, signatureExist, templateForm){

				var url = docviewAction;
				url += '?_docid=' + docid;
				if (formid) {
					url += '&_formid=' +  formid;
				}
				if(signatureExist){
					url += '&signatureExist=' +  signatureExist;
				}
				if (templateForm) {
					url += '&_templateForm=' +  templateForm;
				}
				ajaxPage.routerLoadPage(url);
			},

			/**
			 * 视图操作列提交方法
			 * @param colId : 文档id
			 */
			doFlow = function(colId , approveLimit){
				var $remark = $("#doFlowRemarkDiv").find("#temp_remark");
				$.confirm({
					tip : $remark,
					trueCall : function(){

						var $cur = ajaxPage.getCurPage();
						
						$cur.find('#_remark').val($remark.val());
						if($remark.val()!=''){

							$cur.find("[name=_selects][value=" + colId + "]").attr("checked", true);
							$cur.append("<input type='hidden' name='_approveLimit' value='" + approveLimit + "'/>");
							ajaxPage.submitPage("../dynaform/view/doflow.action");
						}else{
							alert(someInformation);
							return false;
						}
					},
					falseCall : function(){
						$("#doFlowRemarkDiv").append($remark);
					}
				});
			}
			/**
			 * 视图操作列删除方法
			 * @param colId : 文档id
			 */
			doDelete = function(colId){

				$.confirm({
					trueCall : function(){
						var $cur = ajaxPage.getCurPage();
						$cur.find("[name=_selects][value=" + colId + "]").attr("checked", true);
						ajaxPage.submitPage("../dynaform/view/delete.action");
					},
				});
			}
			//事件绑定
			bindEvent = function(){
				$("#listView").on("click", ".table-column-toggle tr[editType=edit]", function(){//点击行时打开查看表单
					openDoc($(this));
					
				}).on("click", ".table-column-toggle input[name=_selects]", function(e){	//点击复选框时阻止事件冒泡
					e.stopPropagation();
					
				}).on("click", ".table-column-toggle input[type=button][colBtnType=" 
						+ ColumnOperaType.BUTTON_TYPE_DELETE + "]", function(e){	//操作列为删除类型时
					e.stopPropagation();
					doDelete($(this).attr("docId"));
					
				}).on("click", ".table-column-toggle input[type=button][colBtnType=" 
						+ ColumnOperaType.BUTTON_TYPE_DOFLOW + "]", function(e){	//操作列为提交流程类型时
					e.stopPropagation();
					doFlow($(this).attr("docId"), $(this).attr("colApproveLimit"));
					
				}).on("click", ".table-column-toggle input[type=button][colBtnType=" 
						+ ColumnOperaType.BUTTON_TYPE_TEMPFORM + "]", function(e){	//操作列为打开模板类型时
					e.stopPropagation();
					openTemplateDoc($(this).attr("docId"), $(this).attr("docFormid"), $(this).attr("isSignatureExist"), $(this).attr("colTemplateForm"));
					
				}).on("click", ".table-column-toggle input[type=button][colBtnType=" 
						+ ColumnOperaType.BUTTON_TYPE_SCRIPT + "]", function(e){	//操作列为脚本类型时
					e.stopPropagation();
					runScript($(this).attr("docId"), $(this).attr("colId"));

				}).on("click", ".table-column-toggle input[type=button][colBtnType=" 
						+ ColumnOperaType.BUTTON_TYPE_JUMP + "]", function(e){	//操作列为跳转流程类型时
					e.stopPropagation();
					jump2form($(this).attr("colMappingform"), $(this).attr("jumpMapping"), $(this).attr("colButtonName"));

				}).on("click", ".table-column-toggle img[fieldType='word']", function(e){	//列为word字段时
					e.stopPropagation();
					showWordDialogWithView($(this).attr("showword"),'WordControl', $(this).attr("docId"), 
							$(this).attr("result"), $(this).attr("colFieldName"),3,2,false,true);

				}).on("click", ".table-column-toggle img[fieldType='map']", function(e){	//列为地图字段时
					e.stopPropagation();
					FormBaiduMap(($(this).attr("docId")+"_"+$(this).attr("colFieldName")), $(this).attr("appid"),"1");
					
				}).on("click", ".listDataThTd[isorderby='true']", function(e){	//排序
					e.stopPropagation();
					var colFieldName = $(this).attr("colFieldName");
					var $sortCol = $("#_sortCol");
					var $sortStatus = $("#_sortStatus");
					var sortCol = $sortCol.val();
					var sortStatus = $sortStatus.val();
					if (sortCol != colFieldName && sortCol.toUpperCase() != colFieldName.toUpperCase()) {
						$sortStatus.val("ASC");
					} else {
						if (sortStatus == "ASC") {
							$sortStatus.val("DESC");
						}else{
							$sortStatus.val("ASC");
						}
					}
					$sortCol.val(colFieldName);
					ajaxPage.reloadPage();
				});
			},
			//判断是否输出汇总行
			sumTrIsShow = function($field){
				$field.find("#sumTrId").find("td").each(function(){
					if(jQuery(this).attr("isSum") == "true" || jQuery(this).attr("isTotal") == "true"){
						config.sumTrIsHidden = false;
						return;
					}
				});
			},
			toDataTdHtml = function($td,row){
				var tdObj = parseAttrs($td,row);
			},
			//根据列文本显示方式的配置，截取文本
			truncationText = function(input,displayType,displayLength,isShowIcon){
				if(displayType == Column.DISPLAY_PART && !isShowIcon){
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
				return input;
			},
			//格式化html标签
			convert2HTMLEncode = function(tdObj, str){
				var s = str;
				if(Column.COLUMN_TYPE_FIELD == tdObj.colType && !tdObj.colFieldName.substr(0,1) == "$" && !tdObj.colFlowReturnCss){
					s = s.replace(new RegExp(">","gm"),"&gt;");
					s = s.replace(new RegExp("<","gm"),"&lt;");
				}
				return s;
			},
			//处理多状态字段值
			processMulState = function(tdObj){
				var docId = tdObj.docId;
				var docFormid = tdObj.docFormid;
				var templateForm = tdObj.viewTemplateForm;
				var result = tdObj.result;
				var _result = "";
				var data = {
						instances : []	
				};
				if("$StateLabel" == tdObj.colFieldName && (result.indexOf("[")==0 || result.indexOf("<img")==0)){//视图列绑定流程状态字段类型
					var instances;
					var imgHtml = "",
						fontStart = "",
						fontEnd = "";
					if(result.indexOf("[")==0){
						instances = JSON.parse(result);
					}else if(result.indexOf("<img")==0){
						var jsonStartIndex = result.indexOf("[{"),
							jsonEndIndex = result.lastIndexOf("}]");
						fontStart = result.substring(result.indexOf("<font"),jsonStartIndex);
						fontEnd = result.substring(jsonEndIndex + 2,result.length);
						imgHtml = result.substring(0,result.indexOf("<font"));
						instances = result.substring(jsonStartIndex,jsonEndIndex + 2);
						instances = eval("(" + instances + ")");
					}
					for(var i=0;i<instances.length;i++){

						var instance = instances[i];
						var nodes = instance.nodes;
						instance._nodes = [];
						for(var j=0;j<nodes.length;j++){
							var node = nodes[j];
							var nodeId = node.nodeId;
							var stateLable = truncationText(node.stateLabel,tdObj.displayType,tdObj.colDisplayLength,tdObj.showIcon);
							if(!tdObj.isReadonly){
								if(result.indexOf("<img")==0){
									stateLable = fontStart + stateLable + fontEnd;
								}
								stateLable = "<a href=\"javaScript:viewDoc('"
									+ docId + "', '"
									+ docFormid + "', '"
									+ tdObj.isSignatureExist + "', '"
									+ templateForm + "', '"
									+ tdObj.isEdit + "', '"
									+ instanceId + "', '"
									+ nodeId + "')\">" + stateLable + "</a>&nbsp;&nbsp;";
							}
							
							node.stateLable = stateLable;
							//instance._nodes.push(node);
						}
						data.instances.push(instance);
					}
					_result = template("listViewFlowCol-tmpl", data);
				}else if("$PrevAuditNode" == tdObj.colFieldName && result.indexOf("[")==0){//视图列绑定上一环节流程处理节点名称字段
					var instances = JSON.parse(result);
					for(var i=0;i<instances.length;i++){
						var instance = instances[i];
						var instanceId = instance.instanceId;
						var prevAuditNode = instance.prevAuditNode;
						var prevNode = truncationText(prevAuditNode,tdObj.displayType,tdObj.colDisplayLength,tdObj.showIcon);
						if(!tdObj.isReadonly){
							prevNode = "<a href=\"javaScript:viewDoc('"
								+ docId + "', '"
								+ docFormid + "', '"
								+ tdObj.isSignatureExist + "', '"
								+ templateForm + "', '"
								+ tdObj.isEdit + "', '"
								+ instanceId + "')\">" + prevNode + "</a>&nbsp;&nbsp;";
						}
						instance.prevNode = prevNode;
						data.instances.push(instance);
					}
					_result = template("listViewPrevAuditNode-tmpl", data);
				}else if("$PrevAuditUser" == tdObj.colFieldName && result.indexOf("[")==0){//视图列绑定上一环节流程处理节点名称字段
					var instances = JSON.parse(result);
					for(var i=0;i<instances.length;i++){
						var instance = instances[i];
						var instanceId = instance.instanceId;
						var prevAuditUser = instance.prevAuditUser;
						var prevUser = truncationText(prevAuditUser,tdObj.displayType,tdObj.colDisplayLength,tdObj.showIcon);
						if(!tdObj.isReadonly){
							prevUser = "<a href=\"javaScript:viewDoc('"
								+ docId + "', '"
								+ docFormid + "', '"
								+ tdObj.isSignatureExist + "', '"
								+ templateForm + "', '"
								+ tdObj.isEdit + "', '"
								+ instanceId + "')\">" + prevUser + "</a>&nbsp;&nbsp;";
						}
						instance.prevUser = prevUser;
						data.instances.push(instance);
					}
					_result = template("listViewPrevAuditUser-tmpl", data);
				}else {
					_result = truncationText(result,tdObj.displayType,tdObj.colDisplayLength,tdObj.showIcon);
				}
				return _result;
			},
			//处理操作、LOGO、地图、word列
			processResultByField = function(tdObj){

				var aHtml = "";
				var result = tdObj.result;
				result = convert2HTMLEncode(tdObj,result);
				if(tdObj.fieldtype=="weixingpsfield" && jQuery.trim(result).indexOf("{")==0){//微信gps定位控件
					var location = jQuery.parseJSON(result);
					aHtml+='<div class="gps_col">';
					if(tdObj.showType=="00"){//真实值
						aHtml+='<a href="#" class="gps_col_link" data-location=\''+result+'\'>';
						aHtml+='<span class="gps_col_text">'+location.address+'</span>';
						aHtml+='</a>';
					}else{//显示值
						aHtml+='<span class="gps_col_text">'+location.address+'</span>';
					}
					aHtml+='</div>';
				}else if(tdObj.fieldtype=="weixinrecordfield" && jQuery.trim(result).indexOf("{")==0){	//录音控件
					aHtml += '<div class="weixin_record">'
								+ '<img src="../share/images/view/voice.png" width="21px"/>'
							+ '</div>';
				}else if(tdObj.fieldtype=="imageupload"){
					if(result && result != " "){
						var _images = JSON.parse(result);
						for(var i = 0; i < _images.length; i++){
							var _url = contextPath + _images[i].path;
							var _picHtml = "<div class='images-preview' data-src='"+_url+"' style='display: inline-block;margin:3px;'>" +
									"<img style='max-height:50px;max-width:50px;' src='"+_url+"' />" +
									"</div>";
							aHtml += _picHtml;
						}
					}
				}else if(tdObj.fieldtype=="attachmentupload"){
					if(result && result != " "){
						var _images = JSON.parse(result);
						for(var i = 0; i < _images.length; i++){
							var _url = contextPath + _images[i].path;
							var _name = _images[i].name;
							var _picHtml = "<a href='" + _url + "' target='_about'>" + _name + "</a>";
							aHtml += _picHtml;
						}
					}
				}else if(tdObj.fieldtype=="onlinetakephoto"){
					if(result && result != " "){
						var _url = "";
						if(result.indexOf("<div") != -1){
							_url = $(result).attr("url").replace(/\\'/g,"");
						}else{
							_url = result;
						}
						
						var _picHtml = "<div class='images-preview' data-src='"+_url+"' style='display: inline-block;margin:3px;'>" +
								"<img style='max-height:50px;max-width:50px;' src='"+_url+"' />" +
								"</div>";
						aHtml += _picHtml;
					}
				}else if((tdObj.fieldInstanceOfWordField || tdObj.fieldInstanceOfgenericWordField) && jQuery.trim(result).indexOf("{")==0){
					aHtml = "<img src='resource/images/view/genericword.jpg' fieldType='genericWord' />";
				}else if(tdObj.fieldInstanceOfMapField && jQuery.trim(result).indexOf("{")==0){
					aHtml = "<img src='resource/images/view/map.png' fieldType='map'/>";
				}else{
					aHtml = result;
				}
				return aHtml;
			},
			parseTbodyTdObj = function($td){
				var tdObj = {};
				tdObj.fieldtype = $td.attr('fieldtype');
				tdObj.displayType = $td.attr('displayType');
				tdObj.colWidth = $td.attr('colWidth');
				tdObj.colGroundColor = $td.attr('colGroundColor');
				tdObj.colColor = $td.attr('colColor');
				tdObj.colFontSize = $td.attr('colFontSize');
				tdObj.isVisible = $td.attr('isVisible');
				tdObj.isReadonly = $td.attr('isReadonly');
				tdObj.colType = $td.attr('colType');
				tdObj.fieldInstanceOfWordField = $td.attr('fieldInstanceOfWordField');
				tdObj.fieldInstanceOfgenericWordField = $td.attr('fieldInstanceOfgenericWordField');
				tdObj.fieldInstanceOfMapField = $td.attr('fieldInstanceOfMapField');
				tdObj.displayType = $td.attr('displayType');
				tdObj.isShowTitle = $td.attr('isShowTitle');
				tdObj.isHidden = $td.attr('isHidden');
				tdObj.colDisplayLength = $td.attr('colDisplayLength');
				tdObj.colFieldName = $td.attr('colFieldName');
				tdObj.colFlowReturnCss = $td.attr('colFlowReturnCss');
				tdObj.viewDisplayType = $td.attr('viewDisplayType');

				tdObj.isSignatureExist = $td.attr('isSignatureExist');
				tdObj.isEdit = $td.attr('isEdit');
				tdObj.colButtonType = $td.attr('colButtonType');
				tdObj.colApproveLimit = $td.attr('colApproveLimit');
				tdObj.colButtonName = $td.attr('colButtonName');
				tdObj.colMappingform = $td.attr('colMappingform');
				
				tdObj.colIcon = $td.attr('colIcon');
				tdObj.docId = $td.attr("docId");
				tdObj.colTemplateForm = $td.attr("colTemplateForm");
				tdObj.showword = $td.attr("showword");
				
				tdObj.showIcon =  ($td.attr('showIcon') != null) ? $td.attr('showIcon'):'';
				tdObj.docId = $td.attr('docId');
				tdObj.viewTemplateForm = $td.attr('viewTemplateForm');
				tdObj.docFormid = $td.attr('docFormid');
				tdObj.jumpMapping = $td.find("div[name='jumpMapping']").html();
				tdObj.result = $td.find("div[name='result']").html();
			
				//tdObj.displayType = (tdObj.displayType == 'true'?true:false);
				tdObj.colWidth = (tdObj.colWidth != "null")?tdObj.colWidth:'';
				tdObj.colGroundColor = (tdObj.colGroundColor && tdObj.colGroundColor != "null" && tdObj.colGroundColor != "FFFFFF")?tdObj.colGroundColor:'';
				tdObj.colColor = (tdObj.colColor && tdObj.colColor != "null" && tdObj.colColor != "000000")?tdObj.colColor:'';
				tdObj.colFontSize = (tdObj.colFontSize && tdObj.colFontSize != "null" && tdObj.colFontSize != "12")?tdObj.colFontSize:'';
				tdObj.isVisible = (tdObj.isVisible == 'true'?true:false);
				tdObj.isReadonly = (tdObj.isReadonly == 'true'?true:false);
				tdObj.colType = tdObj.colType?tdObj.colType:"";
				tdObj.fieldInstanceOfWordField = (tdObj.fieldInstanceOfWordField == 'true');				
				tdObj.fieldInstanceOfgenericWordField = (tdObj.fieldInstanceOfgenericWordField == 'true');
				tdObj.fieldInstanceOfMapField = (tdObj.fieldInstanceOfMapField == 'true');
				//tdObj.displayType = tdObj.displayType?tdObj.displayType:"";
				tdObj.isShowTitle = (tdObj.isShowTitle == 'true');
				
				tdObj.isOperateCol = ("COLUMN_TYPE_OPERATE" == tdObj.colType);	//是否操作列
				tdObj.isRowNumCol = ("COLUMN_TYPE_ROWNUM" == tdObj.colType);	//是否序号列
				tdObj.isLogoCol = ("COLUMN_TYPE_LOGO" == tdObj.colType && tdObj.colIcon && tdObj.colIcon != "");	//是否logo列

				tdObj.colDisplayLength = tdObj.colDisplayLength?tdObj.colDisplayLength:"";
				tdObj.colFieldName = tdObj.colFieldName?tdObj.colFieldName:"";
				tdObj.colFlowReturnCss = (tdObj.colFlowReturnCss == 'true'?true:false);
				tdObj.viewDisplayType = (tdObj.viewDisplayType != "null")?tdObj.viewDisplayType:'';
				
				tdObj.isSignatureExist = (tdObj.isSignatureExist == 'true'?true:false);
				tdObj.isEdit = (tdObj.isEdit == 'true'?true:false);
				tdObj.isHidden = (tdObj.isHidden == 'true'?true:false);
				tdObj.colButtonType = (tdObj.colButtonType != "null")?tdObj.colButtonType:'';
				tdObj.colApproveLimit = (tdObj.colApproveLimit != "null")?tdObj.colApproveLimit:'';
				tdObj.colButtonName = (tdObj.colButtonName != "null")?tdObj.colButtonName:'';
				tdObj.colMappingform = (tdObj.colMappingform != "null")?tdObj.colMappingform:'';
				tdObj.colIcon = (tdObj.colIcon != "null")?tdObj.colIcon:'';
				
				return tdObj;
			},
			//解析属性值
			parseTbodyTd = function($td){
				var tdObj = parseTbodyTdObj($td);

				var result = tdObj.result; 
				if(result && result != "" && result.indexOf("<table>") == -1){
					tdObj.title = $td.find("div[name='result']").text();
				}
				
				//是否隐藏字段
				if((tdObj.colWidth && tdObj.colWidth == '0') || !tdObj.isVisible || tdObj.isHidden ){
					tdObj.isHide = true;
					tdObj.display = "none";
				}

				if(tdObj.displayType){

					if(View.DISPLAY_TYPE_TEMPLATEFORM == tdObj.viewDisplayType){
						tdObj.templateForm = tdObj.viewTemplateForm;
					}
					//是否添加事件
					if(!(tdObj.isReadonly || tdObj.colType == "COLUMN_TYPE_LOGO") && result.indexOf("<TABLE>") == -1){
						tdObj.click = true;
					}
					
					if(tdObj.isReadonly){
						tdObj.tagName = "p";
						tdObj.editType = "readonly";
					}else{
						tdObj.tagName = "a";
						tdObj.editType = "edit";	//事件委托时使用
					}

					if(result.toLowerCase().indexOf("<a ") != -1 
							|| result.toLowerCase().indexOf("<a>") != -1
							|| (result.toLowerCase().indexOf("<input ") != -1 
							&& (result.toLowerCase().indexOf("type='button'") != -1 
							|| result.toLowerCase().indexOf("type=button") != -1))
							|| result.toLowerCase().indexOf("viewdoc") != -1){
					}else{
						if(tdObj.colType == "COLUMN_TYPE_FIELD"){
							tdObj.result = processMulState(tdObj);	//流程多状态、多审批人等处理
							tdObj.result = processResultByField(tdObj);	//字段列处理
						}
					}
				}
				
				return tdObj;
			},
			//解析列头th数据
			parseHeadTh = function($tdField, i){
				var thObj = {};
				thObj.upImg = "<img border=\"0\" src='../share/images/view/up.gif'/>";
				thObj.downImg = "<img border=\"0\" src='../share/images/view/down.gif'/>";
				
				thObj.colName = $tdField.attr("colName");
				thObj.colText = $tdField.attr("colText");
				thObj.isVisible = $tdField.attr("isVisible");
				thObj.isHiddenColumn = $tdField.attr("isHiddenColumn");
				thObj.colWidth = $tdField.attr("colWidth");
				thObj.colType = $tdField.attr("colType");
				thObj.colFieldName = $tdField.attr("colFieldName");
				thObj.isOrderByField = $tdField.attr("isOrderByField");
				thObj.isVisible = (thObj.isVisible == "true")?true:false;
				thObj.isHiddenColumn = (thObj.isHiddenColumn == "true")?true:false;
				thObj.colWidth = (thObj.colWidth == "null") ? "" : thObj.colWidth;
				thObj.cls = Setting.TH_TD_CLASS;
				thObj.thArrow = "";
				
				if(!thObj.isVisible || thObj.isHiddenColumn || thObj.colWidth == "0"){
					thObj.isHide = "true";
					thObj.display = "none";
				}
				if(i>2){
					thObj.priority = 6;
				}else{
					thObj.priority = 1;
				}

				var $sortCol = $("#_sortCol");
				var $sortStatus = $("#_sortStatus");
				var sortCol = $sortCol.val();
				var sortStatus = $sortStatus.val();
				
				if(sortCol != "" && sortCol.toUpperCase() == thObj.colFieldName.toUpperCase()){
					if(sortStatus == "ASC"){
						thObj.thArrow = thObj.upImg;
					}else if(sortStatus == "DESC"){
						thObj.thArrow = thObj.downImg;
					}
				}
				
				
				if(thObj.colWidth != ""){
					config.isSetWidth = true;
				}
				return thObj;
			},
			//解析汇总列td数据
			parseFootTd = function($tdField, i){
				var tdObj = {};
				tdObj.isvisible = $tdField.attr("isvisible");
				tdObj.ishiddencolumn = $tdField.attr("ishiddencolumn");
				tdObj.issum = $tdField.attr("issum");
				tdObj.istotal = $tdField.attr("istotal");
				tdObj.colname = $tdField.attr("colname");
				tdObj.sumbydatas = $tdField.attr("sumbydatas");
				tdObj.sumtotal = $tdField.attr("sumtotal");
				tdObj.isvisible = (tdObj.isvisible == "true")?true:false;
				tdObj.ishiddencolumn = (tdObj.ishiddencolumn == "true")?true:false;
				
				tdObj.colWidth = (tdObj.colWidth == "null") ? "" : tdObj.colWidth;
				//是否隐藏字段
				if((tdObj.colWidth && tdObj.colWidth == '0') || !tdObj.isVisible || tdObj.isHidden ){
					tdObj.display = "none";
				}
				return tdObj;
			},
			//获取表头数据
			getHeadData = function($head){
				var tr = {
						cls : Setting.TH_CLASS,
						ths : []
				}
				$head.find(">td").each(function(i){
					var $me = $(this);
					config.hideCol[i] = $me.attr("isHiddenColumn");
					tr.ths.push(parseHeadTh($me, i));
				});
				
				return tr;
			},
			//获取数据行数据
			getBodyData = function($trs){
				var tbody = {
						trs : []
				};

				$trs.each(function(){
					var $tr = $(this);
					var tr = {
							docId : $tr.attr("docId"),
							docFormid : $tr.attr("docFormid"),
							isSignatureExist : $tr.attr("isSignatureExist"),
							editType : config.editType,
							appid : jQuery("body",parent.document).find("#application").val(),
							tds : []
					};
					$tr.find(">td").each(function(){
						var $td = $(this);
						
						var td = parseTbodyTd($td);
						tr.tds.push(td);
					});
					tbody.trs.push(tr);
				});
				return tbody;
			},
			//获取汇总行数据
			getFootData = function($foot){
				
				
				
				var tr = {
						tds : []
				}
				var td = {};
				
				$foot.find(">td").each(function(i){
					var $td = $(this);
//					var td = {
//							textContent : $td.text()
//					}
					tr.tds.push(parseFootTd($td, i));
				});
				
				
				//tr.tds.push(td);
				return tr;
			},
			$field = $(this);

			config.viewId = $field.attr("_viewId"),
			config.sortCol = $field.attr("_sortCol"),
			config.sortStatus = $field.attr("_sortStatus"),
			//isReadonly = $field.isReadonly;
			isReadonly = $field.attr("isReadonly");
			isReadonly = (isReadonly == "true");
			
			if(isReadonly){
				config.editType = "readonly";
			}else{
				config.editType = "edit";
			}
			sumTrIsShow($field);
			var data = {
					viewId : config.viewId,
					head : {},
					tbody : {},
					foot : {},
					sumTrIsHidden : config.sumTrIsHidden
			};
			var $head = $field.find("tr.header"),
				$tbody = $field.find("tr[trType='dataTr']"),
				$foot = $field.find("#sumTrId");
			data.head = getHeadData($head);						//获取表头数据
			data.tbody = getBodyData($tbody);					//获取数据行数据
			data.foot = getFootData($foot);						//获取汇总行数据
			$(".dataTableDiv").append(template("listView-tmpl", data))
			//$field.remove();
			bindEvent();
		});
	};
})(jQuery);


//视图翻到第一页
function showFirstPage(FO) {
	var _currpage = ajaxPage.getParamsByName("_currpage");
	var _pagelines = ajaxPage.getParamsByName("_pagelines");
	var _rowcount = ajaxPage.getParamsByName("_rowcount");
	
	if (isNaN(parseInt(_currpage.val()))
			|| isNaN(parseInt(_pagelines.val()))
			|| isNaN(parseInt(_rowcount.val()))) {
		return;
	}
	var pageNo = parseInt(_currpage.val());
	var pageCount = Math.ceil(parseInt(_rowcount.val()) / parseInt(_pagelines.val()));
	if (pageCount > 1 && pageNo > 1) {
		_currpage.val(1);	//设置成第一页
		ajaxPage.reloadPage();
	}
}

//视图翻到上一页
function showPreviousPage(FO) {
	var _currpage = ajaxPage.getParamsByName("_currpage");
	var _pagelines = ajaxPage.getParamsByName("_pagelines");
	var _rowcount = ajaxPage.getParamsByName("_rowcount");
	
	if (isNaN(parseInt(_currpage.val()))
			|| isNaN(parseInt(_pagelines.val()))
			|| isNaN(parseInt(_rowcount.val()))) {
		return;
	}
	var pageNo = parseInt(_currpage.val());
	var pageCount = Math.ceil(parseInt(_rowcount.val()) / parseInt(_pagelines.val()));
	if (pageCount > 1 && pageNo > 1) {
		_currpage.val(pageNo - 1);	//增加一页
		ajaxPage.reloadPage();
	}
}

//视图翻到下一页
function showNextPage() {
	var _currpage = ajaxPage.getParamsByName("_currpage");
	var _pagelines = ajaxPage.getParamsByName("_pagelines");
	var _rowcount = ajaxPage.getParamsByName("_rowcount");
	
	if (isNaN(parseInt(_currpage.val()))
			|| isNaN(parseInt(_pagelines.val()))
			|| isNaN(parseInt(_rowcount.val()))) {
		return;
	}
	var pageNo = parseInt(_currpage.val());
	var pageCount = Math.ceil(parseInt(_rowcount.val()) / parseInt(_pagelines.val()));
	if (pageCount > 1 && pageCount > pageNo) {
		_currpage.val(pageNo + 1);	//增加一页
		ajaxPage.reloadPage();
	}
}


//视图翻到最后一页
function showLastPage() {
	var _currpage = ajaxPage.getParamsByName("_currpage");
	var _pagelines = ajaxPage.getParamsByName("_pagelines");
	var _rowcount = ajaxPage.getParamsByName("_rowcount");
	
	if (isNaN(parseInt(_currpage.val()))
			|| isNaN(parseInt(_pagelines.val()))
			|| isNaN(parseInt(_rowcount.val()))) {
		return;
	}

	var pageNo = parseInt(_currpage.val());
	var pageCount = Math.ceil(parseInt(_rowcount.val()) / parseInt(_pagelines.val()));
	if (pageCount > 1 && pageCount > pageNo) {
		_currpage.val(pageCount);	//设置成最后一页
		ajaxPage.reloadPage();
	}
}

var dialogView = {
		//翻页ajax,不用form的sumbit（会改变浏览器的历史）
		loadDialogViewList : function(){
			var $iframeBody = $("body");
			var $iframeForm = $("body form");
			var url = $iframeForm.attr("action");
			var params = $iframeForm.serialize();
			$.ajax({
				url : url,
				data : params,
				dataType : "html",
				cache : false,
				type : "POST",
				success : function(html){
					var $div = $("<div></div>");
					$div.append(html);
					//获取table的内容并替换
					var $view_iframe = $div.find("#view_iframe").html();
					$iframeForm.find("#view_iframe").html($view_iframe);
					//获取分页内容并替换
					var $navPage = $div.find("#footer .pagination").html();
					$iframeForm.find("#footer .pagination").html($navPage);
					tableListColumn();
				},
				error : function(ex){
					console.error("ajax页面加载报错：" + ex);
				}
			});
		},
		sendSelectList : function(){
			var $selectList = $("#selectList");
			if($selectList.size()>0){
				var $selectListInput = $("<input type='hidden' name='_selectlist' />")
				var selectList = $selectList.text();
				$selectListInput.val(selectList);
				$selectList.append($selectListInput)
			}
		},
		
		
		//视图翻到第一页
		showFirstPage : function(FO) {
			this.sendSelectList();
			var _currpage = $("body").find("input[name='_currpage']");
			var _pagelines = $("body").find("input[name='_pagelines']");
			var _rowcount = $("body").find("input[name='_rowcount']");
			
			if (isNaN(parseInt(_currpage.val()))
					|| isNaN(parseInt(_pagelines.val()))
					|| isNaN(parseInt(_rowcount.val()))) {
				return;
			}
			var pageNo = parseInt(_currpage.val());
			var pageCount = Math.ceil(parseInt(_rowcount.val()) / parseInt(_pagelines.val()));
			if (pageCount > 1 && pageNo > 1) {
				_currpage.val(1);	//设置成第一页
				this.loadDialogViewList();
			}
		},

		//视图翻到上一页
		showPreviousPage : function(FO) {
			this.sendSelectList();
			var _currpage = $("body").find("input[name='_currpage']");
			var _pagelines = $("body").find("input[name='_pagelines']");
			var _rowcount = $("body").find("input[name='_rowcount']");
			
			if (isNaN(parseInt(_currpage.val()))
					|| isNaN(parseInt(_pagelines.val()))
					|| isNaN(parseInt(_rowcount.val()))) {
				return;
			}
			var pageNo = parseInt(_currpage.val());
			var pageCount = Math.ceil(parseInt(_rowcount.val()) / parseInt(_pagelines.val()));
			if (pageCount > 1 && pageNo > 1) {
				_currpage.val(pageNo - 1);	//增加一页
				this.loadDialogViewList();
			}
		},

		//视图翻到下一页
		showNextPage : function() {
			this.sendSelectList();
			var _currpage = $("body").find("input[name='_currpage']");
			var _pagelines = $("body").find("input[name='_pagelines']");
			var _rowcount = $("body").find("input[name='_rowcount']");
			
			if (isNaN(parseInt(_currpage.val()))
					|| isNaN(parseInt(_pagelines.val()))
					|| isNaN(parseInt(_rowcount.val()))) {
				return;
			}
			var pageNo = parseInt(_currpage.val());
			var pageCount = Math.ceil(parseInt(_rowcount.val()) / parseInt(_pagelines.val()));
			if (pageCount > 1 && pageCount > pageNo) {
				_currpage.val(pageNo + 1);	//增加一页
				this.loadDialogViewList();
			}
		},


		//视图翻到最后一页
		showLastPage : function() {
			this.sendSelectList();
			var _currpage = $("body").find("input[name='_currpage']");
			var _pagelines = $("body").find("input[name='_pagelines']");
			var _rowcount = $("body").find("input[name='_rowcount']");
			
			if (isNaN(parseInt(_currpage.val()))
					|| isNaN(parseInt(_pagelines.val()))
					|| isNaN(parseInt(_rowcount.val()))) {
				return;
			}

			var pageNo = parseInt(_currpage.val());
			var pageCount = Math.ceil(parseInt(_rowcount.val()) / parseInt(_pagelines.val()));
			if (pageCount > 1 && pageCount > pageNo) {
				_currpage.val(pageCount);	//设置成最后一页
				this.loadDialogViewList();
			}
		}
}

/**
 * jquery重构列表视图
 * for:列表视图
 */
function jqRefactor4ListView(){
	var $curPage = ajaxPage.getCurPage();
	$curPage.find("table[moduleType='viewList']").obpmListView();
}