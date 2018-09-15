/**
 * 	给后台preview.jsp视图预览的时候判断页面是否重构完成
 */
var isComplete = false; 

/**
 * 地图视图公用初始化方法
 * @return
 */
function initMapComm(){
	jqRefactor();	//表单控件jquery重构
	jqRefactor4MapView();//地图视图重构
	ev_resize4IncludeViewPar();	//包含元素包含视图时调整iframe高度
	openDownloadWindow(openDownWinStr);		//打开Excel下载窗口
	setEditMode();		//设置文档编辑状态
	ev_reloadParent();	//刷新父窗口
	setTimeout(function(){
		showPromptMsg();	//显示提示信息
	},300);

	jQuery(document).keydown(function(e){
	   enterKeyDown(e);
	});
	jQuery(window).resize(function(){
		ev_reloadParent();	//刷新父窗口
	});
	isComplete = true; //给后台preview.jsp视图预览的时候判断页面是否重构完成
}

//给后台preview.jsp视图预览的时候判断页面是否重构完成
function getIsComplete(){
	return isComplete ;
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
 * 查看表单内容
 * @param docid
 * @param formid
 * @param signatureExist
 * @param templateForm
 * @return
 */
function viewDoc(docid, formid ,signatureExist,templateForm){
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
 * 创建文档
 * @param activityid
 * @return
 */
function createDoc(activityid){
	// 查看/script/view.js
	var action = activityAction + "?_activityid=" + activityid;
	openWindowByType(action,selectStr, VIEW_TYPE_NORMAL,activityid); 
}	

function on_unload() {
	ev_reloadParent();	//刷新父窗口
}

/**
 * 设置文档编辑状态
 * @return
 */
function setEditMode() {
	/* 子文档为编辑模式时才显示activity */
	isedit = document.getElementsByName("isedit")[0].value;
	if (isedit != 'null' && isedit != '') {
		if (isedit == 'true' || isedit) {
			activityTable.style.display = '';
		} else {
			activityTable.style.display = 'none';
		}
	} else {
		activityTable.style.display = '';
	}
	enbled = document.getElementsByName("isenbled")[0].value;
	if (enbled != 'null' && enbled != '') {
		activityTable.style.display = 'none';
	}
}

/**
 * 包含元素包含视图时调整iframe高度
 * from:blue/brisk/default/dwz/fresh/gentle
 */
function ev_resize4IncludeViewPar(){
	var divid = document.getElementsByName("divid")[0].value;
	var _viewid = document.getElementsByName("_viewid")[0].value;
	ev_resize4IncludeView(divid,_viewid,'MAPVIEW');
}

/**
 * 地图视图调整布局
 * form:fresh/gentle/dwz/default
 * for:mapView
 */
function mapViewAdjustLayout(){
	var bodyH=document.body.clientHeight;
	jQuery("#container").height(bodyH);
	//jQuery("#container").width(jQuery("body").width());
	var activityTableH=jQuery("#activityTable").height();
	var searchFormTableH;
	if(jQuery("#searchFormTable").attr("id")=="searchFormTable"){
		searchFormTableH=jQuery("#searchFormTable").height()+18;/*20px is the padding height*/
	}else{
		searchFormTableH=0;
	}
	var pageTableH=jQuery("#pageTable").height();
	jQuery("#dataTable").height(bodyH-activityTableH-searchFormTableH-pageTableH);
}

(function($){
$.fn.obpmMapView = function(){
	return this.each(function(){
		Setting = {//
				TABLE_CLASS : 'listDataTable',		//表格class
				TH_CLASS : 'listDataTh',						//标题行class
				TH_FIRST_TD_CLASS : 'listDataThFirstTd',			//标题行第一个单元格class
				TR_FIRST_TD_CLASS : 'listDataTrFirstTd',		//数据行第一个单元格class
				TR_CLASS : 'listDataTr',				//数据行class
				TR_OVER_CLASS : 'listDataTr_over'	//数据行滑过class
		};
		
		var $field = jQuery(this);
		isSum = $field.attr("isSum");
		isSum = (isSum == "true")?true:false;
		
		var $tableHtml = jQuery("<table class=\"" + Setting.TABLE_CLASS + "\" id=\"dataTable\"></table>");
		
		$field.find("tr").each(function(i){//行<tr>
			var $trHtml = "";
			var $trField = jQuery(this);

			if(i == 0){  //首行（列头）
				$trHtml = jQuery("<tr class=\"" + Setting.TH_CLASS + "\"></tr>");
				$trField.find("td").each(function(){//单元格<td>
					var $tdField = jQuery(this);
					var columnName =$tdField.attr("columnName");
					var tdHtml = "";
						tdHtml = "<td nowrap=\"nowrap\" style=\"text-align:left;\"></td>";
						var inputHtml = "";
							inputHtml += "<input type=\"checkbox\"/>";
							
						jQuery(tdHtml).append(jQuery(inputHtml).bind("click",function(){
							selectAll(this.checked);
						})).append(columnName).appendTo($trHtml);
						
				});
			}else if(isSum && (i == $field.find("tr").size()-1)){//末行(字段值汇总)
				$trHtml = jQuery("<tr class=\"" + Setting.TR_CLASS + "\" onmouseover=\"this.className='" 
						+ Setting.TR_OVER_CLASS + "';\" onmouseout=\"this.className='" + Setting.TR_CLASS + "';\">");

				$trField.find("td").each(function(){//单元格
					var tdHtml = "";
					var $tdField = jQuery(this);
					var isVisible = $tdField.attr("isVisible");
					var isHiddenColumn = $tdField.attr("isHiddenColumn");
					var isSum = $tdField.attr("isSum");
					var isTotal = $tdField.attr("isTotal");
					var colName = $tdField.attr("colName");
					var sumByDatas = $tdField.attr("sumByDatas");
					var sumTotal = $tdField.attr("sumTotal");
					isVisible = (isVisible == "true")?true:false;
					isHiddenColumn = (isHiddenColumn == "true")?true:false;
					isSum = (isSum == "true")?true:false;
					isTotal = (isTotal == "true")?true:false;
					if(i == 0){//首列
						tdHtml += "<td class=\"" + Setting.TR_FIRST_TD_CLASS + "\">";
						tdHtml += "&nbsp;</td>";
					}else{//其他列
						if(isVisible && !isHiddenColumn){
							tdHtml += "<td>";
							if(isSum || isTotal)
								tdHtml += colName;
							if(isSum)
								tdHtml += sumByDatas + "&nbsp;";
							if(isTotal)
								tdHtml += sumTotal + "&nbsp;";
							tdHtml += "</td>";
						}
					}
					
					$tdHtml = jQuery(tdHtml);
					$trHtml.append($tdHtml);
				});
			}else{//显示地图
				$trHtml = jQuery("<tr class=\"" + Setting.TR_CLASS + "\"';\">");
				
				$trField.find("td").each(function(){//单元格<td>
					var $tdField = jQuery(this);
					var formid = $tdField.attr("formid");
					var _viewid= $tdField.attr("_viewid");
					var toLocationString = $tdField.attr("toLocationString");

						var tdHtml =  "<td class=\"" + Setting.TR_FIRST_TD_CLASS + "\">";
							tdHtml += "<iframe src =\"" + contextPath + "/portal/share/component/map/view/baiduMap.jsp?formid=" + formid + "&_viewid=" + _viewid + " \" style=\"width:100%;height:562px;\" frameborder=\"0\"></iframe>";
							tdHtml += "<div id=\"baiduMapData\" style=\"display:none\">";
							tdHtml += toLocationString;
							tdHtml +="</div>";
							tdHtml += "</td>";
							
							var $divHtml = jQuery("<div style=\"display:none\"></div>");
							$trField.find("td").find("div input").each(function(){
									var $inputField = jQuery(this);
									var id = $inputField.attr("id");
									var value = $inputField.attr("value");
									var inputHtml =" <input type=\"checkbox\" name=\"_selects\"";
										inputHtml += " id='" + id + "' value='" + value + "'";
										inputHtml +=" >";
										$inputHtml = jQuery(inputHtml);
										$divHtml.append($inputHtml);
								});
						$tdHtml = jQuery(tdHtml);
						$tdHtml.append($divHtml);
						$trHtml.append($tdHtml);
				});
			}
			$tableHtml.append($trHtml);
		});
		$tableHtml.replaceAll($field);
	});
};
})(jQuery);

/**
 * jquery重构地图视图
 * for:地图视图
 */
function jqRefactor4MapView(){
	jQuery("[moduleType='mapView']").obpmMapView();
}