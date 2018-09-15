<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%
	WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String domainid=webUser.getDomainid();
	String applicationid=request.getParameter("application");
	String path=request.getContextPath();
%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[Select]*}{*[User]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/main.css' />" type="text/css">
<style>
#righttitle {
	height: 38px;
    overflow-x: hidden;
    text-overflow: ellipsis;
    line-height: 38px;
    padding-left: 10px;
    color: #676a6c;
    background-color: #fafafa;
    border-bottom: 1px solid #d2d2d2;
    white-space: nowrap;
}

.leftContent {
    overflow-y: hidden;
    overflow-x: auto!important;
    height:320px
}

#leftcontent>ul {
    margin-bottom: 20px;
}

</style>
<script src="<s:url value="/portal/share/script/list.js"/>"></script>
<!-- tree pugin -->
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/_lib/jquery.cookie.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/_lib/jquery.hotkeys.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/jquery.jstree.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/plugins/jquery.jstree.checkbox.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/json/json2.js'/>"></script>
<script src="<s:url value='/portal/H5/resource/script/jquery.slimscroll.min.js'/>"></script><!-- 滚动条 -->
<script type="text/javascript">
	var contextPath='<%=path%>';
	var domainid='<%=domainid%>'; 
	var applicationid='<%=applicationid%>';
	var depttree;
	var args = OBPM.dialog.getArgs();
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
	/*存放角色信息*/
	var rolelist;
	/*存放联系人列表*/
	var contactlist;
	/*选择模式*/
	var selectMode = args['selectMode'];
	/*存放userEmail*/
	var viewEmail=args['receiverEmail'];
	/*存放userEmailAccount*/
	var viewEmailAccount=args['receiverEmailAccount'];
	/*存放userTelephone*/
	var viewTelephone=args['receiverTelephone'];

	/*查找所有的用户*/
	function getAllUser(param){
		jQuery("#righttitle").html("<span style='float:left;'>{*[cn.myapps.core.email.write.choose.attr.by_username]*}:</span><input type='text' placeholder='{*[cn.myapps.core.email.write.choose.attr.by_username]*}' style='float:left;width:280px;height: 36px;outline:medium;border:none;background-color: #fafafa;' id='SHvalue' name='SHvalue' value=''><input onclick='getOnChange2Search(jQuery(\"#SHvalue\").attr(\"value\"))' type='button'  class='searchPerson'>");
		if(domainid!=""){
			$.ajax({
	    		url: contextPath+"/contacts/getHisActors4FreeFlow.action",
	    		type:"post",
	    		async: false,
	    		cache:false,
				data:{"stateId":args.stateId,"applicationId":application},
				success: function(result){
					if(result){
						var html = "";
						var userList = result.data;
						for(var i = 0;i < userList.length;i++){
							var user = userList[i];
							html += "<div class='list_div' title='"+user.name+"'>"
								+ "<input class='list_div_click' type='radio' name='"+user.name+"' "
								+ "	id='"+user.id+"' avatar='' email='"+user.email+"' "
								+ "	emailAccount='"+user.email+"' telephone='"+user.mobile+"' onclick='selectUser(jQuery(this),true)'>"
								+ "	<span onclick='jQuery(this).prev().click();selectUser(jQuery(this).prev(),true);'> "
								+ user.name+"</span></div>"
						}
						jQuery("#SHvalue").attr("value",param);
						jQuery("#leftcontent").html("");
						jQuery("#rightcontent").html(html);
					}else{
						jQuery("#SHvalue").attr("value",param);
						//jQuery("#rightcontent").html("<div class='list_div'>{*[core.dynaform.form.userfield.front.page.tip.can_not_found_user]*}</div>");
						jQuery("#leftcontent").html("<div class='list_div'>{*[core.dynaform.form.userfield.front.page.tip.can_not_found_user]*}</div>");
					}
	    		}
	    	})	
		}
	}
	
	function getOnChange2Search(value){
		//jQuery("#righttitle").html("{*[Search]*}{*[Result]*}:");
		//if(value!=""){
		getAllUser(value);
		//}
	}
	
	
	function doLeftPageNav(url){
		jQuery.ajax({
					url:contextPath+url,
					type:"post",
					datatype:"json",
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
	
	function doPageNav(url){
		jQuery.ajax({
					url:encodeURI(encodeURI(contextPath+url)),
					type:"post",
					contentType:"application/x-www-form-urlencoded:charset=UTF-8",
					datatype:"json",
					success:function(data){
							if(data){
								jQuery("#rightcontent").html(data);
							}else{
								jQuery("#rightcontent").html("<div class='list_div'>{*[core.dynaform.form.userfield.front.page.tip.can_not_found_user]*}</div>");
							}
						},
					error:function(data,status){
							alert("failling to visited...");
						}
		});	
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
					url:contextPath+"/portal/user/doListBySelectToJSON.action",
					type:"post",
					datatype:"json",
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
			var array = new Array();
			jQuery(".onSelect").each(function(){
				var rtn={};
				rtn.value = jQuery(this).attr("id");
				rtn.text = jQuery(this).html();
				array.push(rtn);
			});
			OBPM.dialog.doReturn(array);
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
			if(selectMode == 'selectOne'){
				jQuery(".list_div_click").each(function(){
					if(jQuery(this).attr("id") != obj.attr("id")){
						jQuery(this).removeAttr("checked");
					}
				});
				jQuery("#selectedUserDiv").find("span").remove();
			}
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

	function alertError(error){
		if(error){
			if(error["errorMsgBeAdd"] && error["errorMsgBeAdd"].length > 0){
				var errorMsg = error["errorMsgBeAdd"];
				errorMsg = errorMsg.substring(0,errorMsg.length - 1);
				alert("[" + errorMsg + "] {*[userAlreadyBeAdd]*}");
			}
		}
	}
	
	function addToUserSelect(obj){
		var map = {id: obj.attr("id"), name: obj.attr("name"), email: obj.attr("email"), telephone: obj.attr("telephone")};
		return addToUserSelectByMap(map);
	}
	
	function addToUserSelectByMap(map){
		var error = {};
		var errorMsgBeAdd = '';
		var id = map["id"];
		var name = map["name"];
		var email = map["email"];
		var telephone = map["telephone"];
		//var ids = document.getElementsByName(id).length;
		var ids = 1;
		jQuery("#selectedUserDiv").find("span").each(function(){
			if(jQuery(this).attr("id")==id){
				ids++;
			}
		});
	   if(ids>1){
		   errorMsgBeAdd += name + ';';
		 //alert("{*[userAlreadyBeAdd]*}");
	   }else{
		 jQuery("#selectedUserDiv").append("<span style='display:block;width:95%;' onclick='clickRemoveSelect(\""+id+"\",\""+name+"\")' title='{*[Click]*}{*[Delete]*}' class='onSelect' id='"+id+"' name='"+id+"' email='"+email+"' telephone='"+telephone+"'>"+name+"</span>");
	   }
	   error = {"errorMsgBeAdd":errorMsgBeAdd};
	   return error;
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
			var telephones="";
			jQuery(".onSelect").each(function(){
				targetValue+=jQuery(this).attr("id")+";";//多个用户用“;”分隔
				names+=jQuery(this).html()+";";
				emails+=jQuery(this).attr("email")+";";
				telephones+=jQuery(this).attr("telephone")+";";
			});
			targetValue=targetValue.substring(0,targetValue.length-1);
			names=names.substring(0,names.length-1);
			emails=emails.substring(0,emails.length-1);
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
	
	//设置己选择的用户数据
	function initSetValue(){
		var targetidVal = "";
		var viewNameVal = "";
		var viewEmailVal = "";
		var viewTelVal = "";
		if (parentObj.document.getElementById(targetid)) {
			targetidVal = parentObj.document.getElementById(targetid).value;
		}
		if (parentObj.document.getElementById(viewName)) {
			viewNameVal = parentObj.document.getElementById(viewName).value;
		}
		if (parentObj.document.getElementById(viewEmail)) {
			viewEmailVal = parentObj.document.getElementById(viewEmail).value;
		}
		if (parentObj.document.getElementById(viewTelephone)) {
			viewTelVal = parentObj.document.getElementById(viewTelephone).value;
		}
		var userIds = targetidVal.split(";");
		var userNames = viewNameVal.split(";");
		var userEmail = viewEmailVal.split(";");
		var userTel = viewTelVal.split(";");
		for(var i=0; i<userIds.length; i++){
			if(userIds[i] != ""){
				var obj = {id:userIds[i],name:userNames[i],email:userEmail[i],telephone:userTel[i]};
				addToUserSelectByMap(obj);
			}
		}
	}
	//滚动条
	function rightContentScroll(){
		var rightscrollHeight = jQuery(".crossULdivright_lef").height()-jQuery(".crossULdivright_lef>#right_btn").height()-jQuery(".crossULdivright_lef>#righttitle").height()-2;
		var leftscrollHeight = jQuery(".crossULdivleft").height()-jQuery(".crossULdivleft>#lefthead").height()-2;
		var selectedscrollHeight = jQuery(".crossULdivright_rig").height()-jQuery(".crossULdivright_rig>.list_div_head").height()-2;
		$("#rightcontent").slimscroll({
			height: rightscrollHeight,
			color:'#333'
		});
		$("#leftcontent").slimscroll({
			height: leftscrollHeight,
			color:'#333'
		});
		$("#selectedUserDiv").slimscroll({
			height: selectedscrollHeight,
			color:'#333'
		});
	}
	jQuery(document).ready(function(){
		getAllUser("");
		initDoReturnFunction();
		initDefValue(defValue);
		initSetValue();
		
		jQuery("#addAll").click(function(){
			jQuery(".list_div_click").each(function(){
				jQuery(this).attr("checked",true);
				addToUserSelect(jQuery(this));
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

		/*注册页签切换事件*/
		jQuery(".crossUL > li").click(function(){
			if(jQuery(this).index() == $(".crossUL li").length - 1){
				jQuery(".guideOne").css("display","none");
				jQuery("#left").css("display","none");
				jQuery("#right_btn").css("display","none");
				jQuery(".crossULdivright_lef").css({"width":"423px"});
				jQuery(".crossULdivright_lef>.slimScrollDiv").css({"height":"330px"});
				jQuery(".crossULdivright_lef>.slimScrollDiv>#rightcontent").css({"height":"330px"});
			}else{
				jQuery(".guideOne").css("display","block");
				jQuery(".crossULdivright_lef").css("display","block");
				jQuery("#righttitle").html('');
				jQuery("#left").css("display","block");
				if(selectMode != 'selectOne'){
					jQuery("#right_btn").css("display","block");
				}
				jQuery(".crossULdivright_lef").css({"width":"198px"});
				jQuery(".crossULdivright_lef>.slimScrollDiv").css({"height":"292px"});
				jQuery(".crossULdivright_lef>.slimScrollDiv>#rightcontent").css({"height":"292px"});
			}
			jQuery(".crossUL li.on").removeClass("on");
			jQuery(this).addClass("on");
			$("#rightcontent").html("");

			if(jQuery(this).attr("id")=="bysearch"){
				getAllUser("");
			}
		});

		if(selectMode == 'selectOne'){
			document.getElementById("addAll").parentNode.style.display = "none";
		}
		//滚动条
		rightContentScroll();
	});
</script>
</head>
<body style="overflow-x:hidden;overflow-y:hidden;height:100%;margin: 0;">
	
	<div class="crossUL-top">
			<ul class="crossUL">
				<li id="bysearch" class="on">{*[all]*}</li>
			</ul>
	</div>
	<div style="float:none;clear:both;"></div>
	<div class="contentDiv on">
		<div id="left" class="crossULdivleft" style="display:none">
			<div id="lefthead" class="list_div list_div_head"></div>
			<div id="leftcontent" class="leftContent"></div>
		</div>
		
		<div id="right" class="crossULdivright">
			<div class="guide guideOne" style="display:none"></div>
			<div class="crossULdivright_lef" style="width: 423px;">
				<div id="right_btn" class="list_div list_div_head" style="text-align:center;">
					<input id="addAll" type="button" class="btn btn-default" value="{*[core.user.addPageAll]*}">
				</div>
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
</o:MultiLanguage>
</html>
