

//弹出会议室预定的确认窗口
function savereservation(){
	//保存后，获取修改的内容以参数形式传入action中保存，界面有修改时，用js替换
	var reservation_name = $("#reservation_name")[0].value;
	var reservation_content = $("#reservation_content")[0].value;
	var reservation_area = $("#mr-reservation-area-list")[0].value;
	var reservation_room = $("#mr-reservation-room-list")[0].value;
	var reservation_areaid = $("#mr-reservation-area-list option:selected").attr("data-id");
	var reservation_roomid = $("#mr-reservation-room-list option:selected").attr("data-id");
	
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
				    data:"id="+id+"&name="+reservation_name+"&content1="+reservation_content+"&number="+reservation_number
				    +"&starttime="+reservation_starttime+"&endtime="+reservation_endtime+"&roomid="+reservation_roomid+"&areaid="
				    +reservation_areaid+"&area="+reservation_area+"&room="+reservation_room, //发送到服务器的数据。将自动转换为请求字符串格式。
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
				    	 layer.close(index);
				    	layer.msg("保存成功", 1, 1);
				    }else{
				    	 layer.close(index);
				    	 layer.msg(data1, 1, 3);
				    }
				    },
				    error:function(e){     //请求失败后的回调函数。
				    	 layer.close(index);
				    	layer.msg("保存失败！", 1, 3);
				        }
				});
	        }, no: function(index){
	        }
	    }
	});
}


function newarea_show(){
	if($("#newarea_block").css("display")=="none")
		$("#newarea_block").css("display","block");
	else
		$("#newarea_block").css("display","none");
}
function newarea_close(){
	$("#newarea_block").css("display","none");
}
function newroom_close(){
	$("#newroom_block").css("display","none");
}
function newroom_show(){
	if($("#newroom_block").css("display")=="none")
		$("#newroom_block").css("display","block");
	else
		$("#newroom_block").css("display","none");
	
}

function room_show(id){
	$("#room_block").popup('open');//alvin
	
	var url = '/obpm/mr/room/initmanagement.action';
	jQuery.ajax({
	    type:"POST",     
	    url:url,
	    data:"id="+id, //发送到服务器的数据。将自动转换为请求字符串格式。
	    dataType:"text",//预期服务器返回的数据类型。如果不指定，jQuery 将自动根据 HTTP 包 MIME 信息来智能判断
	    async:true,   //true为异步请求，false为同步请求
	    success:function(back){    //请求成功后的回调函数。
	    	data = eval("(" + back + ")");
	    	$('#management_area')[0].value = data.areaname;
	    	$('#management_room')[0].value = data.room;
	    	$('#management_number')[0].value = data.number;
	    	$('#management_equipment')[0].value = data.equipment;
	    	$('#management_note')[0].value = data.note;
	    	$('#management_area').attr("data-id",data.area);
	    	$('#management_room').attr("data-id",data.id);
	    	
	    },
	    error:function(){     //请求失败后的回调函数。
	        alert("请求失败");
	    }
	});
}
function room_close(){
	$("#room_block").css("display","none");
}

function save_room(){
	
	var management_area = $('#management_area')[0].value;
	var management_room = $('#management_room')[0].value;
	var management_number = $('#management_number')[0].value;
	var management_equipment =  $('#management_equipment')[0].value;
	var management_note = $('#management_note')[0].value;
	var management_areaid = $('#management_area').attr("data-id");
	var id = $('#management_room').attr("data-id");
	
	if(management_areaid==""||management_room==""||management_number==""||management_equipment==""){
		layer.msg("带'*'的不能为空！", 1, 3);
		return;
	}
	if(isNaN(management_number)){
		layer.msg("人数只能为数字类型！",1,4);
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
				    	MR.management(2,id);
				    }else
				    	layer.msg("保存失败", 1, 3);
				    layer.close(index);
				    },
				    error:function(){     //请求失败后的回调函数。
				        alert("请求失败");
				    }
				});
	        }, no: function(index){
	        	layer.close(index);
	        }
	    }
	});
}

