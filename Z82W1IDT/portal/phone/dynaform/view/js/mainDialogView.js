//事件绑定
function bindEvent(){
	$("#iframe").on("click","input[name=_selects]", function(){		//左侧待选视图单选
		ev_select(this);
	}).on("click", "input[name=selectAll]", function(){		//左侧待选视图全选
		ev_selectAll_Left(this);
	}).on("click", "tr.listDataTr a", function(){		//点击数据行单选一条时
		ev_selectone(this);
	});
}

//构建回选的真实值
function buildData(obj){
	var truvValObj = {};
	
	var trueValues = $(obj).parent("td").parent("tr").find("div[name=truevalue]");
	trueValues.each(function(ind){
		truvValObj[$(this).attr("key")] = $(this).text();
	});
	
	return truvValObj;
}

//选择后构建右侧显示的数据
function ev_select(obj) {
	var key = obj.value;
	var isChecked = obj.checked;
	
	if($(obj).data('values')){
		var valuesStr = HTMLDencode($(obj).data('values')
				.replace(/\'/g,"\""))
				.replace(/\\'/g, "\'")
				.replace(/"{"/g,'{"')
				.replace(/"}"/g,'"}');
		var _val = JSON.parse(valuesStr)
	}else{
		var _val = buildData(obj);
	}
	
	
	
	var htmls = $(obj).parent().parent().html();
	var flag = true;
	if (isChecked) {
		jQuery(".viewRightInfo").find("input[name=_rightselects]").each(function(){
			if($(obj).attr("value") == jQuery(this).attr("value")){
				flag = false;
			}
		});
		if(flag){
			var $htmls = $("<tr id='right_" + key + "' class=\"listDataTr\">"+htmls+"</tr>");
			var $viewMenuSelect = $("#viewMenu_tableListSelect");
			$("#viewMenu_tableListSelect").find("input").each(function(i){
				if($(this).is(":checked")){
					$htmls.find("td.listDataTrTd:eq("+i+")").show();
				}else{
					$htmls.find("td.listDataTrTd:eq("+i+")").hide();
				}
			})
			jQuery(".viewRightInfo").append($htmls);
			jQuery(".viewRightInfo").children().find("input[name=_selects]").replaceWith("<input type='checkbox'  name='_rightselects'  value='" + key + "' />");
		}

//		rtn[key] = value;
//		rtnStr += '"' + key + '":' + jQuery.json2Str(value,true) + ",";
		rtn[key] = _val;
		rtnStr += '"' + key + '":' + jQuery.json2Str(_val,true) + ",";
	} else {
		jQuery(".viewRightInfo").children().remove("#right_"+ key);
		delete rtn[key];
	}
	
	var $tableListSelect = $("#tableListSelect").find(".listDataTr")
	var selectNum = "<span class='selectNum badge badge-primary'></span>"
	if($("#dialog_selectBtn>.selectNum").size()<=0){
		$("#dialog_selectBtn").append(selectNum);
	}
	if($tableListSelect.size()<=0){
		$("#dialog_selectBtn>.selectNum").remove();
	}else{
		$("#dialog_selectBtn>.selectNum").html($tableListSelect.size());
	}
}

//点击返回单条数据的点击事件
function ev_selectone(obj) {
	if(selectOne == "false"){	//单选
		var _val = buildData(obj);
		var params = jQuery.par2Json(decodeURIComponent(jQuery("form").serialize()));
		params['_selects'] = $(obj).attr("_value");
		ev_return(params, "{id:"+jQuery.json2Str(_val,true)+"}");
	}else{	//多选时触发前面的点击事件
		$(obj).parents("tr.listDataTr").find("td.listDataTrFirstTd > input[name='_selects']").trigger("click");
	}
}

//全选事件
function ev_selectAll_Left(obj) {
	var b = obj.checked;
	var c = document.getElementsByName('_selects');
    if(c==null){
    	return;
    }
    if (c.length!=null){
    	for(var i = 0; i < c.length ;++i) {
    		c[i].checked = b && !(c[i].disabled);
    		ev_select(c[i]);
    	}
    }else{
    	c.checked = b;
	}
	return b;

}

//封装数据并返回
function ev_ok() {
	var params = jQuery.par2Json(decodeURIComponent(jQuery("#iframe").find("form").serialize()));
	var selects = "";
	
	jQuery(".viewRightInfo").find("input[name=_rightselects]").each(function(){
		selects += jQuery(this).attr("value") + ";";
	});
	if(selects){
		selects = selects.substring(0,selects.length-1);
	}
	params['_selects'] = selects;
	
	//ev_return(params, jQuery.json2Str(rtn,true));
	rtnStr = "{" + rtnStr.substring(0,rtnStr.length - 1) + "}"; 
	//rtn改为字符拼接方式传递，解决IE10视图选择框跳页后不能执行已释放script问题
	ev_return(params,rtnStr);
}

//执行确定脚本(okscript)并返回
function ev_return(params, selectedValue) {
	DWREngine.setAsync(false);
	var result = {
			params : params,
			selectedValue : selectedValue
	};
	ViewHelper.runScript(params, function(rtn) {
		if (rtn) {
			if(rtn.indexOf('doAlert')>-1 || rtn.indexOf('doConfirm')>-1){
				eval(rtn);
			}else{
				var regExp = /<script.*>(.*)<\/script>/gi;
				if (regExp.test(rtn)) { // 2.执行脚本
					eval(RegExp.$1);
					top.OBPM.dialog.doReturn(result);
				} else {
					alert(rtn);
				}
			}
		} else {
			top.OBPM.dialog.doReturn(result);		
		}
	});
}

//弹出提示框
function doAlert(msg) {
	if (msg) {
		alert(msg);
	}
}

//返回确认提示
function doConfirm(msg, result) {
	if (msg) {
		if (confirm(msg)) {
			top.OBPM.dialog.doReturn(result);
		}
	}
}

//根据已选值回选行数据
function checkSelected(){
	var c = document.getElementsByName('_selects');
	if (c) {
		for (prop in rtn) {
			
			for(var i = 0; i < c.length ;++i) {
				if (prop == c[i].value) {
					c[i].checked = true;
					break;
				}
			}
		}
	}
}

//初始化脚本
function ev_init() {

	$("#selectListBtn").hide();
	$("#viewSelectBox").hide();
	$("#iframe").height($(this).height());
	$("#viewSelectBox").height($(this).height());
	
	//Resize dialog, set the dialog window size as the body size.
	if(defalutSize){//后台显示大小为默认时，允许页面根据内容设置弹出层大小
		top.OBPM.dialog.resize(900, document.body.scrollHeight+270);
	}
	
	checkSelected();		//根据已选值回选行数据
	loaddialogViewByIframe(initText);
	bindEvent();			//事件绑定
	/*var func = new Function("changeElState('btn',false);");
	initElonclick('btn', func);*/
	
	//changeElState('btn',true); // change button state
	//viewDiv.style.width = (document.body.clientWidth - 45) + "px";
}

//加载待选数据页面
function loaddialogViewByIframe(text){

	//var loadingDivBack = document.getElementById('loadingDivBack');
	//if(loadingDivBack)	loadingDivBack.style.display = '';
	jQuery.ajax({
		url:contextPath + "/portal/dynaform/view/iframeDialogView4phone.action",
		type:"post",
		data:text,
		dataType:"html",
		timeout: 3000,
		success:function(data){
			jQuery("#iframe").html(data);
			jQuery(".viewRightInfo",document).find("input[name=_rightselects]").each(function(){
				var value = jQuery(this).attr("value");
				jQuery("#viewLeft").find("input[name=_selects]").each(function(){
					if(jQuery(this).attr("value") == value){
						jQuery(this).attr("checked",'true');
					}
				});
			});

		},
		error:function(data,status){

		}
	});	 
	
}

/**
 * 第一页
 */
function showFirstPageByAjax(){
	var FO = jQuery("#iframe").find("form");
	if (isNaN(parseInt(FO[0]._currpage.value))
			|| isNaN(parseInt(FO[0]._pagelines.value))
			|| isNaN(parseInt(FO[0]._rowcount.value))) {
		return;
	}

	var pageCount = Math.ceil(parseInt(FO[0]._rowcount.value)
			/ parseInt(FO[0]._pagelines.value));
	if (pageCount > 1) {
		var currPage = 1;
		FO[0]._currpage.value = currPage;
		var text = decodeURIComponent(jQuery("#iframe").find("form").serialize());
		loaddialogViewByIframe(text);
	}
}

/**
 * 上一页
 */
function showPreviousPageByAjax() {
	var FO = jQuery("#iframe").find("form");
	if (isNaN(parseInt(FO[0]._currpage.value))
			|| isNaN(parseInt(FO[0]._pagelines.value))
			|| isNaN(parseInt(FO[0]._rowcount.value))) {
		return;
	}

	var pageNo = parseInt(FO[0]._currpage.value);

	if (pageNo > 1) {
		var currPage = pageNo - 1;
		FO[0]._currpage.value = currPage;
		var text = decodeURIComponent(jQuery("#iframe").find("form").serialize());
		loaddialogViewByIframe(text);
	}
}

/**
 * 下一页
 */
function showNextPageByAjax(){
	var FO = jQuery("#iframe").find("form");
	if (isNaN(parseInt(FO[0]._currpage.value))
			|| isNaN(parseInt(FO[0]._pagelines.value))
			|| isNaN(parseInt(FO[0]._rowcount.value))) {
		return;
	}
	var pageNo = parseInt(FO[0]._currpage.value);
	var pageCount = Math.ceil(parseInt(FO[0]._rowcount.value)
			/ parseInt(FO[0]._pagelines.value));
	if (pageCount > 1 && pageCount > pageNo) {
		var currPage = pageNo + 1;
		FO[0]._currpage.value = currPage;
		var text = decodeURIComponent(jQuery("#iframe").find("form").serialize());
		loaddialogViewByIframe(text);
	}
}

/**
 * 最后一页
 */
function showLastPageByAjax() {
	var FO = jQuery("#iframe").find("form");
	if (isNaN(parseInt(FO[0]._currpage.value))
			|| isNaN(parseInt(FO[0]._pagelines.value))
			|| isNaN(parseInt(FO[0]._rowcount.value))) {
		return;
	}

	// var pageNo = parseInt(FO._currpage.value);
	var pageCount = Math.ceil(parseInt(FO[0]._rowcount.value)
			/ parseInt(FO[0]._pagelines.value));

	if (pageCount > 0) {
		var currPage = pageCount;
		FO[0]._currpage.value = currPage;
		var text = decodeURIComponent(jQuery("#iframe").find("form").serialize());
		loaddialogViewByIframe(text);
	}
}

//返回空值
function ev_doClear(){
	var result = {
			params :"",
			selectedValue:""
	};
	top.OBPM.dialog.doClear(result);
}

/**
 * 跳转页面
 */
function jumpPageByAjax() {
	var FO = jQuery("#iframe").find("form");
	if (isNaN(parseInt(FO[0]._currpage.value))
			|| isNaN(parseInt(FO[0]._pagelines.value))
			|| isNaN(parseInt(FO[0]._jumppage.value))
			|| isNaN(parseInt(FO[0]._rowcount.value))) {
		return;
	}

	var pageNo = parseInt(FO[0]._jumppage.value);
	var _pageCount = parseInt(FO[0]._pageCount.value);
	var pageCount = Math.ceil(parseInt(FO[0]._rowcount.value)
			/ parseInt(FO[0]._pagelines.value));
	if (pageNo > _pageCount||pageNo<=0||isNaN(pageNo)) {
		alert(" 输入参数有误!");
		return;
	}
	if (pageCount > 1 && pageCount >= pageNo) {
		var currPage = pageNo;
		FO[0]._currpage.value = currPage;
		var text = decodeURIComponent(jQuery("#iframe").find("form").serialize());
		loaddialogViewByIframe(text);
	}
}

/**
 * 查询
 */
function queryDocument(){
	var FO = jQuery("#iframe").find("form");
	var text = decodeURIComponent(jQuery("#iframe").find("form").serialize());
	FO.find("[name='_currpage']").val("1");
	loaddialogViewByIframe(text);
	$("#searchForm").next(".card_app").show();
	$(".mDialogBox ").css("z-index","1")
}

//重置查询表单
function resetAll() {
	var elements = document.forms[0].elements;
	if(elements){
		for (var i = 0; i < elements.length; i++) {
			//alert(elements[i].type);
			if (elements[i].type == 'text') {
			   if(elements[i].id==elements[i].name){
			   }
				elements[i].value="";
			}
		}
	}
}
/**
function emptycheck(){
	jQuery(".viewRightInfo").find("tr[class=table-tr]").remove();
	jQuery(window.frames["iframe"].document).find("input[name=_selects]").attr("checked",false);
	rtn = {};
}
*/
//清空当前页面选择值
function emptycheck(){
	jQuery(".viewRightInfo").find("tr[class=listDataTr]").remove();
	//
	jQuery("#iframe").find("input[name=_selects]").each(function(){
		jQuery(this).attr("checked",false);
		rtnStr = "";
	});
	rtn = {};
	$("#dialog_selectBtn>.selectNum").remove();
}

//删除选中项
function deletechecked(){
	var checkboxs = document.getElementsByName("_rightselects");
	var isSelect = false;
	for (var i = 0; i < checkboxs.length; i++) {
		if (checkboxs[i].checked == true) {
			isSelect = true;
			break;
		}
	}
	if(isSelect){
	jQuery(".viewRightInfo").find("input[name=_rightselects]").each(function(){
		if(jQuery(this).prop("checked")){
			var key = jQuery(this).attr("value");
			jQuery(".viewRightInfo").children().remove("#right_"+ key);

			jQuery("#iframe").find("input[value=" + key + "]").prop("checked",false);

			//使用正则表达式
			var del = new RegExp("\"" + escape(key)+ "\".+?},");
				
			//从全局变量rtnStr中删除“右侧选中删除项”
			rtnStr = rtnStr.replace(del,"");
			
			var $tableListSelect = $("#tableListSelect").find(".listDataTr")
			var selectNum = "<span class='selectNum badge badge-primary'></span>"
			if($("#dialog_selectBtn>.selectNum").size()<=0){
				$("#dialog_selectBtn").append(selectNum);
			}
			if($tableListSelect.size()<=0){
				$("#dialog_selectBtn>.selectNum").remove();
			}else{
				$("#dialog_selectBtn>.selectNum").html($tableListSelect.size());
			}
			
			delete rtn[key];
		}
	});
	}else{
		alert("请选择要删除的项！");
		}
}

/**
function deletechecked(){
	var checkboxs = document.getElementsByName("_rightselects");
	var isSelect = false;
	for (var i = 0; i < checkboxs.length; i++) {
		if (checkboxs[i].checked == true) {
			isSelect = true;
			break;
		}
	}
	if(isSelect){
	jQuery(".viewRightInfo").find("input[name=_rightselects]").each(function(){
		if(jQuery(this).attr("checked")){
			var key = jQuery(this).attr("value");
			jQuery(".viewRightInfo").children().remove("#right_"+ key);
			jQuery(window.frames["iframe"].document).find("input[value=" + key + "]").attr("checked",false);
			delete rtn[key];
		}
	});
	}else{
		alert("请选择要删除的项！");
		}
}
*/

//全选已选项的选项
function ev_selectAll_main(checked){
	var c = document.getElementsByName('_rightselects');
    if(c==null)
    return;
    if(checked){
        jQuery(".viewRightInfo").find("input[name=_rightselects]").prop("checked",true);
    }else{
    	jQuery(".viewRightInfo").find("input[name=_rightselects]").prop("checked",false);
    }
}

//查看文档
function viewDoc(docid, formid,isDiv) {
	// 查看common.js
	var url = contextPath + '/portal/dynaform/document/view.action';
	url += '?_docid=' + docid;
	if (formid != null && formid != "") {
		url += '&_formid=' +  formid;
	}
	url += "&show_act=false&signatureExist=false";
	url = appendApplicationidByView(url);
	
	showfrontframe({
		title : selectStr,
		url : url,
		w : 800,
		h : 600,
		callback : function(result) {
		}
	});
}

//给url加上application参数
function appendApplicationidByView(url) {
	var appObject = document.getElementsByName("application")[0];
	if (appObject && url.indexOf("application") < 0) {
		if (url.indexOf("?") >= 0) {
			url += "&application=" + appObject.value;
		} else {
			url += "?application=" + appObject.value;
		}
	}
	return url;
}

//切换已选和待选页面
function viewSelectBtn() {
	$("#selectListBtn").toggle();
	$("#selectBtn").toggle();
	$("#viewSelectBox").toggle();
	$("#iframe").toggle();
	tableListColumn();
}

//不同设备浏览器兼容
function borwserCompatibility(){
	var u = navigator.userAgent, app = navigator.appVersion;
	var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
	if(isiOS){
		var myScroll;				
    	window.onload = function() {	
    		setTimeout(
    			function(){
    				myScroll = new IScroll('.mDialogBox', { 
    					scrollX: true, 
    					freeScroll: true,
						preventDefault: false,
						preventDefaultException: { tagName: /^(INPUT|TEXTAREA|BUTTON|SELECT|A|SPAN)$/ }
					})
    			}
    			,2000); 
    	}; 
    	
    	$(".tableList-screen").click(function(){
    		$(".mDialogIs").width($("#dialongViewTable").width());
    		myScroll.refresh();
    	});
    	
    	//document.addEventListener('touchmove', function (e) {
    	//	e.preventDefault(); 
    	//	}, false);

	}else{
		$(".mDialogBox").css("overflow","auto");
	}
}