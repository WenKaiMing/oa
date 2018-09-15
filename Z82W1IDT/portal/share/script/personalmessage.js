/**
 * for portal/dispatch/personalmessage/list.jsp
 * 
 */

function adjustPersonalMgsLayout() {
	var bodyH=jQuery("body").height();
	jQuery("#container").width(jQuery("body").width());
	jQuery("#container").height(bodyH);
	var navigateTableH=jQuery("#navigateTable").height()+1;
	var activityTableH=jQuery("#activityTable").height();
	var pageTableH=jQuery("#pageTable").height();
	jQuery("#contentTable").height(bodyH-navigateTableH-activityTableH-pageTableH);
}

function showMessageDetals(_currpage,_pagelines,_rowcount,application,id,read, title,type) {
	var url = contextPath+'/portal/personalmessage/show.action';
	url += '?_currpage='+_currpage;
	url += '&_pagelines='+_pagelines;
	url += '&_rowcount='+_rowcount;
	url += '&application='+application;
	url += '&id='+id;
	url += '&read='+read;
	//showDialogByDiv(title,url,680,520);  //at util.js
	var isInbox=document.getElementById("isInbox").value;
	var isOutbox=document.getElementById("isOutbox").value;
	var isTrash=document.getElementById("isTrash").value;
	if(title == '已送出通知'){
		title = personalmessage_title_sended;
	}else if(title == '待办通知'){
		title = personalmessage_title_pending;
	}else if(title == '待办超期通知'){
		title = personalmessage_title_pending_overdue;
	}else if(title == '回退通知'){
		title = personalmessage_title_rollback;
	}

	if(type=="问卷调查"){
		window.open(url);
	}else {
		OBPM.dialog.show({
			width : 680, // 默认宽度
			height : 470, // 默认高度
			url : url,
			args : {},
			title : title,
			
			close : function(result) {
				if(result == "trash"){
					document.forms[0].action==contextPath+"/portal/personalmessage/trash.action";
					document.forms[0].submit();
					
				}
				if(isInbox == "true" && read == "false"){
					document.forms[0].action==contextPath+"/portal/personalmessage/inbox.action";
					document.forms[0].submit();
				}// else if(isTrash == "true"){
				//	document.forms[0].action==contextPath+"/portal/personalmessage/read.action";
				//	document.forms[0].submit();
				//}
			}
		});
	}
}

function change(display) {
	switch (display.name){ 
		case "btnInbox": window.location.href=contextPath+"/portal/personalmessage/inboxNoRead.action";break;
		case "btnOutbox": window.location.href=contextPath+"/portal/personalmessage/outbox.action";break;
		case "btnTrash": window.location.href=contextPath+"/portal/personalmessage/trash.action";break;
	} 
}


function initTab(){
	var isInbox=document.getElementById("isInbox").value;
	var isOutbox=document.getElementById("isOutbox").value;
	var isTrash=document.getElementById("isTrash").value;
	
	document.getElementById("btnInbox").className = "btcaption";
	document.getElementById("btnOutbox").className = "btcaption";
	document.getElementById("btnTrash").className = "btcaption";

	//display.className = "btcaption-selected";
	//alert(isInbox + ":" + isOutbox + ":" + isTrash);
	if(isInbox=="true"){
		document.getElementById("btnInbox").className = "btcaption-selected";
	}else if(isOutbox=="true"){
		document.getElementById("btnOutbox").className = "btcaption-selected";
	}else if(isTrash=="true"){
		document.getElementById("btnTrash").className = "btcaption-selected";
	}else{
		document.getElementById("btnInbox").className = "btcaption-selected";
	}
}

function init(){
	initTab();
	adjustPersonalMgsLayout();
	if(selectTab != null && selectTab == "alreadyRead"){
		jQuery("#alreadyReadId").addClass("btcaption-selected");
	}else{
		jQuery("#noReadId").addClass("btcaption-selected");
	}
}

function alreadyRead(){
	window.location.href=contextPath+"/portal/personalmessage/inboxIsRead.action?selectTab=alreadyRead";
}

function noRead(){
	window.location.href=contextPath+"/portal/personalmessage/inboxNoRead.action?selectTab=noRead";
}

jQuery(window).load(function(){
	init();
});
jQuery(window).resize(function(){
	adjustPersonalMgsLayout();
});