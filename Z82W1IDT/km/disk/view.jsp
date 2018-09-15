<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/km/disk/head.jsp"%>
<%@page import="java.io.File"%>
<%@page import="cn.myapps.km.util.FileUtils"%>
<%@page import="cn.myapps.km.disk.ejb.NFile"%>
<%@page import="cn.myapps.km.org.ejb.NUser"%>
<s:bean name="cn.myapps.km.category.ejb.CategoryHelper" id="categoryHelper"></s:bean>
<html><o:MultiLanguage>
<head>
<%
NUser user = (NUser) session.getAttribute(NUser.SESSION_ATTRIBUTE_FRONT_USER);
String userid = user.getId();
String fileid = (String)request.getParameter("id");
long count = new cn.myapps.km.comments.ejb.CommentsProcessBean().countBy(fileid, userid);
%>
<s:bean name="cn.myapps.km.comments.ejb.CommentsProcessBean" id="cpb" >
</s:bean>
<s:bean name="cn.myapps.km.permission.ejb.PermissionHelper" id="permissionHelper"></s:bean>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:property value="content.name"/></title>
<link href='<s:url value="/km/disk/css/km.css" />' rel="stylesheet" type="text/css"/>
<script src='<s:url value="/km/disk/script/share.js"/>'></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/CategoryHelper.js"/>'></script>
<script type="text/javascript">

function addAssessment(value){
	
	if(confirm("{*[cn.myapps.km.disk.comments_tip]*}")){
		var fileId = '<s:property value="content.id" />';
		if(value=='good'){
			var url = encodeURI(encodeURI(contextPath + "/km/comments/save.action?_evaluate=good&content.fileId="+fileId));
			}else{
			var url = encodeURI(encodeURI(contextPath + "/km/comments/save.action?_evaluate=bad&content.fileId="+fileId));
			}
		
		
		if(value=='good'){
			document.getElementById("_good").innerHTML=parseInt(document.getElementById("_good").innerHTML)+1;
		}else if(value=='bad'){
			document.getElementById("_bad").innerHTML=parseInt(document.getElementById("_bad").innerHTML)+1;
		}
		jQuery("#good").attr("src","<s:url value='/km/disk/images/disabledGood.gif'/>").removeAttr("onClick");
		jQuery("#notGood").attr("src","<s:url value='/km/disk/images/disabledNotGood.gif'/>").removeAttr("onClick");
		
		jQuery.ajax({	
			type: 'POST',
			async:false,
			url: url,
			dataType : 'text',
			
			//data: //jQuery("#content").serialize(),
			success:function(result) {
				if(result && result.indexOf("-")>=0){
					var rtn = result.split("-");
					document.getElementById("_good").innerHTML=rtn[0];
					document.getElementById("_bad").innerHTML=rtn[1];
					document.getElementById("_score").innerHTML=rtn[2];
					var  score=rtn[2];
					evaluateScore(score);
					jQuery("#good").attr("src","<s:url value='/km/disk/images/disabledGood.gif'/>").removeAttr("onClick");
					jQuery("#notGood").attr("src","<s:url value='/km/disk/images/disabledNotGood.gif'/>").removeAttr("onClick");
					return;
				}	
			},
			error: function(x) {
				
			}
		});
	}
}

function disabledScore(){
	var count = <%=count%>;
	if(count > 0){
		jQuery("#good").attr("src","<s:url value='/km/disk/images/disabledGood.gif'/>").removeAttr("onClick");
		jQuery("#notGood").attr("src","<s:url value='/km/disk/images/disabledNotGood.gif'/>").removeAttr("onClick");
	}
}

function setViewSize(){
	var bodyH = document.documentElement.clientHeight;
	var bodyW = jQuery("body").width();
	var view_rightW = jQuery(".view_right").width();
	jQuery(".view_center").height(bodyH - 20);
	jQuery(".view_left").width(bodyW - view_rightW - 70);
}


function  evaluateScore(score){
	if(!score){
		var score = <s:property value="content.getScore()"/>;
	}
	if(!typeof(score) == "number") return;
	
	var starHtml = "";
	for(i=1;i <= Math.floor(score);i++){
		starHtml +='<img alt="" src="<s:url value='/km/disk/images/star1.gif'/>">';
	}
	if(parseInt(score)!=score){
		starHtml +='<img alt="" src="<s:url value='/km/disk/images/star3.gif'/>">';		
	}
	for(i=1;i <= (5 - Math.ceil(score));i++){
		starHtml +='<img alt="" src="<s:url value='/km/disk/images/star2.gif'/>">';
	}
	
	jQuery(".starImg").html(starHtml);
}
jQuery(document).ready(function(){
	evaluateScore();
	disabledScore();
	setViewSize();
	init_category();
	});

jQuery(window).resize(function(){
	setViewSize();
});


function init_category(){
	var rootCategory = '<s:property value="content.rootCategoryId"/>';
	if(rootCategory.length>0){
		onRootCategoryChange(rootCategory);
		show_category();
	}
}

