<%@include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%String contextPath = request.getContextPath();%>

<%@page import="cn.myapps.core.email.util.Constants"%><html>
<o:MultiLanguage>
	<head>
	<title>{*[Links]*}{*[Info]*}</title>
	<script src='<s:url value="/dwr/interface/DWRHtmlUtil.js"/>'></script>
	<script src='<s:url value="/dwr/interface/ApplicationUtil.js"/>'></script>
	<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
	<script src='<s:url value="/dwr/interface/CrossReportHelper.js"/>'></script>

	<link rel="stylesheet" href="<s:url value='/resource/css/main.css'/>"
		type="text/css">

<script type="text/javascript" language="javascript">
var contextPath = '<%=contextPath%>';
var email_url = '<%=Constants.EMAIL_BASE_URL%>';
function onTypeChange(type){
	var omodule_tr = document.getElementById('omodule_tr');
	var oview_tr = document.getElementById('oview_tr');
	var oform_tr = document.getElementById('oform_tr');
	var oreport_tr = document.getElementById('oreport_tr');
	var oexcelimport_tr = document.getElementById('oexcelimport_tr');
	var oexternal_tr = document.getElementById('oexternal_tr');
	var oscript_tr = document.getElementById('oscript_tr');
	omodule_tr.style.display='none';
	oview_tr.style.display='none';
	oform_tr.style.display='none';
	oreport_tr.style.display='none';
	oexcelimport_tr.style.display='none';
	oexternal_tr.style.display='none';
	oscript_tr.style.display='none';

	var def =  document.getElementById("actionContent").value;

	//document.getElementById('module').options[0].selected = true;
	
	switch (type){
	case '00':
		omodule_tr.style.display='inline';
		oform_tr.style.display='inline';
		break;
	case '01':
		omodule_tr.style.display='inline';
		oview_tr.style.display='inline';
		break;
	case '02':
		omodule_tr.style.display='inline';
		
		oreport_tr.style.display='inline';
		break;
	case '03':
		oexcelimport_tr.style.display='inline';
		break;
	case '04':
		//oexcelimport_tr.style.display='inline';
		break;
	case '05':
	case '06':
		oexternal_tr.style.display='inline';
		document.getElementById("externalLinks").value = def;
		break;
	case '07':
		oscript_tr.style.display='inline';
		document.getElementById("actionScript").value = def;
		break;
	case '08':
		var object = document.getElementById("externalLinks");
		oexternal_tr.style.display='inline';
		if (def == null || def == "") {
			object.value = email_url;
		} else {
			object.value = def;
		}
		object.disabled="disabled";
		break;
	}
}

function onModuleChange(){
	var type = document.getElementById("_type").value;
	switch (type){
	case '00':
		createFormOptionByModule('actionForm');
		break;
	case '01':
		createViewOptionByModule('actionView');
		break;
	case '02':
		createReportOptionByModule('actionReport');
		break;
	}
	
}

function createViewOptionByModule(view){
	var moduleid = document.getElementById("module").value;
	var def =  document.getElementById("actionContent").value;

	if (moduleid=='') {
		moduleid = '<s:property value="content.moduleid"/>';
	}
	
	ApplicationUtil.creatView(view,'<s:property value="#parameters.application"/>',moduleid,def,function(str) {var func=eval(str);func.call()});
	
}

function createFormOptionByModule(relatedFieldId){
	var module = document.getElementById("module");
	var moduleid = module.value;
	var def =  document.getElementById("actionContent").value;
	if (module.value=='') {
		moduleid = '<s:property value="content.moduleid"/>';
	}

	FormHelper.get_formListByModules(moduleid, function(options) {
		addOptions(relatedFieldId, options, def);
	});
}

function createReportOptionByModule(report){
	var moduleid = document.getElementById("module").value;
	var def =  document.getElementById("actionContent").value;
	if (moduleid=='') {
		moduleid = '<s:property value="content.moduleid"/>';
	}
	
	CrossReportHelper.creatReport(report,'<s:property value="#parameters.application"/>',moduleid,def,function(str) {var func=eval(str);func.call()});
	
}

