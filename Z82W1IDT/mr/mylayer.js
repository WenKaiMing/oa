var cache_index=null;

function closeMyReservation(){
	Utils.closeMyReservationPanel();
}
function closeReservation(){
	Utils.closeReservationPanel();
}

function closeManagement(){
	Utils.closeManagementPanel();
}

var readygo = function() {
    var data;
    
        
    //会议室预定点击事件获取
	$('.reservation tr td').bind('click', function () {
		//var s=this.parentNode.parentNode.firstChild;
		//获得点击表格的<td/>
		var j= $(this).prevAll().length;//$(s).find("td").get($(this).prevAll().length);
		//如果点击的为标题栏，退出操作
		if($(this.parentNode).children("td:first-child").text()==""||$(this).prevAll().length==0)
			return;
        
		var resid = this.getAttribute("data-id"); //获取会议室预定id
        
		//点击空白未预定时执行！
		if(resid==null){
			popinitreservation(j,resid);
			return;
		}
		
		var url = '/obpm/mr/reservation/testmr.action';
        //这里应该通过点击的td作为参数，调用action获得会议预定信息，以json形式为参数传入方法pop
		jQuery.ajax({
		    type:"POST",     
		    url:url,      
		    data:"y="+$(this.parentNode).children("td:first-child").text()+"&x="+j+"&id="+resid, //发送到服务器的数据。将自动转换为请求字符串格式。
		    dataType:"text",//预期服务器返回的数据类型。如果不指定，jQuery 将自动根据 HTTP 包 MIME 信息来智能判断
		    async:true,   //true为异步请求，false为同步请求
		    success:function(back){    //请求成功后的回调函数。
		    	data = eval("(" + back + ")");
		    	popreservation(data);
		    },
		    error:function(){     //请求失败后的回调函数。
		        alert("请求失败");
		    }
		});
		
	});
	
	//会议室管理
	$('.management tr td').on('click', function () {
		//如果点击的为标题栏，退出操作
		if($(this.parentNode).children("td:first-child").children("input:first-child").attr("id")=="all_checkbox"||$(this).prevAll().length==0)
			return;

		var sid = $(this.parentNode).children("td:first-child").children("input:first-child").attr("value");
		var url = '/obpm/mr/room/initmanagement.action';
		var data1;
		jQuery.ajax({
		    type:"POST",     
		    url:url,      
		    data:"id="+sid, //发送到服务器的数据。将自动转换为请求字符串格式。
		    dataType:"text",//预期服务器返回的数据类型。如果不指定，jQuery 将自动根据 HTTP 包 MIME 信息来智能判断
		    async:true,   //true为异步请求，false为同步请求
		    success:function(back){    //请求成功后的回调函数。
		    	data1 = eval("(" + back + ")");
		    	popmanagement(data1);
		    },
		    error:function(){     //请求失败后的回调函数。
		        alert("请求失败");
		    }
		});
	}); 
	
	
	$('.myreservation tr td').bind('click', function () {
		//var s=this.parentNode.parentNode.firstChild;
		//获得点击表格的<td/>
		//var j= $(this).prevAll().length;//$(s).find("td").get($(this).prevAll().length);
		//如果点击的为标题栏，退出操作
//		if(this.parentNode.firstElementChild.textContent=="会议名称")
//			return;
		
		//var sd = this.parentNode.firstElementChild.firstElementChild.value;
		var url = '/obpm/mr/reservation/testmyreservation.action';
		jQuery.ajax({
		    type:"POST",     
		    url:url,      
		    data:"id="+this.parentNode.id, //发送到服务器的数据。将自动转换为请求字符串格式。
		    dataType:"text",//预期服务器返回的数据类型。如果不指定，jQuery 将自动根据 HTTP 包 MIME 信息来智能判断
		    async:false,   //true为异步请求，false为同步请求
		    success:function(back){    //请求成功后的回调函数。
		    	data = eval("(" + back + ")");
		    	popmyreservation(data);
		    },
		    error:function(){     //请求失败后的回调函数。
		        alert("请求失败");
		    }
		});
		//index为弹出层标识。
	}); 
};  