function show_category(){
	jQuery("#categoryList").show();
	var _rootCategory = jQuery("#_rootCategory option:selected").text();
	setTimeout(function(){
		var _subCategory = jQuery("#_subCategory option:selected").text();
		if(_rootCategory){
			jQuery("#categoryList").html(_rootCategory + "-"+ _subCategory);
		}else{
			jQuery("#categoryList").html("");
		}
	},300);
}

//编辑
function ev_editCategory(){
	jQuery(".editCategory").hide();
	jQuery("#categoryList").hide();
	jQuery(".showCategory").show();
}

//保存
function ev_saveCategory(){
	var url ='<s:url value="/km/disk/file/save4ajax.action"/>';
	jQuery.ajax({	
		type: 'POST',
		async:false,
		url: url,
		dataType : 'text',
		data: jQuery("#content").serialize(),
		success:function(result) {
			if(result && result=="success"){
				//回显
				jQuery(".editCategory").show();
				jQuery(".showCategory").hide();
				show_category();
				return;
			}else if(result){
				alert("{*[cn.myapps.km.disk.update_tip]*}");
				}
				
		},
		error: function(x) {
			
		}
	});
}

//取消
function ev_cancel(){
	jQuery(".editCategory").show();
	jQuery("#categoryList").show();
	jQuery(".showCategory").hide();
}

function refreshCategory(){
	var def = document.getElementById("_rootCategory").value;
	var domainId = '<s:property value="content.domainId"/>';
	CategoryHelper.getRootCategoryMap(domainId, function(options) {
		addOptions("_rootCategory", options, def);
	});
	onRootCategoryChange(def);
}

function onRootCategoryChange(value){
	var def =  '<s:property value="content.subCategoryId"/>';
	var domainId = '<s:property value="content.domainId"/>';
	CategoryHelper.getSubCategoryMap(value,domainId, function(options) {
		addOptions("_subCategory", options, def);
	});
}

function addOptions(relatedFieldId, options, defValues){
	var $el = $("#"+relatedFieldId);
	if(relatedFieldId){
		$el.find("option").remove();
		$el.append("<option value='blank'></option>");
		for(var key in options){
			$el.append("<option value='" + key + "'>" + options[key] + "</option>");
		}
	}
	if (defValues) {
		$el.val(defValues);
	}
}

