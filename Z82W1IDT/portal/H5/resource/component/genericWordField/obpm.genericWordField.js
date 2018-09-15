;
/**
 * 通用word控件
 * @author Happy
 * @param $
 */
(function($){
	
	/**
	 * 通用word控件初始化
	 */
	function _init(t){
		
		var options = _parseOptions(t);
		var panle;
		if(options.displayType != PermissionType_HIDDEN){
			if(options.openType && options.openType=="3"){   //弹出层显示
				var html = [];
				html.push('<div  id="genericWordField_map_container_'+options.id+'"></div>');
				panel = $(html.join(""));
				panel.insertAfter(t);
				_openWordByPopUp(options,panel);
				return panel;
			
			}else{ //嵌入式显示
				var html = [];
				var style = resize(options);
				html.push('<div style="'+ style+ '" id="genericWordField_map_container_'+options.id+'"></div>');
				panel = $(html.join(""));
				panel.insertAfter(t);
				_openWordByEmbeded(options,panel);
				return panel;
			}
		}
	}
	/**
	 *嵌入式打开文档 
	 */
	function  _openWordByEmbeded(options,panel){
		var url ="../../share/common/preview/preview.jsp";
			url+="?applicationId=" + options.application + "";
			url+="&path="+options.fullPath +"";
			url+="&name="+options.fileName +"";
			url+="&showName="+options.showName +"";
			url+="&fileType="+ ".doc" +"";
			url+="&isOpenCloseBtn=false";
			url+="&isShowDocName=false";
			url+="&curEditUserId="+WebUser.id;
			url+="&action="+options.action;
			var html = "";
			html+="<iframe fieldName='" + options.name + "' id='" + options.id + "' ";
			html+=" name='word' frameborder='0' width='100%' height='100%' scrolling='no' style='overflow:visible;z-index:1px;' _type='word' ";
			html+=" src='" + url + "'";
			html+=" ></iframe>";
			panel.append(html);
	}
	
	/**
	 *弹出层打开文档 
	 */
	function  _openWordByPopUp(options,panel){
			var html = "";
			html+="<input type='hidden' fieldName='" + options.name + "' id='" + options.id + "' value='" + options.getItemValue + "' />";
			html+="<button class='button-class' type='button'";
			html+=">";
			html+=" <img src='../../share/images/view/genericword.jpg'></img>";
			html+="</button>";
			panel.append(html);
			
				$(panel).find("button").bind("click",function(){
					var url ="../share/common/preview/preview.jsp";
					url+="?applicationId=" + options.application + "";
					url+="&path="+options.fullPath +"";
					url+="&name="+options.fileName +"";
					url+="&showName="+options.showName +"";
					url+="&fileType="+ ".doc" +"";
					url+="&isOpenCloseBtn=false";
					url+="&isShowDocName=false";
					url+="&curEditUserId="+WebUser.id;
				if(options.displayType == PermissionType_READONLY){ //只读状态
					url+="&action=readOnly";
				}else{
					url+="&action="+options.action+"";
				}
				showGenericWordDialog("word编辑对话框",url);
					})
	}
	
	/**
	 * 事件绑定
	 */
	function _bindEvents(t){
		var panel = t.data("genericWordField").panel;
		panel.find(".refresh").on("click",function(e){
			e.preventDefault();
			e.stopPropagation();
			panel.find(".address-text").html(" &nbsp;");
			getLocation(t);
		});
		panel.find(".location").on("click",function(e){
			e.preventDefault();
			e.stopPropagation();
			openLocation(t);
		});
	}
	
	/**
	 * 解析gps控件设置参数
	 */
	function _parseOptions(t){
		var options = {}
		options.id= t.attr("id");
		options.name = t.attr("name");
		options.value= t.data("itemValue");
		options.formName = t.data("formName");
		options.docId = t.data("docId");
		options.fieldId = t.data("fieldId");
		options.openType = t.data("openType");
		options.displayType = t.data("displayType");
		options.saveable = t.data("saveable") == "true";
		options.isSignature = t.data("isSignature") == "true";
		options.applicationId = t.data("application");
		options.fullPath = t.data("fullPath");
		options.fileName = t.data("fileName");
		options.showName = t.data("showName");
		options.fileType = t.data("fileType");
		options.action = t.data("action");
		return options;
	}
	
	$.fn.obpmGenericWordField = function(options, param){
		if(typeof options=="string"){
			return $.fn.obpmGenericWordField.method[options](this,param);
		}
		options = options || {};
		return this.each(function(){
			var t = $(this);
			var state = t.data("genericWordField");
			if(state){
				$.extend(state.options,options);
			}else{
				var r =_init(t);
				state = t.data('genericWordField', {
					options: $.extend({}, $.fn.obpmGenericWordField.defaults, _parseOptions(t), options),
					panel: r
				});
				_bindEvents(t);
			}
		});
	},
	
	$.fn.obpmGenericWordField.defaults = {
			id:'',
			name:undefined
	},
	
	$.fn.obpmGenericWordField.method= {
			
		setValue:function(jq,value){
			
		},
		getValue:function(jq){
		}
	}
	
	//通用word编辑器文本对话框
	function showGenericWordDialog(title, url) {
		wx = '900px';
		wy = '600px';
			OBPM.dialog.show({
						width : 1200,
						height : 600,
						url : url,
						title : title,
						close : function(result) {
						}
					});
	}
	
	
	function resize(options){
		//获取高度
		var parentElem = "#"+ options.fieldId + "_divid";
		var $parentElem = $(parentElem).parent();
		var width = "1000px";
		var height = "500px";
		try{
			width = $parentElem.width()+'px';
			height = $parentElem.height()+'px';
		}catch(e){
			
		}
		var style = "width:"+width+";height:"+height+";min-width:1000px;min-height:500px;overflow:auto";
		return  style;
	}
	
})(jQuery);
