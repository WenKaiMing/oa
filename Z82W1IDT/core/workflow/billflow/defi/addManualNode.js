function RelStr(str) {
	var obj = eval(str);
	if (obj instanceof Array) {
		return obj;
	} else {
		return new Array();
	}
}

function parseRelStr(str) {
	if (str != "") {
		var data = str.split(";");
		var s = data[0];
		if (s.length > 0) {
			var obj = RelStr(s);
			var fieldtoscript = document.all.fieldtoscript;
			for (var j = 0; j < obj.length; j++) {
				var Opt = document.createElement("option");
				Opt.text = obj[j].text;
				Opt.value = obj[j].value;
				fieldtoscript.options.add(Opt);
			}

		}
		var filter = data[1];

		if (filter.length > 0) {
			document.tmp.processDescription.value = filter.substring(1,
					filter.length - 1);
		}

	}

}
function addData() {

	var fields = document.all.field;
	var field;
	if (fields.length > 0) {
		for (var i = 0; i < fields.length; i++) {
			if (fields.options(i).selected == true) {
				field = fields.options(i).value;
				if (field != "" && field != null && field != undefined) {
					tmp.processDescription.value += field;
				}
			}
		}
	}

	addItem();
}
function operateChange(operate) {
	var display = document.getElementById("processDescription");
	if (display.value == "") {

	} else {
		if (operate != "") {

			insertAtCursor(operate);
		}
	}
}
function insertAtCursor(remarkValue) {
	var processDiplay = document.getElementById("processDescription");
	if (document.selection) {
		processDiplay.focus();
		var sel = document.selection.createRange();
		sel.text = remarkValue;

	} else if (processDiplay.selectionStart
			|| processDiplay.selectionStart == "0") {
		var startPos = processDiplay.selectionStart;
		var endPos = processDiplay.selectionEnd;
		processDiplay.value = processDiplay.value.substring(0, startPos)
				+ remarkValue
				+ processDiplay.value.substring(endPos,
						processDiplay.value.length);
	} else {
		processDiplay.value += remarkValue;
	}
}
function changeRela(remark) {
	var display = document.getElementById("processDescription");

	if (display.value == "") {
		if (remark == "LEFT") {
			insertAtCursor('(');
		}
	} else {
		if (remark == "ADD") {
			insertAtCursor('+');
		} else if (remark == "MINUS") {
			insertAtCursor('-');

		} else if (remark == "MULTIPLIED") {
			insertAtCursor('*');

		} else if (remark == "DIVIDED") {
			insertAtCursor('/');

		} else if (remark == "AND") {
			insertAtCursor('&&');

		} else if (remark == "OR") {
			insertAtCursor('||');

		} else if (remark == "NO") {
			insertAtCursor('!');

		} else if (remark == "LEFT") {
			insertAtCursor('(');

		} else if (remark == "RIGHT") {
			insertAtCursor(')');

		} else if (remark == "CLEAR") {
			tmp.processDescription.value = "";
		}
	}
}
function createItems() {
	var iscreate = true;
	var value = document.tmp.processDescription.value;
	var str = '';
	if (value.length > 0) {
		for (var i = 0; i < value.length;) {
			if (((value.charAt(i) == '&') && (value.charAt(i + 1) == '&'))
					|| ((value.charAt(i) == '>') && (value.charAt(i + 1) == '='))
					|| ((value.charAt(i) == '<') && (value.charAt(i + 1) == '='))
					|| ((value.charAt(i) == '<') && (value.charAt(i + 1) == '>'))
					|| ((value.charAt(i) == '|') && (value.charAt(i + 1) == '|'))) {
				str += ";" + value.charAt(i) + value.charAt(i + 1) + ";";
				i = i + 2;
			} else if (value.charAt(i) == '(' || value.charAt(i) == ')'
					|| value.charAt(i) == '+' || value.charAt(i) == '-'
					|| value.charAt(i) == '*' || value.charAt(i) == '/'
					|| value.charAt(i) == '<' || value.charAt(i) == '='
					|| value.charAt(i) == '>' || value.charAt(i) == '!') {
				str += ";" + value.charAt(i) + ";";
				i++;
			} else {

				str += value.charAt(i);
				i++;
			}
		}
		iscreate = createScript(str);

	} else {
		document.tmp.filtercondition.value = '';
	}
	return iscreate;
}
function createScript(value) {
	var iscreatescript = true;
	var script = '';
	if (value != "" && value.length > 0) {
		tmp.filtercondition.value = '';
		tmp.filtercondition.value += 'var doc= $CURRDOC.getCurrDoc();\n';
		var str = value.split(";");

		for (var j = 0; j < str.length; j++) {
			var s = str[j];
			if (s != "") {
				if (s == "(") {
					script += "(";
				} else if (s == ")") {
					script += ")";
				} else if (s == "<") {
					script += "<";
				} else if (s == ">") {
					script += ">";
				} else if (s == ">=") {
					script += ">=";
				} else if (s == "<=") {
					script += "<=";
				} else if (s == "=") {
					script += "==";
				} else if (s == "<>") {
					script += "!=";
				} else if (s == "&&") {
					script += "&&";
				} else if (s == "||") {
					script += "||";
				} else if (s == "!") {
					script += "!";
				} else if (s == "+") {
					script += "+";
				} else if (s == "-") {
					script += "-";
				} else if (s == "*") {
					script += "*";
				} else if (s == "/") {
					script += "/";
				} else if (!isNaN(s)) {
					if (28 + s.length < script.length) {
						if (script.substring(script.length - 3, script.length) == ")!="
								|| script.substring(script.length - 3,
										script.length) == ")==") {
							var len = script.lastIndexOf("(");
							if (script.substring(len - 20, len) == "getItemValueAsString") {
								script += '\'' + s + '\'';
							} else {
								script += s;
							}
						} else {
							script += s;
						}
					} else {
						script += s;
					}
				} else if (s.charAt(0) == '\'' || s.charAt(0) == '\"') {
					script += s;
				} else {
					var fieldtoscript = document.all.fieldtoscript;
					if (fieldtoscript.length > 0) {
						for (var k = 0; k < fieldtoscript.length; k++) {
							if (fieldtoscript.options(k).text == s) {
								if (fieldtoscript.options(k).value == "VALUE_TYPE_VARCHAR") {
									script += '(doc.getItemValueAsString(\''
											+ s + '\'))';
								} else if (fieldtoscript.options(k).value == "VALUE_TYPE_NUMBER") {
									script += '(doc.getItemValueAsDouble(\''
											+ s + '\'))';
								} else if (fieldtoscript.options(k).value == "VALUE_TYPE_DATE") {
									script += '(doc.getItemValueAsString(\''
											+ s + '\'))';
								} else {
									script += '(doc.getItemValueAsString(\''
											+ s + '\'))';
								}
							}
						}
					}
				}
			}
		}
		script += ';';
		tmp.filtercondition.value += script;
		iscreatescript = checkSatement(tmp.filtercondition.value);
	}
	return iscreatescript;
}
function addItem() {
	var fields = document.all.field;
	var fieldType = document.all.fieldType;
	var fieldtoscript = document.all.fieldtoscript;
	for (var i = 0; i < fields.length; i++) {
		if (fields.options(i).selected == true) {
			var Opt = document.createElement("option");
			for (var j = 0; j < fieldType.length; j++) {
				if (fieldType.options(j).selected == true) {
					Opt.value = fieldType.options(j).value;
				}
			}
			Opt.text = fields.options(i).text;

			var k = 0;
			for (var t = 0; t < fieldtoscript.length; t++) {
				if (fields.options(i).text == fieldtoscript.options(t).text) {
					k = 1;
				}

			}
			if (k == 0) {
				fieldtoscript.options.add(Opt);
				k = 0;
			}
		}
	}
}
function createRelStr() {
	var fieldtoscript = document.all.fieldtoscript;
	var str = '[';
	for (var i = 0; i < fieldtoscript.length; i++) {
		if (fieldtoscript.options(i).value != '') {
			str += '{'
			str += '"text"' + ':\'' + fieldtoscript.options(i).text + '\',';
			str += '"value"' + ':\'' + fieldtoscript.options(i).value + '\'';
			str += '},';
		}
	}
	if (str.lastIndexOf(',') != -1) {
		str = str.substring(0, str.length - 1);
	}
	str += ']';
	var processDescription = document.tmp.processDescription.value;
	str += ';[' + processDescription + ']';
	return str;
}
function checkSatement(statement) {

	var issucess = true;
	if (statement.length > 0) {
		var list = ["+", "-", "*", "/", "&", "|", "<", ">", "=", "(", "!"];
		for (var i = 0; i < list.length; i++) {
			if (list[i] == statement.substring(statement.length - 2,
					statement.length - 1)) {
				alert("The condition expression is not correct!");
				tmp.filtercondition.value = "";
				issucess = false;
			}
		}
	}
	return issucess;
}