//添加新会议的弹出层
function popinitreservation(x,y){
	
	Utils.openReservationPanel();
	$('#meeting_title').text("新建会议室预定");
	$('#reservation_name')[0].value = "";
	$('#reservation_content')[0].value = "";
	$('#reservation_number')[0].value = "";
	$('#reservation_starttime')[0].value = "";
	$('#reservation_endtime')[0].value = "";
	
	$('#reservation_id')[0].value = "";
	
	//预定会议室 弹出层 区域选择
    $("#mr-reservation-pop-area").on("change",function(){
    	MR.room_res_select(this.value); 
	});
	//渲染区域 会议室选择栏
	var areaid= MR.area_res_select();
	MR.room_res_select(areaid);
}


//弹出保存的会议室预定窗口
function popreservation(data){
	MR.area_res_select();
	MR.room_res_select(data.areaid);
	
	Utils.openReservationPanel();
	$('#meeting_title').text("预定会议");
	$('#reservation_name')[0].value = data.name;
	$('#reservation_content')[0].value = data.content;
	$('#reservation_number')[0].value = data.number;
	$('#reservation_starttime')[0].value = data.starttime.substring(0,16);
	$('#reservation_endtime')[0].value = data.endtime.substring(0,16);
	$('#mr-reservation-pop-area')[0].value = data.areaid;
	$('#mr-reservation-pop-room')[0].value = data.roomid;
	$('#reservation_id')[0].value = data.id;

	//预定会议室 弹出层 区域选择
    $("#mr-reservation-pop-area").on("change",function(){
    	MR.room_res_select(this.value); 
	});
	//渲染区域 会议室选择栏
}

//弹出会议室预定的确认窗口
function savereservation(){
	//保存后，获取修改的内容以参数形式传入action中保存，界面有修改时，用js替换
	var reservation_name = $("#reservation_name")[0].value;
	var reservation_areaid = $("#mr-reservation-pop-area")[0].value;
	var reservation_roomid = $("#mr-reservation-pop-room")[0].value;
	var reservation_area = $("#mr-reservation-pop-area option:selected").text();
	var reservation_room = $("#mr-reservation-pop-room option:selected").text();
	var reservation_content = $("#reservation_content")[0].value;
	var reservation_number = $("#reservation_number")[0].value;
	var reservation_starttime = $("#reservation_starttime")[0].value;
	var reservation_endtime = $("#reservation_endtime")[0].value;
	//这里对开始时间和结束时间做处理。使预定时间间隔只能为半小时。(12:12->12:00 , 12:33->12:30)
	reservation_starttime = Utils.dateFormat_start(reservation_starttime);
	reservation_endtime = Utils.dateFormat_end(reservation_endtime);
	if(reservation_name==""||reservation_area==""||reservation_room==""||reservation_starttime==""||reservation_endtime==""){
		layer.msg("带*的值不能为空！", 1, 3);
		return;
	}
	if(Utils.daysBetween(reservation_starttime.substring(0,10),Utils.CurentTime())<0){
		layer.msg("预定会议时间不能小于当前日期！",1,4);
		return;
	}
	if(Utils.daysBetween(reservation_starttime.substring(0,10),reservation_endtime.substring(0,10))!=0){
		layer.msg("预定会议室时间不能大于一天！",1,5);
		return;
	}
	if(parseInt(reservation_endtime.substring(11,13))>18||parseInt(reservation_starttime.substring(11,13))<9){
		layer.msg("预定会议时间只能在9:00-18:00点之间！",1,5);
		return;
	}
	if(isNaN(reservation_number)){
		layer.msg("电话只能为数字类型！",1,4);
		return;
	}
	
	var id = $('#reservation_id')[0].value;
	
	var url = '/obpm/mr/reservation/savemr.action';
	var p;
	var er=$.layer({
	    shade: [0],
	    area: ['300px','150px'],
	    dialog: {
	        msg: '保存会议预定？',
	        btns: 2,                    
	        type: -1,
	        btn: ['保存','取消'],
	        yes: function(index){
				jQuery.ajax({
				    type:"POST",      
				    url:url,      
				    data:"name="+reservation_name+"&content1="+reservation_content+"&number="+reservation_number
				    +"&starttime="+reservation_starttime+"&endtime="+reservation_endtime+"&roomid="+reservation_roomid+"&areaid="
				    +reservation_areaid+"&id="+id+"&area="+reservation_area+"&room="+reservation_room, //发送到服务器的数据。将自动转换为请求字符串格式。
				    dataType:"text",//预期服务器返回的数据类型。如果不指定，jQuery 将自动根据 HTTP 包 MIME 信息来智能判断
				    async:true,   //true为异步请求，false为同步请求
				    success:function(data1){   
				    if(data1 == "success")	//保存成功
				    {    
				    	if(MR.cache.date!=null)
				    		MR.reservation(3,MR.cache.date);
				    	else if(MR.cache.room!=null)
				    		MR.reservation(2,MR.cache.room);
				    	else if(MR.cache.area!=null)
				    		MR.reservation(1,MR.cache.area);
				    	else
				    		MR.reservation();
				    	layer.msg("保存成功！", 1, 1);
				    	Utils.closeReservationPanel();
				    }else
				    	layer.msg(data1, 1, 3);
				    },
				    error:function(e){     //请求失败后的回调函数。
				    	layer.msg("保存失败！", 1, 3);
				        }
				});
				layer.close(index);
				layer.close(cache_index);
	        }, no: function(index){
	        	layer.close(index);
	        	layer.close(cache_index);
	        }
	    }
	});
}



