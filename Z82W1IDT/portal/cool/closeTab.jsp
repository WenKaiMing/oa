<script>
/**
 * 关闭并刷新
   1 - 获取refreshId
   2 - 遍历所有的Iframe，并获得win.jQuery对象
   3 - 通过win.jQuery对象，获得刷新对象
   4 - 触发刷新对象的refresh事件（事先已经注册），实现刷新
 */
var hurl = location.href;
var refreshId;
if (hurl.indexOf("refreshId")>0) {
	refreshId = hurl.substring(hurl.indexOf("refreshId")+10);
	refreshId = refreshId.indexOf("&")>0 ? refreshId.substring(0, refreshId.indexOf("&")) : refreshId;
}

function refreshElement(d){
	var frames=d.getElementsByTagName("iframe");
	for(var i=0;i<frames.length;i++){ 
		var frame=frames[i];
		var doc, win; 
		try {
			doc = frame.contentDocument ? frame.contentDocument 
					: frame.contentWindow ? frame.contentWindow.document 
					: frame.document ? frame.document
					: frame;
			win = getIframeWindow(frame);
		}
		catch(e) {
			continue;
		}
		
		if (doc && win) {
			if (win.jQuery) {
				//alert("win.jQuery-->"+win.jQuery("#"+refreshId).size());
				win.jQuery("[refreshId='"+refreshId+"']").trigger("refresh");
			}
			refreshElement(doc);
		}
	}
}

function getIframeWindow(element){
	//return  element.contentWindow;     
	return  element.contentWindow || element.contentDocument.parentWindow; 
}

if (refreshId) {
	refreshElement(top.document);			
}

//执行关闭TAB
parent.closeActiveTab();
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<div style="background-color: #9bffa3;">
	处理成功！请关闭页面！
</div>
<!-- 
<button onclick="dd">refreshElement</button>
<button onclick="parent.closeActiveTab()">closeActiveTab</button>
 -->