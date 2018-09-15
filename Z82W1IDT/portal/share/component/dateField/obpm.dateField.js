(function($){
	$.fn.obpmDateField = function(){
		return this.each(function(){
			var $field = jQuery(this);
			var id=$field.attr("_id");
			var name=$field.attr("_name");
			var fieldType=$field.attr("_fieldType");
			var classname=$field.attr("classname");
			var cssclass=$field.attr("_class");
			var limit=$field.attr("limit");
			var value=$field.attr("value");
			var displayType=$field.attr("_displayType");
			var textType=$field.attr("_textType");
			var readOnlyShowValOnly=$field.attr("readOnlyShowValOnly");
			var dateFmt=$field.attr("_dateFmt");
			var getPrevName=$field.attr("_getPrevName");
			var getPrevNameMinDate=$field.attr("_getPrevNameMinDate");
			var skin=$field.attr("_skin");
			var minDate=$field.attr("_minDate");
			var maxDate=$field.attr("_maxDate");
			var noPatternHms=$field.attr("_noPatternHms");
			var isRefreshOnChanged=$field.attr("_isRefreshOnChanged");
			var subGridView = $field.attr("_subGridView");
			var hiddenValue = $field.attr("_hiddenValue");
			var style = $field.attr("style");
			if(style){
				style = style.replace(/"([^"]*)"/g, "$1"); //把样式中包含的双引号全部替换为空，以免在放入style时发生引号冲突导致样式代码段被截断
			}
			
			value = value ? value : "";
			isRefreshOnChanged = (isRefreshOnChanged == "true");
			getPrevName = (getPrevName == "true");
			noPatternHms = (noPatternHms == "true");
			subGridView = (subGridView == "true");

			var html="";
			if(displayType != PermissionType_HIDDEN){
				var otherAttrsHtml = getOtherAttrs($field[0]);//其他属性
				
				function Wdate(){
					//计算最小值
					var $minDateObj = $("#"+getPrevNameMinDate);
					var _minDate = $minDateObj.val();
					var minDateFmt = $minDateObj.attr("dateFmt");

					if(_minDate && _minDate != ""){
						minDate = _minDate;
					}
					if(_minDate == "") minDate="1900-01-01 00:00:00";
					
					//传入的最小值统一格式
					if(minDateFmt == "yyyy" && minDate.length == 4){
						minDate += "-01-01 00:00:00";
					}
					if(minDateFmt == "yyyy-MM" && minDate.length == 7){
						minDate += "-01 00:00:00";
					}
					if(minDateFmt == "yyyy-MM-dd" && minDate.length == 10){
						minDate += " 00:00:00";
					}
					if(minDateFmt == "yyyy-MM-dd HH:mm" && minDate.length == 16){
						minDate += ":00";
					}
					
					//计算最大值
					var $subInput = jQuery("input[min_name='" + id + "']");
					if($subInput.size() > 0){
						var _maxDate = "";
						var _dateName = "";
						$subInput.each(function(){
							var curVal = jQuery(this).val();
							var curName = jQuery(this).attr("name");
							if(curVal != ""){
								var cur_Date = new Date(curVal.replace(/-/g,"\/"));
								var max_Date = new Date(_maxDate.replace(/-/g,"\/"));
								_maxDate = (cur_Date > max_Date)?_maxDate:curVal;
								_dateName = (cur_Date > max_Date)?_dateName:curName;
							}
						});
						maxDate = _maxDate;
						dateName = _dateName;
					}
					
					var now_min_Date = new Date(minDate.replace(/-/g,"\/"));
					var now_max_Date = new Date(maxDate.replace(/-/g,"\/"));
					if(now_min_Date > now_max_Date){
						var starDate = jQuery("#"+getPrevNameMinDate).attr("name");
						alert(starDate +" 不能大于 " + dateName);
						return false;
					}
					if(maxDate == ""){maxDate = "2099-12-31 23:59:59";}

					WdatePicker({dateFmt:dateFmt,
								minDate:noPatternHms?minDate:'1900-01-01 00:00:00',
								maxDate:noPatternHms?maxDate:'2099-12-31 23:59:59',
								skin:skin,
								onpicked:function(dp){
									if (isRefreshOnChanged) {
										subGridView ? dy_view_refresh(this.id):dy_refresh(this.id);
									}
								}
					});
				};
				
				if(textType.toLowerCase()=="hidden" ){
					html+="<input type='hidden'";
				}else{
					html+="<input type='text'";
				}

				html+=" id='" + id + "' value='"+value+"' limit='"+limit+"' name='"+name+"' classname='"+classname+"' fieldType='"+fieldType+"' class='"+cssclass+"'";
				html+=" isRefreshOnChanged='" + isRefreshOnChanged + "' dateFmt='" + dateFmt + "' " + otherAttrsHtml;
				if (displayType == PermissionType_READONLY || textType.toLowerCase() == "readonly" 
					|| displayType == PermissionType_DISABLED ||textType.toLowerCase() == "disabled"
					|| textType.toLowerCase() == "hidden" || displayType == PermissionType_HIDDEN) {
					html += " readonly='readonly'";
				}
				if(style){
					html+=" style='" + style + "'";
				}
				if(getPrevNameMinDate) html += " min_name=\"" + getPrevNameMinDate +"\"";
				html+=" />";
				var $html = $(html);

				if(textType.toLowerCase()=="hidden" || displayType == PermissionType_READONLY || textType.toLowerCase()=="readonly"
					|| displayType == PermissionType_DISABLED){
					if(readOnlyShowValOnly == "true"){
						$html.css("display", "none");
					}
				}
				if(!subGridView){
					$html.bind("blur",function(){
						if(typeof(dateCompareVal)=="function") dateCompareVal(this);	//普通表单时设置表单是否更改
					});
				}
				$html.bind("click",function(){
					Wdate();
				}).replaceAll($field);
				
				if (readOnlyShowValOnly == "true" && (displayType == PermissionType_READONLY || textType.toLowerCase() == "readonly"
					|| displayType == PermissionType_DISABLED)){
					$html.after("<span id='" + name + "_show' >" + value + "</span>");
				}
			}else{
				html += "<input type='hidden' name=\""+name+"\" value=\""+value+"\" /><span>"+ hiddenValue +"</span>" ;
				$(html).replaceAll($field);
			}
		});
	};
})(jQuery);