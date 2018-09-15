/**
 * 	后台预览的时候判断页面是否重构完成
 */
var isComplete = false; 

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
	jQuery("#container").width(jQuery("body").width() - 4);
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
function viewDoc(docid, formid ,signatureExist,templateForm) {
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
 * 提示是否可以执行操作
 * for:brisk
 */
function judgeOperating2(){
	var query = document.getElementById("isopenablescript");  
    if(query.value=='false;'){
        alert(isOpenAbleScriptShow);
        document.getElementById("isopenablescript").value="";
    }
}
/**
 * for:dwz 通用word控件列预览
 *
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
 * for:dwz 旧word控件
 */
function showWordDialogWithView(title, str, docid, value, fieldname, opentype, displayType, saveable, isSignature) {
	wx = '900px';
	wy = '700px';
	var application = document.getElementById("ApplicationID").value;
	var url = contextPath + '/portal/dynaform/document/newword.action?_docid='
		+ docid + "&type=word&_fieldname=" + fieldname + "&_opentype="
		+ opentype+"&_displayType="+displayType
		+ "&saveable=" + saveable
		+ "&application=" + application
		+ "&isSignature=" + isSignature
		+ "&filename=" + value;

	OBPM.dialog.show({
				width : 900,
				height : 700,
				url : url,
				args : {},
				title : title,
				close : function() {
					
				}
			});
}

/**
 * 重构列表视图
 */
(function($){
	$.fn.obpmCollapsibleView = function(){
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
			$tableHtml = jQuery("<table class=\"" + Setting.TABLE_CLASS + "\" id=\"dataTable\"></table>"),
			count = 0,	//标识折叠的深度
			retractVal = 10,	//每个深度缩进的值
			originalKey = "",	//原始key
			subKey = "",
			parentKey = "",
			/**
			 * 重构数据行td
			 */
			toDataTdHtml = function($tdField){
					var tdAttrs = {};
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
				
					tdAttrs.colWidth = (tdAttrs.colWidth != "null")?tdAttrs.colWidth:'';
					tdAttrs.colGroundColor = (tdAttrs.colGroundColor && tdAttrs.colGroundColor != "null" && tdAttrs.colGroundColor != "FFFFFF")?tdAttrs.colGroundColor:'';
					tdAttrs.colColor = (tdAttrs.colColor && tdAttrs.colColor != "null" && tdAttrs.colColor != "000000")?tdAttrs.colColor:'';
					tdAttrs.colFontSize = (tdAttrs.colFontSize && tdAttrs.colFontSize != "null" && tdAttrs.colFontSize != "12")?tdAttrs.colFontSize:'';
					tdAttrs.isVisible = (tdAttrs.isVisible == 'true'?true:false);
					tdAttrs.isReadonly = (tdAttrs.isReadonly == 'true'?true:false);
					tdAttrs.colType = tdAttrs.colType?tdAttrs.colType:"";
					tdAttrs.fieldInstanceOfWordField = (tdAttrs.fieldInstanceOfWordField == 'true'?true:false);
					tdAttrs.fieldInstanceOfgenericWordField = (tdAttrs.fieldInstanceOfgenericWordField == 'true'?true:false);

					tdAttrs.displayType = tdAttrs.displayType?tdAttrs.displayType:"";
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

				var tdHtml = '';
				var pHtml = '';
				var aHtml = '';
				
				
				var docId = $tdField.attr('docId');
				docId = docId?docId:'';
				
				var title = characterDencode($tdField.attr('title'));
				var tip = "";
				if(title.indexOf("[{") == -1)
					tip = title;
				
				var viewTemplateForm = $tdField.attr('viewTemplateForm');
				viewTemplateForm = (viewTemplateForm != "null")?viewTemplateForm:'';
									
				var docFormid = $tdField.attr('docFormid');
				docFormid = docFormid?docFormid:'';
				
				var jumpMapping = $tdField.find("div[name='jumpMapping']").html();
				jumpMapping = jumpMapping?jumpMapping:'';
				
				var result = $tdField.find("div[name='result']").html();
				result = (result?result:'');


				var convert2HTMLEncode = function(str){
					var s = str;
					if(Column.COLUMN_TYPE_FIELD == tdAttrs.colType && !tdAttrs.colFieldName.substr(0,1) == "$" && !tdAttrs.colFlowReturnCss){
						s = s.replace(new RegExp(">","gm"),"&gt;");
						s = s.replace(new RegExp("<","gm"),"&lt;");
					}
					return s;
				};
				if(tdAttrs.displayType){
					// 宽度为0时隐藏
					if((tdAttrs.colWidth && tdAttrs.colWidth == '0') || !tdAttrs.isVisible || tdAttrs.isHidden ){
						tdHtml += "<td class='" + Setting.TR_TD_CLASS + "' style='display: none;'>";
					}else if(tdAttrs.colGroundColor != ""){//如果设置了底色,加上底色
						tdHtml += "<td class='" + Setting.TR_TD_CLASS + "' width='"
								+ tdAttrs.colWidth + "' style='background-color:" + tdAttrs.colGroundColor + ";word-break: break-all;'>";
					}else{
						tdHtml += "<td class='" + Setting.TR_TD_CLASS + "' width='" + tdAttrs.colWidth + "' style='word-break: break-all;'>";
					}
					
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
							result = truncationText(result,tdAttrs.displayType,tdAttrs.colDisplayLength);
							pHtml += convert2HTMLEncode(result) + "</p>";
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
								var templateForm = "";
								if(View.DISPLAY_TYPE_TEMPLATEFORM == tdAttrs.viewDisplayType){
									templateForm = viewTemplateForm;
								}
								if(result.indexOf("[{") != -1){
									aHtml += "<div style=\"cursor:pointer;\" onclick=\"javaScript:viewDoc('";
								}else{
									aHtml += "<a href=\"javaScript:viewDoc('";
								}
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
									
								if(result.indexOf("img") != -1) {
									if(tdAttrs.isShowTitle)
										aHtml += " title='" + convert2HTMLEncode(tip) + "'";
										
									aHtml += " >";
									aHtml += convert2HTMLEncode(result) + "</a>";
								}else{
									if(tdAttrs.isShowTitle)
										aHtml += " title='" + convert2HTMLEncode(tip) + "'";
									aHtml += " >";
									if(result.indexOf("[{") != -1){
										aHtml += convert2HTMLEncode(result) + "</div>";
									}else{
										aHtml += convert2HTMLEncode(result) + "</a>";
									}
								}
							}
						}
						tdHtml += aHtml;

					}
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
					if("COLUMN_TYPE_LOGO" == tdAttrs.colType && tdAttrs.colIcon && tdAttrs.colIcon != ""){
						tdHtml += "<img style='' src='../../../lib/icon/" + tdAttrs.colIcon+ "'/>";
					}
					if(tdAttrs.fieldInstanceOfWordField){
						var btnHtml = "<img src='../../share/images/view/word.gif'";
						
						btnHtml += " onclick=\"showWordDialogWithView('"+tdAttrs.showword+"','WordControl','"+docId+"','"+result+"','"+tdAttrs.colFieldName+"',3,2,false,true);event.stopPropagation();\" ></img>";
						
						tdHtml += btnHtml;					
					}else if(tdAttrs.fieldInstanceOfgenericWordField){//通用word控件
						var resultObj = JSON.parse(result);
						var btnHtml = "<img class='genericword' src='../../share/images/view/genericword.jpg' "+
										"data-title='"+tdAttrs.showword+"' "+
										"data-fileName='"+resultObj.filename+"' "+
										"data-path='"+resultObj.path+"' "+
										"data-type='"+resultObj.type+"' "+
										"data-colFieldName='"+tdAttrs.colFieldName+"'/>";
						tdHtml += btnHtml;		
					}else if (result && result.length == 0) {
						tdHtml += "&nbsp;";
					}
					tdHtml += "</td>";
				}
				
				return tdHtml;
			},//重构数据行td----end
			
			/**
			重构表头new
			*/
			toThHtml = function($tr) {
				var trHtml;
				trHtml = "<tr class=\"" + Setting.TH_CLASS + "\">";
				trHtml += "<td class=\"" + Setting.TH_FIRST_TD_CLASS + "\" scope=\"col\"><input type=\"checkbox\" onClick=\"selectAll(this.checked)\"></td>";
				
				$tr.find(">td").each(function(index){
					var tdHtml = "",$td = $(this),tdHtml = "";
					var $tdField = $(this);
					var thAttrs = {};
					thAttrs.isVisible = $tdField.attr("isVisible");
					
					thAttrs.isHiddenColumn = $tdField.attr("isHiddenColumn");
					thAttrs.colWidth = $tdField.attr("colWidth");

					thAttrs.isVisible = (thAttrs.isVisible == "true")?true:false;
					thAttrs.isHiddenColumn = (thAttrs.isHiddenColumn == "true")?true:false;
					thAttrs.colWidth = (thAttrs.colWidth == "null") ? "" : thAttrs.colWidth;

					//根据列头的显示隐藏值设置数据行对应列的显示和隐藏值
					$tableHtml.find("tr:gt(0)").each(function(){
						$(this).find(" td:eq("+index+")").attr("isHidden", thAttrs.isHiddenColumn);
					});
					
					if(thAttrs.isVisible && !thAttrs.isHiddenColumn){//显示列
						var styleWidth = thAttrs.colWidth==""?"":"width:"+thAttrs.colWidth;
						tdHtml = "<td class='"+Setting.TH_TD_CLASS+"' style='"+styleWidth+"'>"+$td.text()+"</td>";
					}
					else {//隐藏列
						tdHtml = "<td class='"+Setting.TH_TD_CLASS+"' style=\"display:none;\">"+$td.text()+"</td>";
					}
					trHtml += tdHtml;
				});
				trHtml += "</tr>";
				return trHtml;
			},
			/**
			 * 不折叠的行构建
			 */
			toFoldMasterTrHtml = function($tr) {
				var $tr1 = $("<tr class=\"" + Setting.TR_CLASS + " FoldMaster\"></tr>"), key;
				var $td1 = $("<td class=\"" + Setting.TR_FIRST_TD_CLASS + "\" scope=\"col\"><input type=\"checkbox\" name='_selects' value='"+$tr.attr("docId")+"'></td>");
				$tr1.append($td1);
				$tr.find(">td").each(function(index){
					var $td = $(this), $td1;
					if (index == 0) {	//可折叠列
						var text = $td.find(">div:first").text();
						key = text;
						$td1 = $("<td class='"+Setting.TR_TD_CLASS+", collapsible'>"+text+"</td>");
					} else {	//其他列
						$td1 = $(toDataTdHtml($td));
					}
					$tr1.append($td1).attr("_key",key);
				});
				
				return $tr1;
			},
			/**
			 * 无下级的行构建
			 */
			toLastDetailTrHtml = function($tr,key2) {
				count++;
				var key = key2.replace(/\\/g,"-"),
				$trHtml = $("<tr class=\"" + Setting.TR_CLASS + " FoldDetail\" _key='" + subKey + "' style='display:none;' parentKey = '"+ parentKey +"'></tr>");
				var $td1 = $("<td class=\"" + Setting.TR_FIRST_TD_CLASS + "\" scope=\"col\"><input type=\"checkbox\" name='_selects' value='"+$tr.attr("docId")+"'></td>");
				$trHtml.append($td1);
				$tr.find(">td").each(function(index){
					var $td = $(this), $td1;
					if (index == 0) {//可折叠列
						$td1 = $("<td class='"+Setting.TR_TD_CLASS+", collapsible'>"+key2+"</td>")
								.css("padding-left",((count)*retractVal)+10+"px");	//缩进
					}
					else{//其他列
						$td1 = $(toDataTdHtml($td));
					}
					$trHtml.append($td1);
				});
				
				count=0;	//重置折叠的深度
				originalKey = "";	//重置缩进值
				subKey = "";
				parentKey = "";
				return $trHtml;
			},
			
			/**
			 * 中间行重构
			 */
			toDetailTrHtml = function($tr,orig_key,recursion){
				if(count==0){	//初次重构时设置原始key
					orig_key = orig_key.replace(/\\/g,"-");    //AA-BB-CC-DD
				}
				
				//1-----key
				var pos = orig_key.indexOf("-");       
				var key = orig_key.substring(0, pos);          
				var _subKey = orig_key.substring(pos+1,orig_key.length); 
                 				
				//2-----subKeyWord
				var _pos = _subKey.indexOf("-");
				
				var subKeyWord ;
				if(_pos > 0){
					subKeyWord = _subKey.substring(0, _pos);   
				}
				
				var tmpKey = key;
				//3------subKey
				if(count==0){
					
					if(_pos > 0){
						subKey = key + "_" + subKeyWord;
					}else{
						subKey = key + "_" + _subKey;
					}
				}else{
					
					key = subKey; //控制tr
					
					if(_pos > 0){
						subKey = subKey + "_" + subKeyWord;
					}else{
						subKey = subKey + "_" + _subKey;
					}
				}
				count++;
					var $trMaster = $tableHtml.find("tr.FoldMaster[_key='"+key+"']");
					if ($trMaster.size()<=0) {	//没有Master数据，则需要生成一个Master，供折叠操作使用
						var $trHtml = $("<tr class=\"" + Setting.TR_CLASS + " FoldMaster\" _key='"+key+"' subKey='"+subKey+"' parentKey ='"+ parentKey +"'></tr>");
						if(recursion){	//递归时隐藏行
							$trHtml.css("display","none");
						}
						$tr.find(">td").each(function(index){
							var $td = $(this), $td1;
							if(index == 0) {
								$td1 = $("<td class=\"" + Setting.TR_FIRST_TD_CLASS + "\" scope=\"col\"></td>");
							}
							else if (index == 1) {//可折叠列
								$td1 = $("<td class='"+Setting.TR_TD_CLASS+" folded , collapsible'>"+tmpKey+"</td>").click(function(){//点击折叠
									var $tr = $(this).parent();
									var key = $tr.attr("_key");
									if($(this).attr("class").indexOf("unfolded") > -1){ //  展开状态
										$tr.nextAll("tr[_Key^='"+key+"']").hide();
										$tr.nextAll("tr[_Key^='"+key+"']").each(function(){
											if($(this).attr("class") == "listDataTr FoldMaster"){
												$(this).find("td:eq(1)").removeClass("unfolded").addClass("folded");
											}
										});
										$(this).removeClass("unfolded").addClass("folded");
									}else{ //折叠状态
										$("tr[parentKey='"+key+"']").show();
										$(this).removeClass("folded").addClass("unfolded");
									}
								})
								.css("padding-left",((count)*retractVal)+10+"px")
								.css("background-position-x",((count)*retractVal)-5+"px");
							}
							else{//其他列
								if ($td.attr("isVisible")=="false" || $td.attr("isHiddenColumn")=="true") {//隐藏列
									$td1 = $("<td style='display:none'>&nbsp;</td>");
								}
								else {//显示列
									$td1 = $("<td></td>");
								}
							}
							$trHtml.append($td1);
						});

						$tableHtml.append($trHtml);
					}
				parentKey = key ;
				
				if(_subKey.indexOf("-")>0){	//递归
					toDetailTrHtml($tr,_subKey,true);
				}else {	//无下级行
					$tableHtml.append(toLastDetailTrHtml($tr,_subKey));
				}
			},
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
							var aHtml = "<a style=\"cursor:pointer\" href=\"#\"></a>";
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
			truncationText = function(input,displayType,displayLength){
				if(displayType == Column.DISPLAY_PART){
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
			var sumTrIsHidden = true;

			//判断是否输出汇总行
			$field.find("#sumTrId").find("td").each(function(){
				if(jQuery(this).attr("isSum") == "true" || jQuery(this).attr("isTotal") == "true"){
					sumTrIsHidden = false;
					return;
				}
			});

			
			/**重构DATATABLE内容*/
			$field.find("tr.header").each(function(){//当为表头
				var $tr = $(this);
				$tableHtml.append(toThHtml($tr));
			});
			
			var $dataTr = $field.find("tr[trType='dataTr']");
			for(var k=0;k<$dataTr.size();k++){	//排序（冒泡）
				var $tr = $field.find("tr[trType='dataTr'][sign!=true]:eq(0)");
				var key1 = $tr.find(">td:eq(1) > div[name=result]").text();
				$dataTr.each(function(){
					if($(this).attr("sign") != "true"){
						var key2 = $(this).find(">td:eq(1) > div[name=result]").text();
						if($tr.attr("sign") == "true"){
							key1 = key2;
							$tr = $(this);
						}
						if(key1 > key2) {
							key1 = key2;
							$tr = $(this);
						}
					}
				});
				$tr.attr("sign","true");	//标记已排序
				if(key1.indexOf("\\")<0){	//不折叠的行
					$tableHtml.append(toFoldMasterTrHtml($tr));
				}else {	//折叠行
					toDetailTrHtml($tr,key1,false);
				}
			}
			
			//if (false)//暂时不用，屏蔽之
			$field.find("#sumTrId").each(function(i){//行<tr>
				var $trHtml = "";
				var $trField = jQuery(this);
				
				if(isSum && !sumTrIsHidden){//末行(字段值汇总)
					$trHtml = jQuery("<tr class=\"" + Setting.TR_CLASS + "\" onmouseover=\"this.className='" 
							+ Setting.TR_OVER_CLASS + "';\" onmouseout=\"this.className='" + Setting.TR_CLASS + "';\">");
					
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
						if(i == 0){//首列
							tdHtml += "<td class=\"" + Setting.TR_FIRST_TD_CLASS + "\">";
							tdHtml += "&nbsp;</td>";
						}else{//其他列
							if(sumTdAttrs.isVisible && !sumTdAttrs.isHiddenColumn){
								tdHtml += "<td>";
								if(sumTdAttrs.isSum || sumTdAttrs.isTotal)
									tdHtml += sumTdAttrs.colName;
								if(sumTdAttrs.isSum)
									tdHtml += sumTdAttrs.sumByDatas + "&nbsp;";
								if(sumTdAttrs.isTotal)
									tdHtml += sumTdAttrs.sumTotal + "&nbsp;";
								tdHtml += "</td>";
							}
						}
						$trHtml.append(tdHtml);
					});
					$tableHtml.append($trHtml);
					$trHtml = null;
				}
			});
			
			$tableHtml.replaceAll($field);
		});
	};
})(jQuery);

/**
 * jquery重构列表视图
 * for:列表视图
 */
function jqRefactor4ListView(){
	jQuery("table[moduleType='viewList']").obpmCollapsibleView();
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
}