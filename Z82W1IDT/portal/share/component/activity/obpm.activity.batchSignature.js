/**
 * 批量签章操作
 * 
 */
function BatchSignatureBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 29;
	
	
	if(typeof BatchSignatureBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		BatchSignatureBtn.prototype.getBeforePostData = function(){
			if(typeof DisplayView == 'object' && DisplayView.getTheView(this.target)){
				var view = DisplayView.getTheView(this.target);
				var json = DisplayView.span2Json(this.target);
				var elems = $(view).find("[name=_selects]:checked");
				return DisplayView.addVal2Params(json,elems);
			}else{
				return jQuery(document.forms[0]).serialize();
			};
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		BatchSignatureBtn.prototype.getActionPostData = function(){
			if(typeof DisplayView == 'object' && DisplayView.getTheView(this.target)){
				var view = DisplayView.getTheView(this.target);
				var json = DisplayView.span2Json(this.target);
				var elems = $(view).find("[name=_selects]:checked");
				return DisplayView.addVal2Params(json,elems);
			}else{
				return jQuery(document.forms[0]).serialize();
			};
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		BatchSignatureBtn.prototype.doBefore = function(){
			if(navigator.userAgent.indexOf("MSIE")<0){
				alert("金格iSignature电子签章HTML版只支持IE，如果要签章请用IE浏览器");
				return;
			}
			var mLength = document.getElementsByName("_selects").length;
			var vItem;
			var DocumentList = "";
			for (var i = 0; i < mLength; i++) {
				vItem = document.getElementsByName("_selects")[i];
				if (vItem.checked) {
					if (i != mLength - 1) {
						DocumentList = DocumentList + vItem.value + ";";
					} else {
						DocumentList = DocumentList + vItem.value;
					}
				}
			}
			var ajax = null;
			if (window.ActiveXObject) {
				try {
					ajax = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {
					alert("创建Microsoft.XMLHTTP对象失败,AJAX不能正常运行.请检查您的浏览器设置.");
				}
			} else {
				if (window.XMLHttpRequest) {
					try {
						ajax = new XMLHttpRequest();
					} catch (e) {
						alert("创建XMLHttpRequest对象失败,AJAX不能正常运行.请检查您的浏览器设置.");
					}
				}
			}

			var url = document.getElementById("mGetBatchDocumentUrl").value;
			var mLoginname = document.getElementById("mLoginname").value;
			var DocumentID = document.getElementById("DocumentID").value;
			var ApplicationID = document.getElementById("ApplicationID").value
			var FormID = document.getElementById("FormID").value
			url = url + "?DocumentID=" + DocumentID + "&ApplicationID2="
					+ ApplicationID + "&FormID2=" + FormID;

			ajax.onreadystatechange = function() {
				if (ajax.readyState == 4 && ajax.status == 200) {
					if (ajax.responseText == "false") {
						return;
					}
					var documentName = ajax.responseText.split(',');
					var fildsList = "";
					for (var i = 0; i < documentName.length; i++) {
						if (i != documentName.length - 1) {
							fildsList = fildsList
									+ (documentName[i] + "=" + documentName[i] + ";");
						} else {
							fildsList = fildsList
									+ (documentName[i] + "=" + documentName[i]);
						}
					}
					if (formList.SignatureControl != null) {
						if (DocumentList == "") {
							alert("请选择需要签章的文档。");
						}
						formList.SignatureControl.FieldsList = fildsList; // 所保护字段
						formList.SignatureControl.Position(460, 275); // 签章位置
						formList.SignatureControl.DocumentList = DocumentList; // 签章页面ID
						formList.SignatureControl.WebSetFontOther("True", "同意通过", "0",
								"宋体", "11", "000128", "True"); // 默认签章附加信息及字体,具体参数信息参阅技术白皮书
						formList.SignatureControl.SaveHistory = "false"; // 是否自动保存历史记录,true保存
						formList.SignatureControl.UserName = "lyj"; // 文件版签章用户
						formList.SignatureControl.WebCancelOrder = 0; // 签章撤消原则设置,
						// 0无顺序 1先进后出
						// 2先进先出 默认值0
						// formList.SignatureControl.DivId = "contentTable"; //签章所在层
						formList.SignatureControl.AutoCloseBatchWindow = true;
						formList.SignatureControl.RunBatchSignature();
					} else {
						alert("请安装金格iSignature电子签章HTML版软件");
						document.getElementById("hreftest2").click();
					}
				}
			};
			ajax.open("POST", url);
			ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			ajax.send(null);
			return false;
		}
		/**
		 * 按钮动作时执行的业务操作
		 */
		BatchSignatureBtn.prototype.doAction = function(){
			return false;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		BatchSignatureBtn.prototype.doAfter = function(result){
		}
		
		BatchSignatureBtn._initialized = true;
	
	}
	
	
	
	return this;
}