</script>
</head>
<body>
<%@include file="/common/msg.jsp"%>
<s:hidden name="sharefile" id="sharefile" value="{*[cn.myapps.km.disk.share_file]*}" />
<s:form name="content" id="content" action="" method="post" theme="simple">
<s:hidden name="content.id" />
<s:hidden name="content.name" id="_name" />
<s:hidden name="content.nDirId" />
<s:hidden name="content.creatorId" />
<s:hidden name="content.creator" />
<s:hidden name="content.ownerId" />
<s:hidden name="content.url" />
<s:hidden name="content.version" />
<s:hidden name="content.type" />
<s:hidden name="content.size" />
<s:hidden name="content.createDate" />
<s:hidden name="content.lastmodify" />
<s:hidden name="content.state" />
<s:hidden name="content.domainId" />
<s:hidden name="content.title" />
<s:hidden name="content.memo" />
<s:hidden name="content.shareId" />
<s:hidden name="content.origin" />
<s:bean name="cn.myapps.km.permission.ejb.PermissionHelper" id="permissionHelper"></s:bean>
	<div class="view_center" style="min-width: 950px;">
		<div class="view_left">
			<div class="view_title">
				<img alt="" src="<s:url value='/km/disk/images/com_file.gif'/>">
				<a><s:property value="content.name"/></a> 
			</div>
			<div class="viewLeft_center">
				<div class="border_left"></div>
				<div class="border_center">
					<div class="btn_act">
						<div class="downloadLeft"></div>
						<div class="btnCenter" align="center">
						<s:if test="download">
						<a href="<s:url value='/km/disk/file/download.action'><s:param name='id' value='content.id' /></s:url>" style="cursor:pointer; ">{*[cn.myapps.km.disk.download]*}</a>
						</s:if>
						<s:else>
						<a  style="cursor:default;color:#ccc;">{*[cn.myapps.km.disk.download]*}</a>
						</s:else>
							
						</div>
						<div class="btnRight"></div>
						<div class="btnLeft"></div>
						<s:if test="(content.state==1 || content.state==3) && !_favorited">
						<div class="btnCenter" style="cursor:default;text-align:center;" onclick="show_favorite_page('<s:property value="content.id" />');">
							<a style="cursor:pointer;">{*[cn.myapps.km.disk.favorite]*}</a>
						</div>
						</s:if>
						<s:else>
						<div class="btnCenter" style="cursor:default;text-align:center;" >
							<a style="color:#ccc;">{*[cn.myapps.km.disk.favorite]*}</a>
							</div>
						</s:else>
						<div class="btnRight"></div>
						<div class="btnLeft"></div>
							<s:if test="content.state==2">
								<div class="btnCenter goShareDetail" style="text-align:center;" id="<s:property  value='content.id'/>" >
									<a id="<s:property  value='content.id'/>" style="cursor:pointer; ">{*[cn.myapps.km.disk.share]*}</a>
								</div>
							</s:if>
							<s:else>
								<div class="btnCenter" style="cursor:default;color:#ccc;text-align:center;">
									<a style="cursor:default;color:#ccc;">{*[cn.myapps.km.disk.share]*}</a>
								</div>
							</s:else>
						<div class="btnRight"></div>
					</div>
					<div class="score" >
						<div class="scoreTitle">
							<img alt="" src="<s:url value='/km/disk/images/warning.gif'/>">
							<a>{*[cn.myapps.km.disk.share_comments]*}</a>
						</div>
						<div class="scoreCenter">
						
							<div class="starRating">
								
								<a>{*[cn.myapps.km.disk.star_evaluation]*}: <span class="scorenum"><a id="_score"><s:property value="content.getScore()"/></a></span>{*[cn.myapps.km.disk.points]*}</a><span class="starImg"></span>
							</div>
							<img class="lines" alt="" src="<s:url value='/km/disk/images/V_lines2.gif'/>">
							<div class="scoreRight">
								<img id="good" alt="" src="<s:url value='/km/disk/images/good.gif'/>" onclick="addAssessment('good');">
									<a id="_good"><s:property  value="content.good"/></a>
								<img class="lines2" alt="" src="<s:url value='/km/disk/images/V_lines.gif'/>">
								<img id="notGood" alt="" src="<s:url value='/km/disk/images/no_good.gif'/>" onclick="addAssessment('bad');">
									<a id="_bad"><s:property  value="content.bad"/></a>
							</div>
						</div>
					</div>
				</div>
				<div class="border_right"></div>
			</div>
		</div>
		<div class="view_right">
			<div class="interest">
				<div><a>{*[cn.myapps.km.disk.document_information]*}</a><img alt="" src="<s:url value='/km/disk/images/arrow_icon.gif'/>"></div>
					<table cellspacing="0" style="height:100px;width:245px;">
					<tr>
						<td colspan="2">{*[cn.myapps.km.disk.type]*}：
							<span class="showCategory" style="display: none;margin-bottom:5px;">
								<s:select id="_rootCategory" name="content.rootCategoryId" list="#categoryHelper.getRootCategory(#session.KM_FRONT_USER.domainid)" listKey="id" listValue="name" cssClass="input-cmd" emptyOption="true" onchange="onRootCategoryChange(this.value);"/>
								-
								<s:select id="_subCategory" emptyOption="true" name="content.subCategoryId" list="{}"/>
							</span>
							<span id="categoryList"></span>
						</td>
					</tr>
					<tr class="editCategory" style="">
						<td colspan="2"><span id="lable_category"></span>&nbsp;
							<s:if test="content.state==1 && content.origin==0 && #permissionHelper.verifyDirManagePermission(content.nDirId,#session.KM_FRONT_USER)">
							<span><a href="javascript:ev_editCategory()">【{*[cn.myapps.km.disk.edit]*}】</a></span>
							</s:if>
						</td>
					</tr>
					<tr class="showCategory" style="border:1px dashed #ccc; display: none;">
						<td colspan="2">
							<div>
								<a href="javascript:ev_saveCategory()">【{*[cn.myapps.km.disk.save]*}】</a>
								<a href="javascript:ev_cancel()">【{*[cn.myapps.km.disk.cancel]*}】</a>
							</div>
						</td>
					</tr>
					<tr>
						<td>{*[cn.myapps.km.disk.uploader]*}：</td><td><s:property value="content.creator" /></td>
					</tr>
					<tr>
						<td>{*[Title]*}：</td><td><s:property value="content.title" /></td>
					</tr>
					<tr>
						<td>{*[cn.myapps.km.disk.introduction]*}：</td><td><s:property value="content.memo" /></td>
					</tr>
					<tr>
						<td>{*[cn.myapps.km.disk.time]*}：</td><td><s:date name="content.createDate" format="yyyy-MM-dd"/></td>
					</tr>
					
				</table>
				<table class="interestAct" cellspacing="0">
					<tr>
						<td>
							<div align="center"><a>{*[cn.myapps.km.disk.view]*}</a></div><div align="center"><s:property value="content.views" /></div>
						</td>
						<td>
							<div align="center">
								<s:if test="download">
									<a href="<s:url value='/km/disk/file/download.action'><s:param name='id' value='content.id' /></s:url>" style="cursor:pointer; ">{*[cn.myapps.km.disk.download]*}</a>
								</s:if>
								<s:else>
									<a>{*[cn.myapps.km.disk.download]*}</a>
								</s:else>
							</div>
							<div align="center"><s:property value="content.downloads" /></div>
						</td>
						<td>
							<div align="center">
								<s:if test="(content.state==1 || content.state==3) && !_favorited">
									<a href="###" onclick="show_favorite_page('<s:property value="content.id" />');" style="cursor:pointer;">{*[cn.myapps.km.disk.favorite]*}</a>
								</s:if>
								<s:else>
									<a>{*[cn.myapps.km.disk.favorite]*}</a>
								</s:else>
							</div>
							<div align="center"><s:property value="content.favorites" /></div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	</s:form>
</body>

</o:MultiLanguage></html>