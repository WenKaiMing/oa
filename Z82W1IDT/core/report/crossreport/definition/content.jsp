<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<%
	String contextPath = request.getContextPath();
    String applicationid = request.getParameter("application");
    String domain = request.getParameter("domain");
%>
<s:bean name="cn.myapps.core.dynaform.view.action.ViewHelper" id="vh">
	<s:param name="moduleid" value="#parameters.module" />
</s:bean>
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="fh">
	<s:param name="moduleid" value="#parameters.module" />
</s:bean>
<html>
<o:MultiLanguage>
	<head>
	<title>{*[cn.myapps.core.report.crossreport.info]*}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href='<s:url value="/resource/css/main.css" />'
		type="text/css">
	</head>
	<script src="<s:url value='/script/list.js'/>"></script>
	<script src='<s:url value="/dwr/interface/CrossReportHelper.js"/>'></script>
	<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
	<script src="<s:url value='/script/check.js'/>"></script>
	<script src="<s:url value='/script/util.js'/>"></script>
	<script>
function ev_init(flag){
   var application = '<%=applicationid%>';
   var domain = '<%=domain%>';
     
   var viewid = document.getElementById('content.view').value;
    if(viewid!=null&&viewid!=""){
    	CrossReportHelper.creatColumnOptions(viewid,domain,application,['fieldName', 'fieldName2', 'fieldName3'],'',function(str) {var func=eval(str);func.call()});
   }
    //CrossReportHelper.creatFieldOptions(formid,tempsql,type,domain,application,'fieldName2','',function(str) {var func=eval(str);func.call()});
    //CrossReportHelper.creatFieldOptions(formid,tempsql,type,domain,application,'fieldName3','',function(str) {var func=eval(str);func.call()});
    //CrossReportHelper.creatFieldOptions(formid,tempsql,type,domain,application,'fieldName4','',function(str) {var func=eval(str);func.call()});
      
      //初始化content.str
      if(flag !='1')
      {
        setOptionValue(document.getElementsByName('content.columns')[0].value,'columns');
        setOptionValue(document.getElementsByName('content.rows')[0].value,'rows');
        setOptionValue(document.getElementsByName('content.datas')[0].value,'datas');
      } 
}


// 根据mapping str获取data array
function parseRelStr(str) {
	var obj = eval(str);
	if (obj instanceof Array) {
		return obj;
	}else {
		return new Array();	
	}
}

function addItem(source,target){ 
	if(source.options[source.selectedIndex].selected == true){
		var Opt=document.createElement("option");
		Opt.value = source.options[source.selectedIndex].value;
		Opt.text = source.options[source.selectedIndex].text;
		var k=0;
		for(var j=0;j<target.length;j++){
		    if(source.options[source.selectedIndex].value==target.options[j].value){
			   k=1;
			}
		}
		if(k==0){
	        target.options.add(Opt);
		    k=0;
	    }
	}
}

function delItem(source,target){ 
	for(var x=target.length-1;x>=0;x--){ 
		var opt = target.options[x]; 
		if (opt.selected){ 
		 target.options[x] = null; 
		} 
	} 
} 

var contextPath = '<%=contextPath%>';

function doSave() { 
   if(checkFiled())
   {
	getOptionValue('columns','content.columns');
	getOptionValue('rows','content.rows');
	getOptionValue('datas','content.datas');
	//document.getElementById('content.formCondition').value = createRelStr();
	checkFiled();
	document.forms[0].submit();
   }
}
function clearSelected()
{
	var viewid = document.getElementById('content.view').value;
	var viewname = document.getElementById('view_name_id').value;
	if(viewid!=viewname){
		clearOptions('columns');
		clearOptions('rows');
		clearOptions('datas');
	}	
}

function clearOptions(filed){
	var selid = document.getElementsByName(filed)[0];
	if (selid && selid.options) {
		var optLength=selid.options.length;
		for (var i=0; i<optLength; i++) {
			selid.options[0]=null;	
		}
	}
}
function getOptionValue(filed,contentfiled)
{
   	var selid = document.getElementsByName(filed)[0];
	var columns = new Array();
	if (selid && selid.options) {
		for (var i=0; i<selid.options.length; i++) {
			var fieldName = selid.options[i].value;	
             columns.push(fieldName);
		}
		}
         document.getElementsByName(contentfiled)[0].value = jQuery.json2Str(columns);
}

