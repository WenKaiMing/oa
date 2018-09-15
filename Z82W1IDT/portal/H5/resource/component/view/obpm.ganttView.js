/**
 * 	后台预览的时候判断页面是否重构完成
 */
var isComplete = false; 
/**
 * 甘特视图公用初始化方法
 * @return
 */
function initGantComm(){
	jqRefactor();	//表单控件jquery重构
	jqRefactor4GanttView(); //重构甘特视图
	ev_resize4IncludeViewPar();	//包含元素包含视图时调整iframe高度
	openDownloadWindow(openDownWinStr);		//打开Excel下载窗口
	setTimeout(function(){
		showPromptMsg();	//显示提示信息
	},300);
	selectData4Doc(); //回选列表数据
	ev_reloadParent();	//刷新父窗口
	setEditMode();		//设置文档编辑状态
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
 * 设置文档编辑状态
 * @return
 */
function setEditMode() {
	/* 子文档为编辑模式时才显示activity */
	isedit = document.getElementById("isedit").value;
	if (isedit != 'null' && isedit != '') {
		if (isedit == 'true' || isedit) {
			activityTable.style.display = '';
		} else {
			activityTable.style.display = 'none';
		}
	} else {
		activityTable.style.display = '';
	}
	enbled = document.getElementById("isenbled").value;
	if (enbled != 'null' && enbled != '') {
		activityTable.style.display = 'none';
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
	var action = activityAction + "?_activityid=" + activityid
	openWindowByType(action,selectStr, VIEW_TYPE_NORMAL,activityid); 
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

/**
 * 包含元素包含视图时调整iframe高度
 * from:blue/brisk/default/dwz/fresh/gentle
 */
function ev_resize4IncludeViewPar(){
	var divid = document.getElementsByName("divid")[0].value;
	var _viewid = document.getElementsByName("_viewid")[0].value;
	ev_resize4IncludeView(divid,_viewid,'GANTTVIEW');
}

/**
 * 重构列表视图
 */
(function($){
	$.fn.obpmGanttView = function(){
		return this.each(function(){
			var $field = jQuery(this),
				leftW = 300,	//视图左侧宽度

			/**
			 * 字符串转日期
			 * str：字符格式：YYYY-MM-DD HH:mm:ss
			 * return：日期格式
			 */
			strToDate = function(str) {
				 var tempStrs = str.split(" "),
				 dateStrs = tempStrs[0].split("-"),
				 year = dateStrs[0] ? parseInt(dateStrs[0], 10) : 1970,
				 month = dateStrs[1] ? parseInt(dateStrs[1], 10)-1 : 01,
				 day = dateStrs[2] ? parseInt(dateStrs[2], 10) : 01,
				 timeStrs = tempStrs[1] ? tempStrs[1].split(":") : "",
				 hour = !isNaN(parseInt(timeStrs[0], 10))? parseInt(timeStrs[0], 10) :0, //如果小时没设，默认设为零。
				 minute = !isNaN(parseInt(timeStrs[1], 10))? parseInt(timeStrs[1], 10): 0,//如果分钟没设，默认设为零。
				 second = !isNaN(parseInt(timeStrs[2], 10))? parseInt(timeStrs[2], 10): 0,//如果秒数没设，默认设为零。
				 date = new Date(year, month, day, hour, minute, second);
				 return date;
			},
			/**
			 * 创建视图
			 * scale：视图类型：月/周/日
			 * return：null
			 */
			createGantt = function(scale){
				var dataArr = new Array();
				$field.find("tr").each(function(){
					var $tr = jQuery(this);
					var startTimeIsHidden = $tr.attr("startTimeIsHidden"),	//局部变量开始
						endTimeIsHidden = $tr.attr("endTimeIsHidden"),
						completeIsHidden = $tr.attr("completeIsHidden"),
						resourceIsHidden = $tr.attr("resourceIsHidden"),
						id = $tr.attr("id"),
						name = $tr.attr("name"),
						start = $tr.attr("start"),
						end = $tr.attr("end"),
//						url = $tr.attr("link"),
						color = $tr.attr("color"),
						customClass  = $tr.attr("customClass"),
						isMileStone = $tr.attr("isMileStone"),
						resource = $tr.attr("resource"),
						complete = $tr.attr("complete"),
						isGroup = $tr.attr("isGroup"),
//						pageLines = $tr.attr("pageLines"),
						pId = $tr.attr("parentid"),
//						isopen = $tr.attr("isOpen"),
						dep = $tr.attr("dependency"),
						caption = $tr.attr("caption"),
						formId = $tr.attr("formId");	//局部变量结束
	
					complete = parseInt((complete ? complete : 0));
//					pageLines = pageLines?pageLines:3;
					pId = pId ? pId : '';
					isMileStone = isMileStone-0;
					if(isGroup == 0 || isGroup == '0'){
						isGroup = false;
					}else{
						isGroup = true;
					}
					var childTimeS = "";
					var childTimeE = "";
					jQuery("tr[parentid='" + id + "']").each(function(){
						var $childTr = jQuery(this);
						var childStart = $childTr.attr("start"),
							childEnd = $childTr.attr("end");
						if(childTimeS != ""){
							var cur_Start = new Date(childStart.replace(/-/g,"\/")),
								first_Start = new Date(childTimeS.replace(/-/g,"\/"));
							childTimeS = (cur_Start > first_Start)?childTimeS:childStart;
						}else{
							childTimeS = childStart;
						}
						if(childTimeE !=""){
							var cur_end = new Date(childEnd.replace(/-/g,"\/")),
								last_end = new Date(childTimeE.replace(/-/g,"\/"));
							childTimeE = (cur_end > last_end)?childEnd:childTimeE;
						}else{
							childTimeE = childEnd;
						}
					});
					if(childTimeS !=""){start = childTimeS;}else{start = start ? start : "1970-02-01";}
					if(childTimeE !=""){end = childTimeE;}else{end = end ? end : "1970-02-01";}
					start = Date.parse(strToDate(start));
					end = Date.parse(strToDate(end));
					var arr = {
							name: name,
							desc: caption,
							values: [{
								id: id,
								isPar: false,
								rankSize: 0,
								pId: pId,
								formId: formId,
								from: "/Date("+start+")/",
								to: "/Date("+end+")/",
								label: caption,
								desc : ganttText.name+":&nbsp;&nbsp;"+name
										+"<br/>"+ganttText.completeness+":&nbsp;&nbsp;"+complete+"%",
//										+"<br/>"+ganttText.pId+":&nbsp;&nbsp;"+pId
								customClass: customClass,
								bgcolor: color,
								dep: dep,
								complete: complete
							}]
					};
					dataArr[dataArr.length] = arr;
				});

				var topArr = new Array();	//存取顶级任务
				for(var cKey in dataArr){
					if(!dataArr[cKey].values[0].pId){//判断是否顶级
						topArr[topArr.length] = dataArr[cKey];
						dataArr[cKey].values[0].rankSize = 0;
					}
				}

				/**
				 * 把子任务移到父任务或有相同父任务的同级任务后面
				 * 设置是否有子级、当前级别属性
				 * @param pIndex
				 * @param subArr
				 */
				function sortPAndS(pIndex,subArr){
					dataArr[pIndex].values[0].isPar = true;
					for(var key in subArr){
						dataArr.splice(pIndex+1,0,subArr[key]);
						for(var keyA in dataArr){
							if(subArr[key].values[0].id == dataArr[keyA].values[0].id && (pIndex+1 != keyA)){
								dataArr[keyA].values[0].rankSize = dataArr[pIndex-key].values[0].rankSize + 1;
								dataArr.splice((keyA),1);
							}
						}
						pIndex++;
					}
				}
				
				/**
				 * 逐级递归执行排序
				 * sortPAndS():设置是否有子级、当前级别属性
				 * @param cArr当前级别任务
				 */
				function sortDataArr(cArr) {
					for(var cKey in cArr){
						var pIndex = '';
						var subArray = new Array();
						var subArr = new Array();
						for(var keyData in dataArr){
							if(cArr[cKey].values[0].id == dataArr[keyData].values[0].pId){//查找子级
								subArray[subArray.length] = dataArr[keyData];
							}
							if(cArr[cKey].values[0].id == dataArr[keyData].values[0].id){
								pIndex = keyData;
							}
						}
						subArr = subArray.concat();
						if(pIndex && subArr.length>0){
							pIndex = parseInt(pIndex);
							sortPAndS(pIndex,subArr);
							sortDataArr(subArr);
						}
					}
				}
				sortDataArr(topArr);
				
				var rightWidth = $("#dataTable").width()-leftW-4;
				leftWidth = leftW+"px";
				rightWidth = rightWidth+"px";

				var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
				var dow = ["S", "M", "T", "W", "T", "F", "S"];
				
				if(ganttText.language != 'Language'){
					months = ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"];
					dow = ["日","一","二","三","四","五","六"];
				}
				
				$(".gantt").html("").gantt({source: dataArr ,navigate: 'scroll',scale: scale, 
					leftWidth: leftWidth, rightWidth: rightWidth, maxScale: 'weeks', minScale: 'hours',
					months: months,dow: dow});
			},
			/**
			 * 初始化
			 */
			init = function(){
				createGantt("days");	//创建视图
			};
			init();			//初始化
			
			$(window).resize(function() {//设置rightSide宽度
				rightWidth = $("#dataTable").width()-leftW-2;
				jQuery(".rightPanel").css("width",rightWidth);
			});
		});
	};
})(jQuery);
/**
 * jquery重构列表视图
 * for:列表视图
 */
function jqRefactor4GanttView(){
	jQuery("[moduleType='ganttView']").obpmGanttView();
}