//会议室管理 新建会议室
function popinitmanagement(){

	Utils.openManagementPanel();
	//渲染区域 会议室选择栏
	MR.area_mag_select();
	MR.room_mag_select();
	
	$('#mr-management-pop-room')[0].value = "";
	$('#management_number')[0].value = "";
	$('#management_equipment')[0].value = "";
	$('#management_note')[0].value = "";
	$('#management_id')[0].value = "";
	$('#mr-management-pop-area').removeAttr("disabled");
	$('#mr-management-pop-room').removeAttr("readonly");
	$('#management_edit1').css("display","block");
	$('#mr-management-pop-area1-box').css("display","block");
	$('#mr-management-pop-area2-box').css("display","none");
	
	//预定会议室 弹出层 区域选择
    $("#mr-management-pop-area").on("change",function(){
    	MR.room_mag_select(this.value); 
	});
	
}

//修改
function popmanagement(data){
	Utils.openManagementPanel();
	//渲染区域 会议室选择栏
	MR.area_mag_select();
	MR.room_mag_select();
	//设置和保存！
	$('#management_number')[0].value = data.number;
	$('#management_equipment')[0].value = data.equipment;
	$('#management_note')[0].value = data.note;
	$('#management_id')[0].value = data.id;
	$('#mr-management-pop-area1')[0].value = data.areaname;
	$('#mr-management-pop-room')[0].value = data.room;
	$('#mr-management-pop-area').attr("disabled","false");
	$('#mr-management-pop-room').attr("readonly","readonly");
	$('#management_edit1').css("display","block");
	//$('#mr-management-pop-area-box').css("display","none");
//	$('#mr-management-pop-area2-box').css("display","block");
	
}