function setOptionValue(str,filedname)
{
  var cols = new Array();
  if(str!=null&&str!=""){
	  cols = jQuery.parseJSON(str);
  }else{	  
	  return;
  }  
  cols = jQuery.parseJSON(str);
  for (var i=0; i<cols.length; i++) {
		var Opt=document.createElement("option");
		Opt.value=cols[i];
		if(cols[i].indexOf('ITEM_')>=0)
		{
		  Opt.text=cols[i].substring(cols[i].indexOf('ITEM_')+5);
		 }else
		 {
		   Opt.text=cols[i];
		 }
		document.all(filedname).options.add(Opt);
	}
  
}

function TestReport()
{
  var id = document.getElementById("content.id").value;
  var application = document.getElementById("application").value;
  if(id == null || id =='')
  {
    alert('请先保存再测试报表.');
  }else
  {
    var url = '<s:url value="/core/report/crossreport/runtime/runreport.action"></s:url>?reportId='+id+'&application='+application;
    window.showModalDialog(url);
   }
}

function checkFiled()
{
  var name = document.getElementsByName('content.name')[0].value;
  
  if(name == null && name =='')
    {
      alert('{*[page.name.notexist]*}');
      return false;
     }
  
     
  //处理列信息的校验
  var x = document.getElementsByName('columns')[0];
  if(x.options.length<=0)
  {
   alert('{*[cn.myapps.core.report.crossreport.please_select_columm]*}!');
   return false;
   }
   
 // var y = document.getElementById('rows');
  //if(y.options.length<=0)
 // {
 //  alert('请选择Y轴列!');
 //  return false;}
   
  var datas = document.getElementsByName('datas')[0];
  if(datas.options.length<=0)
  {
   alert('{*[cn.myapps.core.report.crossreport.please_select_data_columm]*}');
   return false;
   }
  if(datas.options.length>1)
  {
   alert('{*[cn.myapps.core.report.crossreport.data_columm_unique]*}');
   return false;
   }
   
  var method = getCheckedValue('content.calculationMethod');
  if(method != null || method !=''){
	//处理当选择了显示列和行后没有选择方式
	  if(document.getElementsByName('content.displayRow')[0].checked && document.getElementsByName('content.displayRow')[0].value == 'true'
	     &&(getCheckedValue('content.rowCalMethod')==null||getCheckedValue('content.rowCalMethod')==''))
	     {
	       alert('{*[cn.myapps.core.report.crossreport.please_select_show_row_sum]*}');
	       return false;
	     }
	     
	  if(document.getElementsByName('content.displayCol')[0].checked && document.getElementsByName('content.displayCol')[0].value == 'true'
	     &&(getCheckedValue('content.colCalMethod')==null || getCheckedValue('content.colCalMethod')==''))
	   {  alert('{*[cn.myapps.core.report.crossreport.please_select_show_column_sum]*}');
	       return false;
	    }
	    return true;
  	}
   
   return true;
   
}

function getCheckedValue(item)
{
 var items = document.getElementsByName(item);
 var rtn = null;
    for(var i =0;i<items.length;)
     {
       if (items[i].checked== true )
       {
        rtn = items[i].value;

        break;
       }
       i++;
     }
     return rtn;
}

jQuery(document).ready(function(){
	ev_init();
	window.top.toThisHelpPage("application_module_crossReport_info");
});
/* 签入
 */
function ev_checkin(){
	getOptionValue('columns','content.columns');
	getOptionValue('rows','content.rows');
	getOptionValue('datas','content.datas');
	document.forms[0].action='<s:url action="checkin"></s:url>';
	document.forms[0].submit();
}
/*
 * 签出
 */
function ev_checkout(){
	getOptionValue('columns','content.columns');
	getOptionValue('rows','content.rows');
	getOptionValue('datas','content.datas');
	document.forms[0].action='<s:url action="checkout"></s:url>';
	document.forms[0].submit();
}