//新建会议室
function new_room(){
	
	var management_area = $('#management_area1')[0].value;
	var management_room = $('#management_room1')[0].value;
	var management_number = $('#management_number1')[0].value;
	var management_equipment =  $('#management_equipment1')[0].value;
	var management_note = $('#management_note1')[0].value;
	var management_areaid = $('#management_area1').find("option:selected").attr("data-id");
	var id = $('#management_room1').attr("data-id");
	
	if(management_areaid==""||management_room==""||management_number==""||management_equipment==""){
		layer.msg("带'*'的不能为空！", 1, 3);
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
				    	MR.management(2,id);
				    }else
				    	layer.msg("保存失败", 1, 3);
				    layer.close(index);
				    },
				    error:function(){     //请求失败后的回调函数。
				        alert("请求失败");
				    }
				});
	        }, no: function(index){
	        	layer.close(index);
	        }
	    }
	});
}

//删除会议室
function delete_room(){
	$.layer({
	    shade: [0],
	    area: ['300px','150px'],
	    dialog: {
	        msg: '确定删除会议室？',
	        btns: 2,                    
	        type: -1,
	        btn: ['保存','取消'],
	        yes: function(index){
//				var a = [];
//				var options = $("#mr-management-table-body").find("input");
//				for(var i=0;i<options.length;i++){
//					if( options[i].checked==true ){
//						a.push(options[i].value);
//					}
//				}
//				if(a.length==0){
//					alert("没有选中任何值！");
//					return;
//				}
//				var str = a.join(",");
				var str = $("#management_room").attr("data-id");
				var areaid = $("#mr-management-area-list").find("option:selected").attr("data-id");
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
				    	MR.management(1,areaid);
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

//新建区域
function new_area(){
	
	var url = '/obpm/mr/area/newarea.action';
	var name = $('#newarea_text')[0].value;
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
				    	MR.area_mag_select();
				    	//popinitmanagement();
				    	//MR.area_edit_cancel();
				    }else
				    	layer.msg("新建失败", 1, 3);
				    	layer.close(index);
				    },
				    error:function(){     //请求失败后的回调函数。
				    	layer.msg("请求失败", 1, 3);
				        layer.close(index);
				    }
				    
				});
	        }, no: function(index){
	        	layer.close(index);
	        	layer.close(cache_index);
	        }
	    }
	});
}
function myreservation_show(id){
	$("#mr-myreservation-box").popup('open');
	
	var data;
	var url = '/obpm/mr/reservation/testmyreservation.action';
	jQuery.ajax({
	    type:"POST",     
	    url:url,      
	    data:"id="+id, //发送到服务器的数据。将自动转换为请求字符串格式。
	    dataType:"text",//预期服务器返回的数据类型。如果不指定，jQuery 将自动根据 HTTP 包 MIME 信息来智能判断
	    async:false,   //true为异步请求，false为同步请求
	    success:function(back){    //请求成功后的回调函数。
	    	data = eval("(" + back + ")");
	    },
	    error:function(){     //请求失败后的回调函数。
	        alert("请求失败");
	    }
	});
	
	MR.area_myr_select();
	MR.room_myr_select(data.area);
	
	$('#myreservation_creatorTel')[0].value = data.creatorTel;
	$('#myreservation_name')[0].value = data.name;
	$('#myreservation_content')[0].value = data.content;
	$('#myreservation_starttime')[0].value = data.starttime;
	$('#myreservation_endtime')[0].value = data.endtime;
	$('#mr-myreservation-pop-area')[0].value = data.area;
	$('#mr-myreservation-pop-room')[0].value = data.room;
	$('#myreservation_id')[0].value = data.id;
	
	//预定会议室 弹出层 区域选择
    $("#mr-myreservation-pop-area").on("change",function(){
    	MR.room_myr_select($(this).find("option:selected").attr("data-id")); 
    	$("#mr-myreservation-pop-area").selectmenu('refresh', true);
		$("#mr-myreservation-pop-room").selectmenu('refresh', true);
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
	var myreservation_areaid = $("#mr-myreservation-pop-area")[0].value;
	var myreservation_roomid = $("#mr-myreservation-pop-room")[0].value;
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

//popup
function res_close(){
	$("#mr-reservation-box").popup("close");
}
function man_close(){
	$("#room_block").popup("close");
}
function myr_close(){
	$("#mr-myreservation-box").popup("close");
}
