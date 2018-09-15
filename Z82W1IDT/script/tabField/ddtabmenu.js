//DD Tab Menu- Last updated April 27th, 07: http://www.dynamicdrive.com
//Only 1 configuration variable below

var ddtabmenu={
	disabletablinks: false, ////Disable hyperlinks in 1st level tabs with sub contents (true or false)?
	currentpageurl: window.location.href.replace("http://"+window.location.hostname, "").replace(/^\//, ""), //get current page url (minus hostname, ie: http://www.dynamicdrive.com/)
	tabOrigitemid: {},

definemenu:function(tabid, dselected){
	this[tabid+"-menuitems"]=null;
	if (document.readyState == 'complete') {
		ddtabmenu.init(tabid, dselected);
	} else {
		OBPM(document).ready(function(){
			ddtabmenu.init(tabid, dselected);
		});
		
//		this.addEvent(window, function(){ddtabmenu.init(tabid, dselected)}, "load")
	}
},

/**
 * 根据页签ID选中某个页签
 * @param {} tabid
 * @param {} targetId 相当于Form ID
 */
showsubmenuById:function(tabid, targetId) {
	var menuitems=this[tabid+"-menuitems"];
 	if (!menuitems) {
 		return;
 	}
	 	
 	ddtabmenu.showsubmenu(tabid, document.getElementById(targetId));
},

/**
 * 根据页签名称选中某个页签
 * @param {} tabid
 * @param {} targetName 控件定制时的页签名称
 */
showsubmenuByName:function(tabid, targetName) {
	var menuitems=this[tabid+"-menuitems"];
 	if (!menuitems) {
 		return;
 	}
 	
 	for (i=0; i<menuitems.length; i++){
		if (menuitems[i].getAttribute("title")){
			if (menuitems[i].title == targetName){
				ddtabmenu.showsubmenu(tabid, menuitems[i]);
				break;
			}
		}
	}
},

/**
 * 选中某一个页签
 * @param {} tabid
 * @param {} targetitem 目标页签
 */
showsubmenu:function(tabid, targetitem){
	if(document.getElementById("tabid")){
		document.getElementById("tabid").value = targetitem.getAttribute("id");
	}
	var menuitems=this[tabid+"-menuitems"];
 	if (!menuitems) {
 		return;
 	}
	// 运行计算时使用同步,使用了DWR库
	DWREngine.setAsync(false);
	if(targetitem != null)
		eval(targetitem.callback);
	DWREngine.setAsync(true);
	
	for (i=0; i<menuitems.length; i++){
		
		if (typeof menuitems[i].hasSubContent!="undefined"){
			if(document.getElementById(menuitems[i].getAttribute("rel")).style.display=='block'){
				menuitems[i].className="";
				document.getElementById(menuitems[i].getAttribute("rel")).style.display="none";
			}
		}
	}

	if (targetitem) {
	if (typeof targetitem.hasSubContent!="undefined")
		var id =targetitem.getAttribute("rel");
		var oContent = document.getElementById(targetitem.getAttribute("rel"));
		
		var frames = jQuery("#"+id).find("iframe[type='word']");
		for(var i =0 ;i<frames.length;i++){
			var frame = frames[i];
			initWord(frame);
		}
		if(oContent != null || oContent != undefined){
			if(oContent.style.display !='block'){
			targetitem.className="current";
			oContent.style.display="block";
			}
		}
		var isloaded = oContent!=null?oContent.isloaded:false;
		// 记录选中页签
//		this.tabOrigitemid[tabid] = targetitem.id;
//		if (isloaded != true) {
//			// 运行计算时使用同步,使用了DWR库
//			DWREngine.setAsync(false);
//			eval(targetitem.callback);
//			DWREngine.setAsync(true);
//		}
	}
},

/**
 * 隐藏页签及页签内容
 * @param {} tabid
 * @param {} menuids
 */
hideMenus: function (tabid, menuids){
	for (var i = 0; i < menuids.length; i++) {
		var menu = document.getElementById("li_" + menuids[i]);
		var content = document.getElementById("content_" + menuids[i]);
		menu.style.display = "none";
		content.style.display = "none";
	}
},

/**
 * 显示页签及页签内容
 * @param {} tabid
 * @param {} menuids
 */
showMenus: function (tabid, menuids){
	for (var i = 0; i < menuids.length; i++) {
		var menu = document.getElementById("li_" + menuids[i]);
		var content = document.getElementById("content_" + menuids[i]);
		menu.style.display = "block";
		content.style.display = "block";
	}
	
},

/**
 * 是否已加载
 * @param {} tabid
 * @return {Boolean}
 */
isloaded: function(tabid) {
	var selectedEl = document.getElementById("content_" + this.tabOrigitemid[tabid]);
	if (selectedEl) {
		return selectedEl.isloaded;
	}
	
	return false;
},

/**
 * 获取选中页签
 * @param {} tabid
 * @return {}
 */
getSelected: function(tabid){
	return this.tabOrigitemid[tabid];
},

isSelected:function(menuurl){
	var menuurl=menuurl.replace("http://"+menuurl.hostname, "").replace(/^\//, "")
	return (ddtabmenu.currentpageurl==menuurl);
},

addEvent:function(target, functionref, tasktype){ //assign a function to execute to an event handler (ie: onunload)
	var tasktype=(window.addEventListener)? tasktype : "on"+tasktype
	if (target.addEventListener)
		target.addEventListener(tasktype, functionref, false);
	else if (target.attachEvent)
		target.attachEvent(tasktype, functionref);
},

/**
 * 初始化页签控件
 * @param {} tabid 页签控件ID
 * @param {} dselected 选中页签的名称
 */
init:function(tabid, dselected){
	if (!document.getElementById(tabid)) {
		alert("ddtabmenu.js: tab not exist, id is \"" + tabid + "\"");
	}
	var menuitems=document.getElementById(tabid).getElementsByTagName("a");
	var setalready=false;
	this[tabid+"-menuitems"]=menuitems;
	for (var x=menuitems.length-1; x>=0; x--){
		if (menuitems[x].getAttribute("rel")){
			//alert("if x="+x);
			this[tabid+"-menuitems"][x].hasSubContent=true;
			if (ddtabmenu.disabletablinks){
				alert("if1 if x="+x);
				menuitems[x].onclick=function(){return false;}
			}
		}
		else{//for items without a submenu, add onMouseout effect
			alert("else x="+x);
			menuitems[x].onmouseout=function(){this.className="";}
		}
		menuitems[x].onclick=function(){ddtabmenu.showsubmenu(tabid, this);}
		if (dselected=="auto" && typeof setalready=="undefined" && this.isSelected(menuitems[x].href)){
			alert("if2 x="+x);
			ddtabmenu.showsubmenu(tabid, menuitems[x]);
			setalready = true;
		}
	}
	
	// 默认显示第一个页签
	if (!setalready) {
		ddtabmenu.showsubmenuById(tabid, dselected);
	}
}
}