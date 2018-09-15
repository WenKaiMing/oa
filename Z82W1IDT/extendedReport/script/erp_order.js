var Order = {
		config : {
			setupType : "",	// pc/phone
			active : "",
			orderType : "",	//单据类型：purchase-采购; sale-销售
			pData : {},		//父表数据,
			sData : {}		//子表数据
		},
		
		/**
		 * 列表初始化（采购和销售订单）
		 */
		initList : function(){

			this.config.setupType = ErpCommon.browserRedirect();
			this.config.orderType = $("input[name=_orderType]").val();
			this.comBindEvent();
			this.listBindEvent();
			ErpCommon.loadOptions();		//加载查询表单的供应商、部门、业务员、客户
			this.loadList();
		},
		
		/**
		 * 表单初始化
		 * @param active
		 */
		initContent : function(){
			if(active == "new"){
				this.newContent();
				this.config.active = "insert";
			}else if(active == "show"){
				this.showContent();
				this.config.active = "update";
			}


			this.config.setupType = ErpCommon.browserRedirect();
			this.config.orderType = orderType;
			this.conBindEvent();
		},
		/**
		 * 公共绑定事件
		 */
		comBindEvent : function(){

			//日期控件
			$('.form_datetime').datetimepicker({
				language:  'zh-CN',
			    minView: "month",
			    format: 'yyyy-mm-dd',
			    autoclose:true
			});
		},
		/**
		 * 表单绑定事件
		 */
		conBindEvent : function(){

			$("button.btn-show-back").click(function(){
				window.history.go(-1);
			});

			$("button.btn-show-edit").click(function(){
				var _val = $("article.obpmSearch").attr("_val");
				var pBillcode = $("article.obpmSearch").attr("pBillcode");
				window.location.href="orderEdit.jsp?active=edit&chartType="+_val+"&pBillcode="+pBillcode; 
			});
			
			$("form").submit(function(){
				Order.saveForm();
				return false;
			});
			
			$("select[name=vendor]").change(function(){
//				console.info("vendorcode--" + $(this).find("option:checked").attr("vendorcode"));
				$("input[name='vendorcode']").val($(this).find("option:checked").attr("vendorcode"));
			});
			
			$("select[name='clientname']").change(function(){
				$("input[name='clientno']").val($(this).find("option:checked").attr("code"));
			});

//			$("select[name=empname]").change(function(){
//				$("input[name='clientno']").val($(this).find("option:checked").attr("code"));
//			});
		},
		/**
		 * 列表绑定事件
		 */
		listBindEvent : function(){

			//新建按钮
			$("button.btn-list-add").click(function(){
				var val = $("article.obpmSearch").attr("_val");
				window.location.href="orderContent.jsp?active=new&chartType="+val;
			});
			
			//删除按钮
			$("button.btn-list-delete").click(function(){
				var $checks = $("#listTable").find("input[name='_selects']:checked");
				if($checks.size() == 0){
					alert("请先选择要删除的数据");
				}else{
					$checks.each(function(){
						var _no = $(this).parents("tr").attr("billcode");
						var _url = "orderData.jsp?active=delete&orderType=" + Order.config.orderType + "&orderNum="+_no;

						$.ajax({
							url : _url,
							type : 'post',
							dataType : 'json',
							success : function(result){
								if(result.status == 1){
									alert("删除成功");
									Order.loadList();
								}else if(result.status == 0){
									alert("删除失败");
								}
								
							}
						});
					});
				}
			});
			
			//查询按钮
			$("button.btn-list-search").click(function(){
				$("#page-wrapper .dataSearch").toggle();
			});

			//表单提交
			$("form").submit(function(){
				Order.loadList();
				return false;
			});
		},
		
		/**
		 * 获取查询列表选项参数
		 * @param name
		 * @param value
		 * @param callback
		 */
		getParameters : function(name,value,callback){
			//vendor,deptment,employ
			var url = "orderData.jsp?"+name+"="+value;
			$.ajax({
				url : url,
				async : false,
				type : 'post',
				dataType : 'json',
				success : function(result){
					if(result.status == 1){
						if(typeof(callback)=="function"){
							callback(name, result.datas);
						}
					}else if(result.status == 0){
						console.info("查询参数获取失败");
					}
				},
				error : function(){
					console.info("查询参数获取失败");
				}
			});
		},
		/**
		 * 保存表单
		 */
		saveForm : function(){
			var $parentArticle = $("form").parent(".obpmSearch");
			var orderType = $parentArticle.attr("_val");
			var pBillcode = $parentArticle.attr("pBillcode");
			var params = $("form").serialize();
			var _url = "orderData.jsp?active=" + this.config.active + "&orderType="+orderType+"&pBillcode="+pBillcode;
			
			$.ajax({
				url : _url,
				type : 'post',
				data : params,
				dataType : 'json',
				success : function(result){
					if(result.status == 1){
						alert("保存成功");
					}else if(result.status == 0){
						alert("保存失败！");
					}
				}
			});
			
		},
		newContent : function(){
			var $this = $("article.obpmSearch");
			var orderType = $this.attr("_val");
			var tempId = "";
			switch (orderType) {
				case "purchase":
					tempId = "purchaseCon";
					break;
				case "sale":
					tempId = "saleCon";
					break;
			}
			var data = {
					list : [{
						BILLAMT : "",
						BILLCODE : "",
						BILLDATE : {},
						BILLID : "",
						CLIENTID : "",
						CLIENTNAME : "",
						DEPID : "",
						DEPNAME : "",
						EMPID : "",
						REMARK : "",
						REPID : "",
						REPNAME : "",
						WUSERNAME : "",
						WUSERNO : "",
						TIME : ""
					}]
				};
			$this.find(".dataList").html("").append(template(tempId, data));

			ErpCommon.loadOptions();		//加载查询表单的供应商、部门、业务员、客户
			this.comBindEvent();
		},
		/**
		 * 子表插入数据
		 * @param obj
		 */
		subInsert : function(obj){
			var $newPanel = $(obj).parents("#newPanel");
			$newPanel.find(".list-row").wrap("<form></form");
			var params = $newPanel.find("form").serializeArray();
			$newPanel.unwrap();
			var _url = "orderData.jsp?active=update&subActive=insert";

			$.ajax({
				url : _url,
				data : params,
				type : 'post',
				dataType : 'json',
				success : function(result){
					if(result.status == 1){
						alert("保存成功");
						Order.updateSubList(params, "new");
						Order.subBack(obj);
					}else if(result.status == 0){
						alert("保存失败！")
					}
				},
				error : function(){
					console.info("保存失败");
				}
			});
		},
		/**
		 * 子表更新数据
		 * @param obj
		 */
		subUpdate : function(obj){

			var $newPanel = $(obj).parents("#newPanel");
			$newPanel.find(".list-row").wrap("<form></form");
			var params = $newPanel.find("form").serializeArray();
			$newPanel.unwrap();
			
			var _url = "orderData.jsp?active=update&subActive=update";
			
			$.ajax({
				url : _url,
				data : params,
				type : 'post',
				dataType : 'json',
				success : function(result){
					if(result.status == 1){
						alert("保存成功");
						Order.updateSubList(params, "update");
						Order.subBack(obj);
					}else if(result.status == 0){
						alert("保存失败！")
					}
				},
				error : function(){
					console.info("保存失败");
				}
			});
		},
		subBack : function(obj){

			var $this = $(obj);
			$this.parents("#newPanel").slideUp("slow");
			$("#wrapper").show();
			setTimeout(function(){
				$this.parents("#newPanel").remove();
			}, 1000);
		},
		/**
		 * 子表删除数据
		 * @param obj
		 */
		subDelete : function(obj){
			if(confirm("确认删除吗？")){
				var $this = $(obj);
				var $newPanel = $this.parents("#newPanel");
				$newPanel.find(".list-row").wrap("<form></form");
				var params = $newPanel.find("form").serializeArray();
				$newPanel.unwrap();
				
				var _url = "orderData.jsp?active=update&subActive=delete";
				
				$.ajax({
					url : _url,
					data : params,
					type : 'post',
					dataType : 'json',
					success : function(result){
						if(result.status == 1){
							alert("删除成功");
							Order.updateSubList(params, "delete");
							Order.subBack(obj);
						}else if(result.status == 0){
							alert("删除失败！")
						}
					},
					error : function(){
						console.info("删除失败");
					}
				});
			}
		},
		/**
		 * 添加子表行
		 * @param obj
		 */
		addSubTr : function(params){

			var data = {
					list : [{}]
			};
			if(params.length>0){
				for(var i in params){
					var name = params[i].name;
					if(name && name.length>0 && name.indexOf("sub.") != -1){
						name = name.substring(4);
					}
					data.list[0][name] = params[i].value;
				}
			}
			var $subList = $("#subList");
			var $tr = $(template("subTr",data));	//使用模板
			$subList.find("tbody").append($tr);
		},
		/**
		 * 根据数据显示子表界面（新建/编辑）
		 * @param data 渲染模板数据
		 * @param type 新建/编辑-new/edit
		 */
		showSubCon : function(data, type){
			var $panel = $("<div id='newPanel' class='newPanel'></div>").css("display", "none");

			$panel.append(template("subTrPhone",data));	//使用模板

			$panel.find("input[name='sub.QTY']").change(function(){
				var _price = Number($(this).parents("div.list-row").find("input[name='sub.PRICE']").val());
				$(this).parents("div.list-row").find("input[name='sub.GOODSAMT']").val(_price*$(this).val());
			})
			
			ErpCommon.loadOptionsOne($panel.find("[stype='_select']"));
			
			$panel.find(".btn-sub-save").bind("click", function(){
				if(type == "new"){
					Order.subInsert(this);
				}else if(type == "edit"){
					Order.subUpdate(this);
				}
			});

			$panel.find(".btn-sub-delete").bind("click", function(){
				Order.subDelete(this);
			});
			
			$panel.find(".btn-sub-back").bind("click", function(){
				Order.subBack(this);
			});
			
			$panel.find(".form-goodsname").change(function(){

				var _val = $(this).val();
				var _spec = $(this).find("[value='"+_val+"']").attr("_spec");
				var _uinitname = $(this).find("[value='"+_val+"']").attr("_uinitname");
				var _price = $(this).find("[value='"+_val+"']").attr("_price");
				var $curPanel = $(this).parents("#newPanel");
				
				$curPanel.find("input[name='sub.GOODSCODE']").val(_val);
				$curPanel.find("input[name='sub.GOODSSPEC']").val(_spec);
				$curPanel.find("input[name='sub.UNITNAME']").val(_uinitname);
				$curPanel.find("input[name='sub.PRICE']").val(_price);
			});
			
			$("body").append($panel);
			$("#wrapper").hide();
			$panel.slideDown();
		},
		/**
		 * 编辑子表
		 * @param obj
		 */
		subEdit : function(obj){
			var $this = $(obj);
			var ind = $this.attr("index");
			var sData = this.config.sData;
			var param = {};
			if(ind){
				param = sData[ind-1];
			}
			param.orderType = this.config.orderType;

			var data = {
					showDel : true,		//编辑时可删除
					list : [param]
			};
			
			this.showSubCon(data, "edit");
		},
		/**
		 * 添加子表数据
		 * @param obj
		 */
		subAdd : function(){
			
			var $subList = $("#subList");
			var _ITEMNO = $subList.find("tr.list-row").size();
			var _BILLCODE = "BI-" + _ITEMNO;
			var BILLCODE = $("input[name='BILLCODE']").val();
			var BILLID = $("input[name='BILLID']").val();
			var _chartType = $("article.obpmSearch").attr("_val");

			var data = {
				showDel : false,
				list : [{
			        ITEMNO : _ITEMNO,
			        BILLCODE : _BILLCODE,
			        pBillcode : BILLCODE,
			        GOODSCODE : "",
			        GOODSNAME : "",
			        GOODSSPEC : "",
			        QTY : 0,
			        UNITNAME : "",
			        PRICE : "",
			        GOODSAMT : "",
			        orderType : _chartType,
			        subActive : "insert",
			        BILLID : BILLID
				}]
			};
			
			this.showSubCon(data, "new");
		},
		/**
		 * 更新子表，添加和修改子表数据后调用
		 * @param params
		 */
		updateSubList : function(params, type){

			var param = {};
			if(params.length>0){
				for(var i in params){
					var name = params[i].name;
					if(name && name.length>0 && name.indexOf("sub.") != -1){
						name = name.substring(4);
					}
					param[name] = params[i].value;
				}
			}
			var sData = this.config.sData;
			
			if(type == "new"){
				sData.push(param);
			}else if(type == "update"){
				for(var i in sData){
					if(sData[i].ITEMNO == param.ITEMNO){
						sData[i] = param;
						break;
					}
				}
			}else if(type == "delete"){
				for(var i in sData){
					if(sData[i].ITEMNO == param.ITEMNO){
						sData.splice(i,1);
						break;
					}
				}
			}
			this.createSubList(sData);
		},
		/**
		 * 根据模板渲染子表
		 * @param json
		 */
		createSubList : function(json){
			var subData = {
				showAdd : true,
				showBtn : false,
				list : (json ? json : [])
			};
			
			if(this.config.setupType == "pc"){
				subData.showBtn = true;
			}
			
			var $subTable = $(template("subTable",subData));
			
			//加载产品
			ErpCommon.loadOptionsOne($subTable.find("[stype='_select']"));

			$subTable.find(".btn-sub-save").bind("click", function(){
				Order.subUpdate(this);
			});
			
			$subTable.find(".btn-sub-delete").bind("click", function(){
				Order.subDelete(this);
			});
			
			$subTable.find(".btn-sub-insert button").bind("click",function(){
				Order.subAdd();
			});
			
			//子表编辑
			$subTable.find("tbody > tr").bind("click", function(){
				Order.subEdit(this);
			});
			
			$("#subList").html("").append($subTable);
			
			if(this.config.setupType == "phone"){
				tableListColumn();
			}
		},
		/**
		 * 加载子表
		 */
		loadSubList : function(){

			if(this.config.active == "insert"){
				Order.createSubList();
			}else{
				var _url = "orderData.jsp?active=showList&subActive=search&orderType=" + this.config.orderType +"&pBillcode=" + this.config.pData.BILLCODE;

				$.ajax({
					url : _url,
					data : "",
					type : 'post',
					dataType : 'json',
					success : function(result){
						
						if(result.status == 1){
							var json = result.datas;
							if(json){
								Order.config.sData = json;
								Order.createSubList(json);
							}
						}else if(result.status == 0){
							alert("子表加载失败！")
						}
					},
					error : function(){
						console.info("加载失败");
					},
				});
			}
		},
		/**
		 * 显示表格及数据
		 */
		showContent : function(){
			var $this = $("article.obpmSearch");
			var orderType = $this.attr("_val");
			var pBillcode = $this.attr("pBillcode");
			var pBillid = $this.attr("pBillid");
			var $conTable = "";
			var tempId = "";
			switch (orderType) {
				case "purchase":
					$conTable = $("#purchaseCon");
					tempId = "purchaseCon";
					break;
				case "sale":
					$conTable = $("#saleCon");
					tempId = "saleCon";
					break;
			}
			
			var _url = "orderData.jsp?active=&orderType=" + orderType;
			if(pBillcode && pBillcode != "null" ){
				_url += "&pBillcode=" + pBillcode;
			}
			if(pBillid && pBillid != "null" ){
				_url += "&pBillid=" + pBillid;
			}
			
			$.ajax({
				url : _url,
				type : 'post',
				dataType : 'json',
				success : function(result){

					if(result.status == 1){
						var json = result.datas;
						if(json && json.length > 0){
							
							json[0].TIME = formatDate(new Date(json[0].BILLDATE.time));
							Order.config.pData = json[0];
							var data = {
								list : json
							};

							var $tmpl = $(template(tempId, data));
							
							$this.find(".dataList").html("").append($tmpl);
							
							Order.loadSubList();	//加载子表数据

							ErpCommon.loadOptions();		//加载查询表单的供应商、部门、业务员、客户
							Order.comBindEvent();
						}
					}else if(result.status == 0){
						alert("加载失败！")
					}
				},
				error : function(){
					console.info("加载失败");
				},
			});
		},
		/**
		 * 加载列表数据
		 */
		loadList : function(){
			$("article.obpmSearch").each(function(){

				var $this = $(this);
				var isSelect = $this.attr("_isSelect");
				var val = $this.attr("_val");
				var params = $this.find("form").serialize();
				var _url = "orderData.jsp?active=search&orderType=" + val;
				
				$.ajax({
					url : _url,
					data : params,
					type : 'post',
					dataType : 'json',
					success : function(result){
						$("#page-wrapper .dataSearch").hide();
						
						if(result.status == 1){
							var json = result.datas;
							
							if(json){
								if(isSelect=="true"){
									$.each(json,function(){
										this["FORM_SELECT"] = "<input type='checkbox' id='"+this["BILLID"]+"' name='_selects' value='"+this["BILLID"]+"'>";
									});
								}
								$this.find(".dataList").html("").append(Order.data2Table($this,json));

								if(Order.config.setupType == "phone"){	//表格响应式布局配置
									tableListColumn();
								}
							}
						}else if(result.status == 0){
							alert("加载失败！")
						}
					},
					error : function(e){
						alert("查询出错:" + e);
					}
				});
			});
		},
		
		/**
		 * 移除json数据中的null字符
		 * @param json
		 */
		jsonDelNull : function(json){
			for(var i=0; i<json.length; i++){
				for(var name in json[i]){
					if(!json[i][name] || json[i][name] == "null"){
						json[i][name] = "";
					}
				}
			}
		},
		/**
		 * 根据orderType值设置表格配置数据
		 */
		setParamsByType : function($me,json){
			this.jsonDelNull(json);		//移除json数据中的null字符
			
			var conf = {
				chartType : $me.attr("_val"),
				name : $me.attr("_name"),
				json : json,
				key2Val : {},
				td1 : "",
				outField : [],
				title : "",
				url : ""
			};
			switch (conf.chartType) {
				case "purchase":
					conf.key2Val = {
						"FORM_SELECT" : "选择", "BILLDATE" : "单据日期", "BILLCODE" : "单据编号", "DEPNAME" : "部门", "VENDORNAME" : "供应商", 
						"VENDORCODE" : "供应商编号", "EMPNAME" : "业务员" ,"BILLAMT" : "单据金额" ,"REMARK" : "备注"
					};
					conf.td1 = "FORM_SELECT";
					conf.outField = ["BILLID","REPID","EMPID","DEPID","VENDORID", "VENDORCODE","WUSERNO","WUSERNAME"];
					if(conf.name == ""){
						conf.title = "采购订单汇总表";
					}else{
						conf.title = "采购订单明细表";
					}
					conf.url = "orderContent.jsp";
					break;
				case "sale":
					conf.key2Val = {
						"FORM_SELECT" : "选择", "DEPNAME" : "部门", "CLIENTNO" : "客户编号", "CLIENTNAME" : "客户", "BILLAMT" : "单据金额", 
						"REMARK" : "备注", "BILLCODE" : "单据编号", "BILLDATE" : "单据日期", "EMPNAME" : "业务员"
					};
					conf.outField = ["BILLID", "EMPID", "STOREID", "GOODSID", "CLIENTID", "DEPID", "REPID", "REPNAME", "VENDORID", 
					                 "WUSERNO", "WUSERNAME"];
					conf.td1 = "FORM_SELECT";
					if(conf.name == ""){
						conf.title = "销售订单汇总表";
					}else{
						conf.title = "销售订单明细表";
					}
					conf.url = "orderContent.jsp";
					break;
				default :
					break;
			}
			return conf;
		},
		/**
		 * 渲染表格数据
		**/
		data2Table : function($me, json){
			var conf = this.setParamsByType($me, json);	//配置数据
			var $tableH = $("<table id='listTable' class='table' data-mode='columntoggle' style='width:100%'></table>");
			$me.find(".dataSearch-title").html(conf.title);
			//标题--start
			var theadH = "<thead><tr class='listDataTh'>";
			theadH += "<th class='listDataThFirstTd' ishiddencolumn='false' isvisible='true'>"+conf.key2Val[conf.td1]+"</th>";
			var td1Tmp = conf.td1.toUpperCase();
			for(var name in conf.json[0]){
				var nameT = name.toUpperCase();
				var isOut = false;	//是否非数据字段
				if(nameT == td1Tmp){
					isOut = true;
				}else{
					for(var j=0;j<conf.outField.length;j++){
						var outTmp = conf.outField[j].toUpperCase();
						if(nameT == outTmp){
							isOut = true;
							break;
						}
					}
				}
				
				if(isOut)continue;	//非数据字段时不统计
				theadH += "<th class='listDataThTd' ishiddencolumn='false' isvisible='true'>" + conf.key2Val[nameT] + "</th>";
			}
			theadH += "</tr></thead>";
			$tableH.append(theadH);
			var $tbodyH = $("<tbody></tbody>");
			//标题--end
			//数据--start
			var td1Tmp1 = conf.td1.toUpperCase();
			for(var i=0; i<conf.json.length; i++){
				var $tr = $("<tr class='listDataTr' _url='" + conf.url + "' BILLID='"+conf.json[i].BILLID+"' BILLCODE='"
						+ conf.json[i].BILLCODE+"' _chartType='" + conf.chartType + "'></tr>");
				var _url = "";
				if(conf.url != ""){
					$tr.css({"color":"#0000f0"});
					_url = conf.url + "?active=show&chartType=" + $tr.attr("_chartType") + "&pBillcode=" + $tr.attr("BILLCODE") + "&pBillid=" + $tr.attr("BILLID");
				}
				$tr.append("<td class='listDataTrFirstTd'>" + conf.json[i][td1Tmp1] + "</td>");
				for(var name in conf.json[i]){
					var nameT = name.toUpperCase();
					var isOut = false;	//是否非数据字段
					if(nameT == td1Tmp){
						isOut = true;
					}else{
						for(var j=0;j<conf.outField.length;j++){
							var outTmp = conf.outField[j].toUpperCase();
							if(nameT == outTmp){
								isOut = true;
								break;
							}
						}
					}
					if(isOut)continue;	//非数据字段时不统计
					var val = null;
					if(typeof conf.json[i][name] == "number"){
						val = Math.floor(Number(conf.json[i][name]));
					}else if(typeof conf.json[i][name] == "object" && conf.json[i][name] != null){
						if(conf.json[i][name].date){
							var _time = new Date(conf.json[i][name].time);
							val = formatDate(_time);
						}
					}else{
						val = conf.json[i][name];
					}

					$tr.append("<td class='listDataTrTd'><a href='"+_url+"'>" + val + "</a></td>");
				}
				$tbodyH.append($tr);
			}
			$tableH.append($tbodyH);
			//数据--end
			return $tableH;
		}
};