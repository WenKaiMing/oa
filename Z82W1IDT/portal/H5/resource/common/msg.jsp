<%@ page pageEncoding="UTF-8"%>
<o:MultiLanguage>
<style>
<!--
.alertbox{
	position: fixed;
    margin:auto;
    left:0; 
    right:0; 
    top:45%; 
    width:500px; 
    z-index: 9999;
}
.msgSub{
	text-align:center;
}
.tip{
	font-size:12px;
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
		if(msgType == "danger"){
			$msgObj.removeClass().addClass("alertbox alert alert-danger");
		}else if(msgType == "success"){
			$msgObj.removeClass().addClass("alertbox alert alert-success");
		}else if(msgType == "info"){
			$msgObj.removeClass().addClass("alertbox alert alert-info");
		}else if(msgType == "warning"){
			$msgObj.removeClass().addClass("alertbox alert alert-warning");
		}else if(msgType == "error"){
			$msgObj.removeClass().addClass("alertbox alert alert-danger");
		}

		$msgObj.find("#tip").html("<span>"+timeSize+"</span>")	//初始化倒计时内容
			.end().fadeIn(1000)//显示消息
			.bind("mousedown",function(){//鼠标按下后停止倒计时隐藏
				clearTimeout(time2);
				$msgObj.find("#tip");
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

window.onload = function(){
	var $msgDivObj = jQuery("#msg").find(".msgSub");
	var msgType = $msgDivObj.attr("msgType");	//消息类型
	showMessage(msgType, $msgDivObj.html());
	//jQuery("#msg").height(jQuery(".msgSub").height()+14);
};

</script>

<div id="msg" class="alertbox alert" role="alert" style="display: none;">
	<s:if test="hasFieldErrors()">
		<div class="msgSub" msgType="error">
			<s:iterator value="fieldErrors">
				*<s:property value="value[0]" />&nbsp;&nbsp;
			</s:iterator>
		</div>
	</s:if>
	<s:elseif test="hasActionMessages()">
		<div class="msgSub" msgType="info">
			<s:iterator value="actionMessages">
				<s:property />
			</s:iterator>
		</div>
	</s:elseif>
	<div id="tip" class="tip fr"></div>
</div>

</o:MultiLanguage>