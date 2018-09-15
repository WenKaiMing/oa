<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<html><o:MultiLanguage>
<head>
<title>{*[Module]*}</title>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main.css'/>"
	type="text/css">
<style type="text/css">
<!--
.STYLE2 {
	font-size: 16px;
	color: #000000;
}

.STYLE3 {
	color: #000000
}

.fieldlength {width:100px;}
-->

</style>
</head>

<script src='<s:url value="/dwr/interface/Sequence.js"/>'></script>
<script language="JavaScript" src="<s:url value='/core/dynaform/form/formeditor/dialog/script.js'/>"></script>
<script>
	function typeChange(type,index) { //'text','date' ,'select','radio','textarea','checkbox'
		var fl = jQuery("#"+ 'fieldLength' + index);
		var fo = jQuery("#"+ 'fieldOption' + index);
		var ff = jQuery("#"+ 'fieldFormat' + index);
		if(type=='00' || type=='04'){
		  fl.removeAttr("readOnly");
		  fo.attr("readOnly","true");
		  ff.attr("readOnly","true");
		  fo.css("background","#EEE");
		  ff.css("background","#EEE");
		  ff.val("");
		  fl.css("background","#FFF");
		  
		}else if(type=='01'){
		  fo.attr("readOnly","true");
		  fl.attr("readOnly","true");
		  ff.removeAttr("readOnly");
		  ff.css("background","#FFF");
		  if (ff.val() == "") {ff.val("yyyy-MM-dd");}
		  fo.css("background","#EEE");
		  fl.css("background","#EEE");
		}else if(type=='02'||type=='03'|| type=='05'){
		  fl.attr("readOnly","true");
		  ff.attr("readOnly","true");
		  ff.val("");
		  fo.removeAttr("readOnly");
		  fl.css("background","#EEE");
		  ff.css("background","#EEE");
		  fo.css("background","#FFF");
		}
		else if(type=='06'){
		  fl.removeAttr("readOnly");
		  ff.removeAttr("readOnly");
		  fo.attr("readOnly","true");
		  fo.css("backgroundColor","#EEE");
		  ff.css("backgroundColor","#FFF");
		  ff.value="##.##"
		  fl.css("backgroundColor","#FFF");
		}
	}
	
	var rowIndex = 0;
    var getField = function(data) {
	  	var s =''; 
		s +='<input type="text" class="fieldlength" id="fieldname'+ rowIndex +'" name="fieldname" value="'+HTMLDencode(data.fieldname)+'" onblur="checkSpace(this);checkStartChar(this);"/>';
		return s; 
	};
	var getFieldType = function(data) {
	  	var s =''; 
	  	var typeCodes = ['00','06','01','02','03','04','05'];
	  	var typeNames = ['{*[Text]*}','{*[Number]*}','{*[Date]*}','{*[SelectBox]*}','{*[RadioBox]*}','{*[Textarea]*}','{*[CheckBox]*}'];
		s +='<select name="fieldType" id="type'+ rowIndex +'" onchange="typeChange(this.value,'+ rowIndex +')">';
			for (var i=0; i < typeCodes.length; i++) {
			if (data.fieldtype.toUpperCase() == typeCodes[i]) {
				s+='<option value="'+typeCodes[i]+'" selected>'+typeNames[i]+'</option>';
			} else {
				s+='<option value="'+typeCodes[i]+'">'+typeNames[i]+'</option>';
			}
		}
		s +='</select>';
		
		return s; 
	};
	var getFieldLength=function(data){
	   var s =''; 
	   s +='<input type="text" class="fieldlength" id="fieldLength'+ rowIndex +'" name="fieldLength" onblur="checkNumber(this)" value="'+HTMLDencode(data.fieldlength)+'" />';
	   return s; 
	};
	var getFieldOption=function (data){
	    var s='';
	 	s +='<input type="text" class="fieldlength" id="fieldOption'+ rowIndex +'" name="fieldOption" value="'+HTMLDencode(data.fieldoption)+'"/>';
	    return s; 
	};
	var getFieldFormat=function(data){
	 	var s='';
	 	s +='<input type="text" class="fieldlength" id="fieldFormat'+ rowIndex +'" name="fieldFormat" value="'+HTMLDencode(data.fieldformat)+'"/>';
	    return s;
	};
	var getDelete = function(data) {
	  	var s = '<input type="button" value="{*[Delete]*}" onclick="delRow(tb, this.parentNode.parentNode)"/>';
	  	rowIndex ++;
	  	return s;
	};
