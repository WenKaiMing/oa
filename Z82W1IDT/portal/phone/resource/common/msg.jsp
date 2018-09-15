<%@ page pageEncoding="UTF-8"%>
<o:MultiLanguage>

<script>
function showMessage(msgType, content) {
	content = jQuery.trim(content);
	if(content != ""){		
		var $msgObj = jQuery("#msg");
		var $msgBack = jQuery("#msgBack");
		var $msgDivObj = $msgObj.find(".msgSub");
	
		if(!$msgDivObj.size()>0){
			$msgObj.find(".msg-box").append(jQuery('<div class="msgSub"></div>'));
			$msgDivObj = $msgObj.find(".msgSub");
		}
		$msgDivObj.html(content);	//初始化提示内容
		
		//根据提示消息类型改变背景颜色
		if(msgType == "error"){
			$msgObj.find("#tip").html('<span class="icon icon-close"></span>');
		}else{
			$msgObj.find("#tip").html('<span class="icon icon-check"></span>');
		}
		
		$msgBack.show();
		$msgObj.show();
		$msgObj.find(".msg-box").addClass("bounceIn").removeClass("bounceOut").show();
		
		
		//3秒后自动隐藏
		setTimeout(function(){
			$msgObj.find(".msg-box").addClass("bounceOut").removeClass("bounceIn");
			$msgObj.delay(750).hide(0);
			$msgBack.delay(750).hide(0);
		},3000);
	}
}

jQuery(function(){
	var $msgDivObj = jQuery("#msg").find(".msgSub");
	var msgType = $msgDivObj.attr("msgType");	//消息类型
	showMessage(msgType, $msgDivObj.html());
});

</script>

<div id="msg" class="transparent_message" style="background-color: rgba(0, 0, 0, 0);">
<div class="msg-box animated">
	<div id="tip" class="tip"><!-- (<span>3</span>)(鼠标悬停暂停隐藏) --></div>
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
</div>
<div id="msgBack" class="msg-toast"></div>
</o:MultiLanguage>