// 保存form里的所有原始属性
var alSavedElements = new Array();
// 是否判断form的属性改变，true判断，false不判断
var bCheckForm = true;

/**
 * 页面加载时候的操作，所有页面加载时的操作可以在这里进行扩展
 * 
 * @param form
 *            所要保存属性的form
 */
function saveElementsOnLoad(form) {

	saveFormElements(form);
}

/**
 * 离开页面时的操作，所有离开页面前的操作可在这里进行扩展
 * 
 * @param form
 *            所要保存属性的form
 * @param elements
 *            所保存的属性的数组
 * @return 离开页面的提示信息
 */
function checkFormOnUnload(form) {
	var bFormStatus = isFormChanged(form);
	if (bCheckForm && bFormStatus) {
		return "该页面已经被修改，离开后所有修改全部丢失！";
	}
	return;
}

/**
 * 保存form的所有属性
 * 
 * @param form
 *            所要保存的属性的form
 */
function saveFormElements(form) {
	for (var i = 0; i < form.elements.length; i++) {
		if ("select-one" == form.elements[i].type) {
			alSavedElements.push(form.elements[i].selectedIndex);
			continue;
		}
		if ("radio" == form.elements[i].type
				|| "checkbox" == form.elements[i].type) {
			alSavedElements.push(form.elements[i].checked);
			continue;
		}
		alSavedElements.push(form.elements[i].value);
	}
}
/**
 * 检查form的属性是否改变
 * 
 * @param form
 *            所比较的form
 * @param alSavedElements
 *            所比较的原始属性数组
 * @return true form已变化 false form没变化
 */
function isFormChanged(form) {
	var bChanged = false;
	// alert(form.elements.length +"====="+ alSavedElements.length);
	if (form.elements.length != alSavedElements.length) {
		bChanged = true;
		return bChanged;
	}
	for (var i = 0; i < form.elements.length; i++) {
		/*
		 * if ("submit" != form.elements[i].type && "button" !=
		 * form.elements[i].type && "reset" != form.elements[i].type && "hidden" !=
		 * form.elements[i].type && "radio" != form.elements[i].type &&
		 * "checkbox" != form.elements[i].type && "select-one" !=
		 * form.elements[i].type && form.elements[i].value !=
		 * alSavedElements[i]) { bChanged = true; break; }
		 */
		if ("text" == form.elements[i].type
				&& form.elements[i].type != "hidden") {
			if (form.elements[i].value != '') {
				bChanged = true;
				break;
			}
		}
		if ("hidden" == form.elements[i].type
				&& form.elements[i].title == 'optionSelect') {
			if (form.elements[i].value != '') {
				bChanged = true;
				break;
			}
		}
		if (("radio" == form.elements[i].type || "checkbox" == form.elements[i].type)
				&& form.elements[i].type != "hidden") {
			// alert(form.elements[i].checked);
			if (form.elements[i].checked) {
				bChanged = true;
				break;
			}
		}
		if (("textarea" == form.elements[i].type)
				&& form.elements[i].style.display != "none") {
			if (form.elements[i].value != '') {
				bChanged = true;
				break;
			}
		}
	}
	return bChanged;
}

/**
 * 忽略form改变检查 说明：该函数调用后即使form改变也不做离开页面的提示
 */
function ignoreFormCheck() {
	bCheckForm = false;
}

/**
 * 强制进行form改变检查 说明：该函数调用后无论form是否改变都会提示form已改变，是否离开页面
 */
function forceFormCheck() {
	bCheckForm = true;
}

/**
 * 返回form的当前状态 说明：用户可以通过该状态决定程序的流程走向
 * 
 * @param form
 *            所检查的form对象
 * @return ture form改变，true form没改变
 */
function getFormStatus(form) {
	return isFormChanged(form);
}
