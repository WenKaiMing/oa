/**
  * 重载DWR方法
  */
DWRUtil.getValue = function(ele, options) {
  if (options == null) {
    options = {};
  }
  
  var orig = ele;
  ele = document.getElementById(ele);
  // We can work with names and need to sometimes for radio buttons, and IE has
  // an annoying bug where
  var nodes = document.getElementsByName(orig);
  if (ele == null && nodes.length >= 1) {
    ele = nodes.item(0);
  }
  if (ele == null) {
    DWRUtil.debug("getValue() can't find an element with id/name: " + orig + ".");
    return "";
  }

  if (DWRUtil._isHTMLElement(ele, "select")) {
    // This is a bit of a scam because it assumes single select
    // but I'm not sure how we should treat multi-select.
    var sel = ele.selectedIndex;
    if (sel != -1) {
      var reply = ele.options[sel].value;

      return reply;
    }
    else {
      return "";
    }
  }

  if (DWRUtil._isHTMLElement(ele, "input")) {
    if (ele.type == "radio") {
      var node;
      for (i = 0; i < nodes.length; i++) {
        node = nodes.item(i);
        if (node.type == "radio") {
          if (node.checked) {
            if (nodes.length > 1) return node.value;
            else return true;
          }
        }
      }
    }
    switch (ele.type) {
    case "checkbox":
    case "check-box":
    case "radio":
      return ele.checked;
    default:
      return ele.value;
    }
  }

  if (DWRUtil._isHTMLElement(ele, "textarea")) {
    return ele.value;
  }

  if (options.textContent) {
    if (ele.textContent) return ele.textContent;
    else if (ele.innerText) return ele.innerText;
  }
  return ele.innerHTML;
};

// Class Column
function Column() {
	this.id = null;
	this.orderno = 0;
	this.isOrderByField = null;
	this.orderType = null;
	this.type = null;
	this.showType = '00';
	this.name = null;
	this.multiLanguageLabel = null;
	this.width = null;
	this.valueScript = null;
	this.hiddenScript=null;
	this.formid = null;
	this.fieldName = null;
	this.parentView = null;
	this.imageName = null;
	this.fontColor = null;
	this.flowReturnCss = false;
	this.sum = false;
	this.total = false; //总计
	this.mappingField = null;//映射字段
	this.displayType = '00';//显示方式(默认显示全部)
	this.showTitle = true;//是否显示title(默认显示)
	this.displayLength = '';//显示内容长度(小于0/空字符/null/非数字,显示所有)
	this.buttonType = null;
	this.approveLimit = null;
	this.buttonName = null;
	this.visible = true;
	this.visible4ExpExcel = true;
	this.visible4Print = true;//自定义打印时隐藏值
	this.visible4PagePrint = true;//网页打印时隐藏值
	this.templateForm = null;
	this.icon = null;
	this.actionScript = null;
	this.sortStandard = null;
	this.jumpMapping = null; //操作列跳转类型的配置
	this.mappingform = null; //操作列跳转类型按钮的目标表单id
	this.formatType = null; //格式的类型
	this.decimalsNum = null; //数值的小数位数
	this.thouSign = false; //千位分隔符
	this.decimalsCurr = null; //货币的小数位数
	this.currTyp = null; //货币类型
	this.color = '000000'; //字体颜色
	this.fontSize = '12'; //字体大小
	this.groundColor = 'FFFFFF'; //底色
	this.showIcon = false; //以图标显示
	this.iconMapping = null; //以图标显示的映射关系
}

function doCreate(column) {
	DWREngine.setAsync(false);
	var process = this;
	Sequence.getSequence(function(id) {
				column.id = id;
				column.orderno = process.getMaxOrderNo() + 1;
				column.showType='01';
				/*
				 * for (prop in column) { alert(prop + ": " + column[prop]); }
				 */
				columnCache.push(column);
			});
}
function getMaxOrderNo() {
	var maxOrderNo = 0;
	for (var i = 0; i < columnCache.length; i++) {
		if (!isNaN(columnCache[i].orderno)
				&& columnCache[i].orderno > maxOrderNo) {
			maxOrderNo = columnCache[i].orderno;
		}
	}
	return maxOrderNo;
}

// Parent window's columnCache
var columnCache = [];
// Current edit column
var column;