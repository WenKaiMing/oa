var Chart = {
		/**
		 * 表格数据配置
		 */
		config : {
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
		/**
		 * 初始化图表
		 */
		init : function(){
			this.config.setupType = ErpCommon.browserRedirect();
			$("article.echarts").each(function(){
				Chart.ajax(this);
			});
			
			this.bindEvent();
		},
		/**
		 * 初始化表格
		 */
		initTable : function(){
			
			$("article.obpmTable").each(function(){
				var $me = $(this);
				var val = $me.attr("_val");
				var _url = "../tableData.jsp?chartType=" + val;
				if($me.attr("_name")){
					_url += "&_name=" + $me.attr("_name");
				}
				$.ajax({
					url : _url,
					data : "",
					type : 'post',
					dataType : 'json',
					success : function(json){
						$me.find(".erpTable").html("").append(Chart.data2TableN($me,json));
						//表格响应式布局配置
						$me.find(".erpTable").find('>table').DataTable({
							info : false,
							searching : false,
							paging : false,
							pagingType : false,
							ordering : false,
					        responsive: true
					});
					}
				});
			});
			$('.form_datetime').datetimepicker({
		        language:  'zh-CN',
		        minView: "month",
		        format: 'yyyy-mm-dd',
		        autoclose:true
		    });
			$(".submit").click(function(){
				Chart.searchTable(this);
			});
			$(".dateRange").change(function(){
				var _val = $(this).find("option:selected").attr("_val");
				var $startTime = $(this).parents(".erpSearch").find(".start-time");
				var $endTime = $(this).parents(".erpSearch").find(".end-time");
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
		bindEvent : function(){

			
			
			if(this.config.setupType == "pc"){
				$(".erpSearch").show();
			}else{
				//查询按钮
				$("button.btn-list-search").click(function(){
					$("#page-wrapper .erpSearch").toggle();
				}).show();
			}
		},
		/**
		 * 表格查询
		 */
		searchTable : function(obj){
			
				var $parentArticle = $(obj).parents(".obpmTable");
				var _starttime = $parentArticle.find(".start-time").val();
				var _endtime = $parentArticle.find(".end-time").val();
				var val = $parentArticle.attr("_val");
				var _url = "../tableData.jsp?chartType=" + val +"&_startTime=" + _starttime + "&_endTime=" + _endtime;
				if($parentArticle.attr("_name")){
					_url += "&_name=" + $me.attr("_name");
				}
				$.ajax({
					url : _url,
					data : "",
					type : 'post',
					dataType : 'json',
					success : function(json){
						$parentArticle.find(".erpTable").html("").append(Chart.data2TableN($parentArticle,json));
						//表格响应式布局配置
						$parentArticle.find(".erpTable").find('>table').DataTable({
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
			if(conf.chartType == "bestSelling"){
				
				conf.key2Val = {
						"GCODE" : "编码", "GNAME" : "名称", "SPEC" : "规格", "UNIT" : "单位", "OQT" : "订单数量" ,"OAM" : "订单金额" ,"SQT" : "发货数量" ,"SAM" : "发货金额" , 
						"BQT" : "发票数量" ,"BAM" : "发票金额" ,"CAM" : "成本金额" ,"CBAM" : "收款金额" , "RQT" : "付款金额","RAM" : "收货数量",
						"UOAM" : "未付金额","GDTYPE" : "类别" 
				};
				conf.td1 = "GDTYPE";
				if(conf.name == null){
					conf.title = "畅销产品业绩汇总表";
				}else{
					conf.title = "产品日流水明细表";
				}
				conf.url = "../detailTable.jsp";
			}else if(conf.chartType == "productType"){
				
				conf.key2Val = {
						"ONHANDQTY" : "数量" , "GDTYPE" : "类别"
				};
				conf.td1 = "GDTYPE";
				conf.title = "产品类别库存占比汇总表";
			}else if(conf.chartType == "goodsonhand"){
				
				conf.key2Val = {
						"STNAME" : "仓库名称","ONHANDQTY" : "实时数量" 
				};
				conf.td1 = "STNAME";
				conf.title = "实时库存表";
			}else if(conf.chartType == "sumDep"){
				
				conf.key2Val = {
						"UOAM" : "订单欠款" , "OQT" : "订单数量" , "OAM" : "订单金额" , "SQT" : "发货数量" , 
						"SAM" : "发货金额" , "BQT" : "发票数量" , "BAM" : "发票金额" , "CAM" : "成本金额" , 
						"CBAM" : "收款金额","DEPTNAME" : "部门名称" 
				};
				conf.td1 = "DEPTNAME";
				conf.title = "部门业绩比较分析表";
				conf.url = "../detailTable.jsp";
			}else if(conf.chartType == "sumRep"){
				
				conf.key2Val = {
						"BILLDATE" : "日期", "OQT" : "订单数量" ,"OAM" : "订单金额" ,"SQT" : "发货数量" ,"SAM" : "发货金额" , 
						"BQT" : "发票数量" ,"BAM" : "发票金额" ,"CAM" : "成本金额" ,"CBAM" : "收款金额" ,
						"UOAM" : "订单欠款","REPNAME" : "业务员" 
				};
				conf.td1 = "REPNAME";
				if(conf.name == "null"){
					conf.title = "业务员业绩汇总表";
				}else{
					conf.title = "业务员业绩日流水明细表";
				}
				conf.outField = ["billdate"];
				conf.url = "../detailTable.jsp";
			}else if(conf.chartType == "sumTrader"){
				
				conf.key2Val = {
						"BILLDATE" : "日期", "OQT" : "订单数量" , "OAM" : "订单金额"  , "SQT" : "发货数量"  , 
						"SAM" : "发货金额"  ,"BQT" : "发票数量"  , "BAM" : "发票金额"  , 
						"CAM" : "成本金额"  , "CBAM" : "收款金额"  , "UCBAM" : "订单欠款",
						"TRADERNAME" : "客户","UOAM" : "未收订单额"
				};
				conf.td1 = "TRADERNAME";
				conf.title = "客户业绩表";
				conf.outField = ["billdate"];
				conf.url = "../detailTable.jsp";
			}else if(conf.chartType == "supplier"){
				
				conf.key2Val = {
						"BILLDATE" : "日期", "OQT" : "订单数量" ,"OAM" : "订单金额" ,"SQT" : "发货数量" ,"SAM" : "发货金额" , 
						"BQT" : "发票数量" ,"BAM" : "发票金额" ,"CAM" : "成本金额" ,"CBAM" : "收款金额" , "RQT" : "付款金额","RAM" : "收货数量",
						"UOAM" : "未付金额","TRADERNAME" : "供应商" 
				};
				conf.td1 = "TRADERNAME";
				conf.title = "供应商应付比较分析图表";
				conf.outField = ["billdate"];
				conf.url = "../detailTable.jsp";
			}else if(conf.chartType == "wareHouse"){
				
				conf.key2Val = {
						"ST" : "仓库" ,"GC" : "编码" ,"GN" : "名称" ,"SPEC" : "规格" ,"UN" : "单位" ,"GT" : "类别" ,
						"SQT" : "期初数量" ,"IQT" : "入仓数量" ,"OQT" : "出仓数量" ,"CQT" : "结存数量"
				};
				conf.td1 = "ST";
				conf.title = "仓库库存占比分析表";
			}else if(conf.chartType == "cashBanTrend"){
				
				conf.key2Val = {
						"UOAM" : "订单欠款" , "OQT" : "订单数量" , "OAM" : "订单金额" , "SQT" : "发货数量" , 
						"SAM" : "发货金额" , "BQT" : "发票数量" , "BAM" : "发票金额" , "CAM" : "成本金额" , 
						"CBAM" : "收款金额","DEPTNAME" : "部门" 
				};
				conf.td1 = "DEPTNAME";
				conf.title = "现金银行余额分析表";
			}else if(conf.chartType == "subjectBalance"){
				conf.key2Val = {
						"UOAM" : "订单欠款" , "OQT" : "订单数量" , "OAM" : "订单金额" , "SQT" : "发货数量" , 
						"SAM" : "发货金额" , "BQT" : "发票数量" , "BAM" : "发票金额" , "CAM" : "成本金额" , 
						"CBAM" : "收款金额","DEPTNAME" : "部门" 
				};
				conf.td1 = "DEPTNAME";
				conf.title = "科目余额汇总表";
			}
			return conf;
		},
		/**
		 * option : 选项参数
			 arrys : 数组对象数据，
			 xAxi : x轴字段，
			 outField : 非数据字段
		 */
		data2Option4Bar : function(_params){
			
			var option = {
				    title : {
				        text: _params.title,
				        subtext: _params.subTitle
				    },
				    tooltip : {
				        trigger: 'axis'
				    },
				    legend: {
				    	show : false,
				        orient : 'vertical',
				        x : 'center',
				        data:[]
				    },
				    grid : {
				    	x : "70px"
				    },
				    toolbox: {
				        show : true,
				        feature : {
				            mark : {show: true},
//				            dataView : {show: true, readOnly: false},
//				            magicType : {show: true, type: ['line', 'bar']},
//				            restore : {show: true},
				            saveAsImage : {show: false}
				        }
				    },
				    calculable : true,
				    xAxis : [
				        {
				            type : 'category',
				            data : []
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value'
				        }
				    ],
				    series : []
			};
			var arrLen = _params.vals.length;
			for(var name in _params.vals[0]){
				var isOut = false;	//是否非数据字段
				for(var j=0;j<_params.outField.length;j++){
					var nameTmp = name.toUpperCase();
					var outTmp = _params.outField[j].toUpperCase();
					if(nameTmp == outTmp && _params.xAxi != _params.outField[j]){
						isOut = true;
						break;
					}
				}
				if(isOut)continue;	//非数据字段时不统计
				
				var jsonT ={
				        name:'',
				        type : _params.magicType,
				        data:[],
				        markPoint : {
				            data : [
//				                {type : 'max', name: '最大值'},
//				                {type : 'min', name: '最小值'}
				            ]
				        }
				    };
				
				for(var i=0;i<arrLen;i++){
					if(name.toUpperCase() == _params.nameField.toUpperCase()){		// x轴值
						option.xAxis[0].data.push(_params.vals[i][name]);
					}else{
						jsonT.data.push(_params.vals[i][name]);
					}
				}
				if(name != _params.nameField){
					var nameTmp = name.toUpperCase();
					jsonT.name = _params.key2Val[nameTmp];
					option.legend.data.push(_params.key2Val[nameTmp]);
					option.series.push(jsonT);
				}
			}
			return option;
		},

		/**
		**/
		data2TableN : function($me, json){
			var conf = this.setParamsByType($me, json);	//配置数据
			
			var $tableH = $("<table class='table table-striped table-bordered table-hover' style='width:100%'></table>");
			//$tableH.append("<caption>" + conf.title + "</caption>");
			var _var = $me
//			$me.find(".obpmTable-title").html(conf.title);
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
		 * option : 选项参数
			 arrys : 数组对象数据，
			 xAxi : x轴字段，
			 outField : 非数据字段
		 */
		data2Option4Pie : function(_params){
			var option = {
				    title : {
				        text: _params.title,
				        subtext: _params.subTitle,
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c} ({d}%)"
				    },
				    legend: {
				    	show : false,
				        orient : 'vertical',
				        x : 'left',
				        data:[]
				    },
				    toolbox: {
				        show : false,
				        feature : {
				            mark : {show: true},
				            saveAsImage : {show: false}
				        }
				    },
				    calculable : true,
				    series : []
			};
			var jsonT ={
			        name : _params.fromField,
			        type : _params.magicType,
		            radius : '55%',
		            center: ['50%', '60%'],
		            radius : '55%',
		            center: ['50%', '50%'],
			        data:[]
			};
			var vals = _params.vals;
			for(var i=0; i<vals.length;i++){
				var nameField = _params.nameField.toUpperCase();
				var dataT1 = {name:"",value:0};
				
				option.legend.data.push(vals[i][nameField]);
				dataT1.name = vals[i][nameField];
				dataT1.value = vals[i][_params.valField];
				jsonT.data.push(dataT1);
			}
			option.series.push(jsonT);
			return option;
		},

		/**
		 * option : 选项参数
			 arrys : 数组对象数据，
			 xAxi : x轴字段，
			 outField : 非数据字段
		 */
		data2Option4Line : function(_params){
			var title, subTitle, key2Val, magicType, arrys1, xAxi, valField,groupField;
			var option = {
				    title : {
				        text : _params.title,
				        subtext : _params.subTitle,
				        x : "center"
				    },
				    tooltip : {
				        trigger: 'axis'
				    },
				    legend: {
				        orient : 'vertical',
				        x : 'left',
				        data:[]
				    },
				    toolbox: {
				        show : true,
				        feature : {
				            mark : {show: true},
				            saveAsImage : {show: false}
				        }
				    },
				    calculable : true,
				    xAxis : [
				        {
				            type : 'category',
				            data : []
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value'
				        }
				    ],
				    series : []
			};
			var arrLen = _params.vals.length;
			var jsonT = {};
			var groupVal = "";
			var xAxiArr = [];
			
			var isNew = false;
			var nameCount = 0;		//subname数量统计
			var hasPut = false;
			for(var i=0;i<_params.vals.length;i++){
				if(groupVal == "" || groupVal != _params.vals[i][_params.groupField]){		//subname变更时添加新的jsonT，使用不同拆线进行显示
					nameCount++;
					isNew = true;
					groupVal = _params.vals[i][_params.groupField];
					option.legend.data.push(_params.vals[i][_params.groupField]);
					jsonT = {
					        name:_params.vals[i][_params.groupField],
					        type : _params.magicType,
					        data:[],
					        markPoint : {
					            data : []
					        }
					    };
				}else{
					isNew = false;
					var jsonTs = option.series;
					for(var j=0;j<=jsonTs.length;j++){
						if(_params.vals[i][_params.groupField] == jsonTs[j].name){
							jsonT = jsonTs[j];
							break;
						}
					}
				}
				
				jsonT.data.push(_params.vals[i][_params.valField]);
				if(isNew){
					if(nameCount ==2){	//把月份设置进option
						option.xAxis[0].data = xAxiArr;
					}
					option.series.push(jsonT);
					jsonT = {};
				}
				if(nameCount == 1){		//添加x轴月份
					xAxiArr.push(_params.vals[i][_params.xAxi] + "月份");
				}
			}
			return option;
		},
		/**
		 * 获取元素中的属性键值对以json对象返回
		 * @param $opt
		 * @returns {___anonymous7560_7860}
		 */
		getParams : function($opt){
			return _params = {
					title : $opt.attr("_title"),
					subTitle : "",
					fromField : $opt.attr("_fromField"),
					nameField: $opt.attr("_nameField"),
					valField : $opt.attr("_valField"),
					magicType : $opt.attr("_magicType"),
					url : $opt.attr("_href"),
					groupField : $opt.attr("_groupField"),
					vals : {},
					key2Val : {},
					outField : []
				};
		},
		/**
		 * 根据图表类型获取opts
		 * @param _params
		 * @returns
		 */
		data2Option : function(_params){
			if(_params === null){
				return false;
			}
			if(_params.magicType == "bar"){
				return Chart.data2Option4Bar(_params);
			}else if(_params.magicType == "pie"){
				return Chart.data2Option4Pie(_params);
			}else if(_params.magicType == "line"){
				return Chart.data2Option4Line(_params);
			}
		},
		/**
		 * 获取图表数据并渲染
		 */
		ajax : function(me){
			var $this = $(me);
			var val = $this.attr("_val");
//			if(val == "" || val != "goodsonhand"){
			if(val == ""){
				return false;
			}
			var _url = "../dataPage.jsp?chartType=" + val;
			$.ajax({
				url : _url,
				data : "",
				type : 'post',
				dataType : 'json',
				success : function(json){
					if(json === null){
						return false;
					}
					var option = null,
						params = Chart.getParams($this),		//获取参数
						myChart = echarts.init(me);
					
					params.vals = json;
					
					if(val == "bestSelling"){		//畅销产品类别占比分析图表
						
					}else if(val == "cashBanTrend"){	//现金银行余额分析图表
						
						params.key2Val = {
								"SUBNAME" : "现金银行名称" ,"NYEAR" : "年份" ,"STANDARDBALA" : "期初金额" ,"NMONTH" : "月份"
						};
					}else if(val == "goodsonhand"){	//实时库存图表
						
						params.key2Val = {
								"STNAME" : "仓库名称","ONHANDQTY" : "实时数量" 
						};
					}else if(val == "productType"){	//产品类别库存占比分析图表
						
					}else if(val == "sumDep"){		//部门业绩比较分析表
						
						params.key2Val = {
								"UOAM" : "订单欠款" , "OQT" : "订单数量" , "OAM" : "订单金额" , "SQT" : "发货数量" , 
								"SAM" : "发货金额" , "BQT" : "发票数量" , "BAM" : "发票金额" , "CAM" : "成本金额" , "CBAM" : "收款金额",
								"DEPTNAME" : "部门名称","BILLDATE" : "出货日期"
						};
						params.outField = ["OQT","SQT","BQT" ,"BAM","CAM" ,"UOAM"];		//例外字段，即非数字字段，不进行统计
					}else if(val == "sumRep"){	//业务员业绩比较分析表
						
						params.key2Val = {
								"OQT" : "订单数量" ,"OAM" : "订单金额" ,"SQT" : "发货数量" ,"SAM" : "发货金额" , 
								"BQT" : "发票数量" ,"BAM" : "发票金额" ,"CAM" : "成本金额" ,"CBAM" : "收款金额" ,"UOAM" : "订单欠款" 
						};
						params.outField = ["OQT","SQT","BQT" ,"BAM","CAM" ,"UOAM"];		//例外字段，即非数字字段，不进行统计
					}else if(val == "sumTrader"){		//客户业绩图表
						
						params.key2Val = {
								"OQT" : "订单数量" , "OAM" : "订单金额"  , "SQT" : "发货数量"  , 
								"SAM" : "发货金额"  ,"BQT" : "发票数量"  , "BAM" : "发票金额"  , 
								"CAM" : "成本金额"  , "CBAM" : "收款金额"  , "UOAM" : "未收订单额" 
						};
						params.outField = ["OQT","SQT","BQT" ,"BAM","CAM" ,"UOAM"];		//例外字段，即非数字字段，不进行统计
					}else if(val == "supplier"){		//供应商应付比较分析图表
						
						params.key2Val = {
								"OQT" : "订单数量" ,"OAM" : "订货金额" ,"SQT" : "发货数量" ,"SAM" : "发货金额" , "RQT" : "付款金额","RAM" : "",
								"BQT" : "发票数量" ,"BAM" : "发票金额" ,"CAM" : "成本金额" ,"CBAM" : "收货金额" ,"UOAM" : "订单欠款" 
						};
						params.outField = ["OQT","SQT","BQT" ,"BAM","CAM" ,"UOAM","RAM"];		//例外字段，即非数字字段，不进行统计
					}else if(val == "wareHouse"){	//仓库库存占比分析图表
						
					}
					
					option = Chart.data2Option(params);
					myChart.setOption(option);
//					if(params.url != ""){
//						myChart.on("click",function(){
//							window.location.href = params.url + "?chartType=" + val;
//						});
//					}
//					window.onresize = myChart.resize;
				}
			});
		}
};