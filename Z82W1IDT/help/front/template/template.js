function adjustFlashIteratorSize(){
   	var container = document.getElementById("container");
	var containerHeight = document.body.clientHeight - 20;
	var containerWidth = document.body.clientWidth - 20;
	container.style.height = containerHeight + 'px';
	container.style.width = containerWidth + 'px';
	container.style.visibility = "visible";
}

function opens(str){
	window.open (str, 'flash', 'height=680, width=1010, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
}