</script>
<body id="application_module_crossReport_info" class="contentBody">
<s:form id="formItem" action="save" method="post" validate="true" theme="simple">
	<s:hidden name="content.applicationid" value="%{#parameters.application}"></s:hidden>
	<s:hidden name="sm_name" value="%{#parameters.sm_name}"/>
	<input type="hidden" id="view_name_id" value="<s:property value="content.view" />"/>
	<table class="table_noborder">
		<tr>
			<td class="nav-s-td" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td style="padding-left: 10px;">
					<div id="sec_tab1">
					<div class="listContent"><input type="button" id="span_tab1"
						name="spantab1" class="btcaption" onClick="ev_switchcol('1')"
						value="{*[Basic]*}" /></div>
					<div class="listContent nav-seperate"><img
						src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
					</div>
					<div class="listContent"><input type="button" id="spancol1"
							name="spancol1" class="btcaption" onClick="ev_switchcol('col1')"
							value="{*[cn.myapps.core.report.crossreport.column_info]*}" /></div>
						<div class="listContent nav-seperate"><img
							src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
						</div>
						<div class="listContent"><input type="button" id="spancol2"
							name="spancol2" class="btcaption" onclick="ev_switchcol('col2')"
							value="{*[cn.myapps.core.report.crossreport.row_info]*}" /></div>
						<div class="listContent nav-seperate"><img
							src="<s:url value='/resource/imgv2/back/main/nav_seperate2.gif' />" />
						</div>
						<div class="listContent"><input type="button" id="spancol3"
							name="spancol3" class="btcaption" onClick="ev_switchcol('col3')"
							value="{*[cn.myapps.core.report.crossreport.data_info]*}" /></div>
					</td>
				</tr>
			</table>
			</td>
			<td align="right" class="nav-s-td">
			<table width="120" align="right" border=0 cellpadding="0" cellspacing="0">
				<tr>
				<s:if test="checkoutConfig == 'true'">
					<s:if test="content.id !=null && content.id !='' && !content.checkout ">
					<!-- 签出按钮 -->
					<td align="left">
						<button  type="button" class="button-image" style="width:50px" onClick="ev_checkout()"><img
							src="<s:url value="/resource/imgnew/act/checkout.png" />"
							align="top">{*[core.dynaform.form.checkout]*}</button>
						</td>
					</s:if>
					<s:elseif test="content.id !=null && content.id !='' && content.checkout && #session['USER'].id == content.checkoutHandler">
					<!-- 签入按钮 -->
					<td align="left">
						<button type="button" class="button-image" style="width:50px" onClick="ev_checkin()"><img
							src="<s:url value="/resource/imgnew/act/checkin.png" />"
							align="top">{*[core.dynaform.form.checkin]*}</button>
						</td>
					</s:elseif>
					</s:if>
					
					<s:if test="checkoutConfig == 'true'">
					<s:if test="(content.checkout && #session['USER'].id == content.checkoutHandler) || (!content.checkout && content.checkoutHandler == null)">
					<!-- 签出 -->
					<td align="left" width="70">
						<button type="button" id="save_btn" style="width:50px" class="button-image" onClick="doSave()">
						<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
							align="top">{*[Save]*}</button>
						</td>
					</s:if>
					<s:elseif test="content.checkout && #session['USER'].id != content.checkoutHandler">
					<!-- 签入-->
					<td align="left" width="70">
						<button type="button" id="save_btn" style="width:50px" class="button-image" disabled="disabled" onClick="doSave()">
						<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
							align="top">{*[Save]*}</button>
						</td>
					</s:elseif>
					<s:if test="!content.checkout && content.checkoutHandler == ''">
							<!-- 没有签出-->
							<td align="left">
								<button type="button" id="save_btn" style="width:50px" class="button-image"  onClick="alert('{*[message.update.before.checkout]*}')">
								<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
									align="top">{*[Save]*}</button>
								</td>
					</s:if>
					</s:if>
					<s:else>
						<td align="left" width="70">
						<button type="button" id="save_btn" style="width:50px" class="button-image" onClick="doSave()">
						<img src="<s:url value="/resource/imgnew/act/act_4.gif"/>"
							align="top">{*[Save]*}</button>
						</td>
					</s:else>
					<td width="70">
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
		<%@include file="/common/page.jsp"%>
		<div id="1" helpid="application_module_crossReport_info">
		<table class="table_noborder id1">
			<tr>
				<td class="commFont">{*[Name]*}:</td>
				<td class="commFont">{*[Title]*}:</td>
			</tr>
			<tr>
				<td><s:textfield cssClass="input-cmd" name="content.name"
					theme="simple" /></td>
				<td><s:textfield cssClass="input-cmd"
					name="content.reportTitle" theme="simple" /></td>
			</tr>
			<tr>
				<td colspan=2>
				<table class="table_noborder">
					<tr>
						<td style="padding: 0;">
						<fieldset><legend>{*[DataSource]*}</legend>
						<table class="table_noborder">
							<tbody id="tb">
								<tr>
									<td>{*[View]*}: <s:select name="content.view"
										list="#vh.get_viewListByModules(#parameters.module)" id="content.view" onchange="clearSelected();" theme="simple" /></td>
								</tr>
							</tbody>
						</table></fieldset>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr id="note">
				<td class="commFont">{*[Remarks]*}:</td>
				<td class="commFont"></td>
			</tr>
			<tr>
				<td><s:textarea cssClass="input-cmd" name="content.note"
					cols="80" rows="3" theme="simple" /></td>
				<td class="commFont"></td>
			</tr>
		</table>
		</div>
		<table id="col1" style="display: none;" width="30%">
			<tr>
				<td class="commFont" colspan="3" >
				<fieldset><legend>{*[cn.myapps.core.report.crossreport.show_column_sum]*}:</legend>
				<s:checkbox name="content.displayCol" theme="simple" /> <span
					id="col_tr"><s:radio name="content.colCalMethod" onclick=""
					list="#{'SUM':'{*[cn.myapps.core.report.crossreport.sum]*}','AVERAGE':'{*[cn.myapps.core.report.crossreport.average]*}'}"
					theme="simple" /></span>
				</fieldset>
				</td>
			</tr>
			<tr>
				<td colspan="3" align="left">{*[cn.myapps.core.report.crossreport.please_select_column_info]*}：</td>
			</tr>
			<tr>
				<td height="66" class="tdLabel" align="left">
				<label class="label"></label> <select
					name="fieldName" size="14" multiple="multiple" style="width: 12em"
					ondblclick="addItem(document.all.fieldName,document.all.columns)">
					<s:hidden name="content.columns" />
					<s:hidden name="content.rows" />
					<s:hidden name="content.datas" />
					<s:hidden name='content.checkout' />
					<s:hidden name="content.checkoutHandler" />
					<s:hidden name="module" value="%{#parameters.module}" />
					<s:hidden name="sm_module" value="%{#parameters.module}" />
					<s:hidden name="content.module" value="%{#parameters.module}" />
				</select>
				</td>
				<td bgcolor="#FFFFFF" align="center" width="10">
				<p align="center">
				<button type="button" class="button-image"
					onClick="addItem(document.all.fieldName,document.all.columns)"><img
					src="<s:url value="/resource/image/right2.gif"/>"
					alt="{*[add item]*}"></button>
				</p>
				<p align="center">
				<button type="button" class="button-image"
					onClick="delItem(document.all.fieldName,document.all.columns)"><img
					src="<s:url value="/resource/image/left2.gif"/>"
					alt="{*[delete item]*}"></button>
				</p>
				</td>
				<td height="66" class="tdLabel">
				<label class="label"></label> <select
					id="selectid" name="columns" size="14" multiple="multiple"
					style="width: 12em"
					ondblClick="delItem(document.all.fieldName,document.all.columns)">
				</select>
				</td>
			</tr>
		</table>

		<table id="col2" style="display: none;"  width="30%">
			<tr>
				<td class="commFont" colspan="3" >
				<fieldset><legend>{*[cn.myapps.core.report.crossreport.show_row_sum]*}:</legend>
				<s:checkbox name="content.displayRow" theme="simple" /> <span
					id="row_tr"><s:radio name="content.rowCalMethod" onclick=""
					list="#{'SUM':'{*[cn.myapps.core.report.crossreport.sum]*}','AVERAGE':'{*[cn.myapps.core.report.crossreport.average]*}'}"
					theme="simple" /></span>
				</fieldset>
				</td>
			</tr>
			<tr>
				<td colspan="3" align="left">{*[cn.myapps.core.report.crossreport.please_select_row_info]*}:</td>
			</tr>
			<tr>
				<td height="66" class="tdLabel" align="left">
				<label class="label"></label> <select
					name="fieldName2" size="14" multiple="multiple" style="width: 12em"
					ondblclick="addItem(document.all.fieldName2,document.all.rows)">
				</select>
				</td>
				<td bgcolor="#FFFFFF" align="center" width="40">
				<p align="center">
				<button type="button" class="button-image"
					onClick="addItem(document.all.fieldName2,document.all.rows)"><img
					src="<s:url value="/resource/image/right2.gif"/>"
					alt="{*[add item]*}"></button>
				</p>
				<p align="center">
				<button type="button" class="button-image"
					onClick="delItem(document.all.fieldName2,document.all.rows)"><img
					src="<s:url value="/resource/image/left2.gif"/>"
					alt="{*[delete item]*}"></button>
				</p>
				</td>
				<td height="66" class="tdLabel" align="left">
				<label class="label"> </label> <select
					id="selectid" name="rows" size="14" multiple="multiple"
					style="width: 12em"
					ondblClick="delItem(document.all.fieldName2,document.all.rows)">
				</select>
				</td>
			</tr>
		</table>

		<table id="col3" style="display: none;"  width="60%">
			<tr>
				<td colspan="4" align="left">
				<fieldset><legend>{*[cn.myapps.core.report.crossreport.please_select_data_columm]*}:</legend><s:radio
					name="content.calculationMethod" onclick=""
					list="#{'SUM':'{*[cn.myapps.core.report.crossreport.sum]*}','AVERAGE':'{*[cn.myapps.core.report.crossreport.average]*}','DISTINCT':'{*[cn.myapps.core.report.crossreport.distinct]*}','COUNT':'{*[cn.myapps.core.report.crossreport.count]*}','MAX':'{*[cn.myapps.core.report.crossreport.max]*}','MIN':'{*[cn.myapps.core.report.crossreport.min]*}'}"
					theme="simple" />
				</fieldset>
					</td>
			</tr>
			<tr>
				<td height="66" class="tdLabel">
				<label class="label"></label> <select
					name="fieldName3" size="14" multiple="multiple" style="width: 12em"
					ondblclick="addItem(document.all.fieldName3,document.all.datas)">
				</select>
				</td>
				<td bgcolor="#FFFFFF">
				<p align="center">
				<button type="button" class="button-image"
					onClick="addItem(document.all.fieldName3,document.all.datas)"><img
					src="<s:url value="/resource/image/right2.gif"/>"
					alt="{*[add item]*}"></button>
				</p>
				<p align="center">
				<button type="button" class="button-image"
					onClick="delItem(document.all.fieldName3,document.all.datas)"><img
					src="<s:url value="/resource/image/left2.gif"/>"
					alt="{*[delete item]*}"></button>
				</p>
				</td>
				<td height="66" class="tdLabel">
				<label class="label"></label> <select
					id="selectid" name="datas" size="14" multiple="multiple"
					style="width: 12em"
					ondblClick="delItem(document.all.fieldName3,document.all.datas)">
				</select>
				</td>
				<td width="400"></td>
			</tr>
			
		</table>
