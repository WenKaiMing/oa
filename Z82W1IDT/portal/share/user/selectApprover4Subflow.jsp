<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>
<%@page import="cn.myapps.constans.Web"%>
<%
	WebUser webUser = (WebUser) session.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String domainid=webUser.getDomainid();
	String applicationid=request.getParameter("application");
	String _flowId =request.getParameter("flowid");
	String _docId =request.getParameter("docid");
	String _nodeId =request.getParameter("nodeid");
	String path=request.getContextPath();
%>
<html><o:MultiLanguage value="FRONTMULTILANGUAGETAG">
<head>
<title>{*[Select]*}{*[User]*}</title>
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
	var contextPath='<%=path%>';
	var domainid='<%=domainid%>'; 
	var applicationid='<%=applicationid%>';
	var _flowId = '<%=_flowId%>';
	var _docId = '<%=_docId%>';
	var _nodeId = '<%=_nodeId%>';
	var _isGetApprover2SubFlow = 'true';
	var depttree;
	var args = OBPM.dialog.getArgs();
	//var parentObj = args['parentObj'];
	var value = args["value"];
	var readonly = args["readonly"];
	var numberSetingType = args["numberSetingType"];
	var instanceTotal = args["instanceTotal"];
	var nodeid = args["nodeid"];
	var jsonStr = args["jsonStr"];
	
	//当前选中的组次
	var checkedPosition = "idPosition1";
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
	
	jQuery(document).ready(function(){
		getRoleslist();
		initFunction();
		initDefValue(defValue);
		InitCheckedUsers();
		checkedPosition = "idPosition1";
		changePositionStyle("idPosition1");
		
	});
	
	/*注册页签切换事件*/
	jQuery(function(){
		jQuery(".crossUL > li").click(function(){
			jQuery(".crossUL li.on").removeClass("on");
			jQuery(this).addClass("on");
			jQuery("#leftcontent").css("overflow","auto");
			if(jQuery(this).attr("id")=="bydept"){
				getDeptTree();
			}
			if(jQuery(this).attr("id")=="byroles"){
				getRoleslist();
			}
			if(jQuery(this).attr("id")=="bysearch"){
				getAllUser("");
			}
		});
	});

	//根据json初始化界面
	function InitCheckedUsers(){
		if(jsonStr != "")var jsonObj = JSON.parse(jsonStr);
		if(jsonObj == null || jsonObj == ""){//无用户数据时
			doAddPosition(1);
		}else{//有用户数据时
			if(jsonObj.approver == '' || jsonObj.approver == null) return;
			var approverObj = JSON.parse(jsonObj.approver);
			if(approverObj == null) return;
			//回显己有组次 
			for(var i=0; i<approverObj.length; i++){
				//设置当前组次
				checkedPosition = "idPosition" + approverObj[i].position;
				//回显组次
				doAddPosition(approverObj[i].position);
				
				var userids = approverObj[i].userids;
				var names = approverObj[i].names;
				if(userids == null || userids == "" || names == null || names == ""){
					break;
				}
				//回显对应组次的己选用户
				for(var j=0; j<userids.length; j++){
					var map = {id: userids[j], name: names[j]};
					addToUserSelectByMap(map);
				}
			}
		}
	}

	
	//添加组
	//params *positionCount--要生成的组次序
	function doAddPosition(positionCount){
		var positionStr = "<div id='idPosition" + positionCount + "' class='clsPosition'>";
		positionStr += "<div style='padding: 10px 5px;'><div class='clsTitle' style='float:left;'>第" + positionCount + "组</div>";
		positionStr += "<div class='deletePosition' style='color:red;float:right;'>X</div><div style='clear:both'></div></div>";
		positionStr += "<div class= 'checkedUserList' name ='idPosition'></div></div>";
		jQuery("#selectedUserDiv").append(positionStr);
		//注册组选中事件
		jQuery("#idPosition" + positionCount).click(function(){
			changePositionStyle(this.id);
			checkedPosition = this.id;
			cancelCheckedUser();
		});
		//注册移除组事件
		jQuery("#idPosition" + positionCount + " .deletePosition").click(function(){
			removePosition(this);
		});
	}

	//改变组选中样式
	function changePositionStyle(objId){
		jQuery(".clsPosition").css("backgroundColor","");
		jQuery("#" + objId).css("backgroundColor","#e0e0e0");
	}

	//移除组
	function removePosition(obj){
		//判断是否还可以删除
		if(jQuery(".clsPosition").size() <= 1){
			alert("{*[Groups.count.one.at.least]*}");
			return;
		}
		//移除组中用户
		jQuery(obj).parent().next().children().each(function(){
			clickRemoveSelect(this.id,this.innerHTML);
		});
		jQuery(obj).parent().parent().remove();
		//把组重新排序
		doSequencing();
	}

	//组排序
	function doSequencing(){
		jQuery("#selectedUserDiv > .clsPosition").each(function(i){
			this.id = "idPosition" + (i + 1);
			jQuery(this).children().first().text("{*[The]*} " + (i + 1) + " {*[Groups]*}");
		});
	}

	//取消待选用户列表中的用户回选
	function cancelCheckedUser(){
		jQuery(".list_div_click").each(function(){
			jQuery(this).attr("checked",false);
		});
	}
	
	/*查找所有的用户*/
	function getAllUser(param){
		jQuery("#lefthead").html("{*[Search]*}:"+"<input type='text' style='height: 18px;width:100px;' id='SHvalue' name='SHvalue' value=''><input onclick='getOnChange2Search(jQuery(\"#SHvalue\").attr(\"value\"))' style='height: 20px;padding-left:2px;' type='button' value='{*[Search]*}'>");
		if(domainid!=""){
			jQuery.ajax({
					url:contextPath+"/portal/user/getAllUser.action",
					type:"post",
					datatype:"jason",
					data:{"domain":domainid,"sm_name":param,"_flowId":_flowId,"_docId":_docId,"_nodeId":_nodeId,"_isGetApprover2SubFlow":_isGetApprover2SubFlow},
					success:function(data){
							if(data){
									jQuery("#SHvalue").attr("value",param);
									jQuery("#leftcontent").html("");
									jQuery("#rightcontent").css("overflow","auto");
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
	}
	
	function getOnChange2Search(value){
		jQuery("#righttitle").html("{*[Search]*}{*[Result]*}:");
		if(value!=""){
			getAllUser(value);
		}
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
					url:contextPath+"/portal/user/getUserListByRole.action",
					type:"post",
					datatype:"jason",
					data:{"applicationid":applicationid,"rolesid":rolesid,"_flowId":_flowId,"_docId":_docId,"_nodeId":_nodeId,"_isGetApprover2SubFlow":_isGetApprover2SubFlow},
					success:function(data){
							if(data){
								jQuery("#rightcontent").css("overflow","auto");
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
	}
	
	/*获取左侧的角色列表*/
	function getRoleslist(){
		jQuery("#lefthead").html("{*[Roles]*}{*[List]*}:");
		if(rolelist!=""){
			if(applicationid!=""){
				jQuery.ajax({
						url:contextPath+"/portal/role/getRolesList.action",
						type:"post",
						datatype:"jason",
						data:{"application":applicationid,"_flowId":_flowId,"_docId":_docId,"_nodeId":_nodeId,"_isGetApprover2SubFlow":_isGetApprover2SubFlow},
						success:function(data){
								if(data){
									rolelist=data;
									jQuery("#leftcontent").css("overflow","auto").html(rolelist);
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
					data:{"_flowId":_flowId,"_docId":_docId,"_nodeId":_nodeId,"_isGetApprover2SubFlow":_isGetApprover2SubFlow},
					success:function(data){
							if(data){
								jQuery("#leftcontent").css("overflow","auto").html(data);
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
					url:contextPath+url,
					type:"post",
					datatype:"jason",
					data:{"_flowId":_flowId,"_docId":_docId,"_nodeId":_nodeId,"_isGetApprover2SubFlow":_isGetApprover2SubFlow},
					success:function(data){
							if(data){
								jQuery("#rightcontent").css("overflow","auto");
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
					url:contextPath+"/portal/user/treelist.action",
					type:"post",
					datatype:"jason",
					data:{"domain":domainid,"departid":deptid,"_flowId":_flowId,"_docId":_docId,"_nodeId":_nodeId,"_isGetApprover2SubFlow":_isGetApprover2SubFlow},
					success:function(data){
							if(data){
								jQuery("#rightcontent").css("overflow","auto");
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
			params += "&_flowId=" + _flowId + "&_docId=" + _docId + "&_nodeId=" + _nodeId + "&_isGetApprover2SubFlow=" + _isGetApprover2SubFlow;

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
	
	function initFunction(){
		//注册删除所有用户事件
		jQuery("#deleteAllUser").click(function(){
			cancelCheckedUser();
			jQuery("#" + checkedPosition + " > .checkedUserList").html("");
			//jQuery("#selectedUserDiv").html("");
			//resetTargetValue();
		});

		//注册点击添加组事件
		jQuery("#addPosition").click(function(){
			//获取己有组，算出要添加的组数
			var positionCount = jQuery("#selectedUserDiv > .clsPosition").size();
			//判断是否还可以添加
			if(numberSetingType != 04)
				if(positionCount >= instanceTotal){
					alert("{*[Groups.count.not.greater.than]*} " + instanceTotal);
					return;
				}
			//添加组
			doAddPosition(positionCount + 1);
		});
		//注册添加所有用户事件
		jQuery("#addAll").click(function(){
			//jQuery("#selectedUserDiv").html("");
			jQuery(".list_div_click").each(function(){
				jQuery(this).attr("checked",true);
			});
			jQuery(".list_div_click").each(function(){
				selectUser(jQuery(this),false);
			});
			//resetTargetValue();
		});

		//注册返回事件
		jQuery("#doReturn").click(function(){
			var positionCount = jQuery("#selectedUserDiv > .clsPosition").size();
			for(var i= 1; i <= positionCount; i++){
				if(jQuery("#idPosition" + i)){
					var div_checkedUserList = jQuery("#idPosition" + i + " > .checkedUserList");
					if(div_checkedUserList){
						if(div_checkedUserList.html() == ""){
							alert("第" + i + "组用户不能为空.");
							return;
						}
					}
				}
			}
			if(numberSetingType != 04){
				if(positionCount != instanceTotal){
					alert("{*[Groups.not.equal]*}" + instanceTotal + ",{*[Please.add.or.del.groups.once.again]*}!");
					return;
				}
			}
			var rtn = '';
			var approver = '"[';
			jQuery('.clsPosition').each(function(i){  
				if(i != 0)approver += ',';
				var useridStr = '';
				var names = '';
				jQuery(this).children().last().children().each(function(i){
					if(i != 0){
						useridStr += ',';
						names += ',';
					}
					useridStr += '\\"' + this.id + '\\"';
					names +=  '\\"' + this.innerHTML + '\\"';
				});
				approver += '{\\"position\\":' + (i+1) + ',\\"userids\\":[' + useridStr + '],';
				approver += '\\"names\\":[' + names + ']}';
			});
			approver += ']"';

			rtn = '{"nodeid":"' + nodeid + '","approver":' + approver + '}';
			var rtnObj = JSON.parse(rtn);
			OBPM.dialog.doReturn(rtnObj);
		});
	}		
	
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
						jQuery("#" + checkedPosition + " > .checkedUserList > span").remove("#"+obj.attr("id"));
					}
				});	
			}
		}else{
			addToUserSelect(obj);
		}
		
		//resetTargetValue();
	}
	
	function addToUserSelect(obj){
		var map = {id: obj.attr("id"), name: obj.attr("name")};
		addToUserSelectByMap(map);
	}
	
	function addToUserSelectByMap(map){
		
		var id = map["id"];
		var name = map["name"];
		var idPositionArrary = jQuery("[name='idPosition']");
		var idPositionLength = idPositionArrary.length;
		 jQuery("#" + checkedPosition + " > .checkedUserList").append("<span style='display:block;width:95%;' onclick='clickRemoveSelect(\""+id+"\",\""+name+"\")' title='{*[Click]*}{*[Delete]*}' class='onSelect' id="+id+" name="+id+">"+name+"</span>");			
		for(var i=0;i<idPositionLength;i++){
			var childNodeLength = idPositionArrary[i].childNodes.length;
			for(var j=0;j<childNodeLength;j++){
				var idpaId = idPositionArrary[i].childNodes[j].id;
				for(var k=j+1;k<childNodeLength;k++){
                    if(idpaId==idPositionArrary[i].childNodes[k].id){
                    	RemoveSelect(idpaId,name,idPositionLength);
                    	alert("{*[userAlreadyBeAdd]*}");
                        }
					}
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
		jQuery(".list_div_click").each(function(){
			if(jQuery(this).attr("id")==id){
				jQuery(this).attr("checked",false);
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
		});
		
		//resetTargetValue();
		jQuery("#selectedUserDiv").focus();
	}

	function RemoveSelect(id,name,idPositionLength){
	
		jQuery(".list_div_click").each(function(){
			if(jQuery(this).attr("id")==id){
				jQuery(this).attr("checked",false);
			}
		});
		jQuery(".onSelect").each(function(){
				if(jQuery(this).attr("id")==id){
					for(var i=1;i<idPositionLength+2;i++){
						jQuery("#idPosition" + i).find(".onSelect").filter("#"+id).eq(1).remove();
					}
					}
			});
	}
	/* 设置值到目标文本框中 */
	function resetTargetValue(){
			var targetValue="";
			var names="";
			jQuery(".onSelect").each(function(){
				targetValue+=jQuery(this).attr("id")+";";//多个用户用“;”分隔
				names+=jQuery(this).html()+";";
			});
			targetValue=targetValue.substring(0,targetValue.length-1);
			names=names.substring(0,names.length-1);
			//parentObj.document.getElementsByName(targetid)[0].value=targetValue;
			if (parentObj.document.getElementById(targetid)) {
				parentObj.document.getElementById(targetid).value=targetValue;
			}
			if (parentObj.document.getElementById(viewName)) {
				parentObj.document.getElementById(viewName).value=names;
			}
			//parentObj.findUserName(targetValue);
	}
</script>
</head>
<body style="overflow-x:hidden;overflow-y:hidden;height:100%;margin: 0;">
	<div class="crossUL-top">
		<ul class="crossUL">
			<li id="byroles" class="on">{*[cn.myapps.core.user.by_role]*}</li>
			<li id="bydept">{*[cn.myapps.core.user.by_department]*}</li>
			<li id="bysearch">{*[Search]*}</li>
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
				<div id="rightcontent" style="clear: all;height: 332px;"></div>
			</div>
			<div class="guide"></div>
			<div class="crossULdivright_rig">
				<div class="list_div list_div_head">
					{*[cn.myapps.core.email.write.choose.delete_all.allready_choose_user]*}：

				</div>
				

				<div id="selectedUserDiv" class="selectedUserDiv"></div>
				<div style="margin-right:10px;position: absolute;top: 2px;right: 0;">
				<!-- <input id="deleteAll" class="btn btn-danger" type="button" value="{*[Remove]*}{*[All]*}"> -->
				<input id="addPosition"class="btn " type="button" value="{*[Add]*}{*[Groups]*}">
				</div>
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
