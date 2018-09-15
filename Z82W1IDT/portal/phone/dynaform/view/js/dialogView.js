
function ev_selectone(docid, value) {
	if(selectOne=='false'){
		var params = jQuery.par2Json(decodeURIComponent(jQuery("form").serialize()));
		params['_selects'] = docid;
		ev_return(params, "{id:"+value+"}");
	}else{
		selectString+=(value+";");
		document.getElementById("selectList").innerHTML=selectString.substring(0, selectString.lastIndexOf(";")); //innerHTML改为innerText,innerHTML会引起&符号丢失
		
	}
}

function ev_doClear(){
	var result = {
			params :"",
			selectedValue:""
	};
	if(selectOne=="false"){
		top.OBPM.dialog.doClear(result);
	}else{
		selectString = "";
		document.getElementById("selectList").innerHTML = "";
	}
}

function ev_ok() {
	var params =jQuery.par2Json(decodeURIComponent(jQuery("form").serialize()));
	
	if(selectOne=="false"){
		var selects = params['_selects'];
		if (selects && selects instanceof Array) {
			params['_selects'] = selects.join(";");		
		}
			
		ev_return(params, jQuery.json2Str(rtn));
	}else{
		selectString=selectString.substring(0, selectString.lastIndexOf(";"));
		ev_return(params, selectString);
	}
}

// 执行确定脚本(okscript)并返回
function ev_return(params, selectedValue) {
	DWREngine.setAsync(false); 
	var result = {
			params :params,
			selectedValue:selectedValue
	};
	ViewHelper.runScript(params, function(rtn) {
		if (rtn) {
			if(rtn.indexOf('doAlert')>-1 || rtn.indexOf('doConfirm')>-1){
				eval(rtn);
			}else{
				var regExp =/<script[^>]*>.*(?=<\/script>)<\/script>/gi;
				if (rtn.replace(regExp,'') == "true") { // 2.执行脚本
					eval(RegExp.$1);
					top.OBPM.dialog.doReturn(result);
				} else {
					alert("确定条件出错，请联系后台管理员");
				}
			}
		} else {
			top.OBPM.dialog.doReturn(result);		
		}
	});
}

function doAlert(msg) {
	if (msg) {
		alert(msg);
	}
}

function doConfirm(msg, result) {
	if (msg) {
		if (confirm(msg)) {
			top.OBPM.dialog.doReturn(result);
		}
	}
}

function getFormFieldByName(name){
	var els = args['parent'].document.getElementsByName(name);
	if (els[0]) {
		if (els[0].tagName == 'IFRAME') {
		//els[0].contentWindow.location.reload();
			return els[0].contentWindow;
		} else {
			return els[0];
		}
	}
	return null;
}

function ev_select(key,value,isChecked) {
	if (isChecked) {
		rtn[key] = value;
	} else {
		delete rtn[key];
	}
}

function ev_selectAll(b) {
	var c = document.getElementsByName('_selects');
    if(c==null)
    return;
    if (c.length!=null){
      for(var i = 0; i < c.length ;++i) {
        c[i].checked = b && !(c[i].disabled);
    	c[i].onclick();
      }
    }else{
      c.checked = b;
	}
	return b;

}

function ev_init() {
	var defalutSize = defalutSize1;
	//Resize dialog, set the dialog window size as the body size.
	if(defalutSize == "true"){//后台显示大小为默认时，允许页面根据内容设置弹出层大小
		top.OBPM.dialog.resize(600, document.body.scrollHeight+70);
	}

	var c = document.getElementsByName('_selects');
	if (c) {
		for (prop in rtn) {
			
			for(var i = 0; i < c.length ;++i) {
				if (prop == c[i].value) {
					c[i].checked = true;
				}
			}
		}
	}
	
	changeElState('btn',true); // change button state

	if(selectlist && selectlist != "null"){
		var $selectList = $("#selectList");
		$selectList.text(selectlist);
		selectString = selectlist;
	}
}

function initElonclick(fieldName, func) {
	var els = document.getElementsByName(fieldName);
	for(var i=0; i<els.length; i++) {
		els[i].onclick = func;
	}
}

//字段只读和非只读状态切换
function changeElState(fieldName,state) {
	var els = document.getElementsByName(fieldName);
	for(var i=0; i<els.length; i++) {
		els[i].disabled = !state;
	}
}

//设置列表宽高
function setFormListSize(){
	if(navigator.userAgent.indexOf("MSIE")>0 && document.documentMode != 10){
		var selectList = jQuery("#selectList").html();
		if(selectList == undefined)
			jQuery("#formList").height(jQuery("body").height()-60);
		else
			jQuery("#formList").height(jQuery("body").height()-115);
	}
	jQuery("#dspview_divid").height(jQuery("#view_iframe").height() - jQuery(".searchDiv").height()-jQuery(".viewselect").height()-30);
}

//重置所有查询条件
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

//显示视图
function showView(docid, formid) {
	// 查看common.js
	var url = docviewAction;
	if (docid != null && formid != null) {
		url += '?_docid=' + docid + '&_formid=' +  formid; 
	}
	var rtn = showView(divTitle, url);
	document.location.reload();
}