function addOptions(relatedFieldId, options, defValues){
	var el = document.getElementById(relatedFieldId);
	if(relatedFieldId){
		DWRUtil.removeAllOptions(relatedFieldId);
		DWRUtil.addOptions(relatedFieldId, options);
	}
	if (defValues) {
		DWRUtil.setValue(relatedFieldId, defValues);
	}
}

function doSave(type){
	buildActionContent();
	//buildActionUrl();
	document.getElementsByName('content.queryString')[0].value = buildQueryString();
	var url ='';
	if (type == "saveAndNew"){
		var url = contextPath+"/core/links/saveAndNew.action";
	}else{
		var url = contextPath+"/core/links/save.action";
		}
	document.forms[0].action = url;
	document.forms[0].submit();
}


function buildActionContent(){
	var type = document.getElementById("_type").value;
	switch (type){
	case '00':
		document.getElementById("actionContent").value = document.getElementById("actionForm").value;
		break;
	case '01':
		document.getElementById("actionContent").value = document.getElementById("actionView").value;
		break;
	case '02':
		document.getElementById("actionContent").value = document.getElementById("actionReport").value;
		break;
	case '03':
		document.getElementById("actionContent").value = document.getElementById("actionExcelImport").value;
		break;
	case '05':
		document.getElementById("actionContent").value = document.getElementById("externalLinks").value;
		break;
	case '06':
		document.getElementById("actionContent").value = document.getElementById("externalLinks").value;
		break;
	case '07':
		document.getElementById("actionContent").value = document.getElementById("actionScript").value;
		break;
	case '08':
		document.getElementById("actionContent").value = document.getElementById("externalLinks").value;
		break;
	}
}

function buildActionUrl(){
	var type = document.getElementById("_type").value;
	switch (type){
	case '00':
		var id = document.getElementById("actionForm").value;
		var url = contextPath + '/portal/dynaform/document/new.action?_formid='+id+'&_isJump=1';
		document.getElementById("actionUrl").value = url;
		break;
	case '01':
		var id = document.getElementById("actionView").value;
		var url = contextPath+'/portal/dynaform/view/displayView.action?_viewid='+id+'&clearTemp=true';
		document.getElementById("actionUrl").value = url;
		break;
	case '02':
		var id = document.getElementById("actionReport").value;
		var url = contextPath+'/portal/report/crossreport/runtime/runreport.action?reportId='+id;
		document.getElementById("actionUrl").value = url;
		break;
	case '03':
		var id = document.getElementById("actionExcelImport").value;
		var applicationid = document.getElementById("applicationid").value;
		var url = contextPath+'/portal/share/dynaform/dts/excelimport/importbyid.jsp?id='+id+"&applicationid="+applicationid;
		document.getElementById("actionUrl").value = url;
		break;
	case '05':
		var url = document.getElementById("externalLinks").value;
		document.getElementById("actionUrl").value = url;
		break;
		
	}
}

//生成请求参数
function buildQueryString(){
	var pkey = document.getElementsByName("paramKey");
	var pvalue = document.getElementsByName("paramValue");
	var str = '[';
	for (var i=0;i<pkey.length;i++) {
		if (pkey[i].value != '' && pvalue[i].value != '' ){
				str += '{';
				str += pkey[i].name +':\''+pkey[i].value+'\',';
				str += pvalue[i].name +':\''+pvalue[i].value+'\'';
				str += '},';
		}
	}
	str += ']';
	return  str;	

}

//根据mapping str获取data array
function parseRelStr(str) {
	var obj = eval(str);
	if (obj instanceof Array) {
		return obj;
	} else {
		return new Array();	
	}
}


function ev_load(){
	var type = document.getElementById("_type").value;
	var content = document.getElementById("actionContent").value;
	switch (type){
		case '05':
			document.getElementById("externalLinks").value = content;
			break;
		case '06':
			document.getElementById("externalLinks").value = content;
			break;
		case '07':
			document.getElementById("actionScript").value = content;
			break;
			
	}
	onTypeChange(type);
	onModuleChange();
	
	var str = document.getElementsByName('content.queryString')[0].value;
	var datas = parseRelStr(str);
	addRows(datas);
	
}

