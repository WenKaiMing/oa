(function($){
	$.fn.obpmIncludedView = function(){
		return this.each(function(){
			var $field = jQuery(this);
			var id = $field.attr("id");
			var isRefreshOnChanged = $field.attr("isRefreshOnChanged");
			var getName = $field.attr("getName");
			var userType = $field.attr("userType");
			var action = $field.attr("action");
			var application = $field.attr("application");
			var _viewid = $field.attr("_viewid");
			var _fieldid = $field.attr("_fieldid");
			var _opentype = $field.attr("_opentype");
			var isRelate = $field.attr("isRelate");
			var parentid = $field.attr("parentid");
			var divid = $field.attr("divid");
			var getEditMode = $field.attr("getEditMode");
			var fixation = $field.attr("fixation");
			var fixationHeight = $field.attr("fixationHeight");
			var height = "";
			if(fixation){
				height = "height:" + fixationHeight + ";";
			}else {
				height = "height:"+(window.outerHeight/2)+"px;";
			}
			userType = (userType == "true");
			getEditMode = (getEditMode == "true");
			isRefreshOnChanged = (isRefreshOnChanged == "true");
			var html="";
			
			if(_opentype==1 || _opentype==277){
				html+="<div id='" + id + "' getName='" + getName + "' fixation='" + fixation + "' fixationHeight='" + fixationHeight 
					+ "' name='display_view' width='100%' height='100%' type='includedView' waterMark='"+divid+"_waterMark'";
				if(userType){
					html+=" _src='../view/preView.action";//改成相对路径 --Jarod
					html+="?application=" + application + "";
					html+="&_skinType=" + $field.attr("skinType") + "";
				}else{
					html+=" _src='../view/";
					html+="" + action + "";
					html+="?application=" + application + "";//改成相对路径 --Jarod
				}
				html+="&_viewid=" + _viewid + "";
				html+="&_fieldid=" + _fieldid + "";
				html+="&_opentype=" + _opentype + "";
				html+="&parentid=" + parentid + "";
				html+="&isRelate=" + isRelate + "";
				html+="&divid=" + divid + "";
				if(getEditMode){
					html+="&isedit=false";
				}
				if(isRefreshOnChanged){
					html+="&refreshparent=true";
				}
				html+="'";
				html+=" isRefreshOnChanged='" + isRefreshOnChanged + "'";
				html+=" style='" + height + "overflow:auto;'></div>";
				$field.attr("moduleType","IncludedView_backup");
				var $htmlP = $(html);
				
				$.ajax({
					type : 'POST',
					url : $htmlP.attr("_src"),
					async : false,
					dataType : 'html',
					data : {},
					context : $htmlP,
					success : function(html){
						var $html = $("<div></div>").append(html);
						var $form = $html.find("form");
						var viewid = _viewid + "_params";
						var $viewDiv = $("<div></div>").attr("id",viewid).attr("_action",$form.attr("action")).css("display","none");
						//表单元素转成span标签存入dom中
						$.each($form.serializeArray(),function(){
							$viewDiv.append("<span name='" + this.name + "'>" + this.value + "</span>"); 
						});
						$(this).append($viewDiv);
						//去掉表单元素
						$form.find("input[type!=button],select,textarea").not("input[name='_jumppage']").each(function(){
							if(!$(this).attr("moduleType")) $(this).remove();
						});
						//保留form中元素并去掉form
						$form.after($form.html()).remove();
						//插入dom中
						$(this).append($html.html()).insertAfter($field);
						if(typeof(initDispComm)=='function'){
							initDispComm();	//子视图公用初始化方法
							DisplayView.bindEvent($(this));
							DisplayView.displayWaterMark($(this));	//子视图水印方法
						}
					}
				});
			}else{
				html+="<iframe id='" + id + "' getName='" + getName + "' fixation='" + fixation + "' fixationHeight='" + fixationHeight 
				+ "' name='display_view' width='100%' height='100%' frameborder='0' ";
				if(userType){
					html+=" src='../view/preView.action";//改成相对路径 --Jarod
					html+="?application=" + application + "";
					html+="&_skinType=" + $field.attr("skinType") + "";
				}else{
					html+=" src='../view/";
					html+="" + action + "";
					html+="?application=" + application + "";//改成相对路径 --Jarod
				}
				html+="&_viewid=" + _viewid + "";
				html+="&_fieldid=" + _fieldid + "";
				html+="&_opentype=" + _opentype + "";
				html+="&parentid=" + parentid + "";
				html+="&isRelate=" + isRelate + "";
				html+="&divid=" + divid + "";
				if(getEditMode){
					html+="&isedit=false";
				}
				if(isRefreshOnChanged){
					html+="&refreshparent=true";
				}
				html+="'";
				html+=" isRefreshOnChanged='" + isRefreshOnChanged + "'";
				html+=" style='" + height + "overflow:auto;'></iframe>";


				var pNode = this.parentNode;
				pNode.innerHTML = html;

				jQuery(pNode).find("iframe").bind("save",function(){
					var iframe = this;
					win = iframe.contentWindow || iframe.contentDocument.parentWindow;
					if (win && win.doSave) win.doSave();
				});

				
				if(isRefreshOnChanged){
					function bindOnloaEvent(){
						var $iframe = jQuery("#"+ id );
						var name = $iframe.attr("getName");
						if($iframe[0].contentWindow.document.readyState == "complete"){
							setTimeout(function(){
								$iframe.unbind("load");
								$iframe.bind("load",function(){
									dy_refresh(name);
								});
							},500);
						}else{
							setTimeout(function(){
								bindOnloaEvent();
							},500);
						}
					}
					setTimeout(function(){
						bindOnloaEvent();
					},500);
				}
				
			}
		});
	};
})(jQuery);
