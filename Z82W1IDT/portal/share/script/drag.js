var isMove = false;

// 开始移动
function startMove(oEvent, div_id) {
	var x, y, divLeft, divTop;
	var offset_x;
	var offset_y;
	var whichButton;
	if (parent.parent.parent.document.all && oEvent.button == 1)
		whichButton = true;
	else {
		if (oEvent.button == 0)
			whichButton = true;
	}
	if (whichButton) {
		var oDiv = div_id;
		offset_x = parseInt(oEvent.clientX - oDiv.offsetLeft);
		offset_y = parseInt(oEvent.clientY - oDiv.offsetTop);
		parent.parent.parent.document.documentElement.onmousemove = function(mEvent) {
			var eEvent;
			if (parent.parent.parent.document.all)
				eEvent = event;
			else {
				eEvent = mEvent;
			}
			var oDiv = div_id;
			var x = eEvent.clientX - offset_x;
			var y = eEvent.clientY - offset_y;
			oDiv.style.left = (x) + "px";
			oDiv.style.top = (y) + "px";
		}
	}
}
// 停上移动并保留位置
function stopMove(oEvent) {
	parent.parent.parent.document.documentElement.onmousemove = null;
}