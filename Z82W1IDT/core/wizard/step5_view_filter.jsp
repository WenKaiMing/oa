<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/common/taglibs.jsp"%>
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="fh">
	<s:param name="moduleid" value="content.moduleid" />
</s:bean>
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
.STYLE3 {color: #000000}
-->
</style>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
<script src='<s:url value="/dwr/interface/Sequence.js"/>'></script>
</head>

<script>
function ev_init() {
	var str="<s:property value="content.f_fieldsdescription" />";
	if(str.length>0){
    var obj=RelStr(str);
	    if(obj!=null){
	    	if(obj.length>0){
		        var field=document.all.fieldName;
			    for(var i=0;i<obj.length;i++){
			    	var Opt=document.createElement("option");
					Opt.value=obj[i].fieldtype;
					Opt.text=obj[i].fieldname;
					field.options.add(Opt);
			    }
	      	}
		}
	}
}

function getdata(data){
	var fields= document.all.fieldName;
   	if(data.length>0){
	var obj=RelStr(data);
	if(obj.length>0){
		for(var j=0;j<obj.length;j++){
			var Opt=document.createElement("option");
				Opt.text=obj[j].text;
			    Opt.value=obj[j].value;
			    fields.options.add(Opt);
			}
	    }
    }
}

function RelStr(str){
	var obj = eval(str);
	if (obj instanceof Array) {
		return obj;
	}else{
		return new Array();	
	}
}
</script>
<script> 
function moveup(){   
	var s =   document.all.fields;   
  	var v =   new   Array();   
    for(var i=0;i<s.length-1;i++){   
        if(!   s.options[i].selected   &&   s.options[i+1].selected){   
            v.value   =   s.options[i].value;   
            v.text   =   s.options[i].text;   
            v.selected   =   s.options[i].selected;   
            s.options[i].value   =   s.options[i+1].value;   
            s.options[i].text   =   s.options[i+1].text;   
            s.options[i].selected   =   s.options[i+1].selected;   
            s.options[i+1].value   =   v.value;   
            s.options[i+1].text   =   v.text;   
            s.options[i+1].selected   =   v.selected;   
        }   
    }   
} 

function movedown(){   
    var s = document.all.fields;
    var v = new Array();   
    for(var i = s.length-1; i > 0; i--){   
        if(!s.options[i].selected && s.options[i-1].selected){   
            v.value = s.options[i].value;   
            v.text = s.options[i].text;   
            v.selected = s.options[i].selected;   
            s.options[i].value = s.options[i-1].value;   
            s.options[i].text = s.options[i-1].text;   
            s.options[i].selected = s.options[i-1].selected;   
            s.options[i-1].value = v.value;   
            s.options[i-1].text = v.text;   
            s.options[i-1].selected = v.selected;   
        }   
    }   
}  
    
function addItem(source,target){ 
	for(var i=0;i<source.length;i++){	 
		if(source.options[i].selected==true){
			var Opt=document.createElement("option");
			Opt.value=source.options[i].value;
			Opt.text=source.options[i].text;
			var k=0;
			for(var j=0;j<target.length;j++){
			    if(source.options[i].text==target.options[j].text)
			       k=1;
			}
			if(k==0){
				target.options.add(Opt);
				k=0;
			}
		}	
	}
} 

function delItem(source,target){ 
	for(var x = target.length-1;x >= 0;x--){ 
		var opt = target.options[x]; 
		if (opt.selected){ 
		 target.options[x] = null; 
		} 
	} 
} 

function getFieldId(){
	var fieldid = "";
  	DWREngine.setAsync(false);
	Sequence.getSequence(function(id) {
		fieldid = id;
	});
	return fieldid;
}
function ev_OK(action){
	var selid = document.getElementById("selectid");
    var filterStr="";
    var searchFormStr = "";
    
    var fields = document.all.fields;
    var opt = selid.getElementsByTagName("option");
	if(opt.length <= 0){
		alert("{*[page.column.empty]*}"); 
	}else{
		var items=new Array();
        for(i=0;i<opt.length;i++){
	        var current =opt[i];
	        var fieldid = getFieldId();
	        items += current.value+";";
	        filterStr += createFilterJSON(current.value,current.text);
	        searchFormStr += createSearchFormJSON(current.value, current.text, fieldid);
	    }
	   	filterStr = filterStr.substring(0, filterStr.length-1);
	   	filterStr = "[" + filterStr + "],";
	   	if(document.getElementById('content.f_formid')!=null){
	   		filterStr += "'"+ document.getElementById('content.f_formid').value  + "'";
	   	}else{
	   		filterStr += "'"+ document.getElementById('save_content_f_formid').value  + "'";
	   	}
	   	searchFormStr = searchFormStr.substring(0, searchFormStr.length-1);
	    searchFormStr = "[" + searchFormStr + "]";
	    filterStr = "[" + filterStr + "]";
		if(document.getElementById('content.v_filterField')!=null){
			document.getElementById('content.v_filterField').value=createRelStr();
		}else{
			document.getElementById('save_content_v_filterField').value=createRelStr();
		} 
		if(document.getElementById('content.v_filter')!=null){
			document.getElementById('content.v_filter').value=filterStr;
		}else{
			document.getElementById('save_content_v_filter').value=filterStr;
		}
		if(document.getElementById('content.v_searchForm')!=null){
			document.getElementById('content.v_searchForm').value=searchFormStr;
		}else{
			document.getElementById('save_content_v_searchForm').value=searchFormStr;
		}
        document.forms[0].action = action;
        document.forms[0].submit();
    }
}
function createSearchFormJSON (fieldtype, fieldname,fieldid) {
	var searchFormJSON = "";
		searchFormJSON = "{'fieldtype':'" + fieldtype + "','fieldname':'" + fieldname + "','fieldid':'" + fieldid + "'},";
		return searchFormJSON;
}

function createFilterJSON (fieldtype, fieldname) {
	var filterCode = "";
	filterCode = "{'fieldtype':'" + fieldtype + "','fieldname':'" + fieldname + "'},";
	return filterCode;
}

function createRelStr() {
	var fields=  document.all.fields;
	var str = '[';
	if(fields.length>0){
		for (var i=0;i<fields.length;i++) {
			if (fields.options[i].value != '') {
				str += '{'
				str += '"text"' +':\''+fields.options[i].text+'\',';
				str += '"value"' +':\''+fields.options[i].value+'\'';
				str += '},';
			}
		}
		if (str.lastIndexOf(',') != -1) {
			str = str.substring(0, str.length - 1);
		}
	}
	str += ']';
		
	return  str;
}

function initfields(){
	var str="";
	if(document.getElementById('content.v_filterField')!=null){
		str=document.getElementById('content.v_filterField').value;
	}else{
		str=document.getElementById('save_content_v_filterField').value;
	}
	if(str.length>0){
    var obj=RelStr(str);
	    if(obj!=null){
	    	if(obj.length>0){
		        var field=document.all.fields;
			    for(var i=0;i<obj.length;i++){
			    	var Opt=document.createElement("option");
					Opt.value=obj[i].value;
					Opt.text=obj[i].text;
					field.options.add(Opt);
			    }
	      	}
		}
	}
}
function ev_onload(){
	initfields();
  	ev_init();
}
</script>
<body leftmargin=0 rightmargin=0 topmargin=0 bottommargin=0
	onload="ev_onload()">

<s:form action="save" method="post">
<s:hidden name="content.f_formid" />
<s:hidden name="content.v_filterField" />
<s:hidden name="content.v_filter" />
<s:hidden name="content.v_searchForm" />
<%@include file="/common/page.jsp"%>
<%@include file="/common/msg.jsp"%>
<s:if test="runtimeException.nativeMessage !=null && runtimeException.nativeMessage !=''">	
			<%@include file="/portal/share/common/msgbox/msg.jsp"%>
		</s:if>
<table width="99%">
	<tr style="height:100px;">
		<td>
			<%@include file="wizard_guide.jsp" %>
		</td>
		<td rowspan="2" style="width:200px;"><s:include value="wizard_common.jsp"><s:param name="step" value="54"/></s:include></td>
		
	</tr>
	<tr style="height:400px; vertical-align: top;">
		<td style="text-align: center;">
			<table class="marAuto">
			    <tr><td><label class="label"> {*[Fields]*}</label></td>
			        <td></td>
			        <td><label class="label">{*[Columns]*} </label> </td>
			    </tr>
				<tr>
					<td height="60" class="tdLabel">
					<div align="center"><select
						name="fieldName" size="15" multiple="multiple" style="width:10em"
						ondblclick="addItem(document.all.fieldName, document.all.fields)">

					</select></div>
					</td>
					<td bgcolor="#FFFFFF">

					<p align="center">
					<button type="button" class="button-image" onClick="moveup()"><img
						src="<s:url value="/resource/image/up2.gif"/>"
						alt="{*[Move_Up]*}"></button>
					</p>
					<p align="center">
					<button type="button" class="button-image"
						onClick="addItem(document.all.fieldName,document.all.fields)"><img
						src="<s:url value="/resource/image/right2.gif"/>"
						alt="{*[Add]*} {*[Item]*}"></button>
					</p>
					<p align="center">

					<button type="button" class="button-image"
						onClick="delItem(document.all.fieldName,document.all.fields)"><img
						src="<s:url value="/resource/image/left2.gif"/>"
						alt="{*[Delete]*} {*[Item]*}"></button>

					</p>
					<p align="center">

					<button type="button" class="button-image" onClick="movedown()"><img
						src="<s:url value="/resource/image/down2.gif"/>"
						alt="{*[Move_Down]*}"></button>

					</p>
					</td>
					<td height="60" class="tdLabel">
					<div align="center"><select
						id="selectid" name="fields" size="15" multiple="multiple" style="width:10em"
						ondblClick="delItem(document.all.fieldName,document.all.fields)">
					</select></div>
					</td>
					<td style="display:none"><s:select id="fieldType"
						name="fieldType" list="{}" theme="simple" /></td>
				</tr>
			</table>
			<table width="100%">
				<tr>
					<td class="commFont" align="center">
					<button type="button"
						onClick="forms[0].action='<s:url action="toviewcolumn"></s:url>';forms[0].submit();">{*[Back]*}</button>
					&nbsp;
					<button type="button" onClick="ev_OK('toviewsuccess.action');">{*[Next]*}</button>
					</td>
				</tr>
			</table>
			<table style="border: 1px solid #d4d4d4;margin:auto;">
				<tr><td>
				*{*[page.wizard.step5.column.description3]*}<br />
				*{*[page.wizard.step5.column.description4]*}</td>
					<td>
						<img src="<s:url value='/resource/imgnew/wizard/view_col_fil.gif' />" />
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</s:form>

</body>
</o:MultiLanguage></html>