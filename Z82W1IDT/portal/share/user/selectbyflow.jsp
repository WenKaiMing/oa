<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%
	WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String domainid=webUser.getDomainid();
	String contextPath = request.getContextPath();
	response.setHeader("Pragma","No-Cache");   
	response.setHeader("Cache-Control","No-Cache");   
	response.setDateHeader("Expires",   0);
	request.setAttribute("request",request);
	
	String flowid = (String)request.getParameter("flowid");
	String docid = (String)request.getParameter("docid");
	String nodeid = (String)request.getParameter("nodeid");
%>

<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[Select]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css">
<script src="<s:url value="/portal/share/script/list.js"/>"></script>
<!-- tree pugin -->
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/_lib/jquery.cookie.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/_lib/jquery.hotkeys.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/jquery.jstree.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/plugins/jquery.jstree.checkbox.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/json/json2.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery.slimscroll.min.js' />"></script>
<script type="text/javascript">
var contextPath = '<%=contextPath%>';
var domainid = '<%=domainid%>'; 
var flowid = '<%=flowid%>';
var docid = '<%=docid%>';
var nodeid = '<%=nodeid%>';

var depttree;
var args = OBPM.dialog.getArgs();
var parentObj = args['parentObj'];
var applicationid = args['applicationid'];
var targetid=args['targetid'];
var viewName=args['receivername'];
var defValue=args['defValue'];
var rolelist;

//查找所有用户
function getAllUser(value){
	jQuery("#lefthead").html("{*[Search]*}:"+"<input type='text' style='height: 18px;width:100px;' id='SHvalue' name='SHvalue' value=''><input onclick='toSearchUser();' style='padding-left:2px;' type='button' class='flowsearchPerson'>");
	//jQuery("#righttitle").html("<span style='float:left;width:75px;'>{*[Search]*}:</span>"+"<input type='text' style='float:left;width:280px;height: 36px;outline:medium;border:none;background-color: #fafafa;' id='SHvalue' name='SHvalue' value=''><input onclick='toSearchUser();' style='padding-left:2px;' type='button'  class='searchPerson'>");
	var url = contextPath+"/portal/dynaform/document/selectByFlow.action?flowid="+flowid+"&docid="+docid+"&nodeid="+nodeid+"&type="+3;
	if(value && value != 'undefinded'){
		url = url + "&id=" + encodeURIComponent(value);
	}
	jQuery.ajax({
		url:url,
		//url:contextPath+"/portal/dynaform/document/selectByFlow.action",
		type:"post",
		datatype:"jason",
		//data:{"flowid":flowid,"docid":docid,"nodeid":nodeid,"type":"3","id":value},
		success:function(data){
				if(data){
					jQuery("#SHvalue").attr("value",value);
					jQuery("#leftcontent").html("");
					jQuery("#rightcontent").html(data);
					jQuery("#righttitle").html("");
					
					doPageNav(1);
					jQuery("#all_page_hide").hide();
				}else{
					jQuery("#rightcontent").html("<div class='list_div'>{*[core.dynaform.form.userfield.front.page.tip.can_not_found_user]*}</div>");
					
				}
			},
		error:function(data,status){
				alert("failling to visited...");
			}
});	
}

function toSearchUser(){
	var value = jQuery("#SHvalue").val();
	getAllUser(value);
}

/*根据角色id去那下面的users*/
function getUserListByRole(obj){
	jQuery(".selectImg_right").each(function(){
		jQuery(this).css("visibility","hidden");
	});
	jQuery("#img_"+obj.attr("id")).css("visibility","visible");
	getUserListByRoleid(obj);
}

function getUserListByRoleid(roleObj){
	var rolesid=roleObj.attr("id");
	var rolesname=roleObj.attr("title");
	if(rolesid!=""){
		jQuery("#righttitle").html("{*[Role]*}："+rolesname);
		jQuery.ajax({
			url:contextPath+"/portal/dynaform/document/selectByFlow.action?flowid="+flowid+"&docid="+docid+"&nodeid="+nodeid+"&type="+2+"&id="+rolesid,
			type:"post",
			datatype:"jason",
			//data:{"flowid":flowid,"docid":docid,"nodeid":nodeid,"type":"2","id":rolesid},
			success:function(data){
					if(data){
						//jQuery("#rightcontent").css("overflow","auto");
						jQuery("#rightcontent").html(data);
						doPageNav(1);
						jQuery("#all_page_hide").hide();
					}else{
						jQuery("#rightcontent").html("<div class='list_div'>{*[core.dynaform.form.userfield.front.page.tip.can_not_found_user]*}</div>");
					}
				},
			error:function(data,status){
					alert("failling to visited...");
				}
	});	
	}
}

