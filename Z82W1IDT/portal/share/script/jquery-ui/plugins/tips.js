/*jQuery(document).ready(function(){				   
	var rightwin=jQuery("#right");
	var windowobj=jQuery(window);
	var cwinWidth=rightwin.width();
	var cwinHeight=rightwin.height();
	var browserWidth=windowobj.width();
	var browserHeight=windowobj.height();
	var scrollLeft=windowobj.scrollLeft();
	var scrollTop=windowobj.scrollTop();
	rightwin.mywin({left:"right",top:"bottom"},
		function(){
				rightwin.hide(1000);												  
		},{left:browserWidth-cwinWidth-5,top:browserHeight}
	).fadeOut(30000).dequeue();
});

*/
/* name:mywin插件
 * 参数position：窗口显示的最终位置{left：XX，top：XX}
 * 参数hidefunc：关闭时调用的函数
 * 参数initPos： 窗口初位置{left：XX，top：XX}
 */
jQuery.fn.mywin=function(position,hidefunc,initPos){
	if(position && position instanceof Object){
		var positionleft=position.left;
		var positiontop=position.top;
		
		var left;
		var top;
		var windowobj=$(window);
		var currentwin=this;
		var cwinWidth=this.outerWidth(true);
		var cwinHeight=this.outerHeight(true);	
		
		var browserWidth;                        //浏览器宽度
		var browserHeight;                       //浏览器高度
		var scrollLeft;                          //
		var scrollTop;                           //
					
		//计算浏览器可视区域位置
		function getWinDin(){
			browserWidth=windowobj.width();
			browserHeight=windowobj.height();
			scrollLeft=windowobj.scrollLeft();
			scrollTop=windowobj.scrollTop();
		}
		//计算浏览器的左边距
		function callLeft(positionleft,browserWidth,scrollLeft,cwinWidth){
			if(positionleft && typeof positionleft=="string"){
				if(positionleft=="center"){
					left=(browserWidth-cwinWidth)/2;
				}
				else if(positionleft=="left"){
					left=0;
				}
				else if(positionleft=="right"){
					left=browserWidth-cwinWidth;
				}
			}
			else if(positionleft && typeof positionleft=="number"){
				top=positionleft;
			}else{
				left=(browserWidth-cwinWidth)/2;
			}
		}
		
		//计算浏览器的上边距
		function callTop(positiontop,browserHeight,scrollTop,cwinHeight){
			if(positiontop && typeof positiontop=="string"){
				if(positiontop=="center"){
					top=(browserHeight-cwinHeight)/2;
				}
				else if(positiontop=="top"){
					top=0
				}
				else if(positiontop=="bottom"){
					top=browserHeight-cwinHeight;
				}
			}
			else if(positiontop && typeof positiontop=="number"){
				top=positiontop;
			}else{
				top=(browserHeight-cwinHeight)/2;
			}
		}
		//移动窗口的位置
		function movewin(){
			callLeft(currentwin.data("positionleft"),browserWidth,scrollLeft,cwinWidth);
			callTop(currentwin.data("positiontop"),browserHeight,scrollTop,cwinHeight);	
			currentwin.animate({
							   	left:left-5,
								top: top
							   },2000);
		}
		
		//拖动窗口滚动条后重新调整窗口的相对位置
		var scrolltimeout;
		$(window).scroll(function(){
			if(!currentwin.is(":visible")){
				return;
			}
			clearTimeout(scrolltimeout);
			scrolltimeout=setTimeout(function(){
				getWinDin();	
				movewin();	
			},2000);
		});
		//浏览器窗口太小变化时重新调整窗口的相对位置
		$(window).resize(function(){
			if(!currentwin.is(":visible")){
				return;
			}
			getWinDin();
			movewin();
		});
		//点击关闭图标关闭窗口时间
		currentwin.children(".title").children("img").click(
			function(){
				if(!hidefunc){
					currentwin.hide(1000);
				}else{
					hidefunc();
				}
		});
		//初始化窗口的位置
		if(initPos && initPos instanceof Object){
			var initleft=initPos.left;
			var inittop=initPos.top;
			if(initleft && typeof initleft=="number"){
				currentwin.css("left",initleft);
			}else{
				currentwin.css("left",0);	
			}
			if(inittop && typeof inittop=="number"){
				currentwin.css("top",inittop);
			}else{
				currentwin.css("top",0);	
			}
			currentwin.show();
		}
		
		currentwin.data("positionleft",positionleft);
		currentwin.data("positiontop",positiontop);
		getWinDin();
		movewin();
		return currentwin;	
	}
}