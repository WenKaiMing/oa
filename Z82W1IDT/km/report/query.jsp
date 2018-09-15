<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/km/disk/head.jsp"%>
<%@page import="cn.myapps.km.disk.ejb.NFileProcessBean"%>

<%
NFileProcessBean process = new NFileProcessBean();
long total = process.getUploadFilesTotal();

%>
<html><o:MultiLanguage>
<head>
<title>{*[cn.myapps.km.disk.report_data_retrieval]*}</title>
<link rel="stylesheet" href="<s:url value='/resource/css/style.css'/>" type="text/css" />
<link rel="stylesheet" href="<s:url value='/resource/css/main-front.css'/>" type="text/css" />
<link href='<s:url value="/km/disk/css/km.css" />' rel="stylesheet" type="text/css"/>
<style>
#contentTable {overflow-y:auto; overflow-x:hidden;}
#navigateTable {height:27px;width:100%;}
.tab {width:68px;height:22px;}
body{margin:0;padding:0;}
.searchinput{float:left;width:250px;;padding-right:10px;}
</style>
<script type="">
	var contextPath='<%=contextPath%>';
</script>
<script src="<s:url value="/script/list.js"/>"></script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/CategoryHelper.js"/>'></script>
<script src='<s:url value="/portal/share/component/dateField/datePicker/WdatePicker.js"/>'></script>
<script type="text/javascript" src='<s:url value="/km/disk/script/share.js"/>'></script>
<script type="text/javascript">
	function cl(){
		document.getElementsByName("startDate")[0].value="";
		document.getElementsByName("endDate")[0].value="";
		document.getElementsByName("rootCategoryId")[0].value="";
		document.getElementsByName("subCategoryId")[0].value="";
		document.getElementsByName("operationType")[0].value="";
		document.getElementsByName("departmentId")[0].value="";
		document.getElementsByName("userId")[0].value="";
		document.getElementsByName("userInput")[0].value="";
	}
	
	function adjustListDiv(){
		var iframeH = jQuery("body",parent.document).find("#userlistframe").height();
		var tbH = jQuery(".table_noborder").height();
		var searchFormH = jQuery("#searchFormTable").height();
		var pageNavH = jQuery(".table_noborder").height();
		jQuery("#contentTable").height(iframeH - tbH - searchFormH - pageNavH - 20);
	}

	jQuery(document).ready(function(){
		if($("#contentTable").find(".table-tr").length == 0 ){
			$(".placeholder__content").show();
		}else{
			$(".placeholder__content").hide();
		}
		//adjustListDiv(); //调整显示通讯录列表的div高度
		jQuery("#clearUser").click(function(){
			jQuery("#userInput").attr("title","");
			jQuery("#userInput").val("");
			jQuery("#userHidden").val("");
		});
		
		var rootCategory = '<s:property value="params.getParameterAsString(\'rootCategoryId\')"/>';
		if(rootCategory.length>0){
			onRootCategoryChange(rootCategory);
		}
	});

	jQuery(window).resize(function(){
		//adjustListDiv(); //调整显示通讯录列表的div高度
	});
	function onRootCategoryChange(value){
		var def ='<s:property value="params.getParameterAsString(\'rootCategoryId\')" />';
		var domainId = '<s:property value="#session.KM_FRONT_USER.domainid"/>';
		CategoryHelper.getSubCategoryMap(value, domainId, function(options) {
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
			DWRUtil.setValue(relatedFieldId, defValues);
		}
	}
</script>
</head>
<body id="domain_user_list" class="listbody" style="overflow: auto;">
<s:bean name="cn.myapps.km.category.ejb.CategoryHelper" id="categoryHelper"></s:bean>
<div>
<s:form name="formList" action="query" method="post" theme="simple">
	<table class="table_noborder">
			<tr><td >
				<div class="domaintitlediv"><img src="<s:url value="/resource/image/email2.jpg"/>" />{*[cn.myapps.km.disk.report_data_retrieval]*}</div>
			</td>
			<td align="right">
				<span style="font-size: 13; font-weight: bold">文件总数： <%=total %> 份   </span>
			</td>
			</tr>
	</table>
	<div id="main">	
		<%@include file="/common/basic.jsp" %>
		<%@include file="/common/msg.jsp"%>	
		<div id="searchFormTable" class="justForHelp">
			<table class="table_noborder" >
				<tr><td>
				    <table border="0" style="width:100%;">
				      <tr style="width:100%;">
				       <td width="650px">
				       		<table style="width:100%;">
				       			<tr>
					       			<td >{*[cn.myapps.km.report.time_type]*}：</td>
					       			<td colspan="3">{*[From]*} <input type='text' name='startDate' id='startDate' class='Wdate' onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}',skin:'whyGreen'})"  value='<s:property value="%{#parameters.startDate}"/>'/>
					       				{*[cn.myapps.km.permission.to]*} <input type='text' name='endDate' id='endDate' class='Wdate' onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}',skin:'whyGreen'})" value='<s:property value="%{#parameters.endDate}"/>'/>
					       			</td>
				       			</tr>
				       			<tr>
				       				<td>{*[cn.myapps.km.report.professional_type]*}：</td>
				       				<td> <s:select id="_rootCategory" name="rootCategoryId" value="params.getParameterAsString('rootCategoryId')" list="#categoryHelper.getRootCategory(#session.KM_FRONT_USER.domainid)" listKey="id" listValue="name" cssClass="input-cmd" headerKey="blank" headerValue="" onchange="onRootCategoryChange(this.value);"/>
										-
										<s:select id="_subCategory" emptyOption="true" name="subCategoryId" list="{}"/>
									 </td>
				       				<td>{*[cn.myapps.km.logs.behavior_options]*}：</td><td> <s:select name="operationType" value="params.getParameterAsString('operationType')" emptyOption="true" list="#{'UPLOAD':'{*[cn.myapps.km.disk.upload]*}','DOWNLOAD':'{*[cn.myapps.km.disk.download]*}','VIEW':'{*[cn.myapps.km.disk.view]*}','FAVORITE':'{*[cn.myapps.km.disk.favorite]*}','SHARE':'{*[cn.myapps.km.disk.share]*}','RECOMMEND':'{*[cn.myapps.km.disk.recommend]*}','MOVE':'{*[cn.myapps.km.move]*}','RENAME':'{*[cn.myapps.km.disk.rename]*}'}"></s:select> </td>
				       			</tr>
				       			<tr>
				       				<td>{*[cn.myapps.km.report.department_type]*}：</td><td> <s:select cssClass="input-cmd" theme="simple" value="params.getParameterAsString('departmentId')" name="departmentId" list="_departmentTree" emptyOption="true" cssStyle="width:130px;"/> </td>
				       				<td>{*[cn.myapps.km.report.person_type]*}：</td>
				       				<td>
					       				<div class="user_select">
											<input type="hidden" id="userHidden"  name="userId" value='<s:property value="params.getParameterAsString('userId')" />'/>
											<input type="text" id="userInput" name="userInput" title="" value=' <s:property value="params.getParameterAsString('userInput')" />' readonly/> 
											<span onclick="selectUser4Km('actionName',{textField:'userInput',valueField:'userHidden',limitSum:'10',selectMode:'multiSelect',readonly:false,title:'{*[cn.myapps.km.disk.select_user]*}'},'')" title="{*[cn.myapps.km.disk.select_user]*}">{*[cn.myapps.km.disk.select_user]*}</span>
											<span id="clearUser" title="{*[Clear]*}">{*[Clear]*}</span>
										</div>
									</td>
				       			</tr>
				       			<tr><td><SPAN style="font-size: 13; font-weight: bold">当前检索记录数: <s:property value="reportItemDataPackage.datas.size"/> 个</SPAN></td></tr>
				       		</table>
				       
				       </td>
					    <td nowrap="nowrap">
							<div class="button-cmd">
								<div class="btn_left"></div>
								<div class="btn_mid">
									<a class="queryicon icon16" title="{*[Query]*}" href="###" onclick="document.getElementsByName('_currpage')[0].value=1;document.forms[0].submit();">{*[Query]*}
									</a>
								</div>
								<div class="btn_right"></div>
							</div>
							<div class="button-cmd">
								<div class="btn_left"></div>
								<div class="btn_mid">
									<a href="javascript:cl();" title="{*[Reset]*}" class="reseticon icon16">{*[Reset]*}</a>
								</div>
								<div class="btn_right"></div>
							</div>
						</td>
				      </tr>
				    </table>
				</td></tr>
			</table>
		</div>
		
		<!-- 用户列表 -->
		<div id="contentTable" class="contentTable queryContentTable">
		<table class="table_noborder" style="width:100%"  cellspacing="0" cellpadding="0">
			<tr class="dtable-header" style="background:#f3f3f3;">
				<td class="column-head-fresh" width="25%">{*[cn.myapps.km.disk.file_name]*}</td>
				<td class="column-head-fresh" width="10%">{*[cn.myapps.km.logs.root_category]*}</td>
				<td class="column-head-fresh" width="10%">{*[cn.myapps.km.logs.subcategory]*}</td>
				<td class="column-head-fresh" width="10%">{*[cn.myapps.km.disk.department]*}</td>
				<td class="column-head-fresh" width="5%">{*[cn.myapps.km.disk.uploader]*}</td>
				<td class="column-head-fresh" width="5%">{*[cn.myapps.km.logs.behavior_type]*}</td>
				<td class="column-head-fresh" width="5%">{*[log.operator]*}</td>
				<td class="column-head-fresh" width="15%">{*[cn.myapps.km.logs.operation_date]*}</td>
			</tr>
			<s:iterator value="reportItemDataPackage.datas" status="index" id="item">
				<tr class="table-tr" onmouseover="this.className='table-tr-onchange';" onmouseout="this.className='table-tr';">
				<td><s:property value="fileName" /></td>
				<td><s:property value="rootCategory" /></td>
				<td><s:property value="subCategory" /></td>
				<td><s:property value="departmentName" /></td>
				<td><s:property value="creator" /></td>
				<td>
					<s:if test="operationType=='UPLOAD'">{*[cn.myapps.km.disk.upload]*}</s:if>
					<s:elseif test="operationType=='DOWNLOAD'">{*[cn.myapps.km.disk.download]*}</s:elseif>
					<s:elseif test="operationType=='VIEW'">{*[cn.myapps.km.disk.view]*}</s:elseif>
					<s:elseif test="operationType=='FAVORITE'">{*[cn.myapps.km.disk.favorite]*}</s:elseif>
					<s:elseif test="operationType=='SHARE'">{*[cn.myapps.km.disk.share]*}</s:elseif>
					<s:elseif test="operationType=='DELETE'">{*[cn.myapps.km.disk.delete]*}</s:elseif>
					<s:elseif test="operationType=='RECOMMEND'">{*[cn.myapps.km.disk.recommend]*}</s:elseif>
					<s:elseif test="operationType=='MOVE'">{*[cn.myapps.km.move]*}</s:elseif>
					<s:elseif test="operationType=='RENAME'">{*[cn.myapps.km.disk.rename]*}</s:elseif>
				</td>
				<td><s:property value="userName" /></td>
				<td><s:date name="#item.operationDate" format="yyyy-MM-dd HH:mm:ss"/></td>
				</tr>
			</s:iterator>
		</table>
		
		</div>
		<table class="table_noborder">
			<tr>
				<td align="right" class="pagenav"></td>
			</tr>
		</table>
		<div class="placeholder__content"><div class="weui-tab__panel"></div></div>
	</div>
</s:form>
</div>
</body>
</o:MultiLanguage></html>