function getRoleslist(){
	jQuery("#lefthead").html("{*[Roles]*}{*[List]*}:");
	if(rolelist!=""){
		if(applicationid!=""){
			jQuery.ajax({
					url:contextPath+"/portal/role/getRolesList.action",
					type:"post",
					datatype:"jason",
					data:{"application":applicationid},
					success:function(data){
							if(data){
								rolelist=data;
								jQuery("#leftcontent").html(rolelist);
							}else{
								jQuery("#leftcontent").html("<div>{*[CanNotFind]*}{*[Role]*}</div>");
							}
						},
					error:function(data,status){
							alert("failling to visited...");
						}
			});	
		}
	}else{
		jQuery("#leftcontent").html(rolelist);
	}
}

function doLeftPageNav(url){
	jQuery.ajax({
				url:contextPath+url,
				type:"post",
				datatype:"jason",
				success:function(data){
						if(data){
							jQuery("#leftcontent").html(data);
						}else{
							jQuery("#leftcontent").html("<div class='list_div'>{*[core.dynaform.form.userfield.front.page.tip.can_not_found_user]*}</div>");
						}
					},
				error:function(data,status){
						alert("failling to visited...");
					}
	});	
}

/*初始化部门树*/
function getDeptTree() {  
	jQuery("#lefthead").html("{*[Department]*}{*[List]*}:");
	depttree = jQuery("#leftcontent").jstree({ 
		core:{
			initially_open: ['root']
		}, 
		"json_data" : {
			"ajax" : { 
				"url" : function (){
					return contextPath + "/portal/department/departTree.action?domain="+domainid+"&datetime=" + new Date().getTime();
				},
				"data" : function (node) {
					// buildParams
					var params = {};
					if (node.attr) {
						params['parentid'] = node.attr("id"); // 上级部门ID
						params['data'] = node.attr("data");
					}
					return params;
				}
			}
		},
		"plugins" : [ "themes", "json_data","lang", "ui",]
	}).bind("select_node.jstree", function(e, data){
		var node = data.rslt.obj;
		if (node && node.attr) {
			if(node.attr("id")!=""){
				var deptid=node.attr("id");
				var deptname=node.attr("name");
				//alert("deptid----->"+deptid+"    deptname--->"+deptname);
				getUserListByDept(domainid,deptid,deptname);
			}
		}
	});
}


/*用户点击部门节点返回该部门下的用户*/
function getUserListByDept(domainid,deptid,deptname){
	if(domainid!="" && deptid!=""){
		jQuery("#righttitle").html("{*[Department]*}:"+deptname);
		jQuery.ajax({
			url:contextPath+"/portal/dynaform/document/selectByFlow.action?flowid="+flowid+"&docid="+docid+"&nodeid="+nodeid+"&type="+1+"&id="+deptid,
			type:"post",
			datatype:"jason",
			//data:{"flowid":flowid,"docid":docid,"nodeid":nodeid,"type":"1","id":deptid},
			success:function(data){
					if(data){
						//jQuery("#rightcontent").css("overflow","auto");
						jQuery("#rightcontent").html(data);
						doPageNav(1);
						jQuery("#all_page_hide").hide();
					}else{
						jQuery("#rightcontent").html("<div class='list_div'>{*[core.dynaform.form.userfield.front.page.tip.can_not_found_user]*}</div>");
					}
				},
			error:function(data,status){
					alert("failling to visited...");
				}
	});	
	}
}