// {arrive: {sendModeCodes:[0, 1], smsApproval:0or1},
// overdue: {sendModeCodes:[0, 1], limittimecount:12,timeunit:0,
// isnotifysuperior:true},
// reject: {sendModeCodes:[0, 1], responsibleType: 0}}
function toJson() {
	var limittimecount = document.getElementById("limittimecount");
	var timeunit = document.getElementById("timeunit");
	var isnotifysuperior = document.getElementById("isnotifysuperior");
	var responsibleType = document.getElementById("responsibleType");

	var map = {};
	var notificationTypeArray = document.getElementsByName("notificationType");
	for (var i = 0; i < notificationTypeArray.length; i++) {
		if (notificationTypeArray[i].checked) {
			// 创建提醒,设置发送方式
			var notification = createNotification('emailMode', 'smsMode', 'msgMode');
			if (!notification) {
				continue;
			}
			var notificationType = notificationTypeArray[i].value;
			map[notificationType] = notification;
			// 根据不同的类型配置属性
			if (notificationType == 'send') {
				var receiverArray = document.getElementsByName("sendReceiver");
				// 接收者处理
				notification.receiverTypes = new Array();
				for (var n = 0; n < receiverArray.length; n++) {
					if (receiverArray[n].checked) {
						notification.receiverTypes
								.push(new Number(receiverArray[n].value));
					}
				}
			} else if (notificationType == 'arrive') {
				// 短信审批
				var smsApproval = document.getElementById("smsApproval");
				if (smsApproval != null && smsApproval.checked) {
					notification.smsApproval = "1";
				} else {
					notification.smsApproval = "0";
				}
			} else if (notificationType == 'reject') {
				notification.responsibleType = responsibleType.value;
			} else if (notificationType == 'overdue') {
				notification.limittimecount = limittimecount.value;
				notification.timeunit = timeunit.value;
				notification.isnotifysuperior = getCheckBoxValue2("isnotifysuperior");
			}
			// 设置模板
			notification.template = document.getElementById(notificationType
					+ "Template").value;
		}
	}
	return jQuery.json2Str(map);
}

