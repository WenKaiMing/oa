<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%
	String path=request.getContextPath();
%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[cn.myapps.core.domain.selectsuperior.select_superior]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css">
<script src="<s:url value="/script/list.js"/>"></script>
<!-- tree pugin -->
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/_lib/jquery.cookie.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/_lib/jquery.hotkeys.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/jquery.jstree.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/jquery-ui/plugins/tree/plugins/jquery.jstree.checkbox.js'/>"></script>
<script type="text/javascript" src="<s:url value='/script/json/json2.js'/>"></script>
<script type="text/javascript">
	var contextPath='<%=path%>';
	var applicationid='';
	var depttree;
	var args = OBPM.dialog.getArgs();
	var parentObj = args['parentObj'];
	var maxUser= 1;
	/*存放userid*/
	var targetid=args['targetid'];
	/*存放username*/
	var viewName=args['receivername'];
	//企业域ID
	var domainid=args['domainid'];
	// 默认值
	var defValue=args['defValue'];
	
	var contentId = args['contentId'];
	var rolelist;
	/*选择模式*/
	var selectMode = args['selectMode'];
	/*存放userEmail*/
	var viewEmail=args['receiverEmail'];
	
	function getOnLineUserList(){
		jQuery("#lefthead").html("{*[cn.myapps.core.domain.selectproxyuser.able_to_select_current_online_user]*}:");
		jQuery.ajax({
					url:contextPath+"/core/user/getOnLineUserForSuperior.action",
					type:"post",
					datatype:"jason",
					data:{"domain":domainid,"contentId":contentId},
					success:function(data){
							if(data){
								jQuery("#leftcontent").html(data);
								if(jQuery("#onLineUsersCount")){
									jQuery("#lefthead").html(jQuery("#lefthead").html()+"(<span style='color:red'>"+jQuery("#onLineUsersCount").attr("value")+"</span>)");
								}
								doLeftPageNav(1);
							}else{
								jQuery("#leftcontent").html("<div class='list_div'>{*[cn.myapps.core.domain.selectproxyuser.can_not_find_user]*}</div>");
							}
						},
					error:function(data,status){
							alert("failling to visited...");
						}
		});	
	}
	
	/*查找所有的用户*/
	function getAllUser(param){
		jQuery("#lefthead").html("{*[cn.myapps.core.domain.selectproxyuser.by_user_name]*}:"+"<input type='text' style='height: 18px;width:100px;' id='SHvalue' name='SHvalue' value=''><input onclick='getOnChange2Search(jQuery(\"#SHvalue\").attr(\"value\"))' style='height: 25px;padding-left:2px;' type='button' value='{*[Search]*}'>");
		if(domainid!=""){
			jQuery.ajax({
					url:contextPath+"/core/user/getAllUser.action",
					type:"post",
					datatype:"jason",
					data:{"domain":domainid,"sm_name":param,"contentId":contentId},
					success:function(data){
							if(data){
								jQuery("#SHvalue").attr("value",param);
								jQuery("#leftcontent").html("");
								jQuery("#rightcontent").css("overflow","auto");
								jQuery("#rightcontent").html(data);
								jQuery("#righttitle").html("{*[cn.myapps.core.domain.selectproxyuser.search_result]*}:");
								doPageNav(1);
								jQuery("#all_page_hide").hide();
							}else{
								jQuery("#SHvalue").attr("value",param);
								jQuery("#rightcontent").html("<div class='list_div'>{*[cn.myapps.core.domain.selectproxyuser.can_not_find_user]*}</div>");
							}
						},
					error:function(data,status){
							alert("failling to visited...");
						}
			});	
		}
	}
	
	function getOnChange2Search(value){
		//if(value!=""){
		getAllUser(value);
		//}
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
					url:contextPath+"/portal/user/getUserListByRole.action"+"?selectMode="+selectMode,
					type:"post",
					datatype:"jason",
					data:{"applicationid":applicationid,"rolesid":rolesid},
					success:function(data){
							if(data){
								jQuery("#rightcontent").css("overflow","auto");
								jQuery("#rightcontent").html(data);
							}else{
								jQuery("#rightcontent").html("<div class='list_div'>{*[cn.myapps.core.domain.selectproxyuser.can_not_find_user]*}</div>");
							}
						},
					error:function(data,status){
							alert("failling to visited...");
						}
			});	
		}
	}
	
	/*获取左侧的角色列表*/
	function getRoleslist(){
		jQuery("#lefthead").html("{*[cn.myapps.core.domain.selectproxyuser.roles_list]*}:");
		if(rolelist!=""){
			if(applicationid!=""){
				jQuery.ajax({
						url:contextPath+"/portal/role/getRolesList.action"+"?selectMode="+selectMode,
						type:"post",
						datatype:"jason",
						data:{"application":applicationid},
						success:function(data){
								if(data){
									rolelist=data;
									jQuery("#leftcontent").html(rolelist);
								}else{
									jQuery("#leftcontent").html("<div>{*[cn.myapps.core.domain.selectproxyuser.can_not_find_role]*}</div>");
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
	
	function doLeftPageNav(pageNum){
		jQuery(".list_div_online").each(function(){
			jQuery(this).hide();
		});
		for(var i = 0;i < 10;i++){
			jQuery(".list_div_online").eq((pageNum-1)*10+i).show();
		}

		var inPage = parseInt(jQuery("#inLeftPage").text());
		var totalPage = parseInt(jQuery("#countLeftPage").text());
		
		if(totalPage == 1){
			jQuery("#firstLeftPage").hide();
			jQuery("#prevLeftPage").hide();
			jQuery("#endLeftPage").hide();
			jQuery("#nextLeftPage").hide();
		}else{
			if(pageNum == 1){
				jQuery("#firstLeftPage").hide();
				jQuery("#prevLeftPage").hide();
			}else{
				jQuery("#firstLeftPage").show();
				jQuery("#prevLeftPage").show();
				if(pageNum != totalPage){
					jQuery("#prevLeftPage").removeAttr("onclick");
					jQuery("#prevLeftPage").off();
					jQuery("#prevLeftPage").on("click",function(){doPageNav(pageNum-1)});
				}
			}

			if(pageNum == totalPage){
				jQuery("#endLeftPage").hide();
				jQuery("#nextLeftPage").hide();
			}else{
				jQuery("#endLeftPage").show();
				jQuery("#nextLeftPage").show();
				if(pageNum != 1){
					jQuery("#nextLeftPage").removeAttr("onclick");
					jQuery("#nextLeftPage").off();
					jQuery("#nextLeftPage").on("click",function(){doPageNav(pageNum+1)});
				}
			}
			jQuery("#inLeftPage").text(pageNum);
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
			
			jQuery(".list_div_user").each(function(){
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
	
	/*初始化部门树*/
	function getDeptTree() {  
		jQuery("#lefthead").html("{*[cn.myapps.core.domain.department.department_list]*}:");
		depttree = jQuery("#leftcontent").jstree({ 
			core:{
				initially_open: ['root']
			}, 
			"json_data" : {
				"ajax" : { 
					"url" : function (){
						return contextPath + "/core/department/departTree.action?domain="+domainid+"&datetime=" + new Date().getTime();
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
					var deptname=jQuery(".jstree-hovered").text();
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
					url:contextPath+"/core/user/treelistForSuperior.action",
					type:"post",
					datatype:"jason",
					data:{"domain":domainid,"departid":deptid,"contentId":contentId},
					success:function(data){
							if(data){
								jQuery("#rightcontent").css("overflow","auto");
								jQuery("#rightcontent").html(data);
								doPageNav(1);
								jQuery("#all_page_hide").hide();
							}else{
								jQuery("#rightcontent").html("<div class='list_div'>{*[cn.myapps.core.domain.selectproxyuser.can_not_find_user]*}</div>");
							}
						},
					error:function(data,status){
							alert("failling to visited...");
						}
			});	
		}
	}
	
	/*初始化默认值*/
	function initDefValue(defValue){
		if (defValue) {
			var array = jQuery.isArray(defValue) ? defValue: defValue.split(",");
			var params = "";
			if (array && array.length > 0) {
				for (var i = 0; i < array.length; i++) {
					params += "&_selects=" + array[i];
				}
			}
			
			jQuery.ajax({
					url:contextPath+"/core/user/doListBySelectToJSON.action",
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
	
	/*初始化返回事件*/
	function initDoReturnFunction(){
		jQuery("#doReturn").click(function(){
			var rtn="";
			jQuery(".onSelect").each(function(){
				rtn+=jQuery(this).attr("id")+",";
			});
			if (rtn && rtn.length > 0) {
				rtn=rtn.substring(0,rtn.length-1);
			}
			OBPM.dialog.doReturn(rtn);
		});
	}

	/*用户点击选择用户事件(返回错误信息)*/
	function selectUserWithReturnMsg(obj,isclickone){
			if(obj.attr("checked")=="checked"){
				jQuery(".list_div_click").each(function(){
					if(jQuery(this).attr("id") != obj.attr("id")){
						jQuery(this).removeAttr("checked");
					}
				});
				jQuery("#selectedUserDiv").find("span").remove();
				return addToUserSelect(obj);
			}else{
				//jQuery(this).attr("checked",false);
				jQuery(".onSelect").each(function(){
					if(jQuery(this).attr("id")==obj.attr("id")){		
						jQuery("span").remove("#"+obj.attr("id"));
					}
				});	
			}
			
			resetTargetValue();
	}
	
	/*用户点击选择用户事件*/
	function selectUser(obj,isclickone){
			if(obj.attr("checked")=="checked"){
				jQuery(".list_div_click").each(function(){
					if(jQuery(this).attr("id") != obj.attr("id")){
						jQuery(this).removeAttr("checked");
					}
				});
				jQuery("#selectedUserDiv").find("span").remove();
				addToUserSelect(obj);
			}else{
				//jQuery(this).attr("checked",false);
				jQuery(".onSelect").each(function(){
					if(jQuery(this).attr("id")==obj.attr("id")){		
						jQuery("span").remove("#"+obj.attr("id"));
					}
				});	
			}
			
			resetTargetValue();
	}
	
	function addToUserSelect(obj){
		var map = {id: obj.attr("id"), name: obj.attr("name"), email: obj.attr("email")};
		return addToUserSelectByMap(map);
	}
	
	function addToUserSelectByMap(map){
		var errorMsg = '';
		var id = map["id"];
		var name = map["name"];
		var email = map["email"];
		//var ids = document.getElementsByName(id).length;
		var ids = 1;
		jQuery("#selectedUserDiv").find("span").each(function(){
			if(jQuery(this).attr("id")==id){
				ids++;
			}
		});
	   if(ids>1){
		   errorMsg += name + ';';
		 //alert("{*[cn.myapps.core.domain.selectproxyuser.user_already_be_add]*}");
	   }else if (parentObj.document.getElementById(viewEmail) && email == '') {
			alert("[" + name + "] {*[用户邮箱未设置！]*}");
	   }else{
		 jQuery("#selectedUserDiv").append("<span style='display:block;width:95%;' onclick='clickRemoveSelect(\""+id+"\",\""+name+"\")' title='{*[cn.myapps.core.domain.selectproxyuser.title.click_delete]*}' class='onSelect' id="+id+" name="+id+" email="+email+">"+name+"</span>");
	   }
		
	   return errorMsg;
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
		
		jQuery('span[class=onSelect]').live('click',function(){
			jQuery(this).remove();
			resetTargetValue();
		});
		resetTargetValue();
		jQuery("#selectedUserDiv").focus();
	}
	
	/* 设置值到目标文本框中 */
	function resetTargetValue(){
			var targetValue="";
			var names="";
			var emails="";
			jQuery(".onSelect").each(function(){
				targetValue+=jQuery(this).attr("id")+";";//多个用户用“;”分隔
				names+=jQuery(this).html()+";";
				emails+=jQuery(this).attr("email")+";";
			});
			targetValue=targetValue.substring(0,targetValue.length-1);
			names=names.substring(0,names.length-1);
			emails=emails.substring(0,emails.length-1);
			//parentObj.document.getElementsByName(targetid)[0].value=targetValue;
			if (parentObj.document.getElementById(targetid)) {
				parentObj.document.getElementById(targetid).value=targetValue;
			}
			if (parentObj.document.getElementById(viewName)) {
				parentObj.document.getElementById(viewName).value=names;
				parentObj.document.getElementById(viewName).title=bulitTitle(names);
			}
			if (parentObj.document.getElementById(viewEmail)) {
				parentObj.document.getElementById(viewEmail).value=emails;
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
	
	jQuery(document).ready(function(){
		getDeptTree();
		initDoReturnFunction();
		initDefValue(defValue);
		initSetValue();
		//OBPM.dialog.resize(jQuery(window).width()+20, jQuery(window).height()+75);
		
		jQuery("#addAll").click(function(){
			jQuery(".list_div_click").each(function(){
				jQuery(this).attr("checked",true);
			});
			var errorMsg = '';
			jQuery("#rightcontent").find('input[class=list_div_click]').each(function(){
				var msg = selectUserWithReturnMsg(jQuery(this),false);
				if(msg != '')
					errorMsg += msg;
			});
			if(errorMsg && errorMsg.length > 0){
				errorMsg = errorMsg.substring(0,errorMsg.length - 1);
				alert("[" + errorMsg + "] {*[cn.myapps.core.domain.selectproxyuser.user_already_be_add]*}");
			}
			resetTargetValue();
		});
		
		jQuery("#deleteAll").click(function(){
			jQuery(".list_div_click").each(function(){
				jQuery(this).attr("checked",false);
			});
			jQuery("#selectedUserDiv").html("");
			resetTargetValue();
		});

		/*注册页签切换事件*/
		jQuery(".crossUL > li").click(function(){
			jQuery(".crossUL li.on").removeClass("on");
			jQuery(this).addClass("on");
			if(jQuery(this).attr("id")=="bydept"){
				getDeptTree();
			}
			/*if(jQuery(this).attr("id")=="byroles"){
				getRoleslist();
			}*/
			if(jQuery(this).attr("id")=="byonline"){
				getOnLineUserList();
			}
			if(jQuery(this).attr("id")=="bysearch"){
				getAllUser("");
			}
		});

		document.getElementById("addAll").style.display = "none";
	});
</script>
</head>
<body style="overflow-x:hidden;overflow-y:auto;margin: 0;padding: 5px;height:95%;">
	<div style="float: left;width: 400px;">
		<ul class="crossUL">
			<!--<li id="byroles" class="on">{*[cn.myapps.core.domain.selectproxyuser.by_role]*}</li>
			-->
			<li id="bydept" class="on">{*[cn.myapps.core.domain.selectproxyuser.by_department]*}</li>
			<li id="byonline">{*[cn.myapps.core.domain.selectproxyuser.online_user]*}</li>
			<li id="bysearch">{*[Search]*}</li>
		</ul>
	</div>
	<div style="float: right;width: 100px;">
		<input id="doReturn" type="button" value="{*[OK]*}">
	</div>
	<div class="contentDiv on">
		<div id="left" class="crossULdivleft">
			<div id="lefthead" class="list_div" style="height: 25;padding-top: 2px;padding-left: 2px;background-color: #F6F7F9;"></div>
			<div id="leftcontent" class="leftContent"></div>
		</div>
		<div id="right" class="crossULdivright">
			<div class="crossULdivright_lef">
				<div id="right_btn" class="list_div">
					<input id="addAll" type="button" value="{*[cn.myapps.core.domain.selectproxyuser.add_page_all]*}">
				</div>
				<div id="righttitle" style="background-color: #F6F7F9;padding-top: 5px;padding-left: 2px;text-align: left;vertical-align: middle;height: 22px;"></div>
				<div id="rightcontent" style="clear: all;padding-top: 5px;overflow: auto;"></div>
			</div>
			<div class="crossULdivright_rig">
				<div class="list_div">
					<input id="deleteAll" type="button" value="{*[cn.myapps.core.domain.selectsuperior.remove_superior]*}">
				</div>
				<div style="background-color: #F6F7F9;padding-top: 5px;padding-left: 2px;text-align: left;vertical-align: middle;height: 22px;">{*[cn.myapps.core.domain.selectproxyuser.already_choose_user]*}：</div>
				<div id="selectedUserDiv" class="selectedUserDiv"></div>
			</div>
		</div>
	</div>
</body>
</o:MultiLanguage>
</html>