//滚动条
function rightContentScroll(){
	
	//var scrollHeight = jQuery(".crossULdivright_lef").height()-jQuery(".crossULdivright_lef>#right_btn").height()-jQuery(".crossULdivright_lef>#righttitle").height();alert(scrollHeight);
	var rightscrollHeight = jQuery(".crossULdivright_lef").height()-jQuery(".crossULdivright_lef>#right_btn").height()-jQuery(".crossULdivright_lef>#righttitle").height()-2;
	var leftscrollHeight = jQuery(".crossULdivleft").height()-jQuery(".crossULdivleft>#lefthead").height()-2;
	$("#rightcontent").slimscroll({
		height: rightscrollHeight,
		color:'#333'
	});
	$("#leftcontent").slimscroll({
		height: leftscrollHeight,
		color:'#333'
	});
}
jQuery(document).ready(function(){
	getAllUser();
	initDoReturnFunction();
	initDefValue(defValue);
	//OBPM.dialog.resize(jQuery(window).width()+20, jQuery(window).height()+75);
	rightContentScroll();
});

/*初始化返回事件*/
function initDoReturnFunction(){
	jQuery("#doReturn").click(function(){
		var array = new Array();
		jQuery(".onSelect").each(function(){
			if (jQuery(this).attr("id")) {
		    	var rtn = {};
		    	rtn.text = jQuery(this).text();//e.text firefox不兼容，标准中checkbox 没有text属性
		    	rtn.value = jQuery(this).attr("id");
		    	array.push(rtn);
		    }
		});
		OBPM.dialog.doReturn(array);
	});
}

/*初始化默认值*/
function initDefValue(defValue){
	if (defValue) {
		var array = jQuery.isArray(defValue) ? defValue: defValue.split(";");
		var params = "";
		if (array && array.length > 0) {
			for (var i = 0; i < array.length; i++) {
				params += "&_selects=" + array[i];
			}
		}
		
		jQuery.ajax({
				url:contextPath+"/portal/user/doListBySelectToJSON.action",
				type:"post",
				datatype:"jason",
				data: "domain=" + domainid + params,
				success:function(userlist){
					if (userlist && userlist.length > 0) {
						for (var i = 0; i < userlist.length; i++) {
							addToUserSelectByMap(userlist[i]);
						}
					}
				},
				
				error:function(data,status){
					alert("failling to doListBySelectToJSON...");
				}
		});	

	}
}

jQuery(function(){
	jQuery("#addAll").click(function(){
		//jQuery("#selectedUserDiv").html("");
		jQuery(".list_div_click").each(function(i){
			if(jQuery(this).data("show") == "true"){
				jQuery(this).attr("checked",true);
				selectUser(jQuery(this),false);
			}
		});

		resetTargetValue();
	});
	
	jQuery("#deleteAll").click(function(){
		jQuery(".list_div_click").each(function(){
			jQuery(this).attr("checked",false);
		});
		jQuery("#selectedUserDiv").html("");
		resetTargetValue();
	});
});

/*注册页签切换事件*/
jQuery(function(){
	jQuery(".crossUL > li").click(function(){
		
		jQuery(".crossUL li.on").removeClass("on");
		jQuery(this).addClass("on");
		//jQuery("#leftcontent").css("overflow","auto");
		if(jQuery(this).attr("id")=="bydept"){
			getDeptTree();
		}
		if(jQuery(this).attr("id")=="byroles"){
			getRoleslist();
		}
		/*if(jQuery(this).attr("id")=="byonline"){
			getOnLineUserList();
		}*/
		if(jQuery(this).attr("id")=="bysearch"){
			getAllUser("");
		}
	});
});

/*用户点击选择用户事件*/
function selectUser(obj,isclickone){
	if(isclickone){
		if(obj.attr("checked")=="checked"){
			var flag=false;
			//jQuery(this).attr("checked",false);
			jQuery(".onSelect").each(function(){
				if(jQuery(this).attr("id")==obj.attr("id")){
					flag=true;
				}
			});
			addToUserSelect(obj);
		}else{
			//jQuery(this).attr("checked",false);
			jQuery(".onSelect").each(function(){
				if(jQuery(this).attr("id")==obj.attr("id")){
					jQuery("span").remove("#"+obj.attr("id"));
				}
			});	
		}
	}else{
		addToUserSelect(obj);
	}
	
	resetTargetValue();
}

function addToUserSelect(obj){
	var map = {id: obj.attr("id"), name: obj.attr("name")};
	addToUserSelectByMap(map);
}

