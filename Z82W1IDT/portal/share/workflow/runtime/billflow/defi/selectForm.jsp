<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/portal/share/common/lib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/portal/share/common/js_base.jsp"%>
<script src='<s:url value="/portal/share/script/util.js" />'></script>

<script type="text/javascript"
	src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/_lib/jquery.cookie.js'/>"></script>
<script type="text/javascript"
	src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/_lib/jquery.hotkeys.js'/>"></script>
<script type="text/javascript"
	src="<s:url value='/portal/share/script/jquery-ui/plugins/tree/jquery.jstree.js'/>"></script>
<script type="text/javascript" src="<s:url value='/portal/share/script/jquery-ui/plugins/layout/jquery.layout.js'/>"></script>
<style type="text/css">
<!--
body {
	margin: 0px;
	background-color: #FFFFFF;
}

a{ 
	font-size:12px; 
	color:#000000;
	text-decoration: none;
}

a:link,visited  {
	color: #000000;
} 

a:hover{
	color: #000000;
} 

a:active {
	color: #000000;
} 

.ui-layout-pane { /* all 'panes' */
	background: #FFF;
	background-color: blue;
	border: 1px solid #BBB;
	overflow: auto;
}
-->
</style>
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper" id="fh" >
	<s:param name="moduleid" value="%{#parameters.s_module}" />
</s:bean>
<script type="text/javascript">
var str="";
var firstId="";
	jQuery(document).ready(function () {
		jQuery('body').layout({ 
			applyDefaultStyles: true 
		});
		treeload();
		jQuery("#fpiframe").attr("src", "editFieldPerm.jsp?formid="+firstId);
		jQuery("#selectedForm").attr("value",firstId);
	});
	
	function treeload() {  
			jQuery("#tree").jstree({   
				core:{ 
				initially_open: ['root'],
				animation: 100
			         },  
			         "html_data":{  
			             "data":getData() 
			         },  
			         "plugins":[ "themes", "html_data"]  
			     }).bind("select_node.jstree", function(e, data){
				     if(node.attr('id')!='root'){
				    	 var page = "editFieldPerm.jsp?formid="+node.attr('id');
					     jQuery("#fpiframe").attr("src", page);
				     }
			     });  
	}

	function getData(){
		var data="<li id='root'><a>{*[cn.myapps.core.workflow.form_list]*}</a><ul>";
		<s:iterator value="#fh.get_forms(#parameters.application)" status="index">
		<s:if test="#index.first">
		firstId="<s:property value='id' />";
		</s:if>
		data+="<li id='<s:property value='id' />'><a href='editFieldPerm.jsp?formid=<s:property value='id' />' target='fpiframe' onclick='selectNode(\"<s:property value='id' />\")'><s:property value='name' /></a></li>";
		</s:iterator>
		return data+"</ul></li>";
	}

	// save field permission to textfield 
	function save() {
		var fpiframe = document.getElementById("fpiframe");
		if (fpiframe.contentWindow.getFieldPermList()) {
			var newlist = fpiframe.contentWindow.getFieldPermList();
			f(newlist != "" || newlist != null){
				var formname = fpiframe.contentWindow.document.getElementsByName("formname")[0].value;
				var formid = fpiframe.contentWindow.document.getElementsByName("formid")[0].value;
				var permList = new Array();
				try{
					
					var permListStr = jQuery("#fieldPermList").attr("value");
					
					//alert("permListStr>>>>"+permListStr);
					
					if (permListStr) {
						permList =eval("("+permListStr+")");
					}
					
					//alert("permList:"+permList);
					var perStr="{formid:\'" + formid + "\',"+ "formname:\'" + formname + "\',"+ "fieldPermList:\'" + newlist + "\'}";
						
					var perm =eval("("+perStr+")");
	
					//alert("list->>" + permList + " isContain:" + isContain(permList, perm));
					
					if (isContain(permList,perm)) {
						permList = changePermList(permList,perm);
					} else {
						if (newlist) {
							permList.push(perm);
						}
					}
					
					var str = jQuery.json2Str(permList);
					jQuery("#fieldPermList").attr("value",str);
				}catch(ex) {
				}	
			}
		}else{
			var allformname=jQuery("#fieldPermList").attr("value");
			
			var formnameStr=fpiframe.contentWindow.document.getElementsByName("formname")[0].value;
			var temppermList = new Array();
			if(allformname!=""&&formnameStr!=""){
				var allformnameArry=eval("("+allformname+")");
				for(var mm=0;mm<allformnameArry.length;mm++){
					if(allformnameArry[mm].formname!=formnameStr){
						//alert(allformnameArry[mm].formname);
						temppermList.push(allformnameArry[mm]);
					}
				}
				jQuery("#fieldPermList").attr("value",jQuery.json2Str(temppermList););
			}else{
				//alert(1);
				jQuery("#fieldPermList").attr("value","");
			}
		}
	}

	function changePermList(permList, perm) {
		var newPermList = new Array();
		
		for (var i=0;i<permList.length;i++) {
			if (permList[i].formid == perm.formid) {
				if (perm.fieldPermList) {
					//permList[i].fieldPermList = perm.fieldPermList;
					newPermList.push(perm);
				}
			} else {
				newPermList.push(permList[i]);
			}
		}
		
		return newPermList;
	}

	function isContain(permList, perm) {
		for (var i=0;i<permList.length;i++) {
			if (permList[i].formid == perm.formid) {
				return true;
			}
		}
		return false;
	}

	function ev_ok() {
		save();
	    var rtn = '';
	    var fieldPermList = jQuery("#fieldPermList").attr("value");
		if (fieldPermList) {
			rtn = fieldPermList;
		}
	    //alert("ev_ok:"+rtn);
	    OBPM.dialog.doReturn(rtn);
	}

	function selectNode(s){
		jQuery("#selectedForm").attr("value",s);
		save();
	}
		

</script>
<title>{*[cn.myapps.core.workflow.select_form]*}</title>
</head>
<body>
<DIV class="ui-layout-north" style="valign:top;">
<table border="0" cellpadding="0" cellspacing="0"
			class="line-position" >
			<tr>
			<td>&nbsp;&nbsp;</td>
			<td class="line-position2">
			    <a href="#" onClick="ev_ok()" style="text-decoration:none;"><img border="0" src="<s:url value="/resource/imgnew/act/act_4.gif"/>">{*[OK]*}</a>
			</td>
			<td>&nbsp;&nbsp;</td>
			<td class="line-position2">
				<a href="#" onClick="OBPM.dialog.doReturn();" style="text-decoration:none;"><img border="0" src="<s:url value="/resource/image/cancel2.gif"/>">{*[Cancel]*}</a>
			</td>
			<td>&nbsp;&nbsp;</td>
			<td class="line-position2">
				<a href="#" onClick="OBPM.dialog.doReturn('');" style="text-decoration:none;"><img border="0" src="<s:url value="/resource/image/qingkong.gif"/>">{*[cn.myapps.core.workflow.clear_all]*}</a>
			</td>
			</tr>
		</table>

</DIV>
<iframe class="ui-layout-center"
	id="fpiframe" frameborder="0" name="fpiframe" style="border: 0px;" /></iframe>

<DIV class="ui-layout-west" >
<div id="tree"></div>
</DIV>
<s:hidden id="selectedForm" />
<s:textarea id="fieldPermList" value="" cssStyle="display:none" />
</body>
<script language="JavaScript">
	var obj=OBPM.dialog.getArgs()['pObj'];
    if(obj.fieldPermList){
    	jQuery('#fieldPermList').attr("value",obj.fieldPermList);
    }
</script>
</o:MultiLanguage></html>