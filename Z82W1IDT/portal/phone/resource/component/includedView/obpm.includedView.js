(function($){
	$.fn.obpmIncludedView = function(){
		return this.each(function(){
			
			var $curPage = ajaxPage.getCurPage();
			var pageId = $curPage.attr("id");
			
			var $field = jQuery(this);
			var $tabContent = $field.parents(".tabcontent");
			
			var action = $field.attr("action");
			var application = $field.attr("application");
			var divId = $field.attr("divid");
			var fieldId = $field.attr("_fieldid");
			var fixation = $field.attr("fixation");
			var fixationHeight = $field.attr("fixationHeight");
			var getName = $field.attr("getName");
			var getEditMode = ($field.attr("getEditMode") == "true");
			var id = $field.attr("id");
			var isRefreshOnChanged = ($field.attr("isRefreshOnChanged") == "true");
			var isRelate = $field.attr("isRelate");
			var openType = 227;//$field.attr("_opentype");
			var parentId = $field.attr("parentid");
			var userType = ($field.attr("userType") == "true");
			var viewId = $field.attr("_viewid");
			var viewTotalNum = $field.attr("viewTotalNum");

			if(fixation){
				height = "height:" + fixationHeight + ";";
			}else {
				height = "";
			}
			
			if($tabContent.size() > 0){
				var isTab = "true";
				/*var formId = $tabContent.attr("formid");
				var tabVisibleStyle = "";
				if($tabContent.is(":visible")){
					tabVisibleStyle = "display:block;";
				}else{
					tabVisibleStyle = "display:none;";
				}*/
			}else{
				var isTab = "false";
			}		

			var url = "";
			if(userType){
				url = "../dynaform/view/preView.action?application=" + application + "&_skinType=" + $field.attr("skinType") + "";
			}else{
				url = "../dynaform/view/" + action + "?application=" + application + "";
			}
			url+="&_viewid=" + viewId + "";
			url+="&_fieldid=" + fieldId + "";
			url+="&_opentype=" + openType + "";
			url+="&parentid=" + parentId + "";
			url+="&isRelate=" + isRelate + "";
			url+="&divid=" + divId + "";
			url+="&_from=includedView";

			if(getEditMode){
				url+="&isedit=false";
			}
			
			if(isRefreshOnChanged){
				url+="&refreshparent=true";
			}

			var data = {
				id : fieldId,
				isRelate : isRelate,
				url : url,
				istab : isTab,
				name : getName,
				fixation : fixation,
				userType : userType,
				height : height,
				isRefreshOnChanged : isRefreshOnChanged,
				fixationHeight : fixationHeight,
				viewTotalNum : viewTotalNum
			};

			var $html = $(template("included-tmpl", data));

			$html.on({
				'load.obpm.includedView': function (e) {
					var $this = $(e.target);
					var url = $this.attr("src");
					var title = $this.attr("getname");
					var id = $this.attr("id");
					var $curPage = ajaxPage.getCurPage();
					var curPageId = $curPage.attr("id");
					var newUrl = url + "&parentForm=" + curPageId;
					
					if(isRefreshOnChanged){
						$this.attr("refresh","true");
					}
					
					
					ajaxPage.getDisplayViewHash(newUrl,id);
				},
				'refresh.obpm.includedView': function (e) {
					if(isRefreshOnChanged){
						var $this = $(e.target);
						var id = $this.attr("id");
						dy_refresh(id);
					}
				},
				'click': function(e){
					$(this).includedView("load");
				}
			}).includedView(data);

			$field.before($html);
			$field.remove();
		})
	};
})(jQuery);