function addToUserSelectByMap(map){
	var id = map["id"];
	var name = map["name"];
	var ids = document.getElementsByName(id).length;
	if (!!window.ActiveXObject){
	    if(ids>1){
		  //alert("{*[userAlreadyBeAdd]*}");
	    }else{
		  jQuery("#selectedUserDiv").append("<span style='display:block;width:95%;' onclick='clickRemoveSelect(\""+id+"\",\""+name+"\")' title='{*[Click]*}{*[Delete]*}' class='onSelect' id="+id+" name="+id+">"+name+"</span>");
		}
	}else{
	    if(ids>0){
		  //alert("{*[userAlreadyBeAdd]*}");
		}else{
		  jQuery("#selectedUserDiv").append("<span style='display:block;width:95%;' onclick='clickRemoveSelect(\""+id+"\",\""+name+"\")' title='{*[Click]*}{*[Delete]*}' class='onSelect' id="+id+" name="+id+">"+name+"</span>");
		}
	}
}

function clickRemoveSelect(id,name){
	/*
	if(jQuery("#"+id)){
		jQuery("#"+id).attr("checked",false);
	}
	if(jQuery("#"+id)){
		jQuery("span").remove("#"+id);
	}
	*/
	jQuery("span[id="+id+"]").remove();
	
	jQuery(".list_div_click").each(function(){
		if(jQuery(this).attr("id")==id){
			jQuery(this).attr("checked",false);
			resetTargetValue();
		}
	});
	/*
	jQuery(".onSelect").each(function(){
		if(jQuery(this).attr("id")==id){
			jQuery("span").remove("#"+jQuery(this).attr("id"));
		}
	});
	*/
	
	resetTargetValue();
	jQuery("#selectedUserDiv").focus();
}

/* 设置值到目标文本框中 */
function resetTargetValue(){
		var targetValue="";
		var names="";
		jQuery(".onSelect").each(function(){
			targetValue+=jQuery(this).attr("id")+";";//多个用户用“;”分隔
			names+=jQuery(this).html()+";";
		});
		if(targetValue != ""){
			targetValue=targetValue.substring(0,targetValue.length-1);
			names=names.substring(0,names.length-1);
		}
		//parentObj.findUserName(targetValue);
}

function bulitTitle(names){
	if(names != null && names != ''){
		var array = names.split(";");
		var title = '';
		for(var i = 0; i < array.length; i++){
			if(i != 0 && i%10 == 0){
				title += "\n";
			}
			title += array[i] + ";";
		}
		return title == ''?title:title.substring(0,title.length-1);
	}
	return '';
}

//设置己选择的用户数据
function initSetValue(){
	var targetidVal = "";
	var viewNameVal = "";
	var viewEmailVal = "";
	if (parentObj.document.getElementById(targetid)) {
		targetidVal = parentObj.document.getElementById(targetid).value;
	}
	if (parentObj.document.getElementById(viewName)) {
		viewNameVal = parentObj.document.getElementById(viewName).value;
	}
	if (parentObj.document.getElementById(viewEmail)) {
		viewEmailVal = parentObj.document.getElementById(viewEmail).value;
	}
	var userIds = targetidVal.split(";");
	var userNames = viewNameVal.split(";");
	var userEmails = viewEmailVal.split(";");
	for(var i=0; i<userIds.length; i++){
		if(userIds[i] != ""){
			var obj = {id:userIds[i],name:userNames[i],email:userEmails[i]};
			addToUserSelectByMap(obj);
		}
	}
}

function doPageNav(pageNum){
	jQuery(".list_div_user").each(function(i){
		jQuery(".list_div_click").eq(i).data("show","false");
		jQuery(this).hide();
	});
	for(var i = 0;i < 10;i++){
		var user = jQuery(".list_div_user").eq((pageNum-1)*10+i);
		jQuery(".list_div_click").eq((pageNum-1)*10+i).data("show","true");
		user.show();
	}
	
	var inPage = parseInt(jQuery("#in_page").text());
	var totalPage = parseInt(jQuery("#total_page").text());
	
	if(totalPage == 1){
		jQuery("#first_page").hide();
		jQuery("#prev_page").hide();
		jQuery("#end_page").hide();
		jQuery("#next_page").hide();
	}else{
		if(pageNum == 1){
			jQuery("#first_page").hide();
			jQuery("#prev_page").hide();
			jQuery("#next_page").removeAttr("onclick");
			jQuery("#next_page").off();
			jQuery("#next_page").on("click",function(){doPageNav(pageNum+1)});
		}else{
			jQuery("#first_page").show();
			jQuery("#prev_page").show();
			if(pageNum != totalPage){
				jQuery("#prev_page").removeAttr("onclick");
				jQuery("#prev_page").off();
				jQuery("#prev_page").on("click",function(){doPageNav(pageNum-1)});
			}
		}

		if(pageNum == totalPage){
			jQuery("#end_page").hide();
			jQuery("#next_page").hide();
			jQuery("#prev_page").removeAttr("onclick");
			jQuery("#prev_page").off();
			jQuery("#prev_page").on("click",function(){doPageNav(pageNum-1)});
		}else{
			jQuery("#end_page").show();
			jQuery("#next_page").show();
			if(pageNum != 1){
				jQuery("#next_page").removeAttr("onclick");
				jQuery("#next_page").off();
				jQuery("#next_page").on("click",function(){doPageNav(pageNum+1)});
			}
		}
		jQuery("#in_page").text(pageNum);
	}
}

