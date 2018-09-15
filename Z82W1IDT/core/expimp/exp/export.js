// 显示loading
function showload(){
//window.onbeforeunload = function(){
	if (loading) {
		loading.style.display = "block";
	}
	var btns = document.getElementsByTagName("button");
	for(var i=0; i<btns.length; i++) {
		btns[i].disabled = true;
	}
}

function onafterunload(){
	if (loading) {
		loading.style.display = "none";
	}
	var btns = document.getElementsByTagName("button");
	for(var i=0; i<btns.length; i++) {
		btns[i].disabled = false;
	}
}

// 下载导出的文件
function ev_download(filename){
	if (filename) {
		document.forms[0].action = 'download.action?filename='+encodeURIComponent(filename);
		document.forms[0].submit();
		//alert(url);
		//window.open(url);
	}
	onafterunload();
}