<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/km/disk/head.jsp"%>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[cn.myapps.km.disk.km_name]*}</title>
<link href='<s:url value="/km/disk/css/km.css" />' rel="stylesheet" type="text/css"/>
<style>
.search_title{
	float:left;
	height:24px;
	line-height:24px;
}
.search_box2{
	float:left;
	width: 200px;
	height: 22px;
	line-height:22px;
	border: 1px solid #ADADAD;
}
.search_ipt{
	float:left;
	width: 155px;
	height:20px;
	line-height:20px;
	background-color:transparent;
	border:0;
}
.search_img{
	margin:0px;
	padding:0px;
	vertical-align:middle;
	cursor:pointer;
	
}
.no2{
	background:#fff;
	border-bottom:#e7ecf0 1px solid;
	border-left:#e7ecf0 1px solid;
	border-right:#e7ecf0 1px solid;
	border-top:#e7ecf0 1px solid;
	color:#00c;
	float:left;
	font:12px/1.33 arial, helvetica, clean;
	font-family: Arial, simsun, sans-serif;
	font-size:13px;
	height:22px;
	line-height:22px;
	margin-right:5px;
	overflow:hidden;
	text-align:center;
	text-decoration:none;
	white-spac:nowrap;
	width:23px;
}

.no2{
	background:#fff;
	border-bottom:#e7ecf0 1px solid;
	border-left:#e7ecf0 1px solid;
	border-right:#e7ecf0 1px solid;
	border-top:#e7ecf0 1px solid;
	color:#00c;
	float:left;
	font:12px/1.333 arial, helvetica, clean;
	font-family: Arial, simsun, sans-serif;
	font-size:13px;
	height:22px;
	line-height:22px;
	margin-right:5px;
	overflow:hidden;
	text-align:center;
	text-decoration:none;
	white-spac:nowrap;
	width:23px;
}

.cur{
	border-bottom:#fff 1px solid;
	border-left:#fff 1px solid;
	border-right:#fff 1px solid;
	border-top:#fff 1px solid;
	color:#000;
	font-weight:700;
}

.next{
	_line-height:24px;
	background:#fff;
	border-bottom:#e7ecf0 1px solid;
	border-left:#e7ecf0 1px solid;
	border-right:#e7ecf0 1px solid;
	border-top:#e7ecf0 1px solid;
	color:#00c;
	float:left;
	font:12px/1.333 arial, helvetica, clean;
	font-family:simsun;
	font-size:13px;
	height:22px;
	line-height:24px;
	margin-right:5px;
	overflow:hidden;
	text-align:center;
	text-decoration:none;
	white-space:nowrap;
	width:60px;
}
.btn {
    display: inline-block;
    padding: 6px 12px;
    margin-bottom: 0;
    font-size: 14px;
    font-weight: 400;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px;
}
.btn-back {
	color: #FFFFFF;
	background: #a8a8a8;
}
.btn-back:hover {
	color: #ffffff;
	background: #818181;
}
.operation{
	margin-bottom:10px;
}
</style>
<script>
/**
 * 搜索
 */
function query(){
	var queryString = document.getElementsByName("queryString")[0].value;
	if(queryString == ""){
		alert("{*[cn.myapps.km.disk.search_tip]*}");
		return;
	}
	document.forms[0].action = "<s:url value='/km/disk/file/query.action' ><s:param name='_type' value='_type' /></s:url>";
	document.forms[0].submit();
}

//标记查询的内容 
function ReplaceStr(queryStringVal) {
	jQuery(".files_name").each(function(){
	    var contentText = jQuery(this).text(); 
	    if(contentText){
	    	var regS = new RegExp(queryStringVal,"g");
	    	contentText = contentText.replace(regS, "<font style='color: red;font-size: 16px;'>" + queryStringVal + "</font>"); 
		    jQuery(this).html(contentText); 
	    } 
	});
	jQuery(".ind_memo").each(function(){
	    var contentText = jQuery(this).text();
	    if(contentText){
	    	var regS = new RegExp(queryStringVal,"g");
	    	contentText = contentText.replace(regS, "<font color='red'>" + queryStringVal + "</font>");  
		    jQuery(this).html(contentText); 
	    } 
	});
} 

