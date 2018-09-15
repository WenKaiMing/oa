<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/km/disk/head.jsp"%>
<s:bean name="cn.myapps.km.category.ejb.CategoryHelper" id="categoryHelper"></s:bean>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href='<s:url value="/km/admin/css/bootstrap.min.css" />' rel="StyleSheet" type="text/css" />
<link href='<s:url value="/km/script/dtree/dtree.css" />' rel="StyleSheet" type="text/css" />
<link href='<s:url value="/km/admin/css/admin.css" />' rel="StyleSheet" type="text/css" />
<script src="<s:url value='/km/admin/js/jquery-2.1.4.js'/>"></script>
<script src="<s:url value='/km/admin/js/km.utils.js'/>"></script>
<script src="<s:url value='/km/admin/js/template.js'/>"></script>
<script src="<s:url value='/km/category/category.service.js'/>"></script>
<!-- plugin -->
<link href='<s:url value="/km/admin/js/plugin/toastr/toastr.css" />' rel="StyleSheet" type="text/css" />
<script src="<s:url value='/km/admin/js/plugin/toastr/toastr.min.js'/>"></script>
<script type="text/javascript">
function ev_edit(obj){
	var url='<s:url action="view"/>?id='+id;
	jQuery("#contentFrame").attr("src",url);
	jQuery(".btn_save").attr("disabled",false).show();
}
function ev_save(){
	var params = {}
	params.name = $("#_name").val();
	params.description = $("#_description").val();
	params.id = $("#_name").attr("_id");
	params.parentId  = $("#_parentId").val();//需要那上级id
	Category.editlist(params,function(result){
		var listId = $("#_name").attr("_id");
		var oldparentId = $("#_parentId").val();
		var newparentId = result.parentId;
		if(oldparentId != "" || typeof(oldparentId) != "undefined"){
			$("li[_id="+listId+"]").remove();
		}else{
			$(".eachOne[_id="+listId+"]").remove();
			$("option[value="+listId+"]").remove();
		}
		var addListArr =  {};
		addListArr.list = [];
		addListArr.list.push(result);
		var fatherId = result.parentId;
		if(fatherId == ""){
			var tmpl_father = template("firstMenu", addListArr);
			$("#categoryList").append(tmpl_father);
		}else{
			var tmpl_son = template("secondMenu", addListArr);
			$(".eachOne[_id="+fatherId+"]").find("ul").append(tmpl_son);
		}
	});
}

function warpAttributes(){
	var iframe = document.getElementById('contentFrame').contentWindow;
	if(iframe.document.getElementById("_id")){
		jQuery("#_id").attr("value",iframe.document.getElementById("_id").value);
		jQuery("#_name").attr("value",iframe.document.getElementById("_name").value);
		jQuery("#_parentId").attr("value",iframe.document.getElementById("_parentId").value);
		jQuery("#_domainId").attr("value",iframe.document.getElementById("_domainId").value);
		jQuery("#_description").attr("value",iframe.document.getElementById("_description").value);
	}
}

function ev_delete(id){
	if(confirm("{*[cn.myapps.km.category.delete_tip]*}")){
		Category.deletelist({"id":id},function(result){
			var fatherId = result.parentId;
			var _id = result.id;
			if(fatherId == ""){
				$(".eachOne[_id="+_id+"]").remove();
				$("option[value="+_id+"]").remove();
			}else{
				$("li[_id="+_id+"]").remove();
			}
		});
	}
}
function ev_new(){
	$("#_name").val("");
	$("#_description").val("");
	$("#_parentId").val("");
	$(".create").show();
	$(".update").hide();
	$("#_name").focus();
}
function ev_add(){
	var params = {};
	params.name = $("#_name").val();
	params.description = $("#_description").val();
	params.parentId = $("#_parentId").val();
	Category.addList(params,function(result){
		var addListArr =  {};
		addListArr.list = [];
		addListArr.list.push(result);
		var fatherId = result.parentId;
		if(fatherId == ""){
			var tmpl_father = template("firstMenu", addListArr);
			$("#categoryList").append(tmpl_father);
			
			var tmpl_option = template("_option", addListArr);
			$("#_parentId").append(tmpl_option);
		}else{
			var tmpl_son = template("secondMenu", addListArr);
			$(".eachOne[_id="+fatherId+"]").find("ul").append(tmpl_son);
		}
		
		$("#_name").val("");
		$("#_description").val("");
		$("#_parentId").val("");
	});
}
function loadTress(){
	Category.getTreeList({},function(data){
		//新建面板下拉选择一级菜单
		var firMenu =  {};
		firMenu.list = data;
		var parentTmpl = template("_parentMenu", firMenu);
		$("#_parentId").html(parentTmpl);
		//左侧树形结构
		var tmpl = template("firstMenu", firMenu);
		$("#categoryList").html(tmpl);
		if($("#categoryList").find(".eachOne").length >0){
			$(".eachOne").each(function(){
				var id = $(this).attr("_id");
				var parent_div = $(this);
				Category.getTreeList({"id":id},function(data){
					var secMenu =  {};
					secMenu.list = data;
					var tmpl = template("secondMenu", secMenu);
					parent_div.find("ul").html(tmpl);
				});
			});
		}
	});
}
jQuery(document).ready(function(){
	var targetId = '<s:property value="targetId" />';
	if(targetId.length>0){
		ev_edit(targetId);
	}
	loadTress();
	$(".category_content").on("click", ".my-list_arrow",function(){
		$(this).parents(".first_menu").toggleClass("open");
		$(this).parents(".first_menu").next().toggleClass("open");
	});
	$(".category_content").on("click", ".editlist",function(){
		$(this).parents("#categoryList").find("li").removeClass("active");
		$(this).parents("li").addClass("active");
		$("#_name").val($(this).attr("name"));
		$("#_name").attr("_id",$(this).attr("_id"));
		$("#_description").val($(this).attr("desc"));
		$("#_parentId").find("option[value='"+$(this).attr("parentid")+"']").attr("selected", "selected")
		$(".create").hide();
		$(".update").show();
	});
});
</script>

