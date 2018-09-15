/**
 * 电子签章操作
 * 
 */
function SignatureBtn(actId,params) {
	this.actId = actId;
	this.params = params;
	this.actType = 28;
	
	
	if(typeof SignatureBtn._initialized == "undefined"){
		
		/**
		 * 获取执行前操作提交到后台的参数
		 */
		SignatureBtn.prototype.getBeforePostData = function(){
			var fields = Activity.makeAllFieldAble();
			jQuery("input[moduleType='surveyField']").obpmSurveyField("getValue");
			var data = jQuery("#document_content").serialize();
			Activity.setFieldDisabled(fields);
			return data;
		}
		
		/**
		 * 获取执行操作提交到后台的参数
		 */
		SignatureBtn.prototype.getActionPostData = function(){
			var fields = Activity.makeAllFieldAble();
			jQuery("input[moduleType='surveyField']").obpmSurveyField("getValue");
			var data = jQuery("#document_content").serialize();
			Activity.setFieldDisabled(fields);
			return data;
		}
		/**
		 * 按钮动作执行前的准备与校验操作
		 *（返回true时继续执行操作，返回false时停止当前操作）
		 */
		SignatureBtn.prototype.doBefore = function(){
			if(getBrowser().indexOf("ie") < 0) {
				alert("电子印章功能仅支持IE内核的浏览器!");
				return;
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

			var url = document.getElementById("mGetDocumentUrl").value;
			var mLoginname = document.getElementById("mLoginname").value;
			var docid = document.getElementsByName("content.id")[0].value;
			var formid = document.getElementsByName("formid")[0].value;
			var applicationid = document.getElementsByName("applicationid")[0].value;
			url = url + "?_docid=" + docid + "&_formid=" + formid + "&_applicationid="
					+ applicationid;
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
					if (document_content.SignatureControl != null) {
						document_content.SignatureControl.FieldsList = fildsList; // 所保护字段
						document_content.SignatureControl.Position(460, 260); // 签章位置，屏幕坐标
						document_content.SignatureControl.UserName = "lyj"; // 文件版签章用户
						document_content.SignatureControl.DivId="contentTable"; //设置签章显示位置
						document_content.SignatureControl.RunSignature(); // 执行签章操作
					} else {
						alert("请安装金格iSignature电子签章HTML版软件");
						document.getElementById("hreftest").click();
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
		SignatureBtn.prototype.doAction = function(){
			return false;
		}
		
		/**
		 * 按钮动作执行后的业务操作
		 */
		SignatureBtn.prototype.doAfter = function(result){
		}
		
		SignatureBtn._initialized = true;
	
	}
	
	
	
	return this;
}