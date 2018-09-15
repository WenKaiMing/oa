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
function showuserselectentrust(actionName, settings, roleid) {
	var oApp = document.getElementsByName("application")[0];
	var title_uf="托付给";
	var url = contextPath + "/portal/phone/resource/component/dialog/selectUserByAll.jsp";
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
				close : function(result) {
					var textObj = document.getElementById(settings.textField);
//					if(textObj != null){
//						textObj.style.border = "1px solid #ff0000";
//					}
					
					var executor = '<span class="executor td text-center" onclick="clickRemoveSelect(this);">'
								+ '<div class="executor-pic"><img src="../images/head.png"></div>'
								+ '<div class="executor-name"></div>'
								+ '<input type="hidden" name="content.executor" />'
								+ '<input type="hidden" name="content.executorId" />'
								+ '</span>';

					if(result){
						for(var i = 0; i < result.length; i++){
							$(".task-person").find(".executor").remove();
							$executor = $(executor);
							$executor.find(".executor-name").text(result[0].text)
							$("#addExecutor").after($executor);
							$("input[name='content.executor']").val(result[0].text);
							$("input[name='content.executorId']").val(result[0].value);
							$("#addExecutor").hide();
						}
					}
					
					/*var textObj = document.getElementById(settings.textField);
					if(result){
						for(var i = 0; i < result.length; i++){
							PM.service.task.updateTaskExecutor(PM.cache.currentEditTaskId,
									result[0].value,result[0].text,function(task){
								$(document).attr("title","任务列表");
								PM.task.randerTaskListPage();
								$("#taskList").show();
								$("#taskEdit").hide();
							});
						}
					}*/
					if (settings.callback) {
						if(typeof settings.callback == "function"){
							settings.callback(rtnValue);
						}else{//用户选择框控件
							eval(settings.callback);
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
						} else {
							if (rtn == '') { // 清空
								field.value = '';
								valueField.value = '';
							}
						}

						if (settings.callback) {
							settings.callback(valueField.name);
						}
					}
					
				}
			});
}

function showUserSelectExecutor(actionName, settings, roleid) {
	
	location.hash = "#/popUpLayer";
	var oApp = document.getElementsByName("application")[0];
	var title_uf="执行人"
	//var url = contextPath + "/portal/phone/resource/component/dialog/selectUserByAll.jsp";
	var	url = contextPath + "/contacts/index.jsp?mode=select";
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
					//选择用户数
					"limitSum": settings.limitSum,
					//选择模式
					"selectMode":settings.selectMode,
					// 存放userEmail的容器id
					"receiverEmail" : settings.showUserEmail,
					// 存放userEmail的容器id
					"receiverEmailAccount" : settings.showUserEmailAccount,
					// 存放userTelephone的容器id
					"receiverTelephone" : settings.showUserTelephone,
					// 多选模式
					"multiple": false,
					// [] 配置显示的tab，全部、部门、职务、常用
					tabs : settings.tabs,
					//可选的静态用户,数据结构：[{avatar : "",	dept : "行政部2",email : "",	id : "",mobile : "",mobile2 : "",name : "邢儿",type : 1},{...}]
					toChooseUsers : settings.toChooseUsers
				},
				title : title_uf,
				close : function(result) {
					var textObj = document.getElementById(settings.textField);
					var executor = '<span class="executor td text-center" onclick="clickRemoveSelect(this);">'
								+ '<div class="executor-pic"><div class="delete"><i class="fa fa-remove" aria-hidden="true"></i></div></div>'
								+ '<div class="executor-name"></div>'
								+ '<input type="hidden" name="content.executor" />'
								+ '<input type="hidden" name="content.executorId" />'
								+ '</span>';

					if(result){
						var data = result.data;
						for(var i = 0; i < data.length; i++){
							$executor = $(executor);
							console.log($executor);
							$executor.find(".executor-name").text(data[i].text)
							var _noAvatar = "";
							if(data[i].avatar != "" && data[i].avatar != undefined){
								_noAvatar = '<div class="noAvatar"><img src="'+data[i].avatar+'" style="width:46px;height:46px;border-radius:4px;"/></div>';
								
							}else{
								_noAvatar = '<div class="noAvatar">'+data[i].text.substr(data[i].text.length-2, 2)+'</div>';
							}
							$executor.find(".executor-pic").append(_noAvatar);
							$("#addExecutor").after($executor);
							$("input[name='content.executor']").val(data[i].text);
							$("input[name='content.executorId']").val(data[i].value);
							$("#addExecutor").hide();
						}
						if (settings.callback) {
							if(typeof settings.callback == "function"){
								settings.callback(rtnValue);
							}else{//用户选择框控件
								eval(settings.callback);
							}
						}
					}
					if(window.location.hash == "#/popUpLayer"){
		         		history.go(-1);
		         	}
				}
			});
}
