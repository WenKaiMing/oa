var TAB_CONTENT = "content_";
var TAB_IAMGE = "img_";
var selectedTabMap = {};

/**
 * 定义折叠容器
 * 
 * @param {}
 *            container
 * @param {}
 *            tabArray
 * @param {}
 *            selectedIndex
 */
function defineCollapse(container, tabArray) {
	if (document.readyState == 'complete') {
		initCollapse(container, tabArray);
	} else {
		OBPM(document).ready(function(){
			initCollapse(container, tabArray);
		});
		
//		addEvent(window, function() {init(container, tabArray);}, "load");
	}
}
/**
 * 添加事件
 * 
 * @param {}
 *            target
 * @param {}
 *            functionref
 * @param {}
 *            tasktype
 */
function addEvent(target, functionref, tasktype) {
	var tasktype = (window.addEventListener) ? tasktype : "on" + tasktype
	if (target.addEventListener)
		target.addEventListener(tasktype, functionref, false)
	else if (target.attachEvent)
		target.attachEvent(tasktype, functionref)
}

/**
 * 初始化显示
 * 
 * @param {}
 *            container
 * @param {}
 *            tabArray
 * @param {}
 *            selectedIndex
 */
function initCollapse(container, tabArray) {
	selectedTabMap[container] = [];
	for (var i = 0; i < tabArray.length; i++) {
		var content_id = TAB_CONTENT + tabArray[i];// 表格ID
		var oContent = document.getElementById(content_id);

		selectedTabMap[container].push(tabArray[i]); // 已选中
		oContent.isloaded = true; // 已加载
	}
}

/**
 * 开关
 * 
 * @param {}
 *            container
 * @param {}
 *            tabId
 */
function toggleCollapse(container, tabId, noRefresh) {// 显示隐藏程序
	var content_id = TAB_CONTENT + tabId;// 表格ID
	var img_id = TAB_IAMGE + tabId;// 图片ID
	var imagePath = "../../share/component/tabField/collapse/images";
	var default_img = "" + imagePath + "/left_dot.gif";// 默认图片
	var on_img = "" + imagePath + "/left_open.gif";// 打开时图片
	var off_img = "" + imagePath + "/left_dot.gif";// 隐藏时图片
	var oContent = document.getElementById(content_id);
	var oImgage = document.getElementById(img_id);

	if (oContent.style.display == "none") {
		selectedTabMap[container].push(tabId); // 选中
	} else {
		selectedTabMap[container].pop(tabId); // 弹出
	}

	// 刷新
	var isloaded = oContent.isloaded;
	var refreshed = false;
	// alert("1");
	/*
	if (isloaded != true) {
		if (!noRefresh) {
			// 运行计算时使用同步,使用了DWR库
			DWREngine.setAsync(false);
			dy_refresh(tabId);
			DWREngine.setAsync(true);
			if(oContent.style.display != "none"){
				refreshed = true;
			}
		}

		oContent.isloaded = true;
	}
	*/

	if (!refreshed) {
		if (oContent.style.display == "none") {// 如果为隐藏状态
			oContent.style.display = "";// 切换为显示状态
			oImgage.src = on_img;
		}// 换图
		else {// 否则
			oContent.style.display = "none";// 切换为隐藏状态
			oImgage.src = off_img;
		}// 换图
	}

}

function getCollapseSelectedArray(container) {
	return selectedTabMap[container];
}

function getCollapseSelected(container) {
	return getCollapseSelectedArray(container).toString();
}

function isCollapseLoaded(container) {
	var selecteds = getCollapseSelectedArray(container);
	var rtn = {};
	for (var i = 0; i < selecteds.length; i++) {
		var selectedEl = document.getElementById(TAB_CONTENT + selecteds[i]);
		if (selectedEl) {
			if (selectedEl.isloaded) {
				rtn[selecteds[i]] = true;
			} else {
				rtn[selecteds[i]] = false;
			}
		}
	}
	return jQuery.json2Str(rtn);
}

/**
 * 显示所有Tab
 * 
 * @param {}
 *            container
 */
function showAllCollapse(container) {
	OBPM('#tab_' + container + '_divid').children("div[id*='content_']:hidden")
			.each(function() {
						var tabId = this.id.substring(TAB_CONTENT.length);
						toggleCollapse(container, tabId);
					})
}

/**
 * 关闭所有Tab
 * 
 * @param {}
 *            container
 */
function closeAllCollapse(container) {
	OBPM('#tab_' + container + '_divid')
			.children("div[id*='content_']:visible").each(function() {
						var tabId = this.id.substring(TAB_CONTENT.length);
						toggleCollapse(container, tabId, true);
					});
}