function saveroom(){
	//保存后，获取修改的内容以参数形式传入action中保存，界面有修改时，用js替换
	var management_area = $("#mr-management-pop-area option:selected").text();
	var management_areaid = $("#mr-management-pop-area")[0].value;
	var management_room = $("#mr-management-pop-room")[0].value;
	var management_number = $("#management_number")[0].value;
	var management_equipment = $("#management_equipment")[0].value;
	var management_note = $("#management_note")[0].value;
	var id = $("#management_id")[0].value;
	
	if(management_areaid==""||management_room==""||management_number==""||management_equipment==""){
		layer.msg("带'*'的不能为空！", 1, 3);
		return;
	}
	if(isNaN(management_number)){
		layer.msg("人数只能为数字类型！",1,4);
		return;
	}
	if(management_equipment.length>200||management_note.length>200){
		layer.msg("设备和备注限制200个字符以内！", 1, 3);
		return;
	}
	var url = '/obpm/mr/room/saveroom.action';
	var p;
	var er=$.layer({
	    shade: [0],
	    area: ['300px','150px'],
	    dialog: {
	        msg: '保存会议室？',
	        btns: 2,                    
	        type: -1,
	        btn: ['保存','取消'],
	        yes: function(index){
				jQuery.ajax({
				    type:"POST",      
				    url:url,      
				    data:"area="+management_area+"&areaid="+management_areaid+"&name="+management_room+"&number="+management_number
				    +"&equipment="+management_equipment+"&note="+management_note+"&id="+id, //发送到服务器的数据。将自动转换为请求字符串格式。
				    dataType:"text",//预期服务器返回的数据类型。如果不指定，jQuery 将自动根据 HTTP 包 MIME 信息来智能判断
				    async:true,   //true为异步请求，false为同步请求
				    success:function(data1){   
				    if(data1 == "success")	//保存成功
				    {    
				    	layer.msg("保存成功", 1, 1);
				    	MR.management();
				    }else
				    	layer.msg("保存失败", 1, 3);
				    layer.close(index);
				    layer.close(cache_index);
				    },
				    error:function(){     //请求失败后的回调函数。
				        alert("请求失败");
				    }
				    
				});
	        }, no: function(index){
	        	layer.close(index);
	        	layer.close(cache_index);
	        }
	    }
	});
}

function deleteroom(id){
	$.layer({
	    shade: [0],
	    area: ['300px','150px'],
	    dialog: {
	        msg: '确定删除会议室？',
	        btns: 2,                    
	        type: -1,
	        btn: ['保存','取消'],
	        yes: function(index){
				var a = [];
				var options = $("#mr-management-table-body").find("input");
				for(var i=0;i<options.length;i++){
					if( options[i].checked==true ){
						a.push(options[i].value);
					}
				}
				if(a.length==0){
					alert("没有选中任何值！");
					return;
				}
				var str = a.join(",");
				
				var url="/obpm/mr/room/deleteroom.action";
				jQuery.ajax({
				    type:"POST",      
				    url:url,      
				    data:"str="+str,
				    dataType:"text",//预期服务器返回的数据类型。如果不指定，jQuery 将自动根据 HTTP 包 MIME 信息来智能判断
				    async:true,   //true为异步请求，false为同步请求
				    success:function(data1){   
				    if(data1 == "success")	//保存成功
				    {    	 
				    	layer.msg("删除成功", 1, 1);
				    	MR.management();
				    }else
				    	layer.msg("删除失败", 1, 3);
				    layer.close(index);
				    },
				    error:function(){     //请求失败后的回调函数。
				        alert("请求失败");
				        layer.close(index);
				    }
				});
				
	        }, no: function(index){
	        	layer.close(index);
	        }
	    }
	});
}

function deleteroom1(){
	var id = $("#management_id")[0].value;
	$.layer({
	    shade: [0],
	    area: ['300px','150px'],
	    dialog: {
	        msg: '确定删除会议室？',
	        btns: 2,                    
	        type: -1,
	        btn: ['保存','取消'],
	        yes: function(index){
				
				var url="/obpm/mr/room/deleteroom.action";
				jQuery.ajax({
				    type:"POST",      
				    url:url,      
				    data:"str="+id,
				    dataType:"text",//预期服务器返回的数据类型。如果不指定，jQuery 将自动根据 HTTP 包 MIME 信息来智能判断
				    async:true,   //true为异步请求，false为同步请求
				    success:function(data1){   
				    if(data1 == "success")	//保存成功
				    {    	 
				    	layer.msg("删除成功", 1, 1);
				    	MR.management();
				    }else
				    	layer.msg("删除失败", 1, 3);
				    layer.close(index);
				    },
				    error:function(){     //请求失败后的回调函数。
				        alert("请求失败");
				        layer.close(index);
				    }
				});
				
	        }, no: function(index){
	        	layer.close(index);
	        }
	    }
	});
}

