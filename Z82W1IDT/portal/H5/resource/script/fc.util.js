FC.Util = {
	cache : {
		
	},
	
	
	/**
	 * 选择用户
	 * 
	 * @param {}
	 *            actionName
	 * @param {}
	 *            settings
	 */
	 showUserSelectNoFlow : function(actionName, settings, roleid, appId) {
		var url = contextPath + "/portal/H5/resource/component/dialog/selectUserByAll.jsp?application="+appId;
		var setValueOnSelect = true;
		if (settings.setValueOnSelect == false) {
			setValueOnSelect = settings.setValueOnSelect;
		}
		
		OBPM.dialog.show({
					width : 682,
					height : 500,
					url : url,
					args : {
						// p1:当前窗口对象
						"parentObj" : window,
						// p2:存放userid的容器id
						"targetid" : settings.valueField,
						// p3:存放username的容器id
						"receivername" : settings.textField,
						// p4:默认选中值, 格式为[userid1,userid2]
						"defValue": settings.defValue,
						//选择用户数
						"limitSum": settings.limitSum,
						//选择模式
						"selectMode":settings.selectMode,
						// 存放userEmail的容器id
						"receiverEmail" : settings.showUserEmail,
						// 存放userEmail的容器id
						"receiverEmailAccount" : settings.showUserEmailAccount,
						// 存放userTelephone的容器id
						"receiverTelephone" : settings.showUserTelephone
					},
					title : "选择发起人",
					close : function(result) {
						var textObj = document.getElementById(settings.textField);
//						if(textObj != null){
//							textObj.style.border = "1px solid #ff0000";
//						}
						if(result){
							var rtnValue = "";
							for(var i = 0; i < result.length; i++){
								rtnValue += result[i].value + ';';
							}
							var rtnText = "";
							for(var i = 0; i < result.length; i++){
								rtnText += result[i].text + ';';
							}
							rtnValue = rtnValue.substring(0,rtnValue.length-1);
							rtnText = rtnText.substring(0,rtnText.length-1);
							$("#"+settings.valueField).val(rtnValue);
							$("#"+settings.textField).val(rtnText);
						}
						if (settings.callback) {
							if(typeof settings.callback == "function"){
								settings.callback(rtnValue);
							}else{//用户选择框控件
								eval(settings.callback);
							}
						}
					}
				});
	},
	//loading show
	dy_lock : function () {
		jQuery("body").css("overflow","hidden");
		jQuery("#loadingMask").fadeTo(300,0.4);
	},

	//loading hide
	dy_unlock : function () {
		jQuery("body").css("overflow","visible");
		jQuery("#loadingMask").fadeOut(200);
	}
}