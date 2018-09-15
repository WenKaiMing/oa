<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/km/disk/head.jsp"%>
<%@page import="java.util.Date"%>
<s:bean name="cn.myapps.km.category.ejb.CategoryHelper" id="categoryHelper"></s:bean>
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href='<s:url value="/km/disk/css/layout.css" />' rel="stylesheet" type="text/css" />
<link href='<s:url value="/km/disk/css/succeed.css"/>' rel="stylesheet" type="text/css" />
<script src='<s:url value="/dwr/engine.js"/>' type="text/javascript"></script>
<script src='<s:url value="/dwr/util.js"/>' type="text/javascript"></script>
<script src='<s:url value="/dwr/interface/CategoryHelper.js"/>' type="text/javascript"></script>
<script src='<s:url value="/km/script/jquery-ui/js/jquery-1.8.3.js" />' type="text/javascript"></script>
<script src='<s:url value="/km/script/uploadify/jquery.uploadify.js"/>' type="text/javascript"></script>
<script src='<s:url value="/km/script/json/json2.js"/>' type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href='<s:url value="/km/script/uploadify/uploadify.css"/>'>
<style type="text/css">
body {
	font: 13px Arial, Helvetica, Sans-serif;
}
</style>
	<script type="text/javascript">
		$(function() {
			$('#file_upload').uploadify({
				'formData'     : {
					'nFileId'   : '<s:property value="content.id"/>',
					'nDirId'    : '<s:property value="content.nDirId"/>'
								},
				'swf'      : '<s:url value="/km/script/uploadify/uploadify.swf"/>',
				'uploader' : '<s:url value="/km/servlet/upload"/>',
				'buttonText':'{*[cn.myapps.km.disk.select_file]*}',
				'removeCompleted':false,
				'multi'    :true,
				//'uploadLimit' : 1,
				'auto'     :false,
				'onUploadSuccess' : function(file, data, response) {
		           //alert('The file ' + file.name + 'The Size '+file.size+ ' was successfully uploaded with a response of ' + response + ':' + data);
					onUploadSuccess(data,response);
					return;
		        }
				
			});
		});
		var files =[];//存储文件对象
		function onUploadSuccess(data,response) {
			if(response){
				var file = eval( '(' + data + ')' );

				if(files.length==0){
					$('#_title').val(file.title);
					document.getElementById('upload_tip').style.display = 'inline';
					 //上传完成后，提交按钮才可以操作
					$("#submitBtn").css("color","#000").bind("click",function(){
		            	loading();
		            	});
				}else{
					$('#_title').val("{*[cn.myapps.km.disk.title_tip]*}");
					$('#_title').attr("disabled",true);
					$('#_memo').val("{*[cn.myapps.km.disk.introduction_tip]*}");
					$('#_memo').attr("disabled",true);
					}
            	files.push(file);
			}
		}
		
		function loading(){
			var _rootCategory = jQuery("#_rootCategory option:selected").text();
			setTimeout(function(){
				var _subCategory = jQuery("#_subCategory option:selected").text();
				if(_rootCategory){
					jQuery("#_classification").val(_rootCategory + "-"+ _subCategory);
				}
			},300);
			if(files.length==1){
				var file = files.pop();
				file.title = $('#_title').val();
				file.memo = $('#_memo').val();
				files.push(file);
			}
			$('#_files').val(JSON.stringify(files));
			document.forms[0].submit();
		}

		function onRootCategoryChange(value){
			var def =  document.getElementById("_subCategory").value;
			var domainId = '<s:property value="#session.FRONT_USER.domainid" />';
			CategoryHelper.createSubCategoryOption(value,domainId,"_subCategory",def ,function(str) {
				var func=eval(str);func.call()
				});
		}
	</script>
</head>
<body>
		<div id="content" class="content">
		<div class="titleDiv" >
			<h3><a id="upload_tip" style="display:none;" >{*[cn.myapps.km.disk.upload_success]*}</a></h3>
		</div>
		<div class="uploadClass">
				<div class="uplaodFomr"> 
					<div id="queue"></div>
					<div style="width: 100%;line-height: 100px;height: 100px;">
						<div style="width: 400px;float: left;">
						<input id="file_upload" name="file_upload" type="file" multiple="true">
						</div>
						<div align="right">  
			                <a id="btn_upload" href="javascript:$('#file_upload').uploadify('upload','*')">{*[cn.myapps.km.disk.upload_start]*}</a>
			                <!-- |  
			            	<a id="btn_stop" href="javascript:jQuery('#file_upload').uploadify('stop')">取消上传</a>  -->
		            	</div>
	            	</div>
					<s:form theme="simple" action="/km/disk/file/save.action" method="post" name="">
						<s:hidden name="_files" id="_files" />
						<s:hidden name="_type" id="_type" />
						
						<p>
							<div class="title lineHeight">{*[cn.myapps.km.disk.title]*}<span>*</span></div>
							<s:textfield name="title" id="_title" cssClass="input" theme="simple"></s:textfield>
						</p>
						
						<p>
							<div class="lineHeight">{*[cn.myapps.km.disk.introduction]*}</div>
							<s:textarea name="memo" id="_memo" cssClass="textarea"></s:textarea>
						</p>
						
						<div style="width:550px; ">
							<div class="sort">
							<div class="lineHeight">{*[cn.myapps.km.disk.categorys]*}</div>
							
								<s:hidden name="content.classification" id="_classification"/>
								<s:select id="_rootCategory" cssStyle="height:30px;width:200px;" name="rootCategoryId" list="#categoryHelper.getRootCategory(#session.FRONT_USER.domainid)" listKey="id" listValue="name" emptyOption="true" cssClass="input-cmd" onchange="onRootCategoryChange(this.value);" />
								- <s:select id="_subCategory" cssStyle="height:30px;width:200px;" emptyOption="true" name="subCategoryId" list="{}"/>
								<span class="sort_span">{*[cn.myapps.km.disk.icon]*}</span>
							</div>
							<div class="department" style="display: none">
								<div class="lineHeight">{*[cn.myapps.km.disk.department]*}</div>
								<input class="department_inpt" value=""/><span class="department_span">{*[cn.myapps.km.disk.icon]*}</span>
								<ul class="departmentUl">
									<li>{*[cn.myapps.km.disk.products_department]*}</li>
									<li>{*[cn.myapps.km.disk.sales_department]*}</li>
									<li>{*[cn.myapps.km.disk.marketing_department]*}</li>
								</ul>
							</div>
							<div class="clear"></div>
						</div>
						<p>
							<div>
								<div class="submit_btn_left"></div>
								<div class="submit_btn_center"><a id="submitBtn">{*[cn.myapps.km.disk.submit_information]*}</a></div>
								<div class="submit_btn_right"> </div>
							</div>
							<div class="clear"></div>
						</p>
						<p>
							<!--<div>
								<div class="goupload_left"></div>
								<div class="goupload_center"><a>继续上传</a></div>
								<div class="goupload_right"></div>
								
							</div>
							<div>
								<div class="complete_left"></div>
								<div class="complete_center"><a>完成上传</a></div>
								<div class="complete_right"></div>
							</div>
							--><div class="clear"></div>
						</p>
					</s:form>
				</div>
			</div>
		</div>
</body>
</o:MultiLanguage></html>