</div>
</s:form>
</body>
<script>
	var rowIndex = 0;
	var getField = function(data) {
	  	var s =''; 
		s +='<select id="field'+ rowIndex +'" name="field" style="width:200">';
		s +='<option value="'+data.field+'" selected></option>';
		s +='</select>';
		return s; 
	};
	
	var getOperator = function(data) { 
		var operators = ['LIKE','=','<>','>','>=','<','<=','IN','NOT IN'];
		var s =''; 
		s +='<select id="operator'+ rowIndex +'" name="operator" style="width:100">';
		for (var i=0; i < operators.length; i++) {
			if (data.operator.toUpperCase() == operators[i]) {
				s+='<option value="'+operators[i]+'" selected>'+operators[i]+'</option>';
			} else {
				s+='<option value="'+operators[i]+'">'+operators[i]+'</option>';
			}
		}
		s +='</select>';
		return s; 
	}; 
	
	var getMatch = function(data) {
		var typeCodes = ['00','01','02'];
		var typeNames = ['{*[Text]*}','{*[Number]*}','{*[Date]*}'];
		
		var s =''; 
		s +='<select name="type" >';
		for (var i=0; i < typeCodes.length; i++) {
			if (data.type.toUpperCase() == typeCodes[i]) {
				s+='<option value="'+typeCodes[i]+'" selected>'+typeNames[i]+'</option>';
			} else {
				s+='<option value="'+typeCodes[i]+'">'+typeNames[i]+'</option>';
			}
		}
		s +='</select>';
		
		s +='<input type="text" id="ipField'+ rowIndex +'" name="ipField" value="'+HTMLDencode(data.match)+'" size="27"/>';
	
		
		return s;
	};
	var getDelete = function(data) {
	  	var s = '<input type="button" value="{*[Delete]*}" onclick="delRow(tb, this.parentNode.parentNode)"/>';
	  	rowIndex ++;
	  	return s;
	};
	
		//orderby form下拉联动
