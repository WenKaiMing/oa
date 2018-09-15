var listAction = "";
var actionMode = '<ww:property value="params.getParameterAsString(\'actionMode\')"/>';
window.onload = function() {
	if (document.forms[0]) {
		var url = document.forms[0].action;
		url = url.substring(url.indexOf(contextPath));
		if(url==contextPath+"/core/user/treelist.action"){
			try{
				var superiorid=window.parent.document.getElementById("selectnode").value;
				var name=window.parent.document.getElementById("name").value;
				var loginno=window.parent.document.getElementById("loginno").value;
				var roleid=window.parent.document.getElementById("roleid").value;
				var targetUrl = "?departid="+superiorid+"&sm_userRoleSets.roleId="+roleid;
				if(orderBy != null && orderBy != ''){
					var orderByField = document.getElementsByName("_orderby")[0];
					if(orderByField && orderByField.value==orderBy){
					}else{
						targetUrl = targetUrl + "&_orderby=orderByNo&&_orderby=id";
					}
				}
				listAction = document.forms[0].action+targetUrl;//原URL如下
				//listAction = document.forms[0].action+"?departid="+superiorid+"&sm_name="+name+"&sm_loginno="+loginno+"&sm_userRoleSets.roleId="+roleid;
			}catch(e){}
			
		}else if(url==contextPath+"/core/department/departmentlist.action"){
			try{
			var superiorid2=window.parent.document.getElementById("selectnode").value;
			var departmentname=window.parent.document.getElementById("departname").value;
			//listAction = document.forms[0].action+"?sm_superior.id="+superiorid2+"&sm_name="+departmentname;
			listAction = document.forms[0].action+"?sm_superior.id="+"&sm_name="+departmentname;
			 }catch(e){}
		}else if(url==contextPath+"/core/domain/list.action"){
			try{
				var userId=document.getElementById("usersId").value;
				listAction = document.forms[0].action+"?t_users.id="+userId;
				 }catch(e){}
		}else if(url==contextPath+"/portal/dynaform/work/workList.action"){
			listAction = document.forms[0].action + '?actionMode=' + actionMode;
		}else{
			listAction = document.forms[0].action;
		}
	}
}
function selectAll(b, isRefresh) {
	var c = document.getElementsByName("_selects");
	if (c == null)
		return;

	if (c.length != null) {
		for (var i = 0; i < c.length; ++i)
			c[i].checked = b && !(c[i].disabled);
	} else {
		c.checked = b;
	}
}

function selectAllByField(b, fieldName) {
	var c = document.getElementsByName(fieldName);

	if (c == null)
		return;

	if (c.length != null) {
		for (var i = 0; i < c.length; ++i)
			c[i].checked = b && !(c[i].disabled);
	} else {
		c.checked = b;
	}
}

//待办翻到第一页
function showFirstPage(FO) {
	if (FO == null) {
		FO = document.forms;
	}
	if (isNaN(parseInt(FO[0]._currpage.value))
			|| isNaN(parseInt(FO[0]._pagelines.value))
			|| isNaN(parseInt(FO[0]._rowcount.value))) {
		return;
	}

	var pageCount = Math.ceil(parseInt(FO[0]._rowcount.value)
			/ parseInt(FO[0]._pagelines.value));

	if (pageCount > 1) {
		if (listAction) {
			FO[0].action = listAction;
		}
		FO[0]._currpage.value = 1;
		FO[0].submit();
	}
}

//待办翻到上一页
function showPreviousPage(FO) {
	if (FO == null) {
		FO = document.forms;
	}
	if (isNaN(parseInt(FO[0]._currpage.value))
			|| isNaN(parseInt(FO[0]._pagelines.value))
			|| isNaN(parseInt(FO[0]._rowcount.value))) {
		return;
	}

	var pageNo = parseInt(FO[0]._currpage.value);
	// var pageCount = Math.ceil(parseInt(FO._rowcount.value) /
	// parseInt(FO._pagelines.value));

	if (pageNo > 1) {
		if (listAction) {
			FO[0].action = listAction;
		}
		FO[0]._currpage.value = pageNo - 1;
		FO[0].submit();
	}
}

//待办翻到下一页
function showNextPage(FO) {
	if (FO == null) {
		FO = document.forms;
	}
	if (isNaN(parseInt(FO[0]._currpage.value))
			|| isNaN(parseInt(FO[0]._pagelines.value))
			|| isNaN(parseInt(FO[0]._rowcount.value))) {
		return;
	}
	var pageNo = parseInt(FO[0]._currpage.value);
	var pageCount = Math.ceil(parseInt(FO[0]._rowcount.value)
			/ parseInt(FO[0]._pagelines.value));
	if (pageCount > 1 && pageCount > pageNo) {
		if (listAction) {
			FO[0].action = listAction;
		}
		FO[0]._currpage.value = pageNo + 1;
		FO[0].submit();
	}
}

//待办翻到最后一页
function showLastPage(FO) {
	if (FO == null) {
		FO = document.forms;
	}
	if (isNaN(parseInt(FO[0]._currpage.value))
			|| isNaN(parseInt(FO[0]._pagelines.value))
			|| isNaN(parseInt(FO[0]._rowcount.value))) {
		return;
	}

	// var pageNo = parseInt(FO._currpage.value);
	var pageCount = Math.ceil(parseInt(FO[0]._rowcount.value)
			/ parseInt(FO[0]._pagelines.value));

	if (pageCount > 0) {
		if (listAction) {
			FO[0].action = listAction;
		}
		FO[0]._currpage.value = pageCount;
		FO[0].submit();
	}
}
//设置cookie值
function setCookie(name,value){
    var exp  = new Date();  
    exp.setTime(exp.getTime() + 30*24*60*60*1000);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString()+"; path=/";
}

