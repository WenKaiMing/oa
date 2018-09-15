//设置cookie，浏览器通过后退返回到视图时可正常刷新
var cook = {};
cook.getCookie = function(name){
	var cookie = {
			name : "",
			value : ""
	};
	
	var _cookies = document.cookie.split("; ");
	for(var i=0; i<_cookies.length; i++){
		var _cookie = _cookies[i];
		cookie.name = _cookie.split("=")[0];
		cookie.value = _cookie.split("=")[1];
		if(cookie.name == "viewurl"){
			break;
		}
	}
	return cookie;
};
cook.setCookie = function(name, value){
	var myDate = new Date();
	myDate.setTime(myDate.getTime() + 1000*60*60*0.5);//时效0.5小时
	document.cookie = name + "=" + escape(value) + ";expires=" + myDate.toGMTString() + ";path=/";//设置cookie和时效
};
cook.delCookie = function(name, value){
	var myDate = new Date();
	myDate.setTime(myDate.getTime() - 10);//时效 2s
	document.cookie = name + "=" + value + ";expires=" + myDate.toGMTString() + ";path=/";
};
cook.reloadByCookie = function(){
	var cookie = {
			name : "",
			value : ""
	};
	cookie = cook.getCookie("viewurl");
	
	//根据cookie刷新页面
	var curUrl = document.location.href;
	if(cookie.value == escape(curUrl)){
		cook.delCookie(cookie.name, cookie.value);	//删除cookie
		window.location.reload();
	}
};