function initOrderBy() {
		var of = document.getElementById('content.form');
		of.onchange = function(defVal){
			FormHelper.getFields(of.value, function(options) {
				addOptions("field", options);
			});
		};
	}
	
		// 增加element options
	function addOptions(elemName, options) {
		var elems = document.getElementsByName(elemName);
		for (var i=0; i<elems.length; i++) {
			var defVal = elems[i].value;
			DWRUtil.removeAllOptions(elems[i].id);
			DWRUtil.addOptions(elems[i].id, options);
			DWRUtil.setValue(elems[i].id, defVal);
		}
	}
	
		// 删除一行
	function delRow(elem, row) {
		if (elem) {
			elem.deleteRow(row.rowIndex);
			//rowIndex --;
		}
	}
	
	// 根据页面内容生成关系语句
	function createRelStr() {
		var fields = document.getElementsByName("field");
		var operators = document.getElementsByName("operator");
		var types = document.getElementsByName("type");
		var ipfields = document.getElementsByName("ipField");
		
		var str = '[';

		for (var i=0;i<fields.length;i++) {
			if (fields[i].value != '' && ipfields[i].value != '') {
			
				str += '{'
				str += fields[i].name +':\''+fields[i].value+'\',';
				str += operators[i].name +':\''+operators[i].value+'\',';
				str += types[i].name +':\''+types[i].value+'\',';
				str += 'match:\''+HTMLEncode(ipfields[i].value)+'\'';
				
				str += '},';
			}
		}
		if (str.lastIndexOf(',') != -1) {
			str = str.substring(0, str.length - 1);
		}
		str += ']';
		return  str;
	}
	
	function ev_isPagination(item,flag) {
	
	if (item.checked && item.value == 'true' && flag=='1') {
		row_tr.style.display="";
	} else if(item.checked && item.value == 'true' && flag=='2'){
	    col_tr.style.display="";
	}else
	{
	  row_tr.style.display="none";
	  col_tr.style.display="none";
	  document.getElementsByName('colCalMethod').value="";
	  document.getElementsByName('rowCalMethod').value="";
	}
}
	
function ev_switchcol(sId)
{
	document.getElementById('span_tab1').className="btcaption";
	document.getElementById('spancol1').className="btcaption";
	document.getElementById('spancol2').className="btcaption";
	document.getElementById('spancol3').className="btcaption";
	
	document.getElementById('col1').style.display="none";
	document.getElementById('col2').style.display="none";
	document.getElementById('col3').style.display="none";
	
	document.getElementById('1').style.display="none";
	if(sId=="col1"){
		ev_init('1');		
	}
	if (sId==1 || sId=='1') {
		document.getElementById('span_tab'+sId).className="btcaption-s-selected";
		document.getElementById(sId).style.display="";
		window.top.toThisHelpPage(jQuery("#"+sId).attr("helpid"));
		return;
	}
	
	
   
	if (jQuery("#"+ sId)) {
		document.getElementById('span'+sId).className="btcaption-s-selected";
		document.getElementById(sId).style.display="";
	}
}
	
</script>

</o:MultiLanguage>
</html>