var rowIndex = 0;
var getParamKey = function(data) {
	if(data){
  	var s =''; 
	s +='<input type="text" id="paramKey'+ rowIndex +'" name="paramKey" style="width:100" value="'+HTMLDencode(data.paramKey)+'" />';
	return s; 
	}
};

var getParamValue = function(data) {
	if(data){
  	var s =''; 
	s +='<input type="text" id="paramValue'+ rowIndex +'" name="paramValue" style="width:100" value="'+HTMLDencode(data.paramValue)+'" />';
	return s;
	}
};

var getDelete = function(data) {
	if(data){
  	var s = '<input type="button" value="{*[Delete]*}" onclick="delRow(tb, this.parentNode.parentNode)"/>';
  	rowIndex ++;
  	return s;
	}
};

// 根据数据增加行
function addRows(datas) {
	var cellFuncs = [getParamKey, getParamValue, getDelete];

	var rowdatas = datas;
	if (!datas || datas.length == 0) {
		var data = {paramKey:'', paramValue:''};
		rowdatas = [data];
	}
	
	DWRUtil.addRows("tb", rowdatas, cellFuncs);
	
}

// 删除一行
function delRow(elem, row) {
	if (elem) {
		elem.deleteRow(row.rowIndex);
		//rowIndex --;
	}
}

jQuery(document).ready(function(){
	ev_load();
	inittab();
	window.top.toThisHelpPage("application_info_generalTools_links_info");
});

