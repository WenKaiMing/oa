var ErpCommon = {
        browserRedirect : function() {
        	var rtn = "";
            var sUserAgent = navigator.userAgent.toLowerCase();
            var bIsIpad = sUserAgent.match(/ipad/i) == "ipad";
            var bIsIphoneOs = sUserAgent.match(/iphone os/i) == "iphone os";
            var bIsMidp = sUserAgent.match(/midp/i) == "midp";
            var bIsUc7 = sUserAgent.match(/rv:1.2.3.4/i) == "rv:1.2.3.4";
            var bIsUc = sUserAgent.match(/ucweb/i) == "ucweb";
            var bIsAndroid = sUserAgent.match(/android/i) == "android";
            var bIsCE = sUserAgent.match(/windows ce/i) == "windows ce";
            var bIsWM = sUserAgent.match(/windows mobile/i) == "windows mobile";
            
            if (bIsIpad || bIsIphoneOs || bIsMidp || bIsUc7 || bIsUc || bIsAndroid || bIsCE || bIsWM) {
            	rtn = "phone";
            } else {
            	rtn = "pc";
            }
            return rtn;
        },

		/**
		 * 加载查询表单的供应商、部门、业务员、客户
		 */
		loadOptions : function(){

			$("select[stype=_default]").each(function(){
				var $this = $(this);
				var name = $this.attr("name");
				var _value = $this.attr("_value");
//				console.info("_value-->" + _value);
				
				var url = "../optionsData.jsp?name="+name;
				$.ajax({
					url : url,
					async : false,
					type : 'post',
					dataType : 'json',
					success : function(json){
						$(".form-"+name).find("option").not("[value='']").remove();
						if(json){
							var _option = "";
							
							$.each(json,function(i,key){
								var code = "";
								if(key.VENDORNO){
									code = " vendorcode='" + key.VENDORNO + "' ";
								}
								
								if(key.CODE){
									code = " code='" + key.CODE + "' ";
								}
								
								_option += "<option value='" + key.NAME + "'" + (key.NAME==_value ? " selected='true' " : "")
									+ ( code ? code : "" ) + ">"+key.NAME+"</option>"
							});
							$this.append(_option);
						}
					},
					error : function(){
						console.log("查询参数获取失败");
					}
				});
			});
		},
		loadOptionsOne : function($obj){
			$obj.each(function(){
				var $this = $(this);
				var name = $this.attr("name");
				var _value = $this.attr("_value");
//				console.info("_value-->" + _value);
				
				name = name.toLowerCase();
				
				var url = "optionsData.jsp?name="+name;
				$.ajax({
					url : url,
					async : false,
					type : 'post',
					dataType : 'json',
					success : function(json){
						$this.find("option").not("[value='']").remove();
						if(json){
							var _option = "";
							
							$.each(json,function(i,key){
								_option += "<option _uinitname='"+(key.UNIT ? key.UNIT : '')+"' " +
									"_price='" + (key.PPRICE ? key.PPRICE : '0') + "'" +
									"_spec='" + (key.SPEC ? key.SPEC : '') + "' value='" 
									+ (key.GOODSCODE ? key.GOODSCODE : '') + "'" + (key.NAME==_value ? "selected='true'" : "") 
									+ ">" + (key.NAME ? key.NAME : '') + "</option>";
							});
							$this.append(_option);
						}
					},
					error : function(){
						console.log("查询参数获取失败");
					}
				});
			});
		}
};