//获取cookie值
function getCookie(name){
    var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
     if(arr != null) return unescape(arr[2]); return null;
}

//切换显示数量
function changeShowNum(){
	var FO = document.forms;
	if (listAction) {
		FO[0].action = listAction;
	}
	//FO[0].action = contextPath + 'XXX.action';
	FO[0].submit();
}
//待办跳转页面
function jumpPage() {
	if (isNaN(parseInt(document.forms[0]._currpage.value))
			|| isNaN(parseInt(document.forms[0]._pagelines.value))
			|| isNaN(parseInt(document.forms[0]._jumppage.value))
			|| isNaN(parseInt(document.forms[0]._rowcount.value))) {
		return;
	}

	var pageNo = parseInt(document.forms[0]._jumppage.value);
	var _pageCount = parseInt(document.forms[0]._pageCount.value);
	var pageCount = Math.ceil(parseInt(document.forms[0]._rowcount.value)
			/ parseInt(document.forms[0]._pagelines.value));
	if (pageNo > _pageCount||pageNo<=0||isNaN(pageNo)) {
		alert(" 输入参数有误!");
		return;
	}
	if (pageCount > 1 && pageCount >= pageNo) {
		if (listAction) {
			document.forms[0].action = listAction;
		}
		document.forms[0]._currpage.value = pageNo;
		document.forms[0].submit();
	}
}

//回车触发页码跳转
function enterJump(){
	jQuery("input[name='_jumppage']").keydown(function(){
		if(event.keyCode == 13){
			jumpPage();
			return false;
		}
	});
}

//待阅翻到第一页
function showCirculatorFirstPage(FO) {
	listAction = contextPath+"/portal/workflow/storage/runtime/workList.action?actionMode=circulator";
	showFirstPage(FO);
}

//待阅翻到上一页
function showCirculatorPreviousPage(FO) {
	listAction = contextPath+"/portal/workflow/storage/runtime/workList.action?actionMode=circulator";
	showPreviousPage(FO);
}

//待阅翻到下一页
function showCirculatorNextPage(FO) {
	listAction = contextPath+"/portal/workflow/storage/runtime/workList.action?actionMode=circulator";
	showNextPage(FO);
}

//待阅翻到最后一页
function showCirculatorLastPage(FO) {
	listAction = contextPath+"/portal/workflow/storage/runtime/workList.action?actionMode=circulator";
	showLastPage(FO);
}

//待阅跳转页面
function jumpPageCirculator() {
	listAction = contextPath+"/portal/workflow/storage/runtime/workList.action?actionMode=circulator";
	jumpPage();
}

function resetPage(FO) {
	if (FO == null) {
		FO = document.formList;
	}
	FO[0]._currpage.value = '1';
}

function resetForm(FO) {
	if (FO == null) {
		FO = document.formList;
	}
	FO[0]._orderby.value = '';
	FO[0]._desc.value = '';
	FO[0]._currpage.value = '1';
}

function resetAll() {
	var elements = document.forms[0].elements;
	for (var i = 0; i < elements.length; i++) {
		var elementName = elements[i].name;
		if ((elementName.indexOf("sm_") > -1)
				|| (elementName.indexOf("d_") > -1) || (elementName.indexOf("s_") > -1)) {
			elements[i].value = "";
		}
	}
}
function resetQuery(clearName){
	var name;
	if(clearName){
		name = document.getElementsByName(clearName)[0];
	}else{
		name = document.getElementsByName("sm_name")[0];
	}
	name.value="";
}
//10.12.26 jack add param of "msg" for internationalization question of window tips
function isSelectedOne(fldName,msg) {
	var c = document.getElementsByName(fldName);
	var flag = false;
	if (c && c.length > 0) {
		for (var i = 0; i < c.length; i++) {
			if (c[i].checked) {
				flag = true;
				break;
			}
		}
	}

	if (!flag) {
		alert(msg);
		return false;
	}
	return true;
}


/*
 * 修饰table js方法
 * 1、隔行变色 2、mouseover变色
 * */
function cssListTable(){
	jQuery("#contentTable tr").css("background-color","white");
	jQuery("#contentTable tr:even").css("background-color","#EEF0F2");
	jQuery("#contentTable tr").mouseover(function(){
		jQuery(this).addClass("mouseontr");
	}).mouseout(function(){
		jQuery(this).removeClass("mouseontr");
	});
}

//待办翻到指定页
function showPageNo(pageNo, FO){
	if (FO == null) {
		FO = document.forms;
	}
	if (isNaN(parseInt(pageNo))
			|| isNaN(parseInt(FO[0]._pagelines.value))
			|| isNaN(parseInt(FO[0]._rowcount.value))) {
		return;
	}

	var pageCount = Math.ceil(parseInt(FO[0]._rowcount.value)
			/ parseInt(FO[0]._pagelines.value));

	if (pageCount > 1) {
		if (listAction) {
			FO[0].action = listAction;
		}
		FO[0]._currpage.value = pageNo;
		FO[0].submit();
	}
}

/*
 * 初始化list div的位置
 * */
