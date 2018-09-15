(function($){
	$.fn.obpmWordField=function(){
		return this.each(function(){
			var $field = jQuery(this);
			var name = $field.attr("name");
			var id= $field.attr("id");
			var getItemValue = $field.attr("getItemValue");
			var getId = $field.attr("getId");
			var wordid = $field.attr("wordid");
			var getOpenTypeEquals = $field.attr("getOpenTypeEquals");
			var showWord = $field.attr("showWord");
			var secondvalue = $field.attr("secondvalue");
			var docgetId = $field.attr("docgetId");
			var docgetFormname = $field.attr("docgetFormname");
			var openType = $field.attr("openType");
			var displayType = $field.attr("displayType");
			var discript = HTMLDencode($field.attr("discript"));
			var saveable = $field.attr("saveable");
			var isSignature = $field.attr("isSignature");
			var filename = $field.attr("filename");
			var _docid = $field.attr("_docid");
			var _type = $field.attr("_type");
			var fieldname = $field.attr("fieldname");
			var formname = $field.attr("formname");
			var versions = $field.attr("content.versions");
			var application = $field.attr("application");
			var _isEdit = $field.attr("_isEdit");
			var signature = $field.attr("signature");
			var isReadonly = (displayType == PermissionType_READONLY || displayType == PermissionType_DISABLED);
			
			saveable = (saveable == "true");
			isSignature = (isSignature == "true");
			discript = discript? discript : name;
			
			var url = "",
				style = "",
				readonly = "",
				openInDiv = false;
			if(displayType == PermissionType_HIDDEN){
				style = ";display:none;";
			}

			if(openType && openType=="2" || openType=="3"){
				openInDiv = true;
			}
			if(getItemValue && getItemValue !=""){
				secondvalue = getItemValue;
				filename = getItemValue;
			}else{
				getItemValue = wordid;
			}
			if(displayType == PermissionType_READONLY){
				readonly = "readonly";
			}
			if (isReadonly) {
				_isEdit=1;
			}

			url = contextPath + "/portal/dynaform/document/newword.action?id=" + getId
				+ "&filename=" + filename
				+ "&_docid=" + _docid
				+ "&_type=" + _type
				+ "&fieldname=" + fieldname
				+ "&formname=" + formname
				+ "&content.versions=" + versions
				+ "&application=" + application
				+ "&_isEdit=" + _isEdit
				+ "&isSignature=" + isSignature
				+ "&isReadonly=" + isReadonly
				+ "&signature=" + signature;

			var data = {
					id : id,
					name : name,
					getId : getId,
					url : url,
					_isEdit : _isEdit,
					style : style,
					wordid : wordid,
					readonly : readonly,
					isReadonly : isReadonly,
					discript : discript,
					openType : openType,
					getItemValue : getItemValue,
					secondvalue : secondvalue
			};
			var $html = $(template("wordOld-tmpl", data));
			if(openInDiv){
				$html.find("button").bind("click",function(){
					showWordDialog(showWord,
							'WordControl',
							docgetId,
							docgetFormname,
							secondvalue,
							id,
							'content.versions',
							openType,
							displayType,
							saveable,
							isReadonly,
							signature,
							(isSignature?true:false));
				})
			}
			$html.replaceAll($field);
		});
	};
	
})(jQuery);