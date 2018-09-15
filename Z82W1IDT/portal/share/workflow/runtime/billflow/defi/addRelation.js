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