//
//弹出我的预定窗口
function popmyreservation(data){
	MR.area_myr_select();
	MR.room_myr_select(data.area);
	
	Utils.openMyReservationPanel();
	$('#myreservation_creatorTel')[0].value = data.creatorTel;
	$('#myreservation_name')[0].value = data.name;
	$('#myreservation_content')[0].value = data.content;
	$('#myreservation_starttime')[0].value = data.starttime.substring(0,16);
	$('#myreservation_endtime')[0].value = data.endtime.substring(0,16);
	$('#mr-myreservation-pop-area')[0].value = data.area;
	$('#mr-myreservation-pop-room')[0].value = data.room;
	$('#myreservation_id')[0].value = data.id;
	
	//预定会议室 弹出层 区域选择
    $("#mr-myreservation-pop-area").on("change",function(){
    	MR.room_myr_select(this.value); 
	});

}


function updateMyreservation(){
	var myreservation_creatorTel = $("#myreservation_creatorTel")[0].value;
	var myreservation_name = $("#myreservation_name")[0].value;
	var myreservation_content = $("#myreservation_content")[0].value;
	var myreservation_starttime = $("#myreservation_starttime")[0].value;
	var myreservation_endtime = $("#myreservation_endtime")[0].value;
	var myreservation_area = $("#mr-myreservation-pop-area option:selected").text();
	var myreservation_room = $("#mr-myreservation-pop-room option:selected").text();
	var myreservation_areaid = $("#mr-myreservation-pop-area")[0].value;;
	var myreservation_roomid = $("#mr-myreservation-pop-room")[0].value;;
	var id = $('#myreservation_id')[0].value;
	//这里对开始时间和结束时间做处理。使预定时间间隔只能为半小时。(12:12->12:00 , 12:33->12:30)
	myreservation_starttime = Utils.dateFormat_start(myreservation_starttime);
	myreservation_endtime = Utils.dateFormat_end(myreservation_endtime);
	if(myreservation_areaid==""||myreservation_roomid==""||myreservation_starttime==""||myreservation_endtime==""||myreservation_name==""){
		layer.msg("带*的值不能为空！", 1, 3);
		return;
	}
	if(Utils.daysBetween(myreservation_starttime.substring(0,10),Utils.CurentTime())<0){
		layer.msg("不能修改过去的预定记录！",1,4);
		return;
	}
	if(Utils.daysBetween(myreservation_starttime.substring(0,10),myreservation_endtime.substring(0,10))!=0){
		layer.msg("预定会议室时间不能大于一天！",1,5);
		return;
	}
	if(parseInt(myreservation_endtime.substring(11,13))>18||parseInt(myreservation_starttime.substring(11,13))<9){
		layer.msg("预定会议时间只能在9:00-18:00点之间！",1,5);
		return;
	}
	if(isNaN(myreservation_creatorTel)){
		layer.msg("电话只能为数字类型！",1,4);
		return;
	}
	var url = '/obpm/mr/reservation/updatemyreservation.action';
	$.layer({
	    shade: [0],
	    area: ['300px','150px'],
	    dialog: {
	        msg: '保存我的预定更改？',
	        btns: 2,                    
	        type: -1,
	        btn: ['保存','取消'],
	        yes: function(index){
				jQuery.ajax({
				    type:"POST",      
				    url:url,      
				    data:"creatorTel="+myreservation_creatorTel
				    +"&name="+myreservation_name+"&mycontent="+myreservation_content
				    +"&starttime="+myreservation_starttime+"&endtime="+myreservation_endtime+"&area="+myreservation_area+"&room="+myreservation_room
				    +"&id="+id+"&areaid="+myreservation_areaid+"&roomid="+myreservation_roomid, //发送到服务器的数据。将自动转换为请求字符串格式。
				    dataType:"text",//预期服务器返回的数据类型。如果不指定，jQuery 将自动根据 HTTP 包 MIME 信息来智能判断
				    async:true,   //true为异步请求，false为同步请求
				    success:function(data1){   
				    if(data1 == "success")	//保存成功
				    {    
				    	layer.msg("保存成功", 1, 1);
				    	MR.myreservation();
				    }else
				    	layer.msg(data1, 1, 3);
				    },
				    error:function(e1){     //请求失败后的回调函数。
				    	layer.msg(e1, 1, 3);
				    }
				});
				layer.close(index);
	        }, no: function(index){
	        	layer.close(index);
	        }
	    }
	});
}

