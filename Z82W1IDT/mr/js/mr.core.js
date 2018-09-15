/**
 * MR 核心类
 * <p>封装MR应用层界面渲染与交互行为</p>
 */
var MR = {
	/**
	 * 初始化
	 */
	init : function() {
		this.bindEvent();
	
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
	        	Utils.closeReservationPanel();
	        	document.getElementById("hello").value = Utils.getToday();
	        	//MR.room();
	        }else if(target.indexOf("-management")!=-1){
	        	MR.management();
	        	MR.area_mag_list();
	        	Utils.closeManagementPanel();
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
	        	Utils.closeMyReservationPanel();
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
	    
	    $("#all_checkbox").on("click",function(){
	    	if($('#all_checkbox').is(":checked")==true){
	    		$('input[name=management_checkbox]').prop("checked",true);
	    	}
	    	else if($('#all_checkbox').is(":checked")==false){
	    		$('input[name=management_checkbox]').prop("checked",false);
	    	}
	    });
	    
	    //会议室预定-点击区域时
		$("#mr-reservation-area-list").on("click",".mr-list-block-option",function(){
//			$(this).css({ background: "#F2F2F2" });
			MR.reservation(1,$(this).attr("data-id"));
			MR.room($(this).attr("data-id"));
		});
	    $("#mr-reservation-room-list").on("click",".mr-list-block-option",function(){
			//点击会议时
	    	//$(this).css({ background: "#F2F2F2" });
			MR.reservation(2,$(this).attr("data-id")); 
		});
	    
	    //会议室管理-点击区域时
		$("#mr-management-area-list").on("click",".mr-list-block-option",function(){
			//$(this).css({ background: #F2F2F2 });
			MR.management(1,$(this).attr("data-id"));
			MR.room_mag_list($(this).attr("data-id"));
		});
	    $("#mr-management-room-list").on("click",".mr-list-block-option",function(){
	    	//$(this).css({ background: #F2F2F2 });
			MR.management(2,$(this).attr("data-id")); 
		});
	    
	    //我的预定-点击区域
	    $("#mr-myreservation-area-list").on("click",".mr-list-block-option",function(){
			//MR.management(1,$(this).attr("data-id"));
			MR.room_myr_list($(this).attr("data-id"));
			MR.cache.area = $(this).attr("data-id");
			MR.cache.room = null;
			MR.cache.pages = 1;
    		MR.myreservation();
		});
	    $("#mr-myreservation-room-list").on("click",".mr-list-block-option",function(){
			//MR.management(2,$(this).attr("data-id"));
	    	MR.cache.room = $(this).attr("data-id");
	    	MR.cache.pages = 1;
    		MR.myreservation();
		});
	    
	    $('#myTab a').click(function (e) {
	    	  e.preventDefault();
	    	  $(this).tab('show');
	    	  
	    });
	    $("#mr-management-pop-area").on("change",function(){
	    	$("#mr-management-pop-room")[0].value="";
	    	$("#management_number")[0].value="";
	    	$("#management_equipment")[0].value="";
	    	$("#management_note")[0].value="";
	    });	
	    
//	    $(".close-popup,.btn-cancel").click(function() {//关闭弹出层的钮点击事件
//	        return Utils.hidePop();
//	    });
//	    $(window).resize(function(){
//	    	  Utils.resizeFourPart();
//	    });
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
			
			$.getJSON(url,function(allroom){
				$("#mr-reservation-table-body").html($("#tmplReservationTableListItem").tmpl(allroom.data));
				
				for(var i=0; i<backdata.length; i++){
					var id = backdata[i].id;
					var roomId = backdata[i].roomId;
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
						var target = $("#"+roomId).find("td").get(j);
						//$(target).text(backdata[i].creator);
						$(target).attr("data-id", id);
						$(target).css({ background: "#ff9f02" });
					}
				}
				readygo();
			});
			
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
		$.getJSON("/obpm/mr/area/queryallarea.action",function(area){
			$("#mr-reservation-area-list").html($("#tmplAreaListItem").tmpl(area.data));

		});
	},
	room : function(areaid){
		var url = "/obpm/mr/room/queryallroom.action";
		if(typeof areaid != "undefined")
			url = "/obpm/mr/room/queryroombyarea.action?areaid="+areaid;
		
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
			readygo();
		});
	},
	
	area_mag_list : function(){
		$.getJSON("/obpm/mr/area/queryallarea.action",function(area){
			$("#mr-management-area-list").html($("#tmplAreaListItem").tmpl(area.data));
		});
	},
	room_mag_list : function(areaid){
		var url = "/obpm/mr/room/queryallroom.action";
		if(typeof areaid != "undefined")
			url = "/obpm/mr/room/queryroombyarea.action?areaid="+areaid;
		
		$.getJSON(url,function(room1){
			$("#mr-management-room-list").html($("#tmplRoomListItem").tmpl(room1.data));
		});
	},
	
	area_myr_list : function(){
		$.getJSON("/obpm/mr/area/queryallarea.action",function(area){
			$("#mr-myreservation-area-list").html($("#tmplAreaListItem").tmpl(area.data));
		});
	},
	room_myr_list : function(areaid){
		var url = "/obpm/mr/room/queryallroom.action";
		if(typeof areaid != "undefined")
			url = "/obpm/mr/room/queryroombyarea.action?areaid="+areaid;
		
		$.getJSON(url,function(room1){
			$("#mr-myreservation-room-list").html($("#tmplRoomListItem").tmpl(room1.data));
		});
	},
	
	area_res_select : function(){
		var areaid;
		$.ajaxSettings.async = false;
		$.getJSON("/obpm/mr/area/queryallarea.action",function(area){
			$("#mr-reservation-pop-area").html($("#tmplAreaSelectItem").tmpl(area.data));
			areaid = area.data[0].id;
		});
		return areaid;
	},
	room_res_select : function(areaid){
		//var url = "/obpm/mr/room/queryallroom.action";
		if(typeof areaid != "undefined")
			url = "/obpm/mr/room/queryroombyarea.action?areaid="+areaid;
		else{
			var areaids = $('#mr-reservation-pop-area')[0].value ;
			url = "/obpm/mr/room/queryroombyarea.action?areaid="+areaids;
		}
		$.ajaxSettings.async = false;
		$.getJSON(url,function(room1){
			$("#mr-reservation-pop-room").html($("#tmplRoomSelectItem").tmpl(room1.data));
		});
	},
	
	area_mag_select : function(){
		$.getJSON("/obpm/mr/area/queryallarea.action",function(area){
			$("#mr-management-pop-area").html($("#tmplAreaSelectItem").tmpl(area.data));
			$("#mr-management-pop-area1").html($("#tmplAreaSelectItem").tmpl(area.data));
		});
	},
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
				
				$("#currPages").html(params.pages);
				MR.cache.countpages = result.count;
				$("#countPages").html(MR.cache.countpages);
				for(var i=0;$(".timepos").length>i;i++)
				{
					var s = $(".timepos")[i];
					$(s).text($(s).text().substring(0,17)+$(s).text().substring(28,33)); 
				}
				readygo();
			}else{
				Utils.showMessage(result.message, "error");
			}
		});
		
	},
	
	area_edit :function(){
		if($('#mr-management-pop-area1 option:selected').text()!=null)
			$('#mr-management-pop-area2')[0].value =$('#mr-management-pop-area1 option:selected').text();
		$("#area_select").css("display","none");
		$("#area_select_edit").css("display","block");
		$("#area_select_edit2").css("display","block");
		$('#mr-management-pop-area1-box').css("display","none");
		$('#mr-management-pop-area2-box').css("display","block");
		$('#mr-management-pop-area2').removeAttr("readonly");
	},
	area_edit_cancel :function(){
		$("#area_select").css("display","block");
		$("#area_select_edit").css("display","none");
		$("#area_select_edit2").css("display","none");
		$('#mr-management-pop-area2-box').css("display","none");
		$('#mr-management-pop-area1-box').css("display","block");
	},
	
	/**
	 * 缓存对象
	 */
	cache : {
		date2 : null,
		date : null,//日期
		area : null,//区域
		room : null,//会议室
		pages : null,
		lines : null,
		countpages : null
	}
	
	
	
};




