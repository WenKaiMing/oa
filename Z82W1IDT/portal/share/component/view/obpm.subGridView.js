/**
 * 	后台预览的时候判断页面是否重构完成
 */
var isComplete = false; 

/**
 * 	判断视图是否设置了列宽
 */
var isSetWidth = false;

/**
 * 网格视图公用初始化方法
 * @return
 */
function initGridComm(){
	jqRefactor4SubGridView();//网格视图重构
	jQuery("div[moduleType='viewFileManager']").obpmViewFileManager();  	//网格视图文件管理功能
	jQuery("div[moduleType='viewTakePhoto']").obpmViewTakePhoto();  	//网格视图在线拍照功能
	jQuery("div[moduleType='viewImageUpload']").obpmViewImageUpload();  	//网格视图图片上传功能
	jQuery("div[moduleType='viewImageUpload2DataBase']").obpmViewImageUpload2DataBase();  	//网格视图图片上传到数据库功能
	setTimeout(function(){
		jqRefactor();	//表单控件jquery重构
		hiddenGridBtn(); //表单没有操作权限的时候，网格视图按钮隐藏
	}, 1);
	openDownloadWindow(openDownWinStr);		//打开Excel下载窗口
	setTimeout(function(){
		ev_resize4IncludeViewPar();	//包含元素包含视图时调整iframe高度
		dataTableSize();	//设置数据容器的高度
		setTimeout(function(){
			showPromptMsg();	//显示提示信息
		},300);
		ev_resize4Change(); //窗体变化时调整网格视图的宽度
	},100);
	
	jQuery(".imgClick").bind("click",function(event){
		 event.stopPropagation();
	});
	
	jQuery("#table_gridView").on("click",".listDataThFirstTd input",function(e){
		var $selectDiv = $("#table-gridView-selects");
		$selectDiv.empty();
		$("#dataBody").find("tr.listDataTr").each(function(){
			var $this = $(this);
			var $firstTd = $this.find("td:eq(0)");
			var $selectCheckBox = $firstTd.find("input[name='_selects']");
			console.log(1)
			console.log($selectCheckBox.is(":checked"))
			if($selectCheckBox.is(":checked")){
				$selectDiv.append($selectCheckBox.clone());
			}
		})
	});
	
	jQuery(window).resize(function(){
		ev_resize4Change(); //窗体变化时调整网格视图的宽度
		dataTableSize();	//设置数据容器的高度
	});
	
	setTimeout(function(){
		tableScroll("gridTable","table_gridView"); //固定表头
		fixTableScroll("gridTable","table_gridView"); //计算固定表头单元格宽度
	},500);
	
	isComplete = true; //后台预览的时候判断页面是否重构完成
}

/*
 * 固定表头
 */
function tableScroll(viewid,scrollid){  
	var $scroll = $("#"+scrollid);  
	var $th = $("#"+viewid).find("tr:eq(0)").clone();  
	var $bakTableLayoutCss = $("#"+viewid).css("table-layout");
	var $bak = $("<div id='bak_table_"+viewid+"'><table class='listDataTable' style='z-index: 1; table-layout: "+$bakTableLayoutCss+";' border='0' cellpadding='0' cellspacing='0'><thead></thead></table></div>");  
	$scroll.append($bak);
	$scroll.css("position","relative");
	$bak.find("thead").append($th);  
	$bak.css({
		"position":"absolute",
		"background-color":"#cfc",
		"display":"block",
		"left":"0px",
		"top":"0px",
		"width":"auto",
	})
	$scroll.on("scroll",function(){  
		$bak.css("top",this.scrollTop+"px")
	})
	
	$(".grid-column-edit").find(">input.input-cmd").width("90%");
}  

/*
 * 修改固定表头单元格宽度
 */
