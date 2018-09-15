<%@ page pageEncoding="UTF-8"%>
<o:MultiLanguage>
<style>
<!--
.transparent_message {
	COLOR: #23571d;
	FONT-SIZE: 14px;
	width: auto;
	height: 16px;
	line-height: 16px;
	padding: 5px;
	TEXT-ALIGN: center;
	display: none;
	position:absolute;
	z-index: 1000;
	width: 100%;
}
.transparent_message .msgSub {
	FONT-SIZE: 14px;
}

.tip{
	position:absolute;
	font-size:12px;
	left:10px;
	bottom: 2px;
}

.transparent_default {
	background-color: #ffffff;
}

.transparent_primary {
	background-color: #337ab7;
	color: #ffffff;
}

.transparent_success {
	background-color: #5cb85c;
	color: #ffffff;
}

.transparent_info {
	background-color: #5bc0de;
	color: #ffffff;
}

.transparent_warning {
	background-color: #ec971f;
	color: #ffffff;
}

.transparent_danger {
	background-color: #d9534f;
	color: #ffffff;
}
.transparent_notice {
	background-color: #9bffa3;
	color: #ffffff;
}
-->
</style>
<script>
function showMessage(msgType, content) {
	content = jQuery.trim(content);
	if(content != ""){
		/**根据提示信息长度计算倒计时时间--start**/
		var sum = 0;
		var timeSize = 3;
		for(var i=0;i<content.length;i++) { 
		    if((content.charCodeAt(i)>=0) && (content.charCodeAt(i)<=255)) {
		      	sum=sum+1;
		    }else {
		      	sum=sum+2;
		    }
		}
		timeSize += (sum>20)?Math.round((sum-20)/10):0;
		/**根据提示信息长度计算倒计时时间--end**/
		
		var $msgObj = jQuery("#msg");
		var $msgDivObj = $msgObj.find(".msgSub");
	
		if(!$msgDivObj.size()>0){
			$msgObj.append(jQuery('<div class="msgSub"></div>'));
			$msgDivObj = $msgObj.find(".msgSub");
		}
		$msgDivObj.html(content);	//初始化提示内容
		//根据提示消息类型改变背景颜色
		if(msgType == "error" || msgType == "danger"){
			$msgObj.addClass("transparent_danger");
		}else if(msgType == "success"){
			$msgObj.addClass("transparent_success");
		}else if(msgType == "info"){
			$msgObj.addClass("transparent_info");
		}else if(msgType == "warning"){
			$msgObj.addClass("transparent_warning");
		}else if(msgType == "default"){
			$msgObj.addClass("transparent_default");
		}else if(msgType == "notice"){
			$msgObj.addClass("transparent_notice");
		}

		$msgObj.find("#tip").html("(<span>"+timeSize+"</span>)("+"{*[page.msg.mouse_hover_pause_hide]*}"+")")	//初始化倒计时内容
			.end().fadeIn(1000)//显示消息
			.bind("mousedown",function(){//鼠标按下后停止倒计时隐藏
				clearTimeout(time2);
				$msgObj.find("#tip").html("(单击隐藏)");
			}).bind("click",function(){//鼠标点击时隐藏
				$msgObj.fadeOut(1000);
				$msgDivObj.html("");
			}).bind("mouseover",function(){
				isOut = false;
			}).bind("mouseout",function(){
				isOut = true;
			});

		//倒计时功能
		var time2 = 0;
		var isOut = true;
		var timer = function(){
			time2 = setTimeout(function(){
				timer();
			},1000);
			if(isOut){
				var $msgTip = $msgObj.find("#tip > span");
				$msgTip.html($msgTip.html()-1);
				if($msgTip.html() <= 0){
					clearTimeout(time2);
					$msgObj.fadeOut(1000);//隐藏消息
					$msgDivObj.html("");
				}
			}
		};
		setTimeout(function(){
			timer();
		},1000);
	}
}

jQuery(function(){
	var $msgDivObj = jQuery("#msg").find(".msgSub");
	var msgType = $msgDivObj.attr("msgType");	//消息类型
	showMessage(msgType, $msgDivObj.html());
	jQuery("#msg").height(jQuery(".msgSub").height()+14);
});

</script>
<div id="msg" class="transparent_message">
	<div id="tip" class="tip">(<span>3</span>)(鼠标悬停暂停隐藏)</div>
	<s:if test="hasFieldErrors()">
		<div class="msgSub" msgType="error">
			<s:iterator value="fieldErrors">
				*<s:property value="value[0]" />&nbsp;&nbsp;
			</s:iterator>
		</div>
	</s:if>
	<s:elseif test="hasActionMessages()">
		<div class="msgSub" msgType="notice">
			<s:iterator value="actionMessages">
				<s:property />
			</s:iterator>
		</div>
	</s:elseif>
</div>
</o:MultiLanguage>