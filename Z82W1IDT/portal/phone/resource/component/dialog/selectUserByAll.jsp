<!DOCTYPE html> 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<%@ include file="/portal/phone/resource/common/js_base.jsp"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%
	WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String domainid=webUser.getDomainid();
	String applicationid=request.getParameter("application");
	String path=request.getContextPath();
	response.setHeader("Pragma","No-Cache");   
	response.setHeader("Cache-Control","No-Cache");   
	response.setDateHeader("Expires",   0);
	request.setAttribute("request",request);
	
	String flowid = (String)request.getParameter("flowid");
	String docid = (String)request.getParameter("docid");
	String nodeid = (String)request.getParameter("nodeid");
	String flow = (String)request.getParameter("flow");
%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[Select]*}{*[User]*}</title>
<meta name="viewport" content="initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<link href="./css/selectUserByAll.css" rel="stylesheet" >
<script src="<s:url value="/portal/share/script/list.js"/>"></script>
<script src="<s:url value='/portal/phone/resource/js/iscroll.js' />"></script>
<script src="<s:url value='/portal/phone/resource/js/common.js' />"></script>
<!-- tree pugin -->
<script type="text/javascript" src="<s:url value='/portal/phone/resource/js/tree/_lib/jquery.cookie.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/phone/resource/js/tree/_lib/jquery.hotkeys.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/phone/resource/js/tree/jquery.jstree.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/phone/resource/js/tree/plugins/jquery.jstree.checkbox.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/phone/resource/js/json/json2.js'/>"></script>
<script src="./selectUserByAll.js"></script>