function fixTableScroll(viewid,scrollid){
	var $scroll = $("#"+scrollid);  
	var $bak = $scroll.find("#bak_table_"+viewid);
	var $gridView = $("#"+viewid);
	var $th = $gridView.find("tr:eq(0)");
	var thSize = $th.find("td").size();
	var $gridViewBdTr = $("#"+viewid).find("tr");
	var totalWidth = 0

	for(var i = 0; i < thSize; i++){
		var width = Math.round($th.find("td:eq("+i+")").outerWidth());
		if(i == 0){
			width = 45;
		}else{
			if(width < 75){
				width = 75;
			}
		}
		totalWidth += width
		$bak.find("td:eq("+i+")").outerWidth(width);
		$.each($gridViewBdTr,function(){
			$(this).find("td:eq("+i+")").outerWidth(width);
		});
	}
	$bak.width($gridView.width()+1);
	
	if($scroll.width() < totalWidth){
		$gridView.css("table-layout","fixed");
		$bak.find(">table").css("table-layout","fixed")
	}else{
		$gridView.css("table-layout","auto");
		$bak.find(">table").css("table-layout","auto")
	}
} 

/*
 * 表单没有操作权限的时候，网格视图按钮隐藏
 */
function hiddenGridBtn(){
	var gridIsEdit = document.getElementsByName("isedit")[0].value;
	if(gridIsEdit=="false"){
		jQuery("#act .actBtn,#act .button-dis").hide();
	}
}
//给后台preview.jsp视图预览的时候判断页面是否重构完成
function getIsComplete(){
	return isComplete ;
}

function on_unload() {
	ev_reloadParent();
}