//获取文件后缀名
function getSuffix(){
	jQuery(".files_name").each(function(){
	     var fileName = jQuery(this).attr("title"); 
		 if(fileName){
			 var suffix = fileName.substr(fileName.lastIndexOf(".") + 1,fileName.length);
			 var  $iconSpan = jQuery(this).siblings(".icon-file-s");
			 if(suffix.toLowerCase()=="doc" || suffix.toLowerCase()=="docx" || suffix.toLowerCase()=="wps"){
				 $iconSpan.addClass("icon-file-doc");
			 }else if(suffix.toLowerCase()=="xls" || suffix.toLowerCase()=="xlsx" || suffix.toLowerCase()=="et"){
				 $iconSpan.addClass("icon-file-xls");
			 }else if(suffix.toLowerCase()=="pdf"){
				 $iconSpan.addClass("icon-file-pdf");
			 }else if(suffix.toLowerCase()=="rar"){
				 $iconSpan.addClass("icon-file-rar");
			 }else if(suffix.toLowerCase()=="zip"){
				 $iconSpan.addClass("icon-file-zip");
			 }else if(suffix.toLowerCase()=="txt"){
				 $iconSpan.addClass("icon-file-txt");
			 }else if(suffix.toLowerCase()=="ppt" || suffix.toLowerCase()=="pptx" || suffix.toLowerCase()=="dps"){
				 $iconSpan.addClass("icon-file-ppt");
			 }else if(suffix.toLowerCase()=="htm" || suffix.toLowerCase()=="html"){
				 $iconSpan.addClass("icon-file-html");
			 }else if(suffix.toLowerCase()=="mov"){
				 $iconSpan.addClass("icon-file-mov");
			 }else if(suffix.toLowerCase()=="gif" || suffix.toLowerCase()=="png" ||
					 suffix.toLowerCase()=="apng" || suffix.toLowerCase()=="bmp" ||
					 suffix.toLowerCase()=="jpeg" || suffix.toLowerCase()=="jpg"){
				 $iconSpan.addClass("icon-file-png");
			 }else if(suffix.toLowerCase()=="folder"){
				 $iconSpan.addClass("icon-file-folder");
			 }else{
				 $iconSpan.addClass("icon-file-unknown");
			 }
		 }
	});
}

///调整搜索页面高度
function setQueryCotainerSize(){
	var diskFrameH = jQuery(parent.document).height();
	jQuery(".queryCotainer").height(diskFrameH - 20);
}

/**
 * 返回星星图片html
 */
function  evaluateScore(score){
	if(!score){
		var score = <s:property value="content.getScore()"/>;
	}
	if(!typeof(score) == "number") return;
	var starHtml = "";
	for(i=1;i <= Math.floor(score);i++){
		starHtml +='<img alt="" src="<s:url value='/km/disk/images/s_all_star.gif'/>">';
	}
	if(parseInt(score)!=score){
		starHtml +='<img alt="" src="<s:url value='/km/disk/images/s_half_star.gif'/>">';		
	}
	for(i=1;i <= (5 - Math.ceil(score));i++){
		starHtml +='<img alt="" src="<s:url value='/km/disk/images/s_no_star.gif'/>">';
	}
	return starHtml;
}

/**
 * 根据评分动态设置星星
 */
function setScore(){
	jQuery("span.scoreNumber").each(function(){
		var html = evaluateScore(jQuery(this).text());
		jQuery(this).before(html);
	});
}

jQuery(document).ready(function(){
	var queryStringVal = jQuery("#queryStringHidden").val();
	document.getElementsByName("queryString")[0].value= queryStringVal;
    ReplaceStr(queryStringVal);   //标记查询的内容 
    getSuffix(); //获取文件后缀名
    setQueryCotainerSize();

    var rowcount = parseInt(document.getElementsByName("_rowCount")[0].value);
    var curragepage = parseInt(document.getElementsByName("_curragePage")[0].value);
    if(rowcount <= curragepage*10){
        document.getElementById("nextpage").style.display = 'none';
    }

    if(curragepage <= 1){
    	document.getElementById("prepage").style.display = 'none';
    }

    if(jQuery("#nextpage").css("display") == "none" && jQuery("#prepage").css("display") == "none")
    	jQuery("#pageNumber").css("display","none");

    showPageNum(curragepage, false,rowcount);

	//按回车键进行搜索
	jQuery("#search_keyword").keydown(function(event){
		 if(event.keyCode==13){
			 query();
		 }
	});
	setScore();		//动态设置评分星星
});