function createNotification(f1, f2, f3) {
	var sendModeCodes = [];
	var emailCode = getCheckBoxValue(f1);
	var smsCode = getCheckBoxValue(f2);
	var msgCode = getCheckBoxValue(f3);
	if (emailCode) {
		sendModeCodes.push(new Number(emailCode));
	}
	if (smsCode) {
		sendModeCodes.push(new Number(smsCode));
	}
	if (msgCode) {
		sendModeCodes.push(new Number(msgCode));
	}

	if (sendModeCodes.length > 0) {
		var notification = new Object();
		notification.sendModeCodes = sendModeCodes;
		return notification;
	} else {
		return null;
	}
}

function getCheckBoxValue(id) {
	var obj = getId(id);
	if (obj.checked) {
		return obj.value;
	}
	return null;
}
function getCheckBoxValue2(id) {
	var obj = getId(id);
	if (obj.checked) {
		return obj.value;
	}
	return false;
}

function getId(s) {
	return document.getElementById(s);
}
function parseJson(rtn) {
	var parseValue = jQuery.parseJSON(rtn);
	
	// 设置发送模式
	for (prop in parseValue) {
		var sendModeArray = parseValue[prop].sendModeCodes;
		for (var i = 0; i < sendModeArray.length; i ++) {
			if (sendModeArray[i] == jQuery('#smsMode').val()) {
				jQuery('#smsMode').attr("checked",true);
			} else if (sendModeArray[i] == jQuery('#emailMode').val()) {
				jQuery('#emailMode').attr("checked",true);
			} else if (sendModeArray[i] == jQuery('#msgMode').val()) {
				jQuery('#msgMode').attr("checked",true);
			}
		}
		break;
	}
	// 设置各通知类型属性
	for (prop in parseValue) {
		if (prop == 'send') {
			// 接收者选择
			var receiverTypes = parseValue[prop].receiverTypes;
			var receiverArray = document.getElementsByName("sendReceiver");
			for (var i = 0; i < receiverArray.length; i++) {
				if (receiverTypes && receiverTypes.constructor === Array) {
					for (var n = 0; n < receiverTypes.length; n++) {
						if (receiverTypes[n] == receiverArray[i].value) {
							receiverArray[i].checked = true;
						}
					}
				}
			}
		} else if (prop == 'arrive'){
			var smsApproval = parseValue.arrive.smsApproval;
			if (smsApproval == "1") {
				jQuery('#smsApproval').attr("checked",true);
			} else {
				jQuery('#smsApproval').attr("checked",false);
			}
		} else if (prop == 'overdue'){
			var limittimecount = parseValue.overdue.limittimecount;
			if (limittimecount) {
				jQuery('#limittimecount').val(limittimecount);
			}
			var timeunit = parseValue.overdue.timeunit;
			if (timeunit) {
				jQuery('#timeunit').val(timeunit);
			}
			var isnotifysuperior = parseValue.overdue.isnotifysuperior;
			if (isnotifysuperior) {
				jQuery('#isnotifysuperior').attr("checked",true);
			}
		} else if (prop == 'reject'){
			var responsibleType = parseValue.reject.responsibleType;
			if (responsibleType) {
				jQuery('#responsibleType').val(responsibleType);
			}
		}
		// 通知类型选择
		jQuery("#"+ prop + 'Type').attr("checked",true);
		
		// 设置模板
		if (parseValue[prop].template) {
			jQuery("#"+ prop + 'Template').val(parseValue[prop].template);
		}
	}
}

function getJsonValue(sendModeCodes, id) {
	if (sendModeCodes && sendModeCodes.length > 0) {
		for (var i = 0; i < sendModeCodes.length; i++) {
			var el = jQuery("#"+ id);
			if (el && sendModeCodes[i] == el.val()) {
				el.attr("checked",true);
			}
		}
	}
}
// 删除最后一个逗号
function deleteBlank(b) {
	var rnt = "";
	var rntValue = "";
	rnt = b.substring(b.length - 1, b.length - 2);
	if (rnt == ",") {
		rntValue = b.substring(b, b.length - 2);
		rntValue += "}";
	} else {
		rntValue = b;
	}
	return rntValue;
}