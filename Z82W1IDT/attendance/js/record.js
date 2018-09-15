/**
 * 考勤记录窗口
 * <p>封装应用层界面渲染与交互行为</p>
 * @author Bill
 */
var RECORD = {

			/**
			 * 初始化
			 */
			init : function() {
				$.ajax({
					  url: 'attendance/attendance/recordquery.action',
					  success: function(datas){
						  $("#record-table-body").html($("#tmplRecordTableListItem").tmpl(datas.data,{
								signdate : function(){
				    						var attendancedate = this.data.attendanceDate;
				    						var signdate = new Date(attendancedate).format("yyyy-MM-dd");
				    						return signdate;
				    			}
						  }));
						  
					  }
				});
				/*
				 * 下级列表
				 */
				$.ajax({
					  url: 'attendance/select.action',
					  success: function(datas){
						  var selectOptionHtml = "";
						  for(var el in datas.data) {
							  	selectOptionHtml += datas.data[el];  
						    }  
						    $("#underList").append(selectOptionHtml);
					  }
				});
				
				this.bindEvent();
				//this.chart();
			},
			/**
			 * 绑定事件
			*/
			bindEvent : function() {
				$("#reloadpage").on("click",function(){
					document.getElementById("formName").reset();
				})
				
				$("#change-page").on("click",function(){
					var userid = $("#userSelect").val().join("','");
					var signDate = $("#signdate").val();
					var signDndDate = $("#signenddate").val();
					
					var Status = $("#status").val();
					$.ajax({
						  type: "POST",
						  url: 'attendance/search.action',
						  data:{signdate:signDate,status:Status,userId:userid,signenddate:signDndDate},
						  success: function(datas){
							  $("#record-table-body").html($("#tmplRecordTableListItem").tmpl(datas.data,{
								  signinTime : function(){
										var startTime = this.data.signinTime;
										startTime = startTime.replace("T"," ");
										var signinTime = new Date(startTime).format("hh:mm:ss");
										return signinTime;
									},
									signoutTime : function(){
										var endTime = this.data.signoutTime;
										if(!endTime) return "";
										endTime = endTime.replace("T"," ");
										var signoutTime = new Date(endTime).format("hh:mm:ss");
										return signoutTime;
									},signdate : function(){
					    						var attendancedate = this.data.attendanceDate;
					    						var signdate = new Date(attendancedate).format("yyyy-MM-dd");
					    						return signdate;
					    			}}));
						  			}
								});
							})
							
				$("#chartPage").on("click",function(){
//					location.href='/obpm/attendance/record.jsp#chart';
//					location.reload();
					location.reload('/obpm/attendance/record.jsp#chart');
				})
							
			},
			
			/**
			 * 图形报表
			 */
			chart : function() {
				// Step:3 conifg ECharts's path, link to echarts.js from current page.
			    // Step:3 为模块加载器配置echarts的路径，从当前页面链接到echarts.js，定义所需图表路径
			    require.config({
			        paths: {
			            echarts: './js'
			        }
			    });
			    
			    // Step:4 require echarts and use it in the callback.
			    // Step:4 动态加载echarts然后在回调函数中开始使用，注意保持按需加载结构定义图表路径
			    require(
			        [
			            'echarts',
			            'echarts/chart/funnel',
			            'echarts/chart/line',
			            'echarts/chart/pie'
			        ],
			        function (ec) {
			        	$.ajax({
							  type: "POST",
							  url: 'attendance/chart.action',
							  success: function(datas){
								  var value1 = 0;
								  var value2 = 0;
								  var value3 = 0;
								  var value4 = 0;
								  var value5 = 0;
								  for (var i = 0; i < datas.data.length; i++) {
									if(datas.data[i].status==1){
										value1 = datas.data[i].version;
									}else if(datas.data[i].status==-1){
										value2 = datas.data[i].version;
									}else if(datas.data[i].status==-2){
										value3 = datas.data[i].version;
									}else if(datas.data[i].status==-3){
										value4 = datas.data[i].version;
									}else if(datas.data[i].status==-4){
										value5 = datas.data[i].version;
									}
								}
			            //--- 考勤情况 ---
			            var myChart = ec.init(document.getElementById('signin'));
			            myChart.setOption({
			            	title : {
			                    text: '本月考勤情况',
			                    subtext: '企业考勤记录圆饼图',
			                    x:'center'
			                },
			                tooltip : {
			                    trigger: 'item',
			                    formatter: "{a} <br/>{b} : {c} ({d}%)"
			                },
			                legend: {
			                    orient : 'vertical',
			                    x : 'left',
			                    data:['正常','迟到','早退','迟到且早退','地点异常']
			                },
			                toolbox: {
			                    show : true,
			                    feature : {
			                        mark : {show: false},
			                        dataView : {show: true, readOnly: false},
			                        magicType : {
			                            show: true, 
			                            type: ['pie', 'funnel'],
			                            option: {
			                                funnel: {
			                                    x: '25%',
			                                    width: '50%',
			                                    funnelAlign: 'left',
			                                    max: 1548
			                                }
			                            }
			                        },
			                        restore : {show: false},
			                        saveAsImage : {show: true}
			                    }
			                },
			                calculable : true,
			                series : [
			                    {
			                        name:'考勤情况',
			                        type:'pie',
			                        radius : '55%',
			                        center: ['50%', '60%'],
			                        data:[
			                            {value:value1, name:'正常'},
			                            {value:value2, name:'迟到'},
			                            {value:value3, name:'早退'},
			                            {value:value4, name:'迟到且早退'},
			                            {value:value5, name:'地点异常'}
			                        ]
			                    }
			                ]
			            });
			            
						}})
			        }
			    );
			}
};