<script type="text/javascript">
	var contextPath='<%=path%>';
	var domainid='<%=domainid%>'; 
	var flowid = '<%=flowid%>';
	var flow = '<%=flow%>';
	var docid = '<%=docid%>';
	var nodeid = '<%=nodeid%>';
	var applicationid='<%=applicationid%>';
	var depttree;
	var args = top.OBPM.dialog.getArgs();
	var parentObj = args['parentObj'];
	/*暂时不需要
	用户设定最大选着数
	var maxUser=args['limitSum'];
	if(maxUser==null || maxUser=="" || maxUser=="null"){
		maxUser=10;
	}*/
	/*存放userid*/
	var targetid=args['targetid'];
	/*存放username*/
	var viewName=args['receivername'];
	// 默认值
	var defValue=args['defValue'];
	var rolelist;
	var multiple = args['multiple'];
	/*选择模式*/
	var selectMode = multiple ? "multiSelect" : "selectOne";
	/*存放userEmail*/
	var viewEmail=args['receiverEmail'];
	/*存放userEmailAccount*/
	var viewEmailAccount=args['receiverEmailAccount'];
	/*存放userTelephone*/
	var viewTelephone=args['receiverTelephone'];
	
	function getOnLineUserList(){
		jQuery("#lefthead").html("{*[cn.myapps.core.email.write.choose.attr.current_online_user]*}:");
		jQuery.ajax({
					url:contextPath+"/portal/user/getOnLineUserList.action"+"?selectMode="+selectMode,
					type:"post",
					datatype:"json",
					timeout: 3000,
					data:{"domain":domainid},
					success:function(data){
							if(data){
								
								//jQuery("#leftcontent").html(data);
								//if(jQuery("#onLineUsersCount")){
								//	jQuery("#lefthead").html(jQuery("#lefthead").html()+"(<span style='color:red'>"+jQuery("#onLineUsersCount").attr("value")+"</span>)");
								//}
								
								var UserListTable="<div class='UserListTableDiv'><table width='100%'></table><div id='OnLineUser_none' style='display:none;'></div></div>"
									jQuery("#leftcontent").html(UserListTable)
									jQuery("#OnLineUser_none").html(data);
								var UserListNum = jQuery("#OnLineUser_none").find(".list_div").size();
									var UserName;
									var UserId;
									var UserEmail;
									var UserEmailaccount;
									var UserTelephone;
									var avatar = "";
									
									for(var i = 0; i < UserListNum;i++){
										var html='';
										UserName = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("name");
										UserId = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("id");
										UserEmail = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("email");
										UserEmailaccount = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("emailaccount");
										UserTelephone = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("telephone");
										if(UserTelephone == "null"){
											UserTelephone = "";
										}
										avatar = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("avatar");
										
										
										html += "<tr onclick='selectUser(jQuery(this).find(\".list_div_click\").click(),true);'><td width='20%' style='vertical-align: middle;text-align: center;border-right: 1px solid #ececec;background:#f8f8f8;'>"
											+"<input class='list_div_click' type='checkbox' name='"+UserName+"' avatar='"+avatar+"' id='"+UserId+"' email='"+UserEmail+"' emailaccount='"+UserEmailaccount+"' telephone='"+UserTelephone+"' onclick='selectUser(jQuery(this),true)'></td>"
											+"<td width='80%'><div class='secondTdImgDiv'><div class='secondTdImg'>";
											+"</tr>";
										
										if(avatar!="" && avatar!=undefined){
											html += "<img src ="+avatar+" style='width:40px;height:40px;border-radius:6px;'>";
										}else{
											html += UserName.substr(UserName.length-2, 2);
										}
										
										html += "</div></div><div class='Usercont'><div class='secondTdName'>"+UserName+"</div><div class='secondTdPhone'>"+UserTelephone+"</div></div></td></tr>";

										jQuery(".UserListTableDiv>table").append(html);
									}
									
									if(jQuery("#onLineUsersCount")){
										jQuery("#lefthead").html(jQuery("#lefthead").text()+"(<span style='color:red'>"+jQuery("#onLineUsersCount").attr("value")+"</span>)");
									}
								
							}else{
								jQuery("#leftcontent").html("<div class='list_div'>{*[core.dynaform.form.userfield.front.page.tip.can_not_found_user]*}</div>");
							}
						},
					error:function(data,status){
							alert("载入失败,请重试");
						}
		});	
	}

	/*根据分组id去那下面的users*/
	function getUserListByContancts(obj){
		jQuery(".selectImg_right").each(function(){
			jQuery(this).css("visibility","hidden");
		});
		jQuery("#img_"+obj.attr("id")).css("visibility","visible");
		getUserListByContanctsid(obj);
		
		var $menuRriggerEle = $(obj),
	    $contentWrapper = $('#left');
	    $menuRriggerEle.toggleClass('is-clicked');
	    //$contentWrapper.toggleClass('lateral-menu-is-open');
	    $('#right').toggleClass('lateral-menu-is-open');
	    $('#leftMask').show();
	}
	
	function getUserListByContanctsid(contanctsObj){
		var contanctsid=contanctsObj.attr("id");
		var contanctsname=contanctsObj.attr("title");
		if(contanctsid!=""){
			jQuery("#righttitle").html("分组："+contanctsname);
			jQuery.ajax({
					url:contextPath+"/portal/usergroup/getUserListBycontancts.action"+"?selectMode="+selectMode,
					type:"post",
					datatype:"json",
					timeout: 3000,
					data:{"domainid":domainid,"contanctsid":contanctsid},
					success:function(data){
							if(data){
								jQuery("#right").css({"width":"80%","z-index":"3"});
								jQuery("#rightcontent").css("overflow","auto");
								//jQuery("#rightcontent").html(data);
								var UserListTable="<div class='UserListTableDiv'><table width='100%'></table><div id='OnLineUser_none' style='display:none;'></div></div>"
									jQuery("#rightcontent").html(UserListTable)
									jQuery("#OnLineUser_none").html(data);
									var UserListNum = jQuery("#OnLineUser_none").find(".list_div").size();
									var UserName;
									var UserId;
									var UserEmail;
									var UserEmailaccount;
									var UserTelephone;
									var avatar = "";
									
									for(var i = 0; i < UserListNum;i++){
										var html='';
										UserName = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("name");
										UserId = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("id");
										UserEmail = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("email");
										UserEmailaccount = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("emailaccount");
										UserTelephone = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("telephone");
										if(UserTelephone == "null"){
											UserTelephone = "";
										}
										avatar = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("avatar");
										
										html += "<tr><td width='20%' style='vertical-align: middle;text-align: center;border-right: 1px solid #ececec;background:#f8f8f8;'>"
											+"<input class='list_div_click' type='checkbox' name='"+UserName+"' avatar='"+avatar+"' id='"+UserId+"' email='"+UserEmail+"' emailaccount='"+UserEmailaccount+"' telephone='"+UserTelephone+"' onclick='selectUser(jQuery(this),true)'></td>"
											+"<td width='80%'><div class='secondTdImgDiv'><div class='secondTdImg'>"
										if(avatar!="" && avatar!=undefined){
											html += "<img src ="+avatar+" style='width:40px;height:40px;border-radius:6px;'>";
										}else{
											html += UserName.substr(UserName.length-2, 2);
										}
										html += "</div></div><div onclick='selectUser(jQuery(this).parent().parent().find(\".list_div_click\").click(),true);' class='Usercont'><div class='secondTdName'>"+UserName+"</div><div class='secondTdPhone'>"+UserTelephone+"</div></div></td>"
											+"</tr>";
										jQuery(".UserListTableDiv>table").append(html);
									}
									jQuery(".UserListTableDiv").append($("#OnLineUser_none").find(".user_run_page"));
							}else{
								jQuery("#rightcontent").html("<div class='list_div'>{*[core.dynaform.form.userfield.front.page.tip.can_not_found_user]*}</div>");
							}
						},
					error:function(data,status){
							alert("载入失败,请重试");
						}
			});	
		}
	}

	//获取左侧通讯录分组列表
	function getContancts(){
		jQuery("#lefthead").html("{*[cn.myapps.core.usergroup.submit.contacts]*}:");
		jQuery.ajax({
			url:contextPath+"/portal/usergroup/getContancts.action"+"?selectMode="+selectMode,
			type:"post",
			datatype:"json",
			timeout: 3000,
			data:{"application":applicationid},
			success:function(data){
					if(data){
						rolelist=data;
						jQuery("#leftcontent").html(rolelist);
						jQuery("#leftcontent .list_div").css({"paddingTop":"15px","paddingBottom":"15px","font-size":"14px"});
						jQuery("#leftcontent .list_div").each(function(i){
							jQuery(this).find("img").attr("src","images/right_2.png");
							 });
					}else{
						jQuery("#leftcontent").html("<div>{*[CanNotFind]*}{*[Role]*}</div>");
					}
				},
			error:function(data,status){
					alert("载入失败,请重试");
				}
		});
	}
	
	/*查找所有的用户*/
	function getAllUser(value){
		if(flowid=="null" || nodeid=="null"){
			var $lefthead = jQuery("#lefthead");
			if($lefthead.find("#SHvalue").size()==0){
				$lefthead = jQuery("#lefthead").html("<div class='searchBox'><span class='searchTitle'></span>"+"<input class='searchInput' placeholder='输入姓名\\账号\\手机号查询' type='text' id='SHvalue' name='SHvalue' value=''><button id='searchBtn'><span class='icon icon-search'></span></button></div>");
				$lefthead.find("#searchBtn").click(function(){
					getAllUser();});
			} 
			var param = $lefthead.find("#SHvalue").val();
			if(domainid!=""){
				
				jQuery.ajax({
						url:contextPath+"/portal/user/getAllUser.action"+"?selectMode="+selectMode,
						type:"post",
						datatype:"json",
						timeout: 3000,
						data:{"domain":domainid,"sm_name":param},
						success:function(data){
								if(data){
									jQuery("#SHvalue").attr("value",param);
									jQuery("#rightcontent").css("overflow","auto");
									//jQuery("#leftcontent").html(data);
									var UserListTable="<div class='UserListTableDiv'><table width='100%'></table><div id='OnLineUser_none' style='display:none;'></div></div>"
										jQuery("#leftcontent").html(UserListTable)
										jQuery("#OnLineUser_none").html(data);
										var UserListNum = jQuery("#OnLineUser_none").find(".list_div").size();
										var UserName;
										var UserId;
										var UserEmail;
										var UserEmailaccount;
										var UserTelephone;
										var avatar = "";
										for(var i = 0; i < UserListNum;i++){
											var html='';
											UserName = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("name");
											UserId = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("id");
											UserEmail = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("email");
											UserEmailaccount = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("emailaccount");
											UserTelephone = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("telephone");
											if(UserTelephone == "null"){
												UserTelephone = "";
											}
											avatar = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("avatar");
											
											html += "<tr onclick='selectUser(jQuery(this).find(\".list_div_click\").click(),true);'><td width='20%' style='vertical-align: middle;text-align: center;border-right: 1px solid #ececec;background:#f8f8f8;'>"
												+"<input class='list_div_click' type='checkbox' name='"+UserName+"' avatar='"+avatar+"' id='"+UserId+"' email='"+UserEmail+"' emailaccount='"+UserEmailaccount+"' telephone='"+UserTelephone+"' onclick='selectUser(jQuery(this),true)'></td>"
												+"<td width='80%'><div class='secondTdImgDiv'><div class='secondTdImg'>";
											if(avatar!="" && avatar!=undefined){
												html += "<img src ="+avatar+" style='width:40px;height:40px;border-radius:6px;'>";
											}else{
												html += UserName.substr(UserName.length-2, 2);
											}
											html += "</div></div><div class='Usercont'><div class='secondTdName'>"+UserName+"</div><div class='secondTdPhone'>"+UserTelephone+"</div></div></td>"
												+"</tr>";
												
											jQuery(".UserListTableDiv>table").append(html);
										}
										jQuery(".UserListTableDiv").append($("#OnLineUser_none").find(".user_run_page"));
									
								}else{
									jQuery("#SHvalue").attr("value",param);
									jQuery("#rightcontent").html("<div class='list_div'>{*[core.dynaform.form.userfield.front.page.tip.can_not_found_user]*}</div>");
								}
							},
						error:function(data,status){
								alert("载入失败,请重试");
							}
				});	
			}
		}else{
			var $lefthead = jQuery("#lefthead");
			if($lefthead.find("#SHvalue").size()==0){
				$lefthead = jQuery("#lefthead").html("<div class='searchBox'><span class='searchTitle'></span>"+"<input class='searchInput' placeholder='输入姓名查询' type='text' id='SHvalue' name='SHvalue' value=''><button onclick='toSearchUser();' id='searchBtn'><span class='icon icon-search'></span></button></div>");
				//$lefthead.find("#searchBtn").click(function(){getAllUser();});
			} 
			//var param = $lefthead.find("#SHvalue").val();
			
			//jQuery("#lefthead").html("{*[Search]*}:"+"<input type='text' style='height: 18px;width:100px;' id='SHvalue' name='SHvalue' value=''><input onclick='toSearchUser();' style='padding-left:2px;' type='button' value='{*[Search]*}'>");

			var url = contextPath+"/portal/dynaform/document/selectByFlow.action?flowid="+flowid+"&docid="+docid+"&nodeid="+nodeid+"&type="+3;
			if(value && value != 'undefinded'){
				url = url + "&id=" + encodeURIComponent(value);
			}
			jQuery.ajax({
				url:url,
				type:"post",
				datatype:"jason",
				timeout: 3000,
				success:function(data){
					if(data){
						jQuery("#SHvalue").attr("value",param);
						jQuery("#rightcontent").css("overflow","auto");
						//jQuery("#leftcontent").html(data);
						var UserListTable="<div class='UserListTableDiv'><table width='100%'></table><div id='OnLineUser_none' style='display:none;'></div></div>"
							jQuery("#leftcontent").html(UserListTable)
							jQuery("#OnLineUser_none").html(data);
							var UserListNum = jQuery("#OnLineUser_none").find(".list_div_user").size();
							var UserName;
							var UserId;
							var UserEmail;
							var UserEmailaccount;
							var UserTelephone;
							var avatar = "";
							for(var i = 0; i < UserListNum;i++){
								var html='';
								UserName = $("#OnLineUser_none .list_div_user").eq(i).find(".list_div_click").attr("name");
								UserId = $("#OnLineUser_none .list_div_user").eq(i).find(".list_div_click").attr("id");
								UserEmail = $("#OnLineUser_none .list_div_user").eq(i).find(".list_div_click").attr("email");
								UserEmailaccount = $("#OnLineUser_none .list_div_user").eq(i).find(".list_div_click").attr("emailaccount");
								UserTelephone = $("#OnLineUser_none .list_div_user").eq(i).find(".list_div_click").attr("telephone");
								if(UserTelephone == "null"){
									UserTelephone = "";
								}
								avatar = $("#OnLineUser_none .list_div_user").eq(i).find(".list_div_click").attr("avatar");
									
								html += "<tr onclick='selectUser(jQuery(this).find(\".list_div_click\").click(),true);'><td width='20%' style='vertical-align: middle;text-align: center;border-right: 1px solid #ececec;background:#f8f8f8;'>"
									+"<input class='list_div_click' type='checkbox' name='"+UserName+"' avatar='"+avatar+"' id='"+UserId+"' email='"+UserEmail+"' emailaccount='"+UserEmailaccount+"' telephone='"+UserTelephone+"' onclick='selectUser(jQuery(this),true)'></td>"
									+"<td width='80%'><div class='secondTdImgDiv'><div class='secondTdImg'>";
								
								if(avatar!="" && avatar!=undefined){
									html += "<img src ="+avatar+" style='width:40px;height:40px;border-radius:6px;'>";
								}else{
									html += UserName.substr(UserName.length-2, 2);
								}	
									
								html += "</div></div><div class='Usercont'><div class='secondTdName'>"+UserName+"</div><div class='secondTdPhone'>"+UserTelephone+"</div></div></td></tr>";
								jQuery(".UserListTableDiv>table").append(html);
							}
							jQuery(".UserListTableDiv").append($("#OnLineUser_none").find(".user_run_page"));
							
						doPageNav(1);
						jQuery("#all_page_hide").hide();
					}else{
						jQuery("#SHvalue").attr("value",param);
						jQuery("#rightcontent").html("<div class='list_div'>{*[core.dynaform.form.userfield.front.page.tip.can_not_found_user]*}</div>");
					}
					},
				error:function(data,status){
						alert("载入失败,请重试");
					}
			});	

			
			
			
		}
		
	}
	

	/*常用联系人*/
	function getFavorite(){
		var $lefthead = jQuery("#lefthead");
		$lefthead.html("常用联系人:");
		if(domainid!=""){
			
			jQuery.ajax({
					url:contextPath+"/contacts/getFavoriteContacts.action",
					type:"post",
					datatype:"json",
					timeout: 3000,
					data:{},
					success:function(result){
						if(1==result.status){
							var html = "";
							var UserListTable="<div class='UserListTableDiv'><table width='100%'></table></div>"
							jQuery("#leftcontent").html(UserListTable)
							var UserListNum = jQuery("#OnLineUser_none").find(".list_div").size();
							var avatar = "";
							$.each(result.data,function(i,item){
								//html += "<div class='list_div' title='"+item.name+"'>"
								//	+ "<input class='list_div_click' type='checkbox' name='"+item.name+"' id='"+item.id+"' email='"+item.email+"' emailaccount='' telephone='"+item.mobile+"' onclick='selectUser(jQuery(this),true)'>"
								//	+ "<span onclick='jQuery(this).prev().click();selectUser(jQuery(this).prev(),true);'>"+item.name+"</span>"
								//	+ "</div>";
								avatar = item.avatar;
								html += "<tr><td width='20%' style='vertical-align: middle;text-align: center;border-right: 1px solid #ececec;background:#f8f8f8;'>"
								+"<input class='list_div_click' type='checkbox' name='"+item.name+"' avatar='"+avatar+"' id='"+item.id+"' email='"+item.email+"' emailaccount='' telephone='"+item.mobile+"' onclick='selectUser(jQuery(this),true)'></td>"
								+"<td width='80%'><div class='secondTdImgDiv'><div class='secondTdImg'>";
								if(avatar!="" && avatar!=undefined){
									html += "<img src ="+avatar+" style='width:40px;height:40px;border-radius:6px;'>";
								}else{
									html += item.name.substr(item.name.length-2, 2);
								}
								html += "</div></div><div onclick='selectUser(jQuery(this).parent().parent().find(\".list_div_click\").click(),true);' class='Usercont'><div class='secondTdName'>"+item.name+"</div><div class='secondTdPhone'></div></div></td>"
									 +"</tr>";
							});
							jQuery(".UserListTableDiv>table").html(html);
							//jQuery("#leftcontent").html(html);
						}else{
							jQuery("#rightcontent").html("<div class='list_div'>{*[core.dynaform.form.userfield.front.page.tip.can_not_found_user]*}</div>");
						}
					},
					error:function(data,status){
							alert("载入失败,请重试");
					}
			});	
		}
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
	
		var $menuRriggerEle = $(obj),
	    $contentWrapper = $('#left');
	    $menuRriggerEle.toggleClass('is-clicked');
	    //$contentWrapper.toggleClass('lateral-menu-is-open');
	    $('#right').toggleClass('lateral-menu-is-open');
	    $('#leftMask').show();
	    $('#right #rightcontent .list_div span').addClass("over");
	}
	
	function getUserListByRoleid(roleObj){
		if(flowid=="null" || nodeid=="null"){
			var rolesid=roleObj.attr("id");
			var rolesname=roleObj.attr("title");
			if(rolesid!=""){
				jQuery("#righttitle").html("{*[Role]*}："+rolesname);
				jQuery.ajax({
						url:contextPath+"/portal/user/getUserListByRole.action"+"?selectMode="+selectMode,
						type:"post",
						datatype:"json",
						timeout: 3000,
						data:{"applicationid":applicationid,"rolesid":rolesid},
						success:function(data){
								if(data){
									jQuery("#right").css({"width":"80%","z-index":"3"});
									jQuery("#rightcontent").css("overflow","auto");
									//jQuery("#rightcontent").html(data);
									
									var UserListTable="<div class='UserListTableDiv'><table width='100%'></table><div id='OnLineUser_none' style='display:none;'></div></div>"
										jQuery("#rightcontent").html(UserListTable)
										jQuery("#OnLineUser_none").html(data);
										var UserListNum = jQuery("#OnLineUser_none").find(".list_div").size();
										var UserName;
										var UserId;
										var UserEmail;
										var UserEmailaccount;
										var UserTelephone;
										var avatar = "";
										for(var i = 0; i < UserListNum;i++){
											var html='';
											UserName = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("name");
											UserId = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("id");
											UserEmail = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("email");
											UserEmailaccount = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("emailaccount");
											UserTelephone = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("telephone");
											if(UserTelephone == "null"){
												UserTelephone = "";
											}
											avatar = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("avatar");
											
											html += "<tr onclick='selectUser(jQuery(this).find(\".list_div_click\").click(),true);'><td width='20%' style='vertical-align: middle;text-align: center;border-right: 1px solid #ececec;background:#f8f8f8;'>"
												+"<input class='list_div_click' type='checkbox' name='"+UserName+"' avatar='"+avatar+"' id='"+UserId+"' email='"+UserEmail+"' emailaccount='"+UserEmailaccount+"' telephone='"+UserTelephone+"' onclick='selectUser(jQuery(this),true)'></td>"
												+"<td width='80%'><div class='secondTdImgDiv'><div class='secondTdImg'>";
												+"</tr>";
											
											if(avatar!="" && avatar!=undefined){
												html += "<img src ="+avatar+" style='width:32px;height:32px;border-radius:6px;'>";
											}else{
												html += UserName.substr(UserName.length-2, 2);
											}
											
											html += "</div></div><div class='Usercont'><div class='secondTdName'>"+UserName+"</div><div class='secondTdPhone'>"+UserTelephone+"</div></div></td></tr>";
											
											jQuery(".UserListTableDiv>table").append(html);
										}
										jQuery(".UserListTableDiv").append($("#OnLineUser_none").find(".user_run_page"));
								}else{
									jQuery("#rightcontent").html("<div class='list_div'>{*[core.dynaform.form.userfield.front.page.tip.can_not_found_user]*}</div>");
								}
							},
						error:function(XMLHttpRequest, textStatus, errorThrown){  
					        	//alert('XMLHttpRequest.readyState-->'+XMLHttpRequest.readyState + 'XMLHttpRequest.status-->'+XMLHttpRequest.status + 'XMLHttpRequest.responseText-->'+XMLHttpRequest.responseText);
								alert("载入失败,请重试");
							}
				});	
			}
		}else{
			var rolesid=roleObj.attr("id");
			var rolesname=roleObj.attr("title");
			if(rolesid!=""){
				jQuery("#righttitle").html("{*[Role]*}："+rolesname);
				jQuery.ajax({
					url:contextPath+"/portal/dynaform/document/selectByFlow.action?flowid="+flowid+"&docid="+docid+"&nodeid="+nodeid+"&type="+2+"&id="+rolesid,
					type:"post",
					datatype:"jason",
					timeout: 3000,
					//data:{"flowid":flowid,"docid":docid,"nodeid":nodeid,"type":"2","id":rolesid},
					success:function(data){
							if(data){
								jQuery("#right").css({"width":"80%","z-index":"3"});
								jQuery("#rightcontent").css("overflow","auto");
								//jQuery("#rightcontent").html(data);
								var UserListTable="<div class='UserListTableDiv'><table width='100%'></table><div id='OnLineUser_none' style='display:none;'></div></div>"
									jQuery("#rightcontent").html(UserListTable)
									jQuery("#OnLineUser_none").html(data);
									var UserListNum = jQuery("#OnLineUser_none").find(".list_div_user").size();
									var UserName;
									var UserId;
									var UserEmail;
									var UserEmailaccount;
									var UserTelephone;
									var avatar = "";
									for(var i = 0; i < UserListNum;i++){
										var html='';
										UserName = $("#OnLineUser_none .list_div_user").eq(i).find(".list_div_click").attr("name");
										UserId = $("#OnLineUser_none .list_div_user").eq(i).find(".list_div_click").attr("id");
										UserEmail = $("#OnLineUser_none .list_div_user").eq(i).find(".list_div_click").attr("email");
										UserEmailaccount = $("#OnLineUser_none .list_div_user").eq(i).find(".list_div_click").attr("emailaccount");
										UserTelephone = $("#OnLineUser_none .list_div_user").eq(i).find(".list_div_click").attr("telephone");
										if(UserTelephone == "null"){
											UserTelephone = "";
										}
										avatar = $("#OnLineUser_none .list_div_user").eq(i).find(".list_div_click").attr("avatar");

										html += "<tr><td width='20%' style='vertical-align: middle;text-align: center;border-right: 1px solid #ececec;background:#f8f8f8;'>"
											+"<input class='list_div_click' type='checkbox' name='"+UserName+"' avatar='"+avatar+"' id='"+UserId+"' email='"+UserEmail+"' emailaccount='"+UserEmailaccount+"' telephone='"+UserTelephone+"' onclick='selectUser(jQuery(this),true)'></td>"
											+"<td width='80%'><div class='secondTdImgDiv'><div class='secondTdImg'>";
										
										if(avatar!="" && avatar!=undefined){
											html += "<img src ="+avatar+" style='width:32px;height:32px;border-radius:6px;'>";
										}else{
											html += UserName.substr(UserName.length-2, 2);
										}
										
										html +="</div></div><div onclick='selectUser(jQuery(this).parent().parent().find(\".list_div_click\").click(),true);' class='Usercont'><div class='secondTdName'>"+UserName+"</div><div class='secondTdPhone'>"+UserTelephone+"</div></div></td>"
											+"</tr>";
											
										jQuery(".UserListTableDiv>table").append(html);
									}
									jQuery(".UserListTableDiv").append($("#OnLineUser_none").find(".user_run_page"));
									
								doPageNav(1);
								jQuery("#all_page_hide").hide();
							}else{
								jQuery("#rightcontent").html("<div class='list_div'>{*[core.dynaform.form.userfield.front.page.tip.can_not_found_user]*}</div>");
							}
						},
					error:function(data,status){
							alert("载入失败,请重试");
						}
				});	
			}
		}	
	}
	
	
	/*获取左侧的角色列表*/
	function getRoleslist(){
		if(flowid=="null" || nodeid=="null"){
			jQuery("#lefthead").html("{*[Roles]*}{*[List]*}:");
			if(rolelist!=""){
			//	if(applicationid!=""){
					jQuery.ajax({
							url:contextPath+"/portal/role/getRolesList.action"+"?selectMode="+selectMode,
							type:"post",
							datatype:"json",
							timeout: 3000,
							data:{"application":applicationid},
							success:function(data){
									if(data){
										rolelist=data;
										jQuery("#leftcontent").html(rolelist);
										jQuery("#leftcontent .list_div").css({"paddingTop":"15px","paddingBottom":"15px","font-size":"14px"});
										jQuery("#leftcontent .list_div").each(function(i){
											jQuery(this).find("img").attr("src","images/right_2.png");
											 });
									}else{
										jQuery("#leftcontent").html("<div>{*[CanNotFind]*}{*[Role]*}</div>");
									}
								},
							error:function(data,status){
									alert("载入失败,请重试");
								}
					});	
			//	}
			}else{
				jQuery("#leftcontent").html(rolelist);
				jQuery("#leftcontent .list_div").css({"paddingTop":"15px","paddingBottom":"15px","font-size":"14px"});
				jQuery("#leftcontent .list_div").each(function(i){
					jQuery(this).find("img").attr("src","images/right_2.png");
					 });
			}
		}else{
			jQuery("#lefthead").html("{*[Roles]*}{*[List]*}:");
			if(rolelist!=""){
				if(applicationid!=""){
					jQuery.ajax({
							url:contextPath+"/portal/role/getRolesList.action",
							type:"post",
							datatype:"jason",
							timeout: 3000,
							data:{"application":applicationid},
							success:function(data){
									if(data){
										rolelist=data;
										jQuery("#leftcontent").css("overflow","auto").html(rolelist);
										jQuery("#leftcontent .list_div").css({"paddingTop":"15px","paddingBottom":"15px","font-size":"14px"});
										jQuery("#leftcontent .list_div").each(function(i){
											jQuery(this).find("img").attr("src","images/right_2.png");
											 });
									}else{
										jQuery("#leftcontent").html("<div>{*[CanNotFind]*}{*[Role]*}</div>");
									}
								},
							error:function(data,status){
									alert("载入失败,请重试");
								}
					});	
				}
			}else{
				jQuery("#leftcontent").html(rolelist);
				jQuery("#leftcontent .list_div").css({"paddingTop":"15px","paddingBottom":"15px","font-size":"14px"});
				jQuery("#leftcontent .list_div").each(function(i){
					jQuery(this).find("img").attr("src","images/right_2.png");
					 });
			}
		}
	}
	
	function doLeftPageNav(url){
		jQuery.ajax({
			url:contextPath+url,
			type:"post",
			datatype:"json",
			timeout: 3000,
			success:function(data){
					if(data){
						jQuery("#leftcontent").html(data);
					}else{
						jQuery("#leftcontent").html("<div class='list_div'>{*[core.dynaform.form.userfield.front.page.tip.can_not_found_user]*}</div>");
					}
				},
			error:function(data,status){
					alert("载入失败,请重试");
				}
		});	
	}
	
	function doPageNav(url){
		if(flowid=="null" || nodeid=="null"){
			jQuery.ajax({
				url:encodeURI(encodeURI(contextPath+url)),
				type:"post",
				contentType:"application/x-www-form-urlencoded:charset=UTF-8",
				datatype:"json",
				timeout: 3000,
				success:function(data){
						var $currTab = jQuery(".crossUL>a.active");
						var $dataContent = $currTab.attr("id")=="bysearch"?jQuery("#leftcontent"):jQuery("#rightcontent");//$currTab.attr("id")=="bysearch";
						if(data){
							$dataContent.css("overflow","auto");
							//$dataContent.html(data);
							var UserListTable="<div class='UserListTableDiv'><table width='100%'></table><div id='OnLineUser_none' style='display:none;'></div></div>"
								$dataContent.html(UserListTable)
								jQuery("#OnLineUser_none").html(data);
								var UserListNum = jQuery("#OnLineUser_none").find(".list_div").size();
								var UserName;
								var UserId;
								var UserEmail;
								var UserEmailaccount;
								var UserTelephone;
								var avatar = "";
								for(var i = 0; i < UserListNum;i++){
									var html='';
									UserName = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("name");
									UserId = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("id");
									UserTelephone = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("telephone");
									if(UserTelephone == "null"){
										UserTelephone = "";
									}
									avatar = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("avatar");
									
									html += "<tr onclick='selectUser(jQuery(this).find(\".list_div_click\").click(),true);'><td width='20%' style='vertical-align: middle;text-align: center;border-right: 1px solid #ececec;background:#f8f8f8;'>"
										+"<input class='list_div_click' type='checkbox' name='"+UserName+"' avatar='"+avatar+"' id='"+UserId+"' email='"+UserEmail+"' emailaccount='"+UserEmailaccount+"' telephone='"+UserTelephone+"' onclick='selectUser(jQuery(this),true)'></td>"
										+"<td width='80%'><div class='secondTdImgDiv'><div class='secondTdImg'>";
										+"</tr>";
									
									if(avatar!="" && avatar!=undefined){
										html += "<img src ="+avatar+" style='width:32px;height:32px;border-radius:6px;'>";
									}else{
										html += UserName.substr(UserName.length-2, 2);
									}
									
									html += "</div></div><div class='Usercont'><div class='secondTdName'>"+UserName+"</div><div class='secondTdPhone'>"+UserTelephone+"</div></div></td></tr>";
									
									
									
									jQuery(".UserListTableDiv>table").append(html);
								}
								jQuery(".UserListTableDiv").append($("#OnLineUser_none").find(".user_run_page"));
							
						}else{
							$dataContent.html("<div class='list_div'>{*[core.dynaform.form.userfield.front.page.tip.can_not_found_user]*}</div>");
						}
					},
				error:function(data,status){
						alert("载入失败,请重试");
					}
			});	
		}else{
			jQuery(".list_div_user").each(function(i){
				jQuery(".list_div_click").eq(i).data("show","false");
				jQuery(this).hide();
			});
			for(var i = 0;i < 10;i++){
				var user = jQuery(".list_div_user").eq((url-1)*10+i);
				jQuery(".list_div_click").eq((url-1)*10+i).data("show","true");
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
				if(url == 1){
					jQuery("#first_page").hide();
					jQuery("#prev_page").hide();
					jQuery("#next_page").removeAttr("onclick");
					jQuery("#next_page").off();
					jQuery("#next_page").on("click",function(){doPageNav(url+1)});
				}else{
					jQuery("#first_page").show();
					jQuery("#prev_page").show();
					if(url != totalPage){
						jQuery("#prev_page").removeAttr("onclick");
						jQuery("#prev_page").off();
						jQuery("#prev_page").on("click",function(){doPageNav(url-1)});
					}
				}

				if(url == totalPage){
					jQuery("#end_page").hide();
					jQuery("#next_page").hide();
					jQuery("#prev_page").removeAttr("onclick");
					jQuery("#prev_page").off();
					jQuery("#prev_page").on("click",function(){doPageNav(url-1)});
				}else{
					jQuery("#end_page").show();
					jQuery("#next_page").show();
					if(url != 1){
						jQuery("#next_page").removeAttr("onclick");
						jQuery("#next_page").off();
						jQuery("#next_page").on("click",function(){doPageNav(url+1)});
					}
				}
				jQuery("#in_page").text(url);
			}
		}
		
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
		//jQuery("#leftcontent.leftContent").css({"margin":"5px","border":"1px #ececec solid","border-radius":"4px"});
		
	}
	
	
	/*用户点击部门节点返回该部门下的用户*/
	function getUserListByDept(domainid,deptid,deptname){
		if(flowid=="null" || nodeid=="null"){
			if(domainid!="" && deptid!=""){
				jQuery("#righttitle").html("{*[Department]*}:"+deptname);
				jQuery.ajax({
						url:contextPath+"/portal/user/treelist.action"+"?selectMode="+selectMode,
						type:"post",
						datatype:"json",
						timeout: 3000,
						data:{"domain":domainid,"departid":deptid},
						success:function(data){
								if(data){
									jQuery("#right").css({"width":"80%","z-index":"3"});
									jQuery("#rightcontent").css("overflow","auto");
									//jQuery("#rightcontent").html(data);
									
									var UserListTable="<div class='UserListTableDiv'><table width='100%'></table><div id='OnLineUser_none' style='display:none;'></div></div>"
										jQuery("#rightcontent").html(UserListTable)
										jQuery("#OnLineUser_none").html(data);
										var UserListNum = jQuery("#OnLineUser_none").find(".list_div").size();
										var UserName;
										var UserId;
										var UserEmail;
										var UserEmailaccount;
										var UserTelephone;
										var avatar = "";
										for(var i = 0; i < UserListNum;i++){
											var html='';
											UserName = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("name");
											UserId = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("id");
											UserEmail = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("email");
											UserEmailaccount = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("emailaccount");
											UserTelephone = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("telephone");
											if(UserTelephone == "null"){
												UserTelephone = "";
											}
											avatar = $("#OnLineUser_none .list_div").eq(i).find(".list_div_click").attr("avatar");
											
											html += "<tr onclick='selectUser(jQuery(this).find(\".list_div_click\").click(),true);'><td width='20%' style='vertical-align: middle;text-align: center;border-right: 1px solid #ececec;background:#f8f8f8;'>"
												+"<input class='list_div_click' type='checkbox' name='"+UserName+"' avatar='"+avatar+"' id='"+UserId+"' email='"+UserEmail+"' emailaccount='"+UserEmailaccount+"' telephone='"+UserTelephone+"' onclick='selectUser(jQuery(this),true)'></td>"
												+"<td width='80%'><div class='secondTdImgDiv'><div class='secondTdImg'>";
												
											if(avatar!="" && avatar!=undefined){
												html += "<img src ="+avatar+" style='width:32px;height:32px;border-radius:6px;'>";
											}else{
												html += UserName.substr(UserName.length-2, 2);
											}
											
											html += "</div></div><div class='Usercont'><div class='secondTdName'>"+UserName+"</div><div class='secondTdPhone'>"+UserTelephone+"</div></div></td></tr>";
											
											jQuery(".UserListTableDiv>table").append(html);
										}
										jQuery(".UserListTableDiv").append($("#OnLineUser_none").find(".user_run_page"));
								}else{
									jQuery("#rightcontent").html("<div class='list_div'>{*[core.dynaform.form.userfield.front.page.tip.can_not_found_user]*}</div>");
								}
								//var $contentWrapper = $('#left');
							    //$contentWrapper.toggleClass('lateral-menu-is-open');
							    $('#right').toggleClass('lateral-menu-is-open');
							    $('#leftMask').show();
							},
						error:function(data,status){
								alert("载入失败,请重试");
							}
				});	
			}
		}else{
			if(domainid!="" && deptid!=""){
				jQuery("#righttitle").html("{*[Department]*}:"+deptname);
				jQuery.ajax({
					url:contextPath+"/portal/dynaform/document/selectByFlow.action?flowid="+flowid+"&docid="+docid+"&nodeid="+nodeid+"&type="+1+"&id="+deptid,
					type:"post",
					datatype:"jason",
					timeout: 3000,
					//data:{"flowid":flowid,"docid":docid,"nodeid":nodeid,"type":"1","id":deptid},
					success:function(data){
							if(data){
								jQuery("#right").css({"width":"80%","z-index":"3"});
								jQuery("#rightcontent").css("overflow","auto");
								//jQuery("#rightcontent").html(data);
								
								var UserListTable="<div class='UserListTableDiv'><table width='100%'></table><div id='OnLineUser_none' style='display:none;'></div></div>"
									jQuery("#rightcontent").html(UserListTable)
									jQuery("#OnLineUser_none").html(data);
									var UserListNum = jQuery("#OnLineUser_none").find(".list_div_user").size();
									var UserName;
									var UserId;
									var UserEmail;
									var UserEmailaccount;
									var UserTelephone;
									var avatar = "";
									
									for(var i = 0; i < UserListNum;i++){
										var html='';
										UserName = $("#OnLineUser_none .list_div_user").eq(i).find(".list_div_click").attr("name");
										UserId = $("#OnLineUser_none .list_div_user").eq(i).find(".list_div_click").attr("id");
										UserTelephone = $("#OnLineUser_none .list_div_user").eq(i).find(".list_div_click").attr("telephone");
										if(UserTelephone == "null"){
											UserTelephone = "";
										}
										avatar = $("#OnLineUser_none .list_div_user").eq(i).find(".list_div_click").attr("avatar");
										
										
										html += "<tr><td width='20%' style='vertical-align: middle;text-align: center;border-right: 1px solid #ececec;background:#f8f8f8;'>"
											+"<input class='list_div_click' type='checkbox' name='"+UserName+"' avatar='"+avatar+"' id='"+UserId+"' email='"+UserEmail+"' emailaccount='"+UserEmailaccount+"' telephone='"+UserTelephone+"' onclick='selectUser(jQuery(this),true)'></td>"
											+"<td width='80%'><div class='secondTdImgDiv'><div class='secondTdImg'>";
										
										if(avatar!="" && avatar!=undefined){
											html += "<img src ="+avatar+" style='width:32px;height:32px;border-radius:6px;'>";
										}else{
											html += UserName.substr(UserName.length-2, 2);
										}
											
										html += "</div></div><div onclick='selectUser(jQuery(this).parent().parent().find(\".list_div_click\").click(),true);' class='Usercont'><div class='secondTdName'>"+UserName+"</div><div class='secondTdPhone'>"+UserTelephone+"</div></div></td>"
											+"</tr>";
										jQuery(".UserListTableDiv>table").append(html);
									}
									jQuery(".UserListTableDiv").append($("#OnLineUser_none").find(".user_run_page"));
								doPageNav(1);
								jQuery("#all_page_hide").hide();
							}else{
								jQuery("#rightcontent").html("<div class='list_div'>{*[core.dynaform.form.userfield.front.page.tip.can_not_found_user]*}</div>");
							}
							//var $contentWrapper = $('#left');
						   // $contentWrapper.toggleClass('lateral-menu-is-open');
						    $('#right').toggleClass('lateral-menu-is-open');
						    $('#leftMask').show();
						},
					error:function(data,status){
							alert("载入失败,请重试");
						}
				});	
			}
		}
	}
	
	function alertError(error){
		if(error){
			if(error["errorMsgBeAdd"] && error["errorMsgBeAdd"].length > 0){
				var errorMsg = error["errorMsgBeAdd"];
				errorMsg = errorMsg.substring(0,errorMsg.length - 1);
				alert("[" + errorMsg + "] {*[userAlreadyBeAdd]*}");
			}
			if(error["errorMsgNoEmail"] && error["errorMsgNoEmail"].length > 0){
				var errorMsg = error["errorMsgNoEmail"];
				errorMsg = errorMsg.substring(0,errorMsg.length - 1);
				alert("[" + errorMsg + "] {*[userAlreadyNoEmail]*}");
			}
			if(error["errorMsgNoEmailAccount"] && error["errorMsgNoEmailAccount"].length > 0){
				var errorMsg = error["errorMsgNoEmailAccount"];
				errorMsg = errorMsg.substring(0,errorMsg.length - 1);
				alert("[" + errorMsg + "] {*[userAlreadyNoEmail]*}");
			}
			if(error["errorMsgNoTel"] && error["errorMsgNoTel"].length > 0){
				var errorMsg = error["errorMsgNoTel"];
				errorMsg = errorMsg.substring(0,errorMsg.length - 1);
				alert("[" + errorMsg + "] {*[userAlreadyNoTel]*}");
			}
		}
	}
	
	
	function addToUserSelectByMap(map){
		var error = {};
		var errorMsgBeAdd = '';
		var errorMsgNoEmail = '';
		var errorMsgNoEmailAccount = '';
		var errorMsgNoTel = '';
		var id = map["id"];
		var name = map["name"];
		var email = map["email"];
		var emailAccount = map["emailAccount"];
		var telephone = map["telephone"];
		var avatar = map["avatar"];
		//var ids = document.getElementsByName(id).length;
		var ids = 1;
		jQuery("#selectedUserDiv").find("span").each(function(){
			if(jQuery(this).attr("id")==id){
				ids++;
			}
		});
	   if(ids>1){
		   //errorMsgBeAdd += name + ';';
		 //alert("{*[userAlreadyBeAdd]*}");
	   }else if (parentObj.document.getElementById(viewEmail) && email == '') {
		   errorMsgNoEmail += name + ';';
			//alert("[" + name + "] {*[用户邮箱未设置！]*}");
	   }else if (parentObj.document.getElementById(viewEmailAccount) && emailAccount == '') {
		   errorMsgNoEmailAccount += name + ';';
			//alert("[" + name + "] {*[用户邮箱未设置！]*}");
	   }else if (parentObj.document.getElementById(viewTelephone) && telephone == '') {
		   errorMsgNoTel += name + ';';
			//alert("[" + name + "] {*[用户手机未设置！]*}");
	   }else{
		   
		   var userSelectTmp = "<span style='padding:0 5px 5px 5px' onclick='clickRemoveSelect(\""
				 +id+"\",\""
				 +name+"\")' title='{*[Click]*}{*[Delete]*}' class='onSelect td ' id='"
				 +id+"' name='"+id+"' email='"
				 +email+"' avatar='"+avatar+"' emailAccount='"
				 +emailAccount+"' telephone='"
				 +telephone+"'>";
				 
				 if(avatar!="" && avatar!=undefined){
					 userSelectTmp += "<div class='face'><span onclick='clickRemoveSelect(\""
						 +id+"\",\""
						 +name+"\")' ><img src='"
					 	 +avatar+"' style='width:40px;height:40px;border-radius:6px;'><span class='icon icon-close' style='position:absolute;top:0px;right:0px;width:14px;height:14px;border:1px solid #fff;border-radius:7px;background:#898383;color:white;'></span></span></div>";
						 
				 }else{
					 userSelectTmp += "<div class='face'><span onclick='clickRemoveSelect(\""
						 +id+"\",\""
						 +name+"\")' style='font-size: 40px;'><span style='height: 40px;width: 40px;color: #fff;text-align: center;line-height: 40px;font-size: 12px;border-radius: 6px;background: #428bcb;'>"+name.substr(name.length-2, 2)+"</span><span class='icon icon-close' style='position:absolute;top:0px;right:0px;width:14px;height:14px;border:1px solid #fff;border-radius:7px;background:#898383;color:white;'></span></span></div>";
						 
				 }
				 userSelectTmp += "<div class='select-name' style='white-space: nowrap;'>"+name+"</div></span>";

		 jQuery("#selectedUserDiv").append(userSelectTmp);
	   }
	   error = {"errorMsgBeAdd":errorMsgBeAdd, "errorMsgNoEmail":errorMsgNoEmail,"errorMsgNoEmailAccount":errorMsgNoEmailAccount, "errorMsgNoTel":errorMsgNoTel};
	   return error;
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
	
	
	/* 设置值到目标文本框中 */
	/**
	function resetTargetValue(){
			var targetValue="";
			var names="";
			var emails="";
			var emailAccounts="";
			var telephones="";
			jQuery(".onSelect").each(function(){
				targetValue+=jQuery(this).attr("id")+";";//多个用户用“;”分隔
				names+=jQuery(this).text()+";";
				emails+=jQuery(this).attr("email")+";";
				emailAccounts+=jQuery(this).attr("emailAccount")+";";
				telephones+=jQuery(this).attr("telephone")+";";
			});
			targetValue=targetValue.substring(0,targetValue.length-1);
			names=names.substring(0,names.length-1);
			emails=emails.substring(0,emails.length-1);
			emailAccounts=emailAccounts.substring(0,emailAccounts.length-1);
			telephones=telephones.substring(0,telephones.length-1);
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
			if (parentObj.document.getElementById(viewEmailAccount)) {
				parentObj.document.getElementById(viewEmailAccount).value=emailAccounts;
			}
			if (parentObj.document.getElementById(viewTelephone)) {
				parentObj.document.getElementById(viewTelephone).value=telephones;
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
	**/
	
	
	jQuery(document).ready(function(){
		bindEvent();
		initDefValue(defValue);
		initSetValue();
		//top.OBPM.dialog.resize(jQuery(window).width()+20, jQuery(window).height()+75);
		//添加所有用户
		jQuery("#addAll").click(function(){
			jQuery(".list_div_click").each(function(){
				jQuery(this).prop("checked",true);
			});
			var errorMsgBeAdd = '';
			var errorMsgNoEmail = '';
			var errorMsgNoEmailAccount = '';
			var errorMsgNoTel = '';
			
			if($('#right').is(':hidden')){
				jQuery("#leftcontent").find('input[class=list_div_click]').each(function(){
					var error = selectUserWithReturnMsg(jQuery(this),false);
					if(error){
						if(error["errorMsgBeAdd"] && error["errorMsgBeAdd"].length > 0){
							errorMsgBeAdd += error["errorMsgBeAdd"];
						}
						if(error["errorMsgNoEmail"] && error["errorMsgNoEmail"].length > 0){
							errorMsgNoEmail += error["errorMsgNoEmail"];
						}if(error["errorMsgNoEmailAccount"] && error["errorMsgNoEmailAccount"].length > 0){
							errorMsgNoEmailAccount += error["errorMsgNoEmailAccount"];
						}
						if(error["errorMsgNoTel"] && error["errorMsgNoTel"].length > 0){
							errorMsgNoTel += error["errorMsgNoTel"];
						}
					}
				});
			}else{
				jQuery("#rightcontent").find('input[class=list_div_click]').each(function(){
					var error = selectUserWithReturnMsg(jQuery(this),false);
					if(error){
						if(error["errorMsgBeAdd"] && error["errorMsgBeAdd"].length > 0){
							errorMsgBeAdd += error["errorMsgBeAdd"];
						}
						if(error["errorMsgNoEmail"] && error["errorMsgNoEmail"].length > 0){
							errorMsgNoEmail += error["errorMsgNoEmail"];
						}if(error["errorMsgNoEmailAccount"] && error["errorMsgNoEmailAccount"].length > 0){
							errorMsgNoEmailAccount += error["errorMsgNoEmailAccount"];
						}
						if(error["errorMsgNoTel"] && error["errorMsgNoTel"].length > 0){
							errorMsgNoTel += error["errorMsgNoTel"];
						}
					}
				});
			}
			
			
			
			if(errorMsgBeAdd && errorMsgBeAdd.length > 0){
				errorMsgBeAdd = errorMsgBeAdd.substring(0,errorMsgBeAdd.length - 1);
				alert("[" + errorMsgBeAdd + "] {*[userAlreadyBeAdd]*}");
			}
			if(errorMsgNoEmail && errorMsgNoEmail.length > 0){
				errorMsgNoEmail = errorMsgNoEmail.substring(0,errorMsgNoEmail.length - 1);
				alert("[" + errorMsgNoEmail + "] {*[userAlreadyNoEmail]*}");
			}
			if(errorMsgNoEmailAccount && errorMsgNoEmailAccount.length > 0){
				errorMsgNoEmailAccount = errorMsgNoEmailAccount.substring(0,errorMsgNoEmailAccount.length - 1);
				alert("[" + errorMsgNoEmailAccount + "] {*[userAlreadyNoEmail]*}");
			}
			if(errorMsgNoTel && errorMsgNoTel.length > 0){
				errorMsgNoTel = errorMsgNoTel.substring(0,errorMsgNoTel.length - 1);
				alert("[" + errorMsgNoTel + "] {*[userAlreadyNoTel]*}");
			}
			setListHeight();
			//resetTargetValue();
		});
		

		

		if(selectMode == 'selectOne'){
			document.getElementById("addAll").style.display = "none";
		}

		//触发默认选中
		if(flow == "true"){
			$("#bysearch").trigger("click");
		}else{
			jQuery("a.active").trigger("click");
		}

		if(flowid=="null" || nodeid=="null"){
		}else{
			$("#byonline").hide();
			$("#bycontancts").hide();
			$("#byfavorite").hide();
		}

		var u = navigator.userAgent, app = navigator.appVersion;
		var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
		if(isiOS){
			devWidth = window.screen.width;
		}else{
			devWidth = $(window).width();
		}
		$(".selectuser").width(devWidth);
		$(".reimburse").width(devWidth);
		
		var userScroll;				
    	
    	userScroll = new IScroll('.selectUserIS-box', { 
		preventDefault: false,
			preventDefaultException: { tagName: /^(INPUT|TEXTAREA|BUTTON|SELECT|A|SPAN)$/ }
		});

    	setListHeight();

    	//document.addEventListener('touchmove', function (e) {
    	//	e.preventDefault(); 
    	//}, false);

	});
</script>
</head>
<body>
<div class="reimburse">
	<div class="card_space_topfix" style="overflow:auto;position:relative">
		<div class="segmented-control crossUL">		
			<a id="byfavorite" class="control-item active">{*[常用]*}</a>
			<a id="bysearch" class="control-item">{*[Search]*}</a>
			<a id="byroles" class="control-item">{*[cn.myapps.core.email.write.choose.tab.title.by_role]*}</a>
			<a id="bydept" class="control-item">{*[cn.myapps.core.email.write.choose.tab.title.by_department]*}</a>
			<a id="byonline" class="control-item">{*[cn.myapps.core.email.write.choose.tab.title.online_user]*}</a>
			<a id="bycontancts" class="control-item">{*[cn.myapps.core.usergroup.submit.contacts]*}</a>
        </div>
    </div>
    <div class="selectUserIS-box">
	<div class="selectuser contentDiv on" style="height:100%;background:#fefefe;">
		<div id="left" class="card_app crossULdivleft">
			<div id="leftMask" onclick="getUserBox(jQuery(this))" style="display:none"></div>
			<div id="lefthead" class="tabName" style="padding: 5px;background-color: #F6F7F9;"></div>
			<div id="leftcontent" class="leftContent" style="overflow-x:hidden;overflow-y:auto;"></div>
		</div>
		
		<div id="right" class="crossULdivright" style="top:0;background:#fefefe;">
			<div class="crossULdivright_lef">
				
				<div id="righttitle" style="background-color: #fefefe;padding-left: 2px;text-align: left;vertical-align: middle;height: 60px;line-height:60px;font-size:16px;"></div>
				<div id="rightcontent" style="clear: all;padding-top: 5px;overflow: auto;"></div>
			</div>
			
		</div>
	</div>
	</div>

	
	<div id="div_button_box" class="card_space_fix zindex10" style="position:absolute">
		<div class="selected-list" style="overflow: auto;">
            <div class="table text-center" style="padding:0px">
                <div class="tr" id="selectedUserDiv">
    			</div>
    		</div>
    	</div>
		<table>
		<tbody>
			<tr class="formActBtn">
				<td><a id="deleteAll" class="btn btn-negative btn-block" data-transition="fade">{*[Remove]*}{*[All]*}</a></td>
				<td><a id="addAll" class="btn btn-primary btn-block" data-transition="fade">添加所有</a></td>
				<td><a id="doReturn" class="btn btn-positive btn-block" data-transition="fade">{*[OK]*}</a></td>
			</tr>
		</tbody>
		</table>
	</div>
</div>
</body>
</o:MultiLanguage>
</html>
