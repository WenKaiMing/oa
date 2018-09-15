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
			var readOnlyShowValOnly = $field.attr("readOnlyShowValOnly");
			var textType=$field.attr("_textType");
			var dateFmt=$field.attr("_dateFmt");
			var getPrevName=$field.attr("_getPrevName");
			var getPrevNameMinDate=$field.attr("_getPrevNameMinDate");
			var skin=$field.attr("_skin");
			var minDate=$field.attr("_minDate");
			var maxDate=$field.attr("_maxDate");
			var noPatternHms=$field.attr("_noPatternHms");
			var isRefresh=$field.attr("_isRefreshOnChanged");
			var subGridView = $field.attr("_subGridView");
			var hiddenValue = $field.attr("_hiddenValue");
			var layoutType = $field.attr("_layoutType");
			var discript = HTMLDencode($field.attr("_discript"));
			var dateFormat, timeFormat, onBeforeShow;
			var horizontalClass = "",
			value = value ? value : "";
			discript = discript? discript : name;
			
			if(layoutType == LayoutType_Horizontal){
				horizontalClass = "flexbox";
			}
			//按mobiscroll日期格式调整数据
			if(dateFmt == "yyyy" && dateFmt.length == 4){
				dateFormat = "yy";
				timeFormat = "";
				onBeforeShow = function (inst) {
					ajaxPage.addHashPostfix("dateControls");
					inst.settings.wheels[0].length=1;
					inst.settings.wheels[1].length=0;
				}
			}
			if(dateFmt == "yyyy-MM" && dateFmt.length == 7){
				dateFormat = "yy-mm";
				timeFormat = "";
				onBeforeShow = function (inst) {
					ajaxPage.addHashPostfix("dateControls");
					inst.settings.wheels[0].length=2;
					inst.settings.wheels[1].length=0;
					
				}
			}
			if(dateFmt == "yyyy-MM-dd" && dateFmt.length == 10){
				dateFormat = "yy-mm-dd";
				timeFormat = "";
				onBeforeShow = function (inst) { 
					ajaxPage.addHashPostfix("dateControls");
					inst.settings.wheels[0].length=3;
					inst.settings.wheels[1].length=0;
	            }
			}
			if(dateFmt == "yyyy-MM-dd HH:mm" && dateFmt.length == 16){
				dateFormat = "yy-mm-dd";
				timeFormat = "HH:ii";
				onBeforeShow = function (inst) { 
					ajaxPage.addHashPostfix("dateControls");
					inst.settings.wheels[0].length=3;
					inst.settings.wheels[1].length=2;
				}
			}
			if(dateFmt == "yyyy-MM-dd HH:mm:ss" && dateFmt.length == 19){
				dateFormat = "yy-mm-dd";
				timeFormat = "HH:ii:ss";
				onBeforeShow = function (inst) { 
					ajaxPage.addHashPostfix("dateControls");
					inst.settings.wheels[0].length=3;
					inst.settings.wheels[1].length=2;
				}
			}
			if(dateFmt == "HH:mm:ss" && dateFmt.length == 8){
				dateFormat = "";
				timeFormat = "HH:ii:ss";
				onBeforeShow = function (inst) {
					ajaxPage.addHashPostfix("dateControls");
				}
			}
			
			isRefresh = (isRefresh == "true");
			getPrevName = (getPrevName == "true");
			noPatternHms = (noPatternHms == "true");
			subGridView = (subGridView == "true");

			var otherAttrsHtml = getOtherAttrs($field[0]);//其他属性
			
			function Wdate($dataField){
				//计算最小值 
				var $minDateObj = $("#"+getPrevNameMinDate);
				var _minDate = $minDateObj.val();
				var minDateFmt = $minDateObj.attr("dateFmt");

				if(_minDate && _minDate != ""){
					minDate = _minDate;
				}
				if(!_minDate || _minDate == "") minDate="1900-01-01 00:00:00";
				
				//传入的最小值统一格式
				if(minDateFmt == "yyyy" && trim(minDate).length == 4){
					minDate = trim(minDate)+"-01-01 00:00:00";
				}
				if(minDateFmt == "yyyy-MM" && trim(minDate).length == 7){
					minDate = trim(minDate)+"-01 00:00:00";
				}
				if(minDateFmt == "yyyy-MM-dd" && trim(minDate).length == 10){
					minDate = trim(minDate)+" 00:00:00";
				}
				if(minDateFmt == "yyyy-MM-dd HH:mm" && trim(minDate).length == 16){
					minDate = trim(minDate)+":00";
				}
				if(minDateFmt == "HH:mm:ss" && trim(minDate).length == 8){
					minDate = "1900-01-01 "+minDate;
				}
				
				
				//计算最大值
				var $subInput = jQuery("input[min_name='" + id + "']");
				var maxDateFmt = $subInput.attr("dateFmt");
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
					_maxDate
					maxDate = _maxDate;
					dateName = _dateName;
				}
				if(!maxDate || maxDate == ""){maxDate = "2099-12-31 23:59:59";}
				
				//传入的最大值统一格式
				if(maxDateFmt == "yyyy" && trim(maxDate).length == 4){
					maxDate = trim(maxDate)+"-01-01 00:00:00";
				}
				if(maxDateFmt == "yyyy-MM" && trim(maxDate).length == 7){
					maxDate = trim(maxDate)+"-01 00:00:00";
				}
				if(maxDateFmt == "yyyy-MM-dd" && trim(maxDate).length == 10){
					maxDate = trim(maxDate)+" 00:00:00";
				}
				if(maxDateFmt == "yyyy-MM-dd HH:mm" && trim(maxDate).length == 16){
					maxDate = trim(maxDate)+":00";
				}
				if(maxDateFmt == "HH:mm:ss" && trim(maxDate).length == 8){
					maxDate = "0000-00-00 "+maxDate;
				}
				
				var now_min_Date = new Date(minDate.replace(/-/g,"\/"));
				var now_max_Date = new Date(maxDate.replace(/-/g,"\/"));
				if(now_min_Date > now_max_Date){
					var starDate = jQuery("#"+getPrevNameMinDate).attr("name");
					alert(starDate +" 不能大于 " + dateName);
					return false;
				}
				
				//ios[xxxx-xx-xx]格式不识别 转时间格式为[xxxx,xx,xx] -- 20151126 by tank 
				var maxarr = maxDate.split(/[- :]/); 
				msMaxDate = new Date(maxarr[0], maxarr[1]-1, maxarr[2], maxarr[3], maxarr[4], maxarr[5]);
				var minarr = minDate.split(/[- :]/); 
				msMinDate = new Date(minarr[0], minarr[1]-1, minarr[2], minarr[3], minarr[4], minarr[5]);
				
				
				
				if(dateFmt == "HH:mm:ss" && dateFmt.length == 8){
					$dataField.unbind().mobiscroll().time({
					    timeFormat: timeFormat,
		                theme: 'ios', 
		                mode: 'mixed', 
		                display: 'bottom',
		                lang: 'zh', 
		                minDate: msMinDate?msMinDate:null,
				        maxDate: msMaxDate?msMaxDate:null,
				        stepMinute: 5 , 
		                onBeforeShow: onBeforeShow,
		                onSelect : function(){
		                	$dataField.unbind().bind("click",function(){
		                		Wdate(jQuery(this));
		                	});
		                },
		                onClose : function(){
		                	ajaxPage.clearHashPostfix("dateControls");
		                }
					}).trigger("click");
				}else{
					$dataField.unbind().mobiscroll().datetime({
						dateFormat: dateFormat,
					    timeFormat: timeFormat,
		                theme: 'ios', 
		                buttons: ['set','clear','cancel'],
		                clearText: '清除',
		                mode: 'mixed',  
		                display: 'bottom', 
		                lang: 'zh', 
		                minDate: msMinDate?msMinDate:null,
		                maxDate: msMaxDate?msMaxDate:null, 
		                stepMinute: 5 ,
		                onBeforeShow:  onBeforeShow,
		                onSelect : function(){
		                	$dataField.unbind().bind("click",function(){
		                		Wdate(jQuery(this));
		                	});
		                },
		                onClose : function(){
		                	ajaxPage.clearHashPostfix("dateControls");
		                }
					}).trigger("click");
				}
			
				return $dataField.bind("change",function(){
                	if (isRefresh) {
						subGridView ? dy_view_refresh($(this).attr("id")):dy_refresh($(this).attr("id"));
					}
                });
			};
			
			var readonly = "",
				hideText = "",
				style = "",
				isReadOnlyShowValOnly = false;

			getPrevNameMinDate = getPrevNameMinDate ? getPrevNameMinDate : "";
			if(textType.toLowerCase()=="hidden" || displayType == PermissionType_HIDDEN){
				hideText = ";display:none;";
			}else{	//不是隐藏状态时置空隐藏时显示值
				hiddenValue = '';
			}

			if(displayType == PermissionType_READONLY || textType.toLowerCase()=="readonly" || displayType == PermissionType_DISABLED){
				readonly = "readonly";
				if(readOnlyShowValOnly == "true"){
					style = ";display:none;";
					isReadOnlyShowValOnly = true;
				}
			}
			
			var data = {
					id : id,
					limit : limit,
					name : name,
					discript : discript,
					minName : getPrevNameMinDate,
					value : value,
					hideText : hideText,
					style : style,
					dateFmt : dateFmt,
					isRefresh : isRefresh,
					readonly : readonly,
					cssclass : cssclass,
					fieldType : fieldType,
					otherAttrsHtml : otherAttrsHtml,
					isReadOnlyShowValOnly : isReadOnlyShowValOnly,
					horizontalClass : horizontalClass,
					hiddenValue : hiddenValue
			};

			var $html = $(template("date-tmpl", data));
			if(readonly != "readonly"){
				$html.find("input").bind("click", function(){
					Wdate($(this));
				});
				if(!subGridView){
					$html.find("input").bind("blur",function(){
						if(typeof(dateCompareVal)=="function") dateCompareVal(this);	//普通表单时设置表单是否更改
					});
				}
			}
			
			$html.replaceAll($field);
		});
	};
})(jQuery);