//查看文档
function viewDoc(docid, formid,isDiv) {
	// 查看common.js
	var url = docviewAction;
	url += '?_docid=' + docid;
	if (formid != null && formid != "") {
		url += '&_formid=' +  formid;
	}
	type = document.getElementsByName('_isdiv')[0].value;
	url += "&show_act=false&signatureExist=false";
	url = appendApplicationidByView(url);
	
	showfrontframe({
		title : divTitle,
		url : url,
		w : 800,
		h : 600,
		callback : function(result) {
		}
	});
}

/**
 * 视图选择框查询头重置按钮
 */
function ev_viewdialog_resetAll() {
	var $formTable = $("body form").find("#searchFormTable");
	
	var elements = $formTable.wrap("<form></form>").parent()[0].elements;
	
//	document.forms[0].elements;
	for (var i = 0; i < elements.length; i++) {
		if(jQuery(elements[i]).attr('fieldType')=='TextAreaField'){
			elements[i].value = "";
		}
		if(jQuery(elements[i]).attr('fieldType')=='UserField'){
			elements[i].value = "";
		}
		if(jQuery(elements[i]).attr('fieldType')=='SelectAboutField'){
			var	originalName = elements[i].name;
			var	idDx = originalName + "ms2side__dx";
			var	idSx = originalName + "ms2side__sx";
			jQuery("#" + idDx).children().appendTo(jQuery("#" + idSx));
			jQuery("#" + idDx).children().remove();
			jQuery(elements[i]).find('option').attr("selected", false);
			jQuery(elements[i]).find("[text='']").attr("selected", true);
		}
		if(elements[i].type == 'checkbox'){
			elements[i].checked = false;
		}
		if(elements[i].type == 'radio'){
			elements[i].checked = false;
		}
		if(jQuery(elements[i]).attr('fieldType')=='TreeDepartmentField'){
			elements[i].value = "";
			elements[i+1].value = "";
		}
		// alert(elements[i].id + ": "+elements[i].type + " resetable-->" +
		// elements[i].resetable);
		if (elements[i].type == 'text'|| elements[i].resetable) {
			elements[i].value = "";
			
		} else if (elements[i].type == 'select-one') {
			// 还原至第一个选项
			if (elements[i].options.length >= 1) {
				elements[i].options[0].selected = true;
			}
		}
	}
	$formTable.unwrap();
	$formTable.find("input[type='hidden'][id!='dy_refreshObj']").val("");//清除隐藏文本框控件的值
	/*
	for (var i = 0; i < arrObject.length; i++) {
		arrObject[i].save("");
	}
	*/
}
/**
 * 视图选择框查询里的查询按钮
 */
function ev_viewdialog_search() {
	$(document).find("form:eq(0)").find("[name='_currpage']").val("1");
	dialogView.loadDialogViewList();
	$(document).find("form:eq(0)").find("#btn-modal-close").trigger("click");
}
//事件绑定
var searchScroll;
function bindEvent(){

    var $searchForm = $("#searchForm");	//查询界面
    var $activityField = $("#activityField");	//操作区域
    var $searchBtn = $("#searchBtn");	//查询按钮
	if($searchForm.size()>0){
		var searchBtn = "<td><a id='searchBtn' class='btn btn-primary btn-block' title='查询'>查询</a></td>"
		if($searchBtn.size()<=0){
			$activityField.find(".dialog_Btn").append(searchBtn);
		}

		searchScroll = new IScroll('#searchForm>.content', { 
			preventDefault: false,
			preventDefaultException: { tagName: /^(INPUT|TEXTAREA|BUTTON|SELECT|A|SPAN)$/ }
		})
	}
	
	var myScroll;
    /*setTimeout(function(){
   		myScroll = new IScroll('.formContent-Box', { 
   			scrollX: true, 
   			freeScroll: true,
			preventDefault: false
		});
   	},100);*/
    
    $(".tableList-screen").click(function(){
    	$(".formContent-is").width($("#dialongViewTable").width());
    	//myScroll.refresh();
    });
    	
    /*document.addEventListener('touchmove', function (e) {
    	e.preventDefault(); 
    }, false);*/
	
    $activityField.on("click", ".btnOk", function(){	//确定
    	ev_ok();
	}).on("click", ".btnClear", function(){	//取消
		ev_doClear();
	}).on("click", "#searchBtn", function(){	//打开查询界面
		$searchForm.next(".formContent-Box").hide();
		$searchForm.next().next(".card_space_fix").hide();
		$searchForm.show();
		$searchForm.addClass("active");
	});
	
	$searchForm.on("click", ".btnSearch",function(){	//查询
		ev_viewdialog_search();
	}).on("click", ".btnReset",function(){	//重置
		ev_viewdialog_resetAll();
	}).on("click", "#btn-modal-close",function(){	//查询弹出层关闭按钮事件
		$searchForm.removeClass("active");
		$searchForm.next(".formContent-Box").show();
		$searchForm.next().next(".card_space_fix").show();
		$searchForm.hide();
	});
}