/**
 * 选择当前节点审批人
 * 
 * @param {}
 *            actionName
 * @param {}
 *            fieldId
 */
function selectField(actionName, fieldId) {
	var oCurridArray = document.getElementsByName("_currid");
	// 当前节点ID
	var currid = '';
	if (oCurridArray && oCurridArray.length > 0) {
		currid = oCurridArray[0].value;
	}
	// 目标文本框
	var oFiled = document.getElementById(fieldId);
	if (oFiled) {
		var map = oFiled.value ? jQuery.parseJSON(oFiled.value) : {};
		
		var defValue = oFiled.value;
		var rtn = showUserSelectNoFlow('', {
					defValue: map[currid],
					callback: function(result) {
						// prototype1_6.js
						if (result) {
							var userlist = result.split(",");
							// 为当前节点设置
							map[currid] = userlist;
							oFiled.value = jQuery.json2Str(map);
						}
					}
				});
	}
}

/**
 * 选择用户
 * 
 * @param {}
 *            actionName
 * @param {}
 *            settings
 */
function showUserSelectNoFlow(actionName, settings, roleid) {
	var oApp = document.getElementsByName("application")[0];
	//var url = contextPath + "/portal/phone/resource/component/dialog/selectUserByAll.jsp?application="+oApp.value;
	var url = contextPath + "/contacts/index.jsp?mode=select";
	var setValueOnSelect = true;
	if (settings.setValueOnSelect == false) {
		setValueOnSelect = settings.setValueOnSelect;
	}
	
	OBPM.dialog.show({
				width : 610,
				height : 450,
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
					//是否多选模式
					"multiple": true,
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
				title : title_uf,
				close : function(rtn) {
					if(rtn){
						if(rtn.state == "success"){
		//					var textObj = document.getElementById(settings.textField);
		//					if(textObj != null){
		//						textObj.style.border = "1px solid #ff0000";
		//					}
							var result = rtn.data;
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
					}
				}
			});
}

/**
 * 选择部门
 * 
 * @param {}
 *            actionName
 * @param {}
 *            settings
 */
function showDepartmentSelect(actionName, settings) {
	var url = contextPath + '/portal/phone/resource/component/dialog/select.jsp';
	var valueField = document.getElementById(settings.valueField);
	var value = "";
	if (valueField) {
		value = valueField.value;
	}
	// 使用jquery-adapter
	OBPM.dialog.show({
				width : 300,
				height : 400,
				url : url,
				args : {
					value : value,
					readonly : settings.readonly,
					limit : settings.limit
				},
				title : title_df,
				close : function(result) {
					var textObj = document.getElementById(settings.textField);
//					if(textObj != null){
//						textObj.style.border = "1px solid #ff0000";
//					}
					var rtn = result;
					var field = document.getElementById(settings.textField);
					if (field) {
						if (rtn) {
							if(rtn =="clear"){// 清空
								field.value = '';
								valueField.value = '';
							}else{
								var rtnValue = '';
								var rtnText = '';

								if (rtn[0] && rtn.length > 0) {
									for (var i = 0; i < rtn.length; i++) {
										rtnValue += rtn[i].value + ";";
										rtnText += rtn[i].text + ";";
									}

									rtnValue = rtnValue.substring(0, rtnValue
													.lastIndexOf(";"));
									rtnText = rtnText.substring(0, rtnText
													.lastIndexOf(";"));
								}
								field.value = rtnText;
								valueField.value = rtnValue;
							}
						}

						if (settings.callback) {
							settings.callback(valueField.name);
						}
					}
					
				}
			});
}