/**
 * 翻到下一页
 */
function showNextPage(){
	var	FO = document.forms;
	var pageNo = parseInt(FO[0]._curragePage.value);
	FO[0].action = "<s:url value='/km/disk/file/query.action' ><s:param name='_type' value='_type' /></s:url>";
	FO[0]._curragePage.value = pageNo + 1;
	FO[0].submit();
}

/**
 * 翻到上一页
 */
function showPreviousPage(){
	var FO = document.forms;
	var pageNo = parseInt(FO[0]._curragePage.value);

	FO[0]._curragePage.value = pageNo - 1;
	FO[0].action = "<s:url value='/km/disk/file/query.action' ><s:param name='_type' value='_type' /></s:url>";
	FO[0].submit();
}

function showDataByNum(val){
	var FO = document.forms;

	FO[0]._curragePage.value = val;
	FO[0].action = "<s:url value='/km/disk/file/query.action' ><s:param name='_type' value='_type' /></s:url>";
	FO[0].submit();
}

function showPageNum(num,flag,rowcount){
	var linesPerPage = 10;//每页显示的列数
	var totalPage = parseInt((rowcount + linesPerPage - 1)/linesPerPage);//总页数
	var spanHTML = "";
	//for(var i=1; 10*i<=rowcount+10; i++){
	for(var i = 1; i <= totalPage; i++){	
		if(i == num){
			spanHTML += '<a class="cur no2">' + i + '</a>';
			//if(flag) break;
		}else {
			spanHTML += '<a class="no2" href="javascript:showDataByNum(' + i + ')">' + i + '</a>';
		}
	}
	jQuery("#pageNumber").html(spanHTML);
}

