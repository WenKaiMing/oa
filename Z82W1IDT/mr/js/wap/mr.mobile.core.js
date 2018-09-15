/**
 * PM 核心类
 * <p>封装PM应用层界面渲染与交互行为</p>
 */
var MR = {
	/**
	 * 初始化
	 */
	init : function() {
		MR.bindEvent();
		//区域、会议室下拉选择隐藏
		$(".mr-list-block-option").css("display","none");
		
		//鼠标放上去时显示
		$(".mr-list-block").on("mouseover",function(e){
			var option = $(this).find(".mr-list-block-option");
			option.css("display","block");
		});
		//鼠标离开时隐藏
		$(".mr-list-block").on("mouseout",function(e){
			var option =$(this).find(".mr-list-block-option");
			option.css("display","none");
		});
		
		//对区域、会议室选定后，获取后台信息刷新页面
		$(".mr-list-block-option").on("click",function(){
			alert($(this).text());
		});
	},

	/**
	 * 绑定事件
	 */
	bindEvent : function() {
	    $(".nav-item").click(function() {//左侧导航点击事件
	        $(".nav-item a").removeClass("selected");
	        $(this).find("a").addClass("selected"),
	        $(".pm-page").hide();
	        var target = $(this).attr("data-target");
	        $("." + target).show();
	        if(target.indexOf("project")!=-1){
	        	PM.project.renderProjectPage();
	        }else if(target.indexOf("-reservation")!=-1){
	        	MR.reservation();
	        	MR.area();
	        	//MR.room();
	        }else if(target.indexOf("-management")!=-1){
	        	MR.management();
	        	MR.area_mag_list();
	        	//初始化区域的下拉列表
	        	//MR.room_mag();
	        }else if(target.indexOf("-myreservation")!=-1){
	        	MR.cache.date = null;
				MR.cache.area = null;
				MR.cache.room = null;
				MR.cache.pages = 1;
				MR.cache.lines = 5;
	        	MR.myreservation();
	        	MR.area_myr_list();
	        }
	    }),
	    //我的预定弹出层关闭
	    $("#myreservation-box-close").on("click",function(){
	    	closeMyReservation();
	    });
	    $("#reservation-box-close").on("click",function(){
	    	closeReservation();
	    });
	    $("#management-box-close").on("click",function(){
	    	closeManagement();
	    });
	    
	    //会议室预定-点击区域时
		$("#mr-reservation-area-list").on("change",function(){
			MR.room($(this).find("option:selected").attr("data-id"));
			MR.reservation(2,$("#mr-reservation-room-list").find("option:selected").attr("data-id"));
			//jqm重新渲染select标签的值
			$("#mr-reservation-room-list").selectmenu('refresh', true);
//			$("#mr-reservation-room-list")[0].value;
//			$("#mr-reservation-room-list mr-list-block-option").value
//			$("#mr-reservation-room-list").find("option[0]").attr("selected",true);
		});
	    $("#mr-reservation-room-list").on("change",function(){
	    	MR.reservation(2,$(this).find("option:selected").attr("data-id"));
	    });
	    
	    //会议室管理-点击区域时
		$("#mr-management-area-list").on("change",function(){
			MR.room_mag_list($(this).find("option:selected").attr("data-id"));
			$("#mr-management-area-list").selectmenu('refresh', true);
			$("#mr-management-room-list").selectmenu('refresh', true);
			MR.management(1,$(this).find("option:selected").attr("data-id"));
		});
	    $("#mr-management-room-list").on("change",function(){
			MR.management(2,$(this).find("option:selected").attr("data-id")); 
		});
//	    
	    //我的预定-点击区域
	    $("#mr-myreservation-area-list").on("change",function(){
			MR.room_myr_list($(this).find("option:selected").attr("data-id"));
			$("#mr-myreservation-area-list").selectmenu('refresh', true);
			$("#mr-myreservation-room-list").selectmenu('refresh', true);
			MR.cache.area = $(this).find("option:selected").attr("data-id");
			MR.cache.room = null;
			MR.cache.pages = 1;
    		MR.myreservation();
    		
		});
	    $("#mr-myreservation-room-list").on("change",function(){
			//MR.management(2,$(this).attr("data-id"));
	    	MR.cache.room = $(this).find("option:selected").attr("data-id");
	    	MR.cache.pages = 1;
    		MR.myreservation();
		});
	    
	    $(".reservation-table td").on("click",function(){
			if($(this).attr("data-status")==0)
			{
//				$(this).css({ background: "#56F202" });
//				$(this).attr("data-status",1);
			}else if($(this).attr("data-status")==1){
//				$(this).css({ background: "#C7C7C7" });
//				$(this).attr("data-status",0);
			}
		});
	    
	    $("#reservation-tableid tr td").on("click",function(){
	    	var dataid = $(this).attr("data-id");
	    	if(typeof dataid != "undefined")
	    	{
	    		var data;
	    		var url = '/obpm/mr/reservation/testmr.action';
	            //这里应该通过点击的td作为参数，调用action获得会议预定信息，以json形式为参数传入方法pop
	    		jQuery.ajax({
	    		    type:"POST",     
	    		    url:url,      
	    		    data:"id="+dataid, //发送到服务器的数据。将自动转换为请求字符串格式。
	    		    dataType:"text",//预期服务器返回的数据类型。如果不指定，jQuery 将自动根据 HTTP 包 MIME 信息来智能判断
	    		    async:false,   //true为异步请求，false为同步请求
	    		    success:function(back){    //请求成功后的回调函数。
	    		    	data = eval("(" + back + ")");
	    		    },
	    		    error:function(){     //请求失败后的回调函数。
	    		        alert("请求失败");
	    		        return;
	    		    }
	    		});
	    		$('#meeting_title').text("预定会议");
	    		$('#reservation_name')[0].value = data.name;
	    		$('#reservation_content')[0].value = data.content;
	    		$('#reservation_number')[0].value = data.number;
	    		$('#reservation_starttime')[0].value = data.starttime;
	    		$('#reservation_endtime')[0].value = data.endtime;
	    		$('#reservation_id')[0].value = data.id;
	    	}else
	    		$('#meeting_title').text("新建预定");
	    	$("#mr-reservation-box").popup('open');
	    });
	    
			
	},

	
	//初始化 会议室预定页面
	reservation : function(x,y){

		var params ={};
		var url="/obpm/mr/room/queryallroom.action";
		if(x=="1"){	//区域
			url = "/obpm/mr/room/queryroombyarea.action?areaid="+y;
			MR.cache.area = y;
			if(MR.cache.date!=null) params = {date:MR.cache.date};
		}else if(x=="2"){	//会议室
			url = "/obpm/mr/room/queryroombyid.action?id="+y;
			MR.cache.room = y;
			if(MR.cache.date!=null) params = {date:MR.cache.date};
		}else if(x=="3"){	//时间
			params = {date:y};
			MR.cache.date = y;
			if(MR.cache.room!=null)
				url = "/obpm/mr/room/queryroombyid.action?id="+MR.cache.room;
			else if(MR.cache.area!=null)
				url = "/obpm/mr/room/queryroombyarea.action?areaid="+MR.cache.area;
		}else{
			MR.cache.date = null;
			MR.cache.area = null;
			MR.cache.room = null;
		}
		
		MR.renderReservation(params,function(backdata){
			
			var a= backdata;
			
			$(".reservation-table").find("td").css({ background: "#FFFFFF" });
			for(var i=0; i<backdata.length; i++)
			{
				if(backdata[i].roomId == MR.cache.room)
				{
					var id = backdata[i].id;
					//var roomId = backdata[i].roomId;
					var startTime = backdata[i].startTime;
					var endTime = backdata[i].endTime;
					
					var timeattr1 = startTime.substring(11,16).split(":");
					var timeattr2 = endTime.substring(11,16).split(":");
					var t1 = parseInt(timeattr1[0]);
					if(timeattr1[1]=="30") t1 = t1+0.5;
					var t2 = parseInt(timeattr2[0]);
					if(timeattr2[1]=="30") t2 = t2+0.5;
					
					var start = (t1*2)%18+1;
					var end = t2==18?18:(t2*2)%18;
					
					for(var j=start;j<=end;j++)
					{
						var target = $(".reservation-table").find("td").get(j);
						$(target).attr("data-id", id);
						$(target).css({ background: "#C7C7C7" });
					}
				}
			}
			
		});
	},
	
	//渲染 会议室预定页面
	renderReservation : function(params,callback){
		params = params || {};
		if(typeof params.status == "undefined"){
			params.status = 3;
		}
		$.getJSON("/obpm/mr/reservation/queryreservation.action",params,function(result){
			if(1==result.status){
				if(callback && typeof callback == "function"){
					callback(result.data);
				}
			}else{
				Utils.showMessage(result.message, "error");
			}
		});
	}, 
	
	area : function(){
		$.ajaxSettings.async = false;
		$.getJSON("/obpm/mr/area/queryallarea.action",function(area){
			$("#mr-reservation-area-list").html($("#tmplAreaListItem").tmpl(area.data));
		});
	},
	room : function(areaid){
		var url = "/obpm/mr/room/queryallroom.action";
		if(typeof areaid != "undefined")
			url = "/obpm/mr/room/queryroombyarea.action?areaid="+areaid;
		$.ajaxSettings.async = false;
		$.getJSON(url,function(room1){
			$("#mr-reservation-room-list").html($("#tmplRoomListItem").tmpl(room1.data));
		});
	},
	
	
	
	//初始化 会议室管理页面
	management : function(x,y){
		var url="/obpm/mr/room/queryallroom.action";
		if(x=="1"){	//区域
			url = "/obpm/mr/room/queryroombyarea.action?areaid="+y;
		}else if(x=="2"){	//会议室
			url = "/obpm/mr/room/queryroombyid.action?id="+y;
		}
		$.getJSON(url,function(room){
			$("#mr-management-table-body").html($("#tmplManagementTableListItem").tmpl(room.data));
			//readygo();
		});
	},
	
	area_mag_list : function(){
		$.ajaxSettings.async = false;
		$.getJSON("/obpm/mr/area/queryallarea.action",function(area){
			$("#mr-management-area-list").html($("#tmplAreaListItem").tmpl(area.data));
		});
	},
	area_mag_select : function(){
		$.ajaxSettings.async = false;
		$.getJSON("/obpm/mr/area/queryallarea.action",function(area){
			$("#management_area1").html($("#tmplAreaListItem").tmpl(area.data));
		});
	},
	
	room_mag_list : function(areaid){
		var url = "/obpm/mr/room/queryallroom.action";
		if(typeof areaid != "undefined")
			url = "/obpm/mr/room/queryroombyarea.action?areaid="+areaid;
		$.ajaxSettings.async = false;
		$.getJSON(url,function(room1){
			$("#mr-management-room-list").html($("#tmplRoomListItem").tmpl(room1.data));
		});
	},
	
	area_myr_list : function(){
		$.ajaxSettings.async = false;
		$.getJSON("/obpm/mr/area/queryallarea.action",function(area){
			$("#mr-myreservation-area-list").html($("#tmplAreaListItem").tmpl(area.data));
		});
	},
	room_myr_list : function(areaid){
		var url = "/obpm/mr/room/queryallroom.action";
		if(typeof areaid != "undefined")
			url = "/obpm/mr/room/queryroombyarea.action?areaid="+areaid;
		$.ajaxSettings.async = false;
		$.getJSON(url,function(room1){
			$("#mr-myreservation-room-list").html($("#tmplRoomListItem").tmpl(room1.data));
		});
	},
	
//	area_res_select : function(){
//		var areaid;
//		$.ajaxSettings.async = false;
//		$.getJSON("/obpm/mr/area/queryallarea.action",function(area){
//			$("#mr-reservation-pop-area").html($("#tmplAreaSelectItem").tmpl(area.data));
//			areaid = area.data[0].id;
//		});
//		return areaid;
//	},
//	room_res_select : function(areaid){
//		//var url = "/obpm/mr/room/queryallroom.action";
//		if(typeof areaid != "undefined")
//			url = "/obpm/mr/room/queryroombyarea.action?areaid="+areaid;
//		else{
//			var areaids = $('#mr-reservation-pop-area')[0].value ;
//			url = "/obpm/mr/room/queryroombyarea.action?areaid="+areaids;
//		}
//		$.ajaxSettings.async = false;
//		$.getJSON(url,function(room1){
//			$("#mr-reservation-pop-room").html($("#tmplRoomSelectItem").tmpl(room1.data));
//		});
//	},
	
	room_mag_select : function(areaid){
		var url = "/obpm/mr/room/queryallroom.action";
		if(typeof areaid != "undefined")
			url = "/obpm/mr/room/queryroombyarea.action?areaid="+areaid;
//		else{
//			var areaids = $('#mr-management-pop-room')[0].value ;
//			url = "/obpm/mr/room/queryroombyarea.action?areaid="+areaid;
//		}
		$.getJSON(url,function(room1){
			$("#mr-management-pop-room").html($("#tmplRoomSelectItem").tmpl(room1.data));
		});
	},
	
	area_myr_select : function(){
		var id;
		$.ajaxSettings.async = false;
		$.getJSON("/obpm/mr/area/queryallarea.action",function(area){
			$("#mr-myreservation-pop-area").html($("#tmplAreaSelectItem").tmpl(area.data));
			id = area.data[0].id;
		});
		return id;
	},
	room_myr_select : function(areaid){
		//var url = "/obpm/mr/room/queryallroom.action";
		if(typeof areaid != "undefined")
			url = "/obpm/mr/room/queryroombyarea.action?areaid="+areaid;
		else{
			var areaids = $('#mr-myreservation-pop-area')[0].value ;
			url = "/obpm/mr/room/queryroombyarea.action?areaid="+areaids;
		}
		$.ajaxSettings.async = false;
		$.getJSON(url,function(room1){
			$("#mr-myreservation-pop-room").html($("#tmplRoomSelectItem").tmpl(room1.data));
		});
	},
	//初始化 我的预定页面
	myreservation : function(){
		//增加判断条件
		var url ="/obpm/mr/reservation/querymyreservation.action";
		params ={};
		if(MR.cache.pages!=null){
			params.pages=MR.cache.pages;
		}
		if(MR.cache.lines!=null){
			params.lines=MR.cache.lines;
		}
		if(MR.cache.date!=null){
			params.date1 = MR.cache.date;
		}
		if(MR.cache.date2!=null){
			params.date2 = MR.cache.date2;
		}
		if(MR.cache.area!=null){
			params.area = MR.cache.area;
		}
		if(MR.cache.room!=null){
			params.room = MR.cache.room;
		}
		if(typeof params.status == "undefined"){
			params.status = 3;
		}
		$.getJSON(url,params,function(result){
			if(1==result.status){
				$("#mr-myreservation-table-body").html($("#tmplMyreservationTableListItem").tmpl(result.data));
				$("#countPages").html(result.count);
				$("#currPages").html(params.pages);
				MR.cache.countpages = result.count;
				//readygo();
			}else{
				layer.msg("查询失败！", 1, 3);
			}
		});
		
	},
	
	area_edit :function(){
		if($('#mr-management-pop-area option:selected').text()!=null)
			$('#mr-management-pop-area2')[0].value =$('#mr-management-pop-area option:selected').text();
		$("#area_select").css("display","none");
		$("#area_select_edit").css("display","block");
		$("#area_select_edit2").css("display","block");
		$('#mr-management-pop-area-box').css("display","none");
		$('#mr-management-pop-area2-box').css("display","block");
		$('#mr-management-pop-area2').removeAttr("readonly");
	},
	area_edit_cancel :function(){
		$("#area_select").css("display","block");
		$("#area_select_edit").css("display","none");
		$("#area_select_edit2").css("display","none");
		$('#mr-management-pop-area2-box').css("display","none");
		$('#mr-management-pop-area-box').css("display","block");
	},
	
	/**
	 * 缓存对象
	 */
	cache : {
		date2 : null,
		date : null,//日期
		area : null,//区域
		room : null,//会议室
		pages : 1,
		lines : 0,
		countpages : null
	}
	
	
	
//	area : function(){
//		$.getJSON("/obpm/mr/area/queryallarea.action",function(area){
//			$("#mr-reservation-area-list").html($("#tmplAreaListItem").tmpl(area.data));
//
//		});
//	},
	
};




