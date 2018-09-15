var Search = {
		/**
		 * 表格数据配置
		 */
		configTable : {
			setupType : "",	// pc/phone
			chartType : "",
			name : "null",
			json : {},
			key2Val : {},
			td1 : "",
			outField : [],
			title : "",
			url : ""
		},
		init : function(){
			this.configTable.setupType = ErpCommon.browserRedirect();
			ErpCommon.loadOptions();		//加载查询表单的供应商、部门、业务员、客户
			this.initList();
			this.bindEvent();
//			Search.deptmentSelect();	//查询头的部门获取
//			Search.tradertypeSelect();	//查询头的类别获取
//			Search.areanameSelect();	//查询头的地区获取
//			Search.empnameSelect();		//查询头的业务员获取
//			Search.accoutSelect();	//查询头的银行出纳账户
//			Search.clientSelect();	//查询头的客户获取
			$(".submit").click(function(){
				Search.searchTable(this);
			});
			$('.form_datetime').datetimepicker({
		        language:  'zh-CN',
		        minView: "month",
		        format: 'yyyy-mm-dd',
		        autoclose:true
		    });
			$(".dateRange").change(function(){
				var _val = $(this).find("option:selected").attr("_val");
				var $startTime = $(this).parents(".dataSearch-from").find(".start-time");
				var $endTime = $(this).parents(".dataSearch-from").find(".end-time");
				switch(_val){
					case "100":	//自定义
						$('.form_datetime').datetimepicker('setStartDate', '2000-01-01');
						$('.form_datetime').datetimepicker('setEndDate', '2080-01-01');
						$startTime.val("");
						$endTime.val("");
					  break;
					case "1":	//本年
						$('.form_datetime').datetimepicker('setStartDate', getYearStartDate);
						$('.form_datetime').datetimepicker('setEndDate', getYearEndDate);
						$startTime.val(getYearStartDate);
						$endTime.val(getYearEndDate);
					  break;
					case "2":	//本月
						$('.form_datetime').datetimepicker('setStartDate', getMonthStartDate);
						$('.form_datetime').datetimepicker('setEndDate', getMonthEndDate);
						$startTime.val(getMonthStartDate);
						$endTime.val(getMonthEndDate);
						 break;
					case "3":	//今周
						$('.form_datetime').datetimepicker('setStartDate', getWeekStartDate);
						$('.form_datetime').datetimepicker('setEndDate', getWeekEndDate);
						$startTime.val(getWeekStartDate);
						$endTime.val(getWeekEndDate);
						break;
					case "4":	//今天
						$('.form_datetime').datetimepicker('setStartDate', getCurrentDate);
						$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
						$startTime.val(getCurrentDate);
						$endTime.val(getCurrentDate);
						break;
					case "5":	//昨天
						$('.form_datetime').datetimepicker('setStartDate', getYesterdayDate);
						$('.form_datetime').datetimepicker('setEndDate', getYesterdayDate);
						$startTime.val(getYesterdayDate);
						$endTime.val(getYesterdayDate);
						break;
					case "6":	//上周
						$('.form_datetime').datetimepicker('setStartDate', getUpWeekStartDate);
						$('.form_datetime').datetimepicker('setEndDate', getUpWeekEndDate);
						$startTime.val(getUpWeekStartDate);
						$endTime.val(getUpWeekEndDate);
						break;
					case "7":	//上月
						$('.form_datetime').datetimepicker('setStartDate', getLastMonthStartDate);
						$('.form_datetime').datetimepicker('setEndDate', getLastMonthEndDate);
						$startTime.val(getLastMonthStartDate);
						$endTime.val(getLastMonthEndDate);
						break;
					case "8":	//上年
						$('.form_datetime').datetimepicker('setStartDate', getUpYearStartDate);
						$('.form_datetime').datetimepicker('setEndDate', getUpYearEndDate);
						$startTime.val(getUpYearStartDate);
						$endTime.val(getUpYearEndDate);
						break;
					case "9":	//上周至今天
						$('.form_datetime').datetimepicker('setStartDate', getUpWeekStartDate);
						$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
						$startTime.val(getUpWeekStartDate);
						$endTime.val(getCurrentDate);
						break;
					case "10":	//上月至今天
						$('.form_datetime').datetimepicker('setStartDate', getLastMonthStartDate);
						$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
						$startTime.val(getLastMonthStartDate);
						$endTime.val(getCurrentDate);
						break;
					case "11":	//上年至今
						$('.form_datetime').datetimepicker('setStartDate', getUpYearStartDate);
						$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
						$startTime.val(getUpYearStartDate);
						$endTime.val(getCurrentDate);
						break;
					case "12":	//本年至今
						$('.form_datetime').datetimepicker('setStartDate', getYearStartDate);
						$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
						$startTime.val(getYearStartDate);
						$endTime.val(getCurrentDate);
						break;
					case "13":	//本月至今
						$('.form_datetime').datetimepicker('setStartDate', getMonthStartDate);
						$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
						$startTime.val(getMonthStartDate);
						$endTime.val(getCurrentDate);
						break;
					case "14":	//今周至今
						$('.form_datetime').datetimepicker('setStartDate', getWeekStartDate);
						$('.form_datetime').datetimepicker('setEndDate', getCurrentDate);
						$startTime.val(getWeekStartDate);
						$endTime.val(getCurrentDate);
						break;
					default:
						break;
				}
			});
		},
		/**
		 * 绑定事件
		 */
		bindEvent : function(){

			if(this.configTable.setupType == "pc"){
				$(".dataSearch").show();
			}else{
				$(".searchBtn").bind("click",function(){
					$(".dataSearch").toggle();
				}).show();
			}
		},
		/**
		 * 初始化列表
		 */
		initList : function(){
				var $me = $("#page-wrapper").find("article");
				var val = $me.attr("_val");
				var _url = "searchData.jsp?chartType=" + val;
				if($me.attr("_name")){
					_url += "&_name=" + $me.attr("_name");
				}
				$.ajax({
					url : _url,
					data : "",
					type : 'post',
					dataType : 'json',
					success : function(json){
						$me.find(".dataList").html("").append(Search.data2TableN($me,json));
						//表格响应式布局配置
						$me.find(".dataList").find('table').DataTable({
							info : false,
							searching : false,
							paging : false,
							pagingType : false,
							ordering : false,
					        responsive: true
					});
					}
				});
		},
		/**
		 * 表格查询
		 */
		searchTable : function(obj){
			
				var $parentArticle = $(obj).parents(".obpmSearch");
				var val = $parentArticle.attr("_val");
				var _sub = $(obj).attr("_val");
				if(_sub == "wlsearch"){
					var _jname = $parentArticle.find("#jname").val();
					var _fullname = $parentArticle.find("#fullname").val();
					var _deptmentSel = $parentArticle.find(".deptment_select").val();
					var _tradertypeSel = $parentArticle.find(".tradertype_select").val();
					var _areanameSel = $parentArticle.find(".areaname_select").val();
					var _code = $parentArticle.find("#code").val();
					var _empname = $parentArticle.find(".empname_select").val();
					var _url = "../tableData.jsp?chartType=" + val +"&_jname=" + _jname + "&_fullname=" + _fullname 
						+"&_deptmentSel=" + _deptmentSel + "&_tradertypeSel=" + _tradertypeSel + "&_areanameSel=" + _areanameSel
						+"&_code=" + _code + "&_empname=" + _empname + "&_sub=" + _sub;
				}else{
					
					var $searchPanel = $(obj).parents(".dataSearch");
					var searchParameters = $searchPanel.find("form").serialize();
					var _url = "../tableData.jsp?chartType=" + val +"&" + searchParameters + "&_sub=" + _sub;
				}

				
				//if($parentArticle.attr("_name")){
				//	_url += "&_name=" + $me.attr("_name");
				//}
				$.ajax({
					url : _url,
					data : "",
					type : 'post',
					dataType : 'json',
					success : function(json){
						
						$("#page-wrapper .dataSearch").hide();
						//var $me = $(".obpmSearch");
						$parentArticle.find(".dataList").html("").append(Search.data2TableN($parentArticle,json));
						//表格响应式布局配置
						$parentArticle.find(".dataList").find('>table').DataTable({
							info : false,
							searching : false,
							paging : false,
							pagingType : false,
							ordering : false,
					        responsive: true
						});
					}
				});
		},
		/**
		 * 移除json数据中的null字符
		 * @param json
		 */
		jsonDelNull : function(json){
			
			if(json){
				for(var i=0; i<json.length; i++){
					for(var name in json[i]){
						
						if(!json[i][name] || json[i][name] == "null"){
							json[i][name] = "";
						}
						if(typeof json[i][name] === 'number' && !isNaN(json[i][name])){
							json[i][name] = Math.round(json[i][name]*100)/100;
						}
					}
				}
			}
		},
		/**
		 * 根据chartType值设置表格配置数据
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

				case "wldw":
					conf.key2Val = {
						"CODE" : "编号", "NAME" : "简称", "FULLNAME" : "全称", "TRADERTYPE" : "类别", "DEPNAME" : "隶属部门" ,"CONTACTOR" : "联系人" ,"MOBILEPHONE" : "手机" ,"TEL" : "电话" , 
						"FAX" : "传真" ,"URL" : "网站" ,"EMAIL" : "邮箱" ,"AREANAME" : "地区" , "ZIP" : "邮编","CREDIT" : "信用额度",
						"CREDITDAY" : "信用天数","BALANCE" : "累计欠款","SHIPTO" : "发货地址","ADDRESS" : "公司地址","ISCLIENT" : "客户","EMPCODE" : "业务员编号","EMPNAME" : "业务员姓名"
					};
					conf.td1 = "CODE";
					if(conf.name == ""){
						conf.title = "往来单位查询汇总表";
					}else{
						conf.title = "往来单位查询明细表";
					}
					conf.url = "detailSearch.jsp";
					break;
				case "fckkc":
					conf.key2Val = {
						"BILLID" : "编号", "GDNAME" : "产品名称", "STOREID" : "仓库编号", "STNAME" : "仓库名称", "GDCODE" : "产品编号", "GOODSID" : "产品ID", "GDSPEC" : "规格"
						,"GDTYPE" : "类型", "ONHANDQTY" : "当前库存", "TOPQTY" : "最高库存", "DOWNQTY" : "最低库存", "UNITNAME" : "单位"
					};
					conf.outField = ["BILLID","STOREID","GOODSID"];
					conf.td1 = "GDCODE";
					if(conf.name == ""){
						conf.title = "分仓库库存查询汇总表";
					}else{
						conf.title = "分仓库库存查询明细表";
					}
					conf.url = "detailSearch.jsp";
					break;
				case "huopin":
					conf.key2Val = {
						"CODE" : "编号", "SHORTNAME" : "简称", "NAME" : "全称", "SPEC" : "规格", "GDTYPE" : "类别", "UINITNAME":"单位","LSPRICE" : "最近售价"
						,"LPPRICE" : "最近进价", "PPRICE" : "成本价", "PICTURE" : "图片"
					};
					conf.outField = ["GDTYPEID","GOODSID","UINTID","UINTID","VIPPRICE","DESCRIPTION"];
					conf.td1 = "CODE";
					if(conf.name == ""){
						conf.title = "货品查询汇总表";
					}else{
						conf.title = "货品查询明细表";
					}
					conf.url = "detailSearch.jsp";
					break;
				case "cnz":
					conf.key2Val = {
						"ACCOUNTID" : "出纳账户ID", "NAME" : "出纳账户名", "BANKNAME" : "开户银行", "BALANCE" : "余额"
					};
					
					conf.td1 = "ACCOUNTID";
					if(conf.name == ""){
						conf.title = "出纳账查询汇总表";
					}else{
						conf.title = "出纳账查询明细表";
					}
					conf.url = "detailSearchCnz.jsp";
					break;
				case "yings":
					conf.key2Val = {
						"CODE" : "编号", "NAME" : "简称", "FULLNAME" : "全称", "DEPTNAME" : "隶属部门", "SAMT" : "期初应收", "INAMT" : "本期应收", "OUTAMT" : "本期收款", "CAMT" : "本期余额"
					};
					conf.outField = ["TRADERID"];
					conf.td1 = "CODE";
					if(conf.name == ""){
						conf.title = "应收查询汇总表";
					}else{
						conf.title = "应收查询明细表";
					}
					conf.url = "detailSearch.jsp";
					break;
				case "yingf":
					conf.key2Val = {
						"CODE" : "编号", "NAME" : "简称", "FULLNAME" : "全称", "DEPTNAME" : "隶属部门", "SAMT" : "期初应收", "INAMT" : "本期应收", "OUTAMT" : "本期收款", "CAMT" : "本期余额"
					};
					conf.outField = ["TRADERID"];
					conf.td1 = "CODE";
					if(conf.name == ""){
						conf.title = "应付查询汇总表";
					}else{
						conf.title = "应付查询明细表";
					}
					conf.url = "detailSearch.jsp";
					break;
				default :
					break;
			}
			return conf;
		},
		

		/**
		**/
		data2TableN : function($me, json){
			var conf = this.setParamsByType($me, json);	//配置数据
			
			var $tableH = $("<table class='table table-striped table-bordered table-hover' style='width:100%'></table>");
			//$tableH.append("<caption>" + conf.title + "</caption>");
			
			$me.find(".dataSearch-title").html(conf.title);
			//标题--start
			var theadH = "<thead><tr>";
			theadH += "<th>"+conf.key2Val[conf.td1]+"</th>";
			var td1Tmp = conf.td1.toUpperCase();
			if(conf.json){
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
					theadH += "<th>" + conf.key2Val[nameT] + "</th>";
				}
			}
			
			theadH += "</tr></thead>";
			$tableH.append(theadH);
			var $tbodyH = $("<tbody></tbody>");
			//标题--end
			//数据--start
			var td1Tmp1 = conf.td1.toUpperCase();

			if(conf.json){
				for(var i=0; i<conf.json.length; i++){
					var $tr = $("<tr _url='" + conf.url + "' _chartType='" + conf.chartType + "' _name='" + conf.json[i][td1Tmp1] + "'></tr>");
					if(conf.url != ""){
						$tr.css("cursor","pointer")
							.css("color","#0000f0")
							.bind("click",function(){
								document.location.href = $(this).attr("_url") + "?chartType=" + $(this).attr("_chartType") + "&_name=" + $(this).attr("_name");
							});
					}
					$tr.append("<td>" + conf.json[i][td1Tmp1] + "</td>");
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
						}else{
							val = conf.json[i][name];
						}
	
						$tr.append("<td>" + val + "</td>");
					}
					$tbodyH.append($tr);
				}
			}
			$tableH.append($tbodyH);
			//数据--end
			return $tableH;
		},
		
		/**
		 * 初始化表单明细
		 */
		initListDetail : function(){
			$("button.btn-show-back").click(function(){
				window.history.go(-1);
			});
			$("article.obpmSearch").each(function(){
				var $me = $(this);
				var val = $me.attr("_val");
				var _url = "searchData.jsp?chartType=" + val;
				if($me.attr("_name")){
					_url += "&_name=" + $me.attr("_name");
				}
				$.ajax({
					url : _url,
					data : "",
					type : 'post',
					dataType : 'json',
					success : function(json){
						$me.find(".dataList").html("").append(Search.dataListDetail($me,json));
						//表格响应式布局配置
//						$me.find(".dataList").find('>table').DataTable({
//							info : false,
//							searching : false,
//							paging : false,
//							pagingType : false,
//							ordering : false,
//					        responsive: true
//						});
					}
				});
			});
		},
		/**
		 * 重构表单明细
		**/
		dataListDetail : function($me, json){
			var conf = this.setParamsByType($me, json);	//配置数据
			
			if(conf.chartType == "wldw"){
				var $tableH = $("<table class='table  table-bordered ' style='width:100%'></table>");
				$tableH.append("<caption style='text-align: center;font-size: 2em;'>" + conf.title + "</caption>");
				//标题--start
				var $tbodyH = $("<tbody></tbody>");
				//标题--end
				
				//数据--start
				var $trAll =  "<tr><td>*编号:</td><td>"+conf.json[0].CODE+"</td><td>*类别:</td><td>"+conf.json[0].TRADERTYPE+"</td><td>隶属部门:</td><td>"+conf.json[0].DEPNAME+"</td></tr>"
							+"<tr><td>全称:</td><td colspan='3'>"+conf.json[0].FULLNAME+"</td><td>简称:</td><td>"+conf.json[0].NAME+"</td></tr>"
							+"<tr><td>联系人:</td><td>"+conf.json[0].EMPNAME+"</td><td>手机:</td><td>"+conf.json[0].MOBILEPHONE+"</td><td>电话:</td><td>"+conf.json[0].TEL+"</td></tr>"
							+"<tr><td>传真:</td><td>"+conf.json[0].FAX+"</td><td>网站:</td><td>"+conf.json[0].URL+"</td><td>邮箱:</td><td>"+conf.json[0].EMAIL+"</td></tr>"
							+"<tr><td>地区:</td><td>"+conf.json[0].AREANAME+"</td><td>邮编:</td><td>"+conf.json[0].ZIP+"</td><td>信用额度:</td><td>"+conf.json[0].CREDIT+"</td></tr>"
							+"<tr><td>信用天数:</td><td>"+conf.json[0].CREDITDAY+"</td><td>累计欠款:</td><td>"+conf.json[0].BALANCE+"</td><td>客户:</td><td>"+conf.json[0].ISCLIENT+"</td></tr>"
							+"<tr><td>业务员编号:</td><td colspan='2'>"+conf.json[0].EMPCODE+"</td><td>业务员姓名:</td><td colspan='2'>"+conf.json[0].EMPNAME+"</td></tr>"
							+"<tr><td>发货地址:</td><td colspan='5'>"+conf.json[0].SHIPTO+"</td></tr>"
							+"<tr><td>公司地址:</td><td colspan='5'>"+conf.json[0].ADDRESS+"</td></tr>";
				$tbodyH.append($trAll);
				$tableH.append($tbodyH);
			}
			else if(conf.chartType == "huopin"){
				var $tableH = $("<table class='table table-bordered' style='width:100%'></table>");
				$tableH.append("<caption style='text-align: center;font-size: 2em;'>" + conf.title + "</caption>");
				//标题--start
				var $tbodyH = $("<tbody></tbody>");
				//标题--end
				var $trhp = "<tr><td>*编号:</td><td>"+conf.json[0].CODE+"</td><td>*类别:</td><td>"+conf.json[0].GDTYPE+"</td><td>隶属部门:</td><td>"+/**conf.json[0].DEPNAME+**/"</td></tr>"
							+"<tr><td>全称:</td><td colspan='3'>"+conf.json[0].NAME+"</td><td>规格:</td><td>"+conf.json[0].SPEC+"</td></tr>"
							+"<tr><td>简称:</td><td>"+conf.json[0].SHORTNAME+"</td><td>单位:</td><td>"+conf.json[0].UINITNAME+"</td><td>最近售价:</td><td>"+conf.json[0].LSPRICE+"</td></tr>"
							+"<tr><td>会员价:</td><td>"+conf.json[0].VIPPRICE+"</td><td>成本价:</td><td>"+conf.json[0].PPRICE+"</td><td>最近进价:</td><td>"+conf.json[0].LPPRICE+"</td></tr>"
							+"<tr><td>详细介绍:</td><td colspan='5'>"+conf.json[0].DESCRIPTION+"</td></tr>"
							+"<tr><td colspan='6'>产品图片:</td></tr>"
							+"<tr><td colspan='6' height='200px'>"+conf.json[0].PICTURE+"</td></tr>"
							+"<tr><td>功能说明:</td><td colspan='5'>查阅公司的货品基础信息资料</td></tr>";
				$tbodyH.append($trhp);
				$tableH.append($tbodyH);
			}
			else if(conf.chartType == "fckkc"){
				var $tableH = $("<table class='table table-bordered ' style='width:100%'></table>");
				$tableH.append("<caption style='text-align: center;font-size: 2em;'>" + conf.title + "</caption>");
				//标题--start
				var $tbodyH = $("<tbody></tbody>");
				//标题--end
				var trInfo = "<tr><td>*产品编号:</td><td>"+conf.json[0].GDCODE+"</td><td>*类别:</td><td>"+conf.json[0].GDTYPE+"</td><td>单位：</td><td>"+conf.json[0].UNITNAME+"</td></tr>"
							+"<tr><td>名称:</td><td colspan='3'>"+conf.json[0].GDNAME+"</td><td>规格：</td><td>"+conf.json[0].GDSPEC+"</td></tr>"
							+"<tr><td colspan='6'>库存信息:</td></tr>"
							+"<tr><td id='trList' colspan='6'></td></tr>"
							+"<tr><td>功能说明</td><td colspan='5'>1.查阅公司的货品各个仓库的库存量及成本单价基础信息资料。</br>2.采购专员、会计、仓库专员可以看见成本价。</td></tr>";
				
				
				var trListPanel = "<table class='table table-bordered ' style='width:100%'>" +
						"<tbody><tr class='list-row'><td>仓库</td><td>当前库存量</td><td>最低库存量</td><td>最高库存量</td><td>成本价</td></tr></tbody></table>";

				var trTotal = "<tr><td>总仓合计</td><td class='total-num' colspan='5'></td></tr>";
				
				$tbodyH.append(trInfo);

				var _url = "../tableData.jsp?chartType=" + conf.chartType +"&_name=" + conf.json[0].GDCODE;
				
				$.ajax({
					url:_url,
					data : "",
					type : 'post',
					dataType : 'json',
					success : function(json){
						$tbodyH.find("#trList").append(trListPanel);
						var _totalNum = 0;
						Search.jsonDelNull(json);
						$.each(json,function(i,data){
							var trList = "<tr class='list-row'><td>"+data.STNAME+"</td>" +
									"<td>"+data.ONHANDQTY+"</td><td>"+data.DOWNQTY+"</td>" +
									"<td>"+data.TOPQTY+"</td><td></td></tr>";
							_totalNum += parseInt(data.ONHANDQTY);
							$("#trList").find("tbody").append(trList);
						})
						$("#trList").find("tbody").append(trTotal);
						$("#trList").find("tbody").find(".total-num").text(_totalNum);
					}
				})
				$tableH.append($tbodyH);
			}
			else if(conf.chartType == "cnz"){
				var $tableH = $("<div class='top_cnz'></div>");
				var cont = "<div><div class='col-sm-6 cnz'>出纳账户:"+conf.json[0].NAME+"</div><div class='col-sm-6 cnz'>余额:"+conf.json[0].balance+"</div></div>"
				$tableH.append($(cont));
				
				var $table = $("<table class='table table-striped table-bordered table-hover ' style='width:100%'></table>");
				$tableH.append($table);
				$table.append("<caption style='text-align: left;padding-left:15px;font-size: 14px;'>" + conf.title + "</caption>");
				//标题--start
				var $tbodyH = $("<tbody></tbody>");
				//标题--end
				var trLast = "<tr><td>功能说明</td><td colspan='4'>查阅公司的出纳信息资料。</td></tr>";
				
				
				var trListPanel = "<tr class='list-row'><td>日期</td><td>凭证号</td>"
					+"<td>摘要</td><td>对方科目</td>"
//					+"<td>经手人</td><td>借方</td><td>贷方</td><td>方向类型</td>"
					+"<td>余额</td></tr>";
	
				var _url = "../tableData.jsp?bankType=bankdetail&chartType=" + conf.chartType +"&_name=" + conf.json[0].ACCOUNTID;
				
				$.ajax({
					url:_url,
					data : "",
					type : 'post',
					dataType : 'json',
					success : function(json){
						
						$tbodyH.append(trListPanel);

						Search.jsonDelNull(json);
						$.each(json,function(i,data){
//							var date = Search.formatDate(new Date(data.BOOKDATE.time));
							var trList = "<tr class='list-row'><td>"+"</td>" +
									"<td>"+data.ACCOUNTID+"</td><td>"+data.BANKNAME+"</td>" +
//									"<td>"+data.NAME+"</td><td>"+data.balance+"</td>" +
//									"<td>"+data.CREDITAMT+"</td><td>"+data.DEBITAMT+"</td>" +
									"<td>"+data.NAME+"</td><td>"+data.balance+"</td></tr>";
							$tbodyH.append(trList);
						})
						
						$tbodyH.append(trLast);
					}
				})
				$table.append($tbodyH);
			}
			else if(conf.chartType == "yings"){
				var $tableH = $("<table class='table table-bordered ' style='width:100%'></table>");
				$tableH.append("<caption style='text-align: center;font-size: 2em;'>" + conf.title + "</caption>");
				//标题--start
				var $tbodyH = $("<tbody></tbody>");
				//标题--end
				var trInfo = "<tr><td>*客户编号:</td><td>"+conf.json[0].CODE+"</td><td>名称:</td><td>"+conf.json[0].FULLNAME+"</td><td>简称：</td><td>"+conf.json[0].NAME+"</td></tr>"
							+"<tr><td>期初应收:</td><td>"+conf.json[0].SAMT+"</td><td>本期应收:</td><td>"+conf.json[0].INAMT+"</td><td>本期收款:</td><td>"+conf.json[0].OUTAMT+"</td></tr>"
							+"<tr><td>应收余额:</td><td>"+conf.json[0].CAMT+"</td><td></td><td></td><td></td><td></td></tr>"
							+"<tr><td id='trList' colspan='6'></td></tr>"
							+"<tr><td>功能说明</td><td colspan='5'>查阅公司的客户应收信息资料</td></tr>";
				
				
				var trListPanel = "<table class='table table-bordered ' style='width:100%'>" +
						"<tbody><tr class='list-row'><td>日期</td><td>应收方向</td><td>单据号</td><td>发生额</td><td>收入额</td><td>支出额</td><td>余额</td></tr></tbody></table>";
				
				$tbodyH.append(trInfo);

				var _url = "../tableData.jsp?payType=yingsdetail&chartType=" + conf.chartType +"&_name=" + conf.json[0].CODE;
				
				$.ajax({
					url:_url,
					data : "",
					type : 'post',
					dataType : 'json',
					success : function(json){
						$tbodyH.find("#trList").append(trListPanel);
						var _totalNum = 0;
						Search.jsonDelNull(json);
						$.each(json,function(i,data){
							var date = Search.formatDate(new Date(data.BILLDATE.time));
							var trList = "<tr class='list-row'><td>"+date+"</td>" +
									"<td>"+data.IOTYPE+"</td><td>"+data.BILLCODE+"</td>" +
									"<td>"+data.SAMT+"</td><td>"+data.INAMT+"</td><td>"+data.OUTAMT+"</td><td>"+data.CAMT+"</td></tr>";
							$("#trList").find("tbody").append(trList);
						})
					}
				})
				$tableH.append($tbodyH);
			}
			else if(conf.chartType == "yingf"){
				var $tableH = $("<table class='table table-bordered ' style='width:100%'></table>");
				$tableH.append("<caption style='text-align: center;font-size: 2em;'>" + conf.title + "</caption>");
				//标题--start
				var $tbodyH = $("<tbody></tbody>");
				//标题--end
				var trInfo = "<tr><td>*供应商编号:</td><td>"+conf.json[0].CODE+"</td><td>名称:</td><td>"+conf.json[0].FULLNAME+"</td><td>简称：</td><td>"+conf.json[0].NAME+"</td></tr>"
							+"<tr><td>期初应收:</td><td>"+conf.json[0].SAMT+"</td><td>本期应收:</td><td>"+conf.json[0].INAMT+"</td><td>本期收款:</td><td>"+conf.json[0].OUTAMT+"</td></tr>"
							+"<tr><td>应收余额:</td><td>"+conf.json[0].CAMT+"</td><td></td><td></td><td></td><td></td></tr>"
							+"<tr><td id='trList' colspan='6'></td></tr>"
							+"<tr><td>功能说明</td><td colspan='5'>查阅公司的供应商应付信息资料。</td></tr>";
				
				
				var trListPanel = "<table class='table table-bordered ' style='width:100%'>" +
						"<tbody><tr class='list-row'><td>日期</td><td>应收方向</td><td>单据号</td><td>发生额</td><td>收入额</td><td>支出额</td><td>余额</td></tr></tbody></table>";

				$tbodyH.append(trInfo);

				var _url = "../tableData.jsp?payType=yingfdetail&chartType=" + conf.chartType +"&_name=" + conf.json[0].CODE;
				
				$.ajax({
					url:_url,
					data : "",
					type : 'post',
					dataType : 'json',
					success : function(json){
						$tbodyH.find("#trList").append(trListPanel);
						var _totalNum = 0;
						Search.jsonDelNull(json);
						$.each(json,function(i,data){
							
							var date = Search.formatDate(new Date(data.BILLDATE.time));
							var trList = "<tr class='list-row'><td>"+date+"</td>" +
									"<td>"+data.IOTYPE+"</td><td>"+data.BILLCODE+"</td>" +
									"<td>"+data.SAMT+"</td><td>"+data.INAMT+"</td><td>"+data.OUTAMT+"</td><td>"+data.MA+"</td></tr>";
							$("#trList").find("tbody").append(trList);
						})
					}
				})
				$tableH.append($tbodyH);
			}
			//数据--end
			return $tableH;
		},
		//查询头的部门获取
		deptmentSelect : function(){
				var $me = $("#page-wrapper").find("article");
				var _deptname = $me.find(".deptment_select").attr("_val");
				
				if(_deptname){
					var _urlsearch = "searchData.jsp?deptmentSel=" + _deptname;
					$.ajax({
						url : _urlsearch,
						data : "",
						type : 'post',
						dataType : 'json',
						success : function(json){
							
							if(json){
								$.each(json,function(i,key){
									
									var $option = "<option>"+key.NAME+"</option>"
									$me.find(".deptment_select").append($option);
								});
							}
						}
					});
				}
		},
		//查询头的类别获取
		tradertypeSelect : function(){
				var $me = $("#page-wrapper").find("article");
				var _tradertype = $me.find(".tradertype_select").attr("_val");
				
				if(_tradertype){
					var _urlsearch = "searchData.jsp?tradertype=" + _tradertype;
					$.ajax({
						url : _urlsearch,
						data : "",
						type : 'post',
						dataType : 'json',
						success : function(json){
							if(json){
								$.each(json,function(i,key){
									var $option = "<option>"+key.NAME+"</option>"
									$me.find(".tradertype_select").append($option);
								});
							}
						}
					});
				}
		},
		//查询头的地区获取
		areanameSelect : function(){
				var $me = $("#page-wrapper").find("article");
				var _tradertype = $me.find(".areaname_select").attr("_val");
				
				if(_tradertype){
					var _urlsearch = "searchData.jsp?areaname=" + _tradertype;
					$.ajax({
						url : _urlsearch,
						data : "",
						type : 'post',
						dataType : 'json',
						success : function(json){
							if(json){
								$.each(json,function(i,key){
									
									var $option = "<option>"+key.NAME+"</option>"
									$me.find(".areaname_select").append($option);
								});
							}
						}
					});
				}
		},
		//查询头的业务员获取
		empnameSelect : function(){
				var $me = $("#page-wrapper").find("article");
				var _deptname = $me.find(".empname_select").attr("_val");
				
				if(_deptname){
					var _urlsearch = "searchData.jsp?empname=" + _deptname;
					$.ajax({
						url : _urlsearch,
						data : "",
						type : 'post',
						dataType : 'json',
						success : function(json){

							if(json){
								$.each(json,function(i,key){
									
									var $option = "<option>"+key.NAME+"</option>"
									$me.find(".empname_select").append($option);
								});
							}
						}
					});
				}
		},
		//查询头的出纳账户获取
		accoutSelect:function(){
			var $me = $("#page-wrapper").find("article");
			var accoutname = $me.find(".accoutname_select").attr("_val");
			
			if(accoutname){
				var _urlsearch = "searchData.jsp?accoutname=" + accoutname;
				$.ajax({
					url : _urlsearch,
					data : "",
					type : 'post',
					dataType : 'json',
					success : function(json){

						if(json){
							$.each(json,function(i,key){
								
								var $option = "<option>"+key.NAME+"</option>"
								$me.find(".accoutname_select").append($option);
							});
						}
					}
				});
			}
		},
		//查询头的应收的客户获取
		clientSelect:function(){
			var $me = $("#page-wrapper").find("article");
			var clientname = $me.find(".clientname_select").attr("_val");
			
			if(clientname){
				var _urlsearch = "searchData.jsp?clientname=" + clientname;
				$.ajax({
					url : _urlsearch,
					data : "",
					type : 'post',
					dataType : 'json',
					success : function(json){

						if(json){
							$.each(json,function(i,key){
								
								var $option = "<option value="+key.CODE+">"+key.NAME+"</option>"
								$me.find(".clientname_select").append($option);
							});
						}
					}
				});
			}
		},
		//格式化日期：yyyy-MM-dd
		formatDate:function(date) {
		    var myyear = date.getFullYear();
		    var mymonth = date.getMonth()+1;
		    var myweekday = date.getDate();

		    if(mymonth < 10){
		        mymonth = "0" + mymonth;
		    }
		    if(myweekday < 10){
		        myweekday = "0" + myweekday;
		    }
		    return (myyear+"-"+mymonth + "-" + myweekday);
		}
};