function goBack(){
	window.location.href="<s:url value='/km/disk/view.action' ><s:param name='_type' value='_type' /></s:url>";
}
</script>
</head>
<body>
<div class="queryCotainer">
<s:form action="" method="post" theme="simple">
<s:bean name="cn.myapps.km.permission.ejb.PermissionHelper" id="ph"/>
<s:hidden name="_curragePage" value="%{#request._curragePage}"></s:hidden>
<s:hidden name="_rowCount" value="%{#request._rowCount}"></s:hidden>
<s:hidden name="queryStringHidden" id="queryStringHidden" value="%{#parameters.queryString}"></s:hidden>
		<div class="operation"><a class="btn btn-back goBack" onclick="goBack()">返回</a></div>
		<div style="width:100%;height:30px;">
			<div class="search_title">{*[cn.myapps.km.disk.search]*}：</div>
			<div class="search_box2">
				<input class="search_ipt" type="text" name="queryString" id="search_keyword" />
				<img class="search_img" alt="" src="<s:url value='/km/disk/images/magnifier.gif' />" onclick="query()"/> 
			</div>
		</div>
	<s:if test="#request.nfiles.size() == 0">
		<span style="color:red;"> {*[cn.myapps.km.disk.search_error]*}</span>
	</s:if>
	<s:else>
		<s:iterator value="#request.nfiles" id="status">
	<s:if test="_type == 1" >
		<s:if test="#ph.checkNFilePermission(id,#session['KM_FRONT_USER'])">
			<div class="ind_container">
				<div class="ind_title">
					<div class="ind_div">
						<a class="files_name" title='<s:property value="name"/>' target="_blank" href="<s:url value='/km/disk/file/view.action' ><s:param name='id' value='id' /><s:param name='_type' value='_type' /></s:url>"><s:property value="name"/></a>
						<span class="ind_date"><s:date name="#status.lastmodify" format="yyyy-MM-dd"/></span>
					</div>
				</div>
				<div class="ind_content">
					<span class="ind_memo"><s:property value="memo"/></span>
				</div>
				<div>
					<span class="ind_span1">
						<span class="scoreNumber"><s:property value="searchScore" /></span>(<s:property value="evaluateSum" />{*[cn.myapps.km.disk.personal_comments]*})
					</span>
					<span class="ind_span2">
						{*[cn.myapps.km.disk.total]*}<s:property value="totalPages" />{*[cn.myapps.km.disk.page]*}
					</span>
					<span class="ind_span2">
						{*[cn.myapps.km.disk.download]*}: <s:property value="downloads" />{*[cn.myapps.km.disk.number]*}
					</span>
					<span class="ind_span3">
						{*[cn.myapps.km.disk.contributor]*}: <s:property value="creator" />
					</span>
					<span class="ind_span4">
						<a target="_blank" title="打开文件所在目录" href="<s:url value='/km/disk/listView.action' ><s:param name='_type' value='_type' /><s:param name='ndirid' value='nDirId' /><s:param name='scanDir' value='true' /></s:url>">
							<img alt="打开文件所在目录" style="vertical-align:middle;" src="<s:url value='/km/disk/images/movetodir.png'/>" height="10" width="10">
						</a>
					</span>
				</div>
			</div>
		</s:if>
		<s:else>
			<div class="ind_container">
				<div class="ind_title">
					<div class="ind_div">
						<span title='<s:property value="name"/>' style="color:#C0C0C0;font-size:16px;"><s:property value="name"/></span>
					</div>
					<span class="ind_date"><s:date name="#status.lastmodify" format="yyyy-MM-dd"/></span>
				</div>
				<div>
					<span class="ind_span1">
						<span class="scoreNumber"><s:property value="searchScore" /></span>(<s:property value="evaluateSum" />{*[cn.myapps.km.disk.personal_comments]*})
					</span>
					<span class="ind_span2">
						{*[cn.myapps.km.disk.total]*}<s:property value="totalPages" />{*[cn.myapps.km.disk.page]*}
					</span>
					<span class="ind_span2">
						{*[cn.myapps.km.disk.download]*}: <s:property value="downloads" />{*[cn.myapps.km.disk.number]*}
					</span>
					<span class="ind_span3">
						{*[cn.myapps.km.disk.contributor]*}: <s:property value="creator" />
					</span>
				</div>
			</div>
		</s:else>
	</s:if>
	<s:else>
		<div class="ind_container">
			<div class="ind_title">
				<div class="ind_div">
					<span title="" class="icon-file"></span>
					<a title='<s:property value="name"/>' target="_blank"  class="files_name" href="<s:url value='/km/disk/file/view.action' ><s:param name='id' value='id' /></s:url>"><s:property value="name"/></a>
					<span class="ind_date"><s:date name="#status.lastmodify" format="yyyy-MM-dd"/></span>
				</div>
			</div>
			<div class="ind_content">
				<span class="ind_memo"><s:property value="memo"/></span>
			</div>
				<div>
					<span class="ind_span1">
						<span class="scoreNumber"><s:property value="searchScore" /></span>(<s:property value="evaluateSum" />{*[cn.myapps.km.disk.personal_comments]*})
					</span>
					<span class="ind_span2">
						{*[cn.myapps.km.disk.total]*}<s:property value="totalPages" />{*[cn.myapps.km.disk.page]*}
					</span>
					<span class="ind_span2">
						{*[cn.myapps.km.disk.download]*}: <s:property value="downloads" />{*[cn.myapps.km.disk.number]*}
					</span>
					<span class="ind_span3">
						{*[cn.myapps.km.disk.contributor]*}: <s:property value="creator" />
					</span>
					<span class="ind_span4">
						<a target="_blank" title="打开文件所在目录" href="<s:url value='/km/disk/listView.action' ><s:param name='_type' value='_type' /><s:param name='ndirid' value='nDirId' /><s:param name='scanDir' value='true' /></s:url>">
							<img alt="打开文件所在目录" style="vertical-align:middle;" src="<s:url value='/km/disk/images/movetodir.png'/>" height="17" width="17">
						</a>
					</span>
				</div>
		</div>
	</s:else>
	</s:iterator>
	</s:else>
		<div class="pageNav">
			<div>
				<span id="prepage">
					<a href="javascript:showPreviousPage();" class="next">{*[cn.myapps.km.disk.previous_page]*}</a>
				</span>
				<div  id="pageNumber">
				</div>
				<span id="nextpage">
					<a href="javascript:showNextPage();" class="next">{*[cn.myapps.km.disk.next_page]*}</a>
				</span>
			</div>
		</div>
</s:form>
</div>
</body>
</o:MultiLanguage></html>