function deleteMyreservation(){
	var id = $('#myreservation_id')[0].value;
	var url = '/obpm/mr/reservation/deletemyreservation.action';
	$.layer({
	    shade: [0],
	    area: ['300px','150px'],
	    dialog: {
	        msg: '删除我的预定？',
	        btns: 2,                    
	        type: -1,
	        btn: ['保存','取消'],
	        yes: function(index){
				jQuery.ajax({
				    type:"POST",      
				    url:url,      
				    data:"id="+id, //发送到服务器的数据。将自动转换为请求字符串格式。
				    dataType:"text",//预期服务器返回的数据类型。如果不指定，jQuery 将自动根据 HTTP 包 MIME 信息来智能判断
				    async:true,   //true为异步请求，false为同步请求
				    success:function(data1){   
				    if(data1 == "success")	//保存成功
				    {    
				    	layer.msg("删除成功", 1, 1);
				    	MR.myreservation();
				    }else
				    	layer.msg("删除失败", 1, 3);
				    },
				    error:function(){     //请求失败后的回调函数。
				        alert("请求失败");}
				});
				layer.close(index);
	        }, no: function(index){
	        	layer.close(index);
	        }
	    }
	});
}

function deleteReservation(){
	var id = $('#reservation_id')[0].value;
	var url = '/obpm/mr/reservation/deletemyreservation.action';
	$.layer({
	    shade: [0],
	    area: ['300px','150px'],
	    dialog: {
	        msg: '删除我的预定？',
	        btns: 2,                    
	        type: -1,
	        btn: ['保存','取消'],
	        yes: function(index){
				jQuery.ajax({
				    type:"POST",      
				    url:url,      
				    data:"id="+id, //发送到服务器的数据。将自动转换为请求字符串格式。
				    dataType:"text",//预期服务器返回的数据类型。如果不指定，jQuery 将自动根据 HTTP 包 MIME 信息来智能判断
				    async:true,   //true为异步请求，false为同步请求
				    success:function(data1){   
				    if(data1 == "success")	//保存成功
				    {    
				    	layer.msg("删除成功", 1, 1);
				    	MR.myreservation();
				    }else
				    	layer.msg(data1, 1, 3);
				    },
				    error:function(){     //请求失败后的回调函数。
				        alert("请求失败");}
				});
				layer.close(index);
	        }, no: function(index){
	        	layer.close(index);
	        }
	    }
	});
}