// 根据数据增加行
	function addRows(datas) {
		var cellFuncs = [getField, getFieldType,getFieldLength,getFieldOption,getFieldFormat, getDelete];
		
		var rowdatas = datas;
		if (!datas || datas.length == 0) {
			var data = {fieldname:'', fieldtype:'',fieldlength:'',fieldoption:'',fieldformat:''};
			rowdatas = [data];
		}
		DWRUtil.addRows("tb", rowdatas, cellFuncs);
		var types = document.getElementsByName("fieldType");
		for (var i=0; i < types.length; i++) {
			types[i].onchange();
		} 
		//resize();
	}
	// 删除一行
	function delRow(elem, row) {
		if (elem) {
			elem.deleteRow(row.rowIndex);
			//rowIndex --;
		}
		//resize();
	}
	// 根据页面内容生成关系语句
	function createRelStr() {
		var fields = document.getElementsByName("fieldname");
		var types = document.getElementsByName("fieldType");
		var fieldlength = document.getElementsByName("fieldLength");
		var fieldoption = document.getElementsByName("fieldOption");
		var fieldformat = document.getElementsByName("fieldFormat");
		
		var str = '[';
		for (var i=0;i<types.length;i++) {
		  
			if (types[i].value != '' && fields[i].value!='') {
				str += '{';
				str += 'fieldname:\''+ HTMLEncode(fields[i].value)+ '\',';
				str += 'fieldtype:\'' + types[i].value+'\',';
				str += 'fieldlength:\''+ HTMLEncode(fieldlength[i].value) + '\',';
				str += 'fieldoption:\''+ HTMLEncode(fieldoption[i].value)+ '\',';
				str += 'fieldformat:\''+ fieldformat[i].value + '\',';
				str += 'fieldid:\'' + getFieldId() + '\'';
				str += '},';
			}
		}
		if (str.lastIndexOf(',') != -1) {
			str = str.substring(0, str.length - 1);
		}
		str += ']';
		return  str;
	}
	
	function getFieldId() {
  		var fieldid = '';
  		DWREngine.setAsync(false);
		Sequence.getSequence(function(id) {
			fieldid = id;
		});
	return fieldid;
}
	// 根据mapping str获取data array
	function parseRelStr(str) {
		var obj = eval(str);
		if (obj instanceof Array) {
			return obj;
		} else {
			return new Array();	
		}
	}
	function ev_next() {
		if(createRelStr()=='[]'){
		  alert('{*[page.name.notexist]*}');
		  return ;
		}
		if(checkfieldname()){
		  return;
		}
		document.getElementsByName('content.f_fieldsdescription')[0].value = createRelStr();
		document.forms[0].action='<s:url action="toStep2Style"></s:url>';
		document.forms[0].submit();
	}
	function checkfieldname(){
		var fields = document.getElementsByName("fieldname");
		  for(var i=0;i<fields.length;i++){
		     for(var j=i+1;j<fields.length;j++){
			       if(fields[i].value==fields[j].value){
			        alert("{*[page.name.exist]*}");
			         return true;
			       }
			    }
		  }
		   return false;	
	}
	
	function checkSpace(obj) {
		var regex = /[^\w\u4e00-\u9fa5]/g;
		obj.value = obj.value.replace(regex, '');
	}
	
	function ev_init() {
		var str = document.getElementsByName('content.f_fieldsdescription')[0].value;
		var datas = parseRelStr(str);
		addRows(datas);
	}
	function IsDigit(){
		return ((event.keyCode>=48)&&(event.keyCode<=57));
	}
	function checkStartChar(obj){
		if (IsDigit(obj.value,"{*[page.name.startingit]*}")) {
			obj.value="";
			obj.focus();
		}
	}

	function IsChar(s,msg){
		if (s && s != "") {
			var patrn=/^[1-9]{1}[0-9]*$/; 
			if (patrn.test(s)){
				return true;
			}
		}
		alert(msg);
		return false;
	}

	function checkNumber(obj) {
		if (obj.value && obj.value != "")
		if (!IsChar(obj.value,"{*[page.length.allowtype]*}")) {
			obj.value="";
			obj.focus();
		}
	}

	function resize(){
		if((jQuery("#maintable").height()+60)>jQuery("body").height()){
			jQuery("#maintable").height(jQuery("body").height()-60);

			jQuery("#contenttable").height(jQuery("#maintable").height()-120);

			jQuery("#contenttable_cols").height(jQuery("#contenttable").height()-240);
			jQuery("#contenttable_cols").css("overflow","auto");
		}
	}
</script>
<body onload="ev_init()">

<s:form action="save" method="post">
<s:hidden name="content.f_formid" />
<%@include file="/common/page.jsp"%>
<%@include file="/common/msg.jsp"%> 
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
	<table width="99%" id="maintable">
		<tr style="height:100px;">
			<td>
				<%@include file="wizard_guide.jsp" %>
			</td>
			<td rowspan="2" style="width:200px;"><s:include value="wizard_common.jsp"><s:param name="step" value="23"/></s:include></td>
		</tr>
		<tr style="height:400px; vertical-align: top;">
			<td style="text-align: center;">
			<input type="hidden" name="formType" value="<s:property value='#parameters.formType'/>">
			<div style="text-align:right;">
				<input type="button" value="{*[Add]*}" onclick="addRows()" />
			</div>
			<div style="height:375px; height:365px\9; overflow:auto;">
			<table id="contenttable" class="marAuto">
				<tr>
					<td>
					<div id="contenttable_cols">
					<table>
						<tbody id="tb">
							<tr align="center">
								<td class="commFont fieldlength">{*[page.wizard.step2.fields.field_name]*}</td>
								<td class="commFont fieldlength">{*[page.wizard.step2.fields.field_type]*}</td>
								<td class="commFont fieldlength">{*[Length]*}</td>
								<td class="commFont fieldlength">{*[Options]*}</td>
								<td class="commFont fieldlength">{*[Format]*}</td>
							</tr>
						</tbody>
					</table>
					</div>
					</td>
				</tr>
				<tr>
					<td valign="top" colspan="2" align="center">
					<button type="button" onClick="forms[0].action='<s:url action="backToFormInfo" />';forms[0].submit();">{*[Back]*}</button>
					&nbsp;
					<button type="button" onClick="ev_next();">{*[Next]*}</button><s:textarea name="content.f_fieldsdescription" id="fieldsDescription" cssStyle="display:none" />
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div style="width: 300px;" class="commFont">{*[Tips]*}:<br>
						<p>{*[page.wizard.step2.fields.tip1]*}</p>
						<p>{*[page.wizard.step2.fields.tip2]*}</p>
						{*[page.wizard.step2.fields.tip3]*}</div>
					</td>
				</tr>
			</table>
			</div>
			</td>
		</tr>
	</table>
</s:form>

</body>
</o:MultiLanguage></html>