</head>
<body>


<div class="category_content">
	
	
	
	<!-- LEFT SITE START -->
	<div id="left">
		<div class="newTag"><button type="button" class="btn btn-newTag" onclick="ev_new()">新建标签</button></div>
		<div id="categoryList"></div>
	</div>
	<!-- LEFT SITE END -->
	
	<!-- RIGHT SITE START -->
	<div id="right">
			<div style="width:450px;margin:15px auto 0;overflow: hidden;">
					<table align="center" height="100%">
						<tr class="categoryRig_tr">
							<td class="categoryRig_first" align="right">{*[cn.myapps.km.category.name]*}:</td>
							<td class="categoryRig_sec" align="left"><input class="input-cmd form-control" name="name" id="_name" /></td>
						</tr>
						<tr class="categoryRig_tr">
							<td class="categoryRig_first" align="right">{*[cn.myapps.km.category.description]*}:</td>
							<td class="categoryRig_sec" rows="2" align="left"><textarea class="input-cmd form-control" name="description" id="_description" ></textarea></td>
						</tr>
						<tr class="categoryRig_tr">
							<td class="categoryRig_first" align="right">{*[cn.myapps.km.category.super_type]*}:</td>
							<td class="categoryRig_sec"><select class="input-cmd form-control" name="parentId" id="_parentId"/></select></td>
						</tr>
				</table>
			</div>		
			<div id="toolbar">
				<button type="button" class="btn_save btn btn-save create" onClick="ev_add()">{*[cn.myapps.km.category.save]*}</button>
				<button type="button" class="btn_save btn btn-save update" style="display:none;" onClick="ev_save()">{*[cn.myapps.km.category.save]*}</button>
			</div>
	</div>
	<!-- RIGHT SITE END -->
</div>

<script type="text/html" id="firstMenu">
{{each list as firMenu}}
	<div class="eachOne" _id="{{firMenu.id}}">
		<div class="first_menu">
			<span class="my-list_arrow"></span><span class="my-list_tag"></span>
			<a class="editlist" desc="{{firMenu.description}}" name="{{firMenu.name}}" parentId="{{firMenu.parentId}}" sort="{{firMenu.sort}}" _id="{{firMenu.id}}" title="{{firMenu.name}}">{{firMenu.name}}</a>
			<button type="button" class="btn_delete button-image" onClick="ev_delete('{{firMenu.id}}')"></button>
		</div>
		<ul></ul>
	</div>
{{/each}}
</script>

<script type="text/html" id="secondMenu">
{{each list as secMenu}}
	<li _id="{{secMenu.id}}">
		<span class="my-list_tag"></span>
		<a class="editlist" desc="{{secMenu.description}}" name="{{secMenu.name}}" parentId="{{secMenu.parentId}}" sort="{{secMenu.sort}}" _id="{{secMenu.id}}" title="{{secMenu.name}}">{{secMenu.name}}</a>
		<button type="button" class="btn_delete button-image" onClick="ev_delete('{{secMenu.id}}')"></button>
	</li>
{{/each}}
</script>
<script type="text/html" id="_parentMenu">
<option value =""></option>
{{each list as parent}}
	<option value ="{{parent.id}}">{{parent.name}}</option>
{{/each}}
</script>
<script type="text/html" id="_option">
{{each list as parent}}
	<option value ="{{parent.id}}">{{parent.name}}</option>
{{/each}}
</script>
</body>
</o:MultiLanguage></html>