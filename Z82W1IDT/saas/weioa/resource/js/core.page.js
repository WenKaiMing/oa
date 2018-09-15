listAction=""
//翻到指定页
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

//翻到下一页
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

//翻到上一页
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
	if (pageNo > 1) {
		if (listAction) {
			FO[0].action = listAction;
		}
		FO[0]._currpage.value = pageNo - 1;
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
	FO[0].submit();
}