function doAllPageNav(type){
	if(type == "0"){
		jQuery("#first_page").hide();
		jQuery("#prev_page").hide();
		jQuery("#end_page").hide();
		jQuery("#next_page").hide();
		jQuery("#all_page_show").hide();
		jQuery("#all_page_hide").show();
		
		jQuery(".list_div_user").each(function(i){
			jQuery(".list_div_click").eq(i).data("show","true");
			jQuery(this).show();
		});
		jQuery("#all_page").text("{*[Pagination]*}");
		jQuery("#all_page").removeAttr("onclick");
		jQuery("#all_page").one("click",function(){doAllPageNav("1")});
	}else{
		jQuery("#all_page_hide").hide();
		jQuery("#all_page_show").show();
		
		jQuery("#all_page").text("{*[All]*}");
		jQuery("#all_page").one("click",function(){doAllPageNav("0")});
		
		jQuery("#prev_page").removeAttr("onclick");
		jQuery("#prev_page").off();
		jQuery("#prev_page").on("click",function(){doPageNav(1)});
		jQuery("#next_page").removeAttr("onclick");
		jQuery("#next_page").off();
		jQuery("#next_page").on("click",function(){doPageNav(2)});
		doPageNav(1);
	}
}
</script>
</head>
<body style="overflow-x:hidden;overflow-y:hidden;height:100%;margin: 0;">
	
	<div class="crossUL-top">


			<ul class="crossUL">

				<li id="bysearch"  class="on">{*[Search]*}</li>
				<li id="byroles">{*[cn.myapps.core.user.by_role]*}</li>
				<li id="bydept">{*[cn.myapps.core.user.by_department]*}</li>
				
				<!--<li id="byonline">{*[Online]*}{*[User]*}</li>-->
			</ul>




	</div>
	<div style="float:none;clear:both;"></div>
	<div class="contentDiv on">
		<div id="left" class="crossULdivleft">
			<div id="lefthead" class="list_div list_div_head"></div>
			<div id="leftcontent" class="leftContent" style="overflow-x:hidden;height:320px"></div>
		</div>
		
		<div id="right" class="crossULdivright">
			<div class="guide guideOne"></div>
			<div class="crossULdivright_lef">
				<div id="right_btn" class="list_div list_div_head" style="display:none;text-align:center;">
					<input id="addAll" type="button" class="btn btn-default" value="{*[core.user.addPageAll]*}">
				</div>
				<div id="righttitle" style="height: 38px;line-height:38px;padding-left:10px;color:#676a6c;background-color: #fafafa;border-bottom: 1px solid #d2d2d2;"></div>
				<div id="rightcontent" style="clear: all;"></div>
			</div>
			<div class="guide"></div>
			<div class="crossULdivright_rig">
				<div class="list_div list_div_head">
					{*[cn.myapps.core.email.write.choose.delete_all.allready_choose_user]*}：

				</div>
				

				<div id="selectedUserDiv" class="selectedUserDiv"></div>
				<div style="margin-right:10px;position: absolute;top: 2px;right: 0;"><input id="deleteAll" class="btn btn-danger" type="button" value="{*[Remove]*}{*[All]*}"></div>
			</div>
		</div>
		<div style="float:none;clear:both;"></div>
	</div>
	<div style="float:none;clear:both;"></div>
	<div style="float: right;padding: 0 20px;margin-top:17px;">
			<input id="doReturn" class="btn btn-success" type="button" value="{*[OK]*}">
	</div>
</body>
</o:MultiLanguage></html>