function updatearea(){
	var url = '/obpm/mr/area/updatearea.action';
	var id = $('#mr-management-pop-area1')[0].value;
	var name = $('#mr-management-pop-area2')[0].value;
	$.layer({
	    shade: [0],
	    area: ['300px','150px'],
	    dialog: {
	        msg: '保存区域？',
	        btns: 2,                    
	        type: -1,
	        btn: ['保存','取消'],
	        yes: function(index){
				jQuery.ajax({
				    type:"POST",      
				    url:url,      
				    data:"id="+id+"&name="+name, //发送到服务器的数据。将自动转换为请求字符串格式。
				    dataType:"text",//预期服务器返回的数据类型。如果不指定，jQuery 将自动根据 HTTP 包 MIME 信息来智能判断
				    async:true,   //true为异步请求，false为同步请求
				    success:function(data1){   
				    if(data1 == "success")	//保存成功
				    {    
				    	layer.msg("保存成功", 1, 1);
				    	MR.area_mag_list();
				    	popinitmanagement();
				    	MR.area_edit_cancel();
				    	MR.management();
				    	//MR.management();
				    }else
				    	layer.msg("保存失败", 1, 1);
				    	layer.close(index);
				    },
				    error:function(){     //请求失败后的回调函数。
				        alert("请求失败");
				        layer.close(index);
				        layer.close(cache_index);
				    }
				    
				});
	        }, no: function(index){
	        	layer.close(index);
	        	layer.close(cache_index);
	        }
	    }
	});
}

//新建一个区域
function newarea(){
	var url = '/obpm/mr/area/newarea.action';
	var name = $('#mr-management-pop-area2')[0].value;
	if(name == ""){
		layer.msg("区域名称不能为空！", 1, 3);
		return;
	}
	$.layer({
	    shade: [0],
	    area: ['300px','150px'],
	    dialog: {
	        msg: '新建区域？',
	        btns: 2,                    
	        type: -1,
	        btn: ['保存','取消'],
	        yes: function(index){
				jQuery.ajax({
				    type:"POST",      
				    url:url,      
				    data:"name="+name, //发送到服务器的数据。将自动转换为请求字符串格式。
				    dataType:"text",//预期服务器返回的数据类型。如果不指定，jQuery 将自动根据 HTTP 包 MIME 信息来智能判断
				    async:true,   //true为异步请求，false为同步请求
				    success:function(data1){   
				    if(data1 == "success")	//保存成功
				    {    
				    	layer.msg("新建成功", 1, 1);
				    	MR.area_mag_list();
				    	popinitmanagement();
				    	MR.area_edit_cancel();
				    }else
				    	layer.msg("新建失败", 1, 3);
				    	layer.close(index);
				    },
				    error:function(){     //请求失败后的回调函数。
				        alert("请求失败");
				        layer.close(index);
				        layer.close(cache_index);
				    }
				    
				});
	        }, no: function(index){
	        	layer.close(index);
	        	layer.close(cache_index);
	        }
	    }
	});
}

function deletearea(){
	var url = '/obpm/mr/area/deletearea.action';
	var id = $('#mr-management-pop-area1')[0].value;
	$.layer({
	    shade: [0],
	    area: ['300px','150px'],
	    dialog: {
	        msg: '删除区域？',
	        btns: 2,                    
	        type: -1,
	        btn: ['删除','取消'],
	        yes: function(index){
				jQuery.ajax({
				    type:"POST",      
				    url:url,      
				    data:"id="+id, //发送到服务器的数据。将自动转换为请求字符串格式。
				    dataType:"text",//预期服务器返回的数据类型。如果不指定，jQuery 将自动根据 HTTP 包 MIME 信息来智能判断
				    async:true,   //true为异步请求，false为同步请求
				    success:function(data1){   
				    if(data1 == "success")	//保存成功
				    {    
				    	layer.msg("删除成功", 1, 1);
				    	MR.management();
				    	MR.area_mag_list();
				    	popinitmanagement();
				    	MR.area_edit_cancel();
				    }else
				    	layer.msg("删除失败", 1, 3);
				    	layer.close(index);
				    },
				    error:function(){     //请求失败后的回调函数。
				        alert("请求失败");
				        layer.close(index);
				        layer.close(cache_index);
				    }
				    
				});
	        }, no: function(index){
	        	layer.close(index);
	        	layer.close(cache_index);
	        }
	    }
	});
}