//设置数据容器的高度。
function dataTableSize(){
	var bodyH = jQuery("body").height();
	var acttableH = jQuery("#acttable").height();
	jQuery("#table_gridView").height(bodyH - acttableH-20);
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

/**
 * 包含元素包含视图时调整iframe高度
 * from:blue/brisk/default/dwz/fresh/gentle
 */
function ev_resize4IncludeViewPar(){
	var divid = document.getElementsByName("divid")[0].value;
	var _viewid = document.getElementsByName("_viewid")[0].value;
	ev_resize4IncludeView(divid,_viewid,'GRIDVIEW');
}

/**
 * 窗体变化时调整网格视图的宽度
 * for:所有皮肤
 */
function ev_resize4Change(){
	var bodyPW = jQuery("body").parent().width();
	jQuery("body").width(bodyPW);
	jQuery("#dspview_divid").width(bodyPW -6);
	jQuery("#table_gridView").width(bodyPW-6);
	jQuery("#acttable").width(bodyPW-6);
}


/**
 * 批量签章按钮对应的Function
 */
function DoBatchSignature() {
	if(navigator.userAgent.indexOf("MSIE")<0){
		alert("金格iSignature电子签章HTML版只支持IE，如果要签章请用IE浏览器");
		return;
	}
	var mLength = document.getElementsByName("_selects").length;
	var vItem;
	var DocumentList = "";
	for (var i = 0; i < mLength; i++) {
		vItem = document.getElementsByName("_selects")[i];
		if (vItem.checked) {
			if (i != mLength - 1) {
				DocumentList = DocumentList + vItem.value + ";";
			} else {
				DocumentList = DocumentList + vItem.value;
			}
		}
	}
	// alert(DocumentList);
	var ajax = null;

	if (window.ActiveXObject) {

		try {

			ajax = new ActiveXObject("Microsoft.XMLHTTP");

		} catch (e) {

			alert("创建Microsoft.XMLHTTP对象失败,AJAX不能正常运行.请检查您的浏览器设置.");
		}

	} else {

		if (window.XMLHttpRequest) {

			try {

				ajax = new XMLHttpRequest();

			} catch (e) {

				alert("创建XMLHttpRequest对象失败,AJAX不能正常运行.请检查您的浏览器设置.");
			}

		}
	}

	var url = document.getElementById("mGetBatchDocumentUrl").value;
	var mLoginname = document.getElementById("mLoginname").value;
	var DocumentID = document.getElementById("DocumentID").value;
	var ApplicationID = document.getElementById("ApplicationID").value
	var FormID = document.getElementById("FormID").value
	url = url + "?DocumentID=" + DocumentID + "&ApplicationID2="
			+ ApplicationID + "&FormID2=" + FormID;

	ajax.onreadystatechange = function() {

		if (ajax.readyState == 4 && ajax.status == 200) {

			if (ajax.responseText == "false") {

				return;
			}

			var documentName = ajax.responseText.split(',');
			// var buffer = [];
			var fildsList = "";
			for (var i = 0; i < documentName.length; i++) {

				if (i != documentName.length - 1) {
					// buffer.push(documentName[i]+"="+documentName[i]);
					fildsList = fildsList
							+ (documentName[i] + "=" + documentName[i] + ";");
				} else {
					// buffer.push(documentName[i]+"="+documentName[i]);
					fildsList = fildsList
							+ (documentName[i] + "=" + documentName[i]);
				}

			}
			// alert(fildsList);
			// buffer.join("");
			// alert(buffer);
			//alert(formList.SignatureControl);
			if (formList.SignatureControl != null) {
				if (DocumentList == "") {
					alert("请选择需要签章的文档。");
				}
				formList.SignatureControl.FieldsList = fildsList; // 所保护字段
				formList.SignatureControl.Position(460, 275); // 签章位置
				formList.SignatureControl.DocumentList = DocumentList; // 签章页面ID
				formList.SignatureControl.WebSetFontOther("True", "同意通过", "0",
						"宋体", "11", "000128", "True"); // 默认签章附加信息及字体,具体参数信息参阅技术白皮书
				formList.SignatureControl.SaveHistory = "false"; // 是否自动保存历史记录,true保存
				// false不保存
				// 默认值false
				formList.SignatureControl.UserName = "lyj"; // 文件版签章用户
				formList.SignatureControl.WebCancelOrder = 0; // 签章撤消原则设置,
				// 0无顺序 1先进后出
				// 2先进先出 默认值0
				// formList.SignatureControl.DivId = "contentTable"; //签章所在层
				formList.SignatureControl.AutoCloseBatchWindow = true;
				formList.SignatureControl.RunBatchSignature();
			} else {
				alert("请安装金格iSignature电子签章HTML版软件");
				document.getElementById("hreftest2").click();
			}

		}

	};

	ajax.open("POST", url);

	ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	ajax.send(null);
}

(function($){
$.fn.obpmSubGridView = function(){
		return this.each(function(){
			Setting = {//
					TABLE_CLASS : 'listDataTable',		//表格class
					TH_CLASS : 'listDataTh',						//标题行class
					TH_FIRST_TD_CLASS : 'listDataThFirstTd',			//标题行第一个单元格class
					TH_TD_CLASS : 'listDataThTd',		//标题行其他单元格class
					TR_FIRST_TD_CLASS : 'listDataTrFirstTd',		//数据行第一个单元格class
					TR_TD_CLASS : 'listDataTrTd',		//数据行其他单元格class
					TR_CLASS : 'listDataTr',				//数据行class
					TR_OVER_CLASS : 'listDataTr_over'	//数据行滑过class
			};
			toFirstTdHtml = function($tdField){
				var tdHtml = "";
				var thAttrs = {};
				thAttrs.upImg = "<img border=\"0\" src='../../share/images/view/up.gif'/>";
				thAttrs.downImg = "<img border=\"0\" src='../../share/images/view/down.gif'/>";
				
				thAttrs.isVisible = $tdField.attr("isVisible");
				thAttrs.isHiddenColumn = $tdField.attr("isHiddenColumn");
				thAttrs.isBlank = $tdField.attr("isBlank");
				thAttrs.id = $tdField.attr("id");
				thAttrs.value = $tdField.attr("value");
				thAttrs.colWidth = $tdField.attr("colWidth");
				thAttrs.colText = $tdField.attr("colText");
				thAttrs.isEmpty = $tdField.attr("isEmpty");
				thAttrs.colType = $tdField.attr("colType");
				thAttrs.colFieldName = $tdField.attr("colFieldName");
				thAttrs.isOrderByField = $tdField.attr("isOrderByField");
				thAttrs.isVisible = (thAttrs.isVisible == "true");
				thAttrs.isHiddenColumn = (thAttrs.isHiddenColumn == "true");
				thAttrs.isBlank =(thAttrs.isBlank =="true");
				thAttrs.isEmpty =(thAttrs.isEmpty =="true");
				
				if(thAttrs.isVisible && !thAttrs.isHiddenColumn){
					if(thAttrs.colWidth != "0"){
						if(thAttrs.colWidth != "" && thAttrs.colWidth != "null"){
							isSetWidth = true;
						}
						if(!thAttrs.isBlank){
							tdHtml += "<td class=\"" + Setting.TH_TD_CLASS + "\" width=\"" 
							+ thAttrs.colWidth + "\" nowrap='nowrap' style='word-wrap: break-word; word-break: break-all;overflow: hidden;' >";
						}else{
							tdHtml += "<td class=\"" + Setting.TH_TD_CLASS + "\" nowrap='nowrap' style=\"overflow: hidden;\">";
						}
						tdHtml +="<input id=\"" + thAttrs.id + "\" value=\"" + thAttrs.value + "\" type=\"hidden\"/>";

						if(thAttrs.colType == "COLUMN_TYPE_FIELD"){
							tdHtml += "<a style=\"cursor:pointer\" href=\"#\" onclick=\"sortTable('"+thAttrs.colFieldName+"')\">";
							if(_sortCol != "null"){
								if(_sortCol != "" && _sortCol.toUpperCase() == thAttrs.colFieldName.toUpperCase()){
									tdHtml += ""+thAttrs.colText +"";
									if(_sortStatus == "ASC"){
										tdHtml += ""+thAttrs.upImg+"";
									}else if(_sortStatus == "DESC"){
										tdHtml += ""+thAttrs.downImg+"";
									}
									tdHtml +="</a>";
								}else{
									if(thAttrs.isOrderByField != "null" && thAttrs.isOrderByField != "" && thAttrs.isOrderByField == "true"){
										tdHtml += ""+thAttrs.colText+"</a>";
									}else{//不勾选排序
										tdHtml += ""+ thAttrs.colText+"";
									}
								}
							}else{
								if(thAttrs.isOrderByField != "null" && thAttrs.isOrderByField != "" && thAttrs.isOrderByField == "true"){
									tdHtml +="" + thAttrs.colText + "";
									//可排序图标
									if(_sortStatus == "ASC"){
										tdHtml +=""+thAttrs.upImg + "";
									}else if(_sortStatus == "DESC"){
										tdHtml +=""+thAttrs.downImg+"";
									}
									tdHtml +="</a>";
								}else{//不勾选排序
									tdHtml +=""+thAttrs.colText+"";
								}
							}
						}else{//脚本不需要排序
							tdHtml +=""+thAttrs.colText+"";
						}
					}else{
						tdHtml +="<td class=\"" + Setting.TH_TD_CLASS + "\" style=\"display:none;\">" + thAttrs.colText + "</td>";
					}
				}
				return tdHtml;
			};//重构表头----end
			
			var $field = jQuery(this);
			var _sortCol = $field.attr("_sortCol");
			var _sortStatus = $field.attr("_sortStatus");
			var isSum = $field.attr("isSum");
			isSum = (isSum == "true");
			
			var $tableHtml = jQuery("<table class=\"" + Setting.TABLE_CLASS + "\" id=\"gridTable\" style=\"" +
						"z-index:1;table-layout:auto;\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"></table>");
			$field.before($tableHtml);
			var sumTrIsHidden = true;
			var $tbodyHtml = $("<tbody id=\"dataBody\" ></tbody>");
			$tableHtml.append($tbodyHtml);
			var tfoot = "<tfoot>";
			//判断是否输出汇总行
			var $tdFootArray = $field.find("#sumTrId").find("td");
			for(var k=0;k<$tdFootArray.size();k++){
				if(jQuery(this).attr("isSum") == "true" || jQuery(this).attr("isTotal") == "true"){
					sumTrIsHidden = false;
					 break;
				}
			}
			var $trArray = $field.find("tr");
			for(var i=0;i<$trArray.size();i++){
				var $trField = jQuery($trArray[i]);
				if(i == 0){  //首行（列头）
					var trHtml ="<tr class=\"" + Setting.TH_CLASS + "\">";
					var $tdArray = $trField.find("td");
					for(var j=0;j<$tdArray.size();j++){
						var $tdField = jQuery($tdArray[j]);
						if(j == 0){//first td
							var tdHtml = "<td class=\"" + Setting.TH_FIRST_TD_CLASS + "\" scope=\"col\">";
								tdHtml += "<input type=\"checkbox\" onclick=\"selectAll(this.checked)\" />";
								tdHtml +="</td>";
							trHtml +=""+ tdHtml +"";
						}else if(j == $field.find("tr").eq(0).find("td").size()-1){//last td
							var actions = $tdField.attr("actions");
							var tdHtml = "<td class=\"hide " + Setting.TH_TD_CLASS + "\" style=\"width:120px\">" + actions + "</td>";
							trHtml +=""+ tdHtml +"";
						}else{//其他列
							//根据列头的显示隐藏值设置数据行对应列的显示和隐藏值
							$field.find("tr:gt(0)").each(function(){
								$(this).find(" td:eq("+j+")").attr("isHidden", $tdField.attr("isHiddenColumn"));
							});
							
							trHtml+=""+ toFirstTdHtml($tdField)+"";
						}
					}
					trHtml +="</tr>";
					$tableHtml.prepend("<thead>" + trHtml + "</thead>");
				}else if(isSum && !sumTrIsHidden && (i == $field.find("tr").size()-1)){//末行(字段值汇总)
					var tdHtml = "";
					var $tdArray = $trField.find("td");
					for(var j=0;j<$tdArray.size();j++){
						var $tdField = jQuery($tdArray[j]);
						var sumTdAttrs = {};
						sumTdAttrs.isVisible = $tdField.attr("isVisible");
						sumTdAttrs.isHiddenColumn = $tdField.attr("isHiddenColumn");
						sumTdAttrs.isSum = $tdField.attr("isSum");
						sumTdAttrs.isTotal = $tdField.attr("isTotal");
						sumTdAttrs.colName = $tdField.attr("colName");
						sumTdAttrs.sumByDatas = $tdField.attr("sumByDatas");
						sumTdAttrs.sumTotal = $tdField.attr("sumTotal");
						sumTdAttrs.isVisible = (sumTdAttrs.isVisible == "true");
						sumTdAttrs.isHiddenColumn = (sumTdAttrs.isHiddenColumn == "true");
						sumTdAttrs.isSum = (sumTdAttrs.isSum == "true");
						sumTdAttrs.isTotal = (sumTdAttrs.isTotal == "true");	
						if(j == 0){//首列
							tdHtml += "<td class=\"" + Setting.TR_FIRST_TD_CLASS + "\">";
							tdHtml += "&nbsp;</td>";
						}else if(j==$trField.find("td").size()-1){
							tdHtml += "<td class=\"hide " + Setting.TR_FIRST_TD_CLASS + "\">";
							tdHtml += "&nbsp;</td>";
						}else{//其他列
							if(sumTdAttrs.isVisible && !sumTdAttrs.isHiddenColumn){
								tdHtml += "<td class=\"" + Setting.TR_TD_CLASS + "\" >";
								if(sumTdAttrs.isSum || sumTdAttrs.isTotal)
									tdHtml += sumTdAttrs.colName;
								if(sumTdAttrs.isSum)
									tdHtml += sumTdAttrs.sumByDatas + "&nbsp;";
								if(sumTdAttrs.isTotal)
									tdHtml += sumTdAttrs.sumTotal + "&nbsp;";
								tdHtml += "</td>";
							}
						}
					}
					var trHtml = "<tr class=\"" + Setting.TR_CLASS + "\" onmouseover=\"this.className='" 
					+ Setting.TR_OVER_CLASS + "';\" onmouseout=\"this.className='" + Setting.TR_CLASS + "';\">";
						trHtml +="" + tdHtml;
						trHtml +="</tr>";
						$tableHtml.append("<tfoot>"+trHtml+"</tfoot>");
				}else if($trField.attr("trType") =="dataTr"){
					var id =$trField.attr("id");
					var trInnerHtml = "<tr id='" + id + "' class=\"" + Setting.TR_CLASS + "\" onmouseover='jQuery(this).addClass(\"" + Setting.TR_OVER_CLASS + "\")' onmouseout='jQuery(this).removeClass(\"" + Setting.TR_OVER_CLASS + "\")'>";

					var $tdArray = $trField.find("td");
					for(var j=0;j<$tdArray.size();j++){
						var $tdField = jQuery($tdArray[j]);
						var tdAttrs = {};
						tdAttrs.fieldType = $tdField.attr('fieldType');
						tdAttrs.colWidth = $tdField.attr("colWidth");
						tdAttrs.colGroundColor = $tdField.attr('colGroundColor');
						tdAttrs.colFontSize = $tdField.attr('colFontSize');
						tdAttrs.colIsEdit = $tdField.attr('colIsEdit');
						tdAttrs.isHiddenColumn = (tdAttrs.isHiddenColumn == "true");
						tdAttrs.colDocId = $tdField.attr('colDocId');
						if(j==0){//首列
							trInnerHtml += "<td class=\"" + Setting.TH_FIRST_TD_CLASS + "\" scope=\"col\">" + $tdField.html() + "</td>";
						}else if(j==$tdArray.size()-1){
							trInnerHtml += "<td class=\"hide " + Setting.TR_FIRST_TD_CLASS + "\" style=\"width:120px\">" + $tdField.html() + "</td>";
						}else{//其它数据列
							if(!tdAttrs.isHiddenColumn){
								tdAttrs.fieldType = $tdField.attr('fieldType');
								tdAttrs.coltype = $tdField.attr('coltype');
								var tdWidth = "";
								var tdBackColor = "";
								var fontSize = "";
								if(tdAttrs.colWidth != "" && tdAttrs.colWidth != "null" && tdAttrs.colWidth != undefined) tdWidth = "width: " + tdAttrs.colWidth + ";";
								if(tdAttrs.colGroundColor != "FFFFFF") tdBackColor = "background-color: #" + tdAttrs.colGroundColor + ";";
								if(tdAttrs.colFontSize != "") fontSize = "font-size: " + tdAttrs.colFontSize + "px;";
								trInnerHtml += "<td class=\"" + Setting.TR_TD_CLASS + "\" scope=\"col\" style=\"word-break: break-all;" + tdBackColor + tdWidth + fontSize + "overflow: hidden;\"";
								if(tdAttrs.colIsEdit != "" && tdAttrs.colIsEdit != "null" && tdAttrs.colIsEdit != undefined){
									if(tdAttrs.colIsEdit == true || tdAttrs.colIsEdit == "true"){
										trInnerHtml += "onclick=\"doRowEdit('" + tdAttrs.colDocId + "',this)\"";
									}
								}
								trInnerHtml +=">";
								
								var $tdGrid = $tdField.find("div");
								var $tdGridID = $tdGrid.attr("id");
								var $tdText = $tdField.context.innerText;
								var tdInnerHtml;
								//图片上传
								if(tdAttrs.fieldType == "imageupload"){
									//解析附件json数据生成html
									var _result = $tdField.find(".grid-column-show").html();
									if(_result && _result != "" && _result != " "){
										var instances = JSON.parse(_result);
										var $tdShow = $tdField.find(".grid-column-show");
										$tdShow.html("");
										$.each(instances,function(key,data){
											var attachmentObj = instances[key];
											var attachmentName = attachmentObj.name;
											var attachmentPath = attachmentObj.path;
											var _html = "<img src='"+contextPath+attachmentPath+"' width='100px'>";
											$tdShow.html(_html);
										});
									}
									tdInnerHtml = $tdField.html();
								}else if(tdAttrs.fieldType == "onlinetakephoto"){
									//解析附件json数据生成html
									var $tdShow = $tdField.find(".grid-column-show");
									var value = $tdShow.html();
									if(value.trim()){
										var _url = $(value).attr("url").replace(/\\'/g,"");
										var _picHtml = "<img style='max-height:50px;max-width:50px;' src='"+_url+"' />";
										$tdShow.html(_picHtml);
									}
									tdInnerHtml = $tdField.html();
								}else if($tdGridID && $tdText && $tdGridID.indexOf("$StateLabel") >= 0 && $tdText.indexOf("[")==0){
									//解析json数据生成html
									var instances = JSON.parse($tdText);
									$.each(instances,function(name,value){
										var instance = instances[name];
										var instanceId = instance.instanceId;
										var nodes = instance.nodes;
										$.each(nodes,function(name,value){
											var node = nodes[name];
											var nodeId = node.nodeId;
											var stateLable = truncationText(node.stateLabel,tdAttrs.displayType,tdAttrs.colDisplayLength);
											tdInnerHtml = stateLable + " ; ";
										})
									})
									
								}else if($tdGridID && $tdText && $tdGrid.attr("id").indexOf("$PrevAuditUser") >= 0 && $tdText.indexOf("[")==0){
									//解析json数据生成html
									var instances = JSON.parse($tdText);
									$.each(instances,function(name,value){
										var instance = instances[name];
										var instanceId = instance.instanceId;
										var prevAuditUser = instance.prevAuditUser;
										tdInnerHtml = truncationText(prevAuditUser,tdAttrs.displayType,tdAttrs.colDisplayLength) + " ; ";
									})
								}else if($tdText.indexOf("path") > 0 && $tdText.indexOf("[{")==0){
									//解析附件json数据生成html
									var dataStr = $tdText.substr(0,$tdText.indexOf("}]")+2);
									var instances = JSON.parse(dataStr);
									var $tdShow = $tdField.find(".grid-column-show");
									var file = "";
									$.each(instances,function(key,data){
										var attachmentObj = instances[key];
										var attachmentName = attachmentObj.name;
										var attachmentPath = attachmentObj.path;
										file += "<p>"+ attachmentName +"</p>" + " ";
										$tdShow.html(file);
									})
									tdInnerHtml = $tdField.html();
								} else if("weixingpsfield" == tdAttrs.fieldType && $tdText.indexOf("{")==0) {//gps
									var location = JSON.parse($tdText);
									var $tdShow = $tdField.find(".grid-column-show");
									var $tdEdit = $tdField.find(".grid-column-edit");
									$tdShow.html(location.address);
									$tdEdit.html(location.address);
									tdInnerHtml = $tdField.html();
								} else if("weixinrecordfield" == tdAttrs.fieldType) {//录音控件
									var $tdShow = $tdField.find(".grid-column-show");
									var $tdEdit = $tdField.find(".grid-column-edit");
									$tdShow.html('<div class="weixin_record"><img src="../../share/images/view/voice.png" width="21px"/></div>');
									$tdEdit.html('<div class="weixin_record"><img src="../../share/images/view/voice.png" width="21px"/></div>');
									tdInnerHtml = $tdField.html();
								}else if(tdAttrs.fieldType== "genericwordfield" && $tdText.indexOf("{")==0){//通用word控件
									var $tdShow = $tdField.find(".grid-column-show");
									var $tdEdit = $tdField.find(".grid-column-edit");
									$tdShow.html("<img src='../../share/images/view/genericword.jpg'></img>");
									$tdEdit.html("<img src='../../share/images/view/genericword.jpg'></img>");
									tdInnerHtml = $tdField.html();
								} else if("COLUMN_TYPE_ROWNUM" == tdAttrs.coltype) {//序号列
									var $tdShow = $tdField.find(".grid-column-show");
									$tdShow.html(i);
									tdInnerHtml = $tdField.html();
								} else {
									tdInnerHtml = $tdField.html();
								}
								
								trInnerHtml +=""+ tdInnerHtml;
								trInnerHtml +="</td>";
							}
						}
					}
					trInnerHtml +="</tr>";
					$tbodyHtml.append(trInnerHtml);
				}
			}
			if(isSetWidth){
				jQuery("#gridTable").css("table-layout","fixed");
			}
			$field.remove();
			// 初始化表格 grid.js用到
			oTable = document.getElementById('dataBody');
		});
	};
})(jQuery);

function truncationText(input,displayType,displayLength){
	if(displayType == "01"){
		displayLength = displayLength.match("\\d+");
		if(displayLength){
			if(input.length > displayLength){
				input = input.substring(0,displayLength) + "...";
			}
		}
	}
	return input;
};

function jqRefactor4SubGridView(){
	jQuery("table[moduleType='subGridView']").obpmSubGridView();
}