</script>
</head>
<body id="application_info_generalTools_links_info" class="contentBody">
	<%@include file="/common/page.jsp"%>
	<table cellpadding="0" cellspacing="0" width="100%">
		<tr style="height: 27px;">
			<td rowspan="2"><div class="appsUsualIncludeTab"><%@include file="/common/commontab.jsp"%></div></td>
			<td class="nav-td" width="100%">&nbsp;</td>
		</tr>
		<tr>
			<td class="nav-s-td" align="right">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" align="right">
						<img align="middle" style="height:23px;" src="<s:url value='/resource/imgv2/back/main/nav_sep.gif' />" />
						<button type="button" class="button-image" onclick="doSave('saveAndNew')"><img
							src="<s:url value="/resource/imgnew/act/act_12.gif"/>">{*[Save&New]*}</button>
						<button type="button" class="button-image" onClick="doSave('save');"><img
							src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[Save]*}</button>
						<button type="button" class="button-image"
							onClick="forms[0].action='<s:url action="list"></s:url>';forms[0].submit();"><img
							src="<s:url value="/resource/imgnew/act/act_10.gif"/>">{*[Exit]*}</button>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<%@include file="/common/msg.jsp"%>
	<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<div id="contentMainDiv" class="contentMainDiv">
	<table class="table_noborder id1">
	<s:form action="save" method="post"
		theme="simple" name="formItem" validate="true">
		<s:textfield cssStyle="display:none;" name="tab" value="1" />
		<s:textfield cssStyle="display:none;" name="selected"
			value="%{'btnLinks'}" />
		<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper"
			id="mh">
			<s:param name="application" value="%{#parameters.application}" />
		</s:bean>	
		<s:hidden name="content.id" />
		<s:hidden id="actionContent" name="content.actionContent" />
		<s:hidden name="content.applicationid" value="%{#parameters.application}" />
		<s:hidden name="application" id="applicationid" value="%{#parameters.application}" />
		<tr>
		    <td align="left"><span class="commFont commLabel">{*[Name]*}：</span><br>
			<s:textfield cssClass="input-cmd" theme="simple" name="content.name" cssStyle="width:350px;"/></td>
		</tr>
				
		<tr>
		    <td align="left"><span class="commFont commLabel">{*[Type]*}：</span><br>
			<s:select cssStyle="width:350px;" cssClass="input-cmd"
					onchange="onTypeChange(this.value)"
					name="content.type" id="_type"
					list="#{'':'{*[Select]*}','00':'{*[Form]*}','01':'{*[View]*}','03':'{*[cn.myapps.core.dynaform.links.excel_import]*}','05':'{*[cn.myapps.core.dynaform.links.customize_links_internal]*}','06':'{*[cn.myapps.core.dynaform.links.customize_links_External]*}','08':'{*[cn.myapps.core.dynaform.links.email_links]*}'}"
					required="true" theme="simple" /></td>
		</tr>
		
		<tr id="omodule_tr" style="display:none;">
			<td align="left"><span class="commFont commLabel">{*[Module]*}：</span>
				<BR/><s:select cssStyle="width:350px;" id="module" name="content.moduleid" list="#mh.getModuleSel(#parameters.application)"
				cssClass="input-cmd" onchange="onModuleChange();" /></td>
		</tr>

		<tr id="oview_tr" style="display:none;">
			<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.dynaform.links.OnActionView]*}：</span><br>
			<s:select id="actionView" cssStyle="width:350px;" emptyOption="true" name="actionView" list="{}" /></td>
		</tr>

		<tr id="oform_tr" style="display:none;">
			<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.dynaform.links.OnActionForm]*}：</span><br>
			<s:select id="actionForm" cssStyle="width:350px;" emptyOption="true"  name="actionForm" list="{}" /></td>
		</tr>

		
		<tr id="oreport_tr" style="display:none;">
			<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.dynaform.links.OnActionReport]*}：</span><br>
			<s:select id="actionReport" cssStyle="width:350px;" emptyOption="true" name="actionReport" list="{}" /></td>
		</tr>
		<tr id="oexcelimport_tr" style="display:none;">
			<s:bean name="cn.myapps.core.links.action.LinkHelper" id="lh" />
			<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.dynaform.links.OnActionExcelImport]*}：</span><br>
			<s:select id="actionExcelImport" cssClass="input-cmd" cssStyle="width:350px;" name="actionExcelImport" list="#lh.get_ExcelImportCfgList(#parameters.application)" /></td>
		</tr>
		
		<tr id="oexternal_tr" style="display:none;">
			<td align="left">
				<span class="commFont commLabel">{*[cn.myapps.core.dynaform.links.customize_link]*}：
				</span><br>
				<s:textfield id="externalLinks" cssClass="input-cmd"  cssStyle="width:350px;" theme="simple" name="externalLinks" /></td>
		</tr>
		
		<tr id="oscript_tr" style="display:none;">
			<td align="left"><span class="commFont commLabel">{*[Script]*}:</span><br>
			<s:textarea id="actionScript" cssClass="input-cmd" cssStyle="width:350px;" name="actionScript" cols="50" rows="3" />
			<button type="button" class="button-image" onclick="openIscriptEditor('actionScript','{*[Script]*}{*[Editor]*}','{*[Links]*}','content.name','{*[Save]*}{*[Success]*}');"><img alt="{*[page.Open_with_IscriptEditor]*}" src="<s:url value='/resource/image/editor.png' />"/></button>
			</td>
		</tr>
		
		<tr id="omanualLink_tr" style="display:none;">
			<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.dynaform.links.manual_link]*}：</span><br>
			<s:textarea id="actionScript" cssClass="input-cmd" cssStyle="width:350px;" name="actionScript" cols="50" rows="3" />
			</td>
		</tr>
		
		<tr >
			<td align="left"><span class="commFont commLabel">{*[cn.myapps.core.dynaform.activity.label.parameter]*}：</span><br>
			<table class="table_hasborder" border=1 cellpadding="0" cellspacing="0" bordercolor="gray" >
				<tbody id="tb">
					<tr>
						<tr>
							<td align="left" class="commFont">{*[cn.myapps.core.dynaform.activity.label.parameterName]*}</td>
							<td align="left" class="commFont">{*[cn.myapps.core.dynaform.activity.label.parameterValue]*}</td>
							<td align="left"><input type="button" value="{*[Add]*}" onclick="addRows()" />
						</td>
					</tr>
				</tbody>
			</table>
			<s:hidden id="queryString" name="content.queryString" />
			</td>
		</tr>
		<tr>
		    <td align="left"><span class="commFont commLabel">{*[Description]*}：</span><br>
			<s:textarea cssStyle="width:350px;" cssClass="input-cmd" theme="simple" name="content.description" /></td>
		</tr>
	</s:form>
</table>
</div>
</body>
</o:MultiLanguage>
</html>
