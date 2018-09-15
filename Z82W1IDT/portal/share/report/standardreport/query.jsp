<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/portal/share/common/head.jsp"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<s:bean name="cn.myapps.core.deploy.module.action.ModuleHelper"
	id="moduleHelper" />
<s:bean name="cn.myapps.core.dynaform.form.action.FormHelper"
	id="formHelper" />
<%
	WebUser user = (WebUser) session
			.getAttribute(Web.SESSION_ATTRIBUTE_FRONT_USER);
	String userSkin = "";
	//获取皮肤参数
	userSkin = user.getUserSetup() == null ? (String) session
			.getAttribute("SKINTYPE") : (String) user.getUserSetup()
			.getUserSkin();
	request.setAttribute("userSkin", userSkin);
%>
<html>
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<head>
<link rel="stylesheet"
	href="<s:url value='/resource/css/main-front.css'/>" type="text/css">
<!-- 兼容ie6半透明 -->
<title>{*[时效查询]*}</title>
<style type="text/css">
body {
	background-color: #dfe8f6;
	font-size: 12px;
	font-weight: bold;
}
</style>
	</head>
	<body leftmargin=0 rightmargin=0 topmargin=0 bottommargin=0>
		<s:form action="summaryReport" method="post" theme="simple"
			name="formItem">
			<table width="100%">
				<tr>
					<td width="10"></td>
					<td width="3">&nbsp;</td>
					<td width="200" class="text-label"></td>
					<td>
						<table width="100%" border=0 cellpadding="0" cellspacing="0">
							<tr>
								<td>&nbsp;</td>
								<td width="60" valign="top"></td>
								<td width="70" valign="top"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

			<table width=100% border=0 cellspacing="0" align="center">
				<%@include file="/common/page.jsp"%>
				<s:hidden name="columns1" />
				<tr>
					<td class="commFont" align="right">{*[模块]*}:</td>
					<td><s:select name="_moduleid" id="_moduleid"
							list="#moduleHelper.getModuleSel(#parameters.application)"
							theme='simple' /></td>
					<td colspan="3" style="background-color: #dfe8f6;"><input
						type="radio" name="dbmethod" checked="checked" value="0">汇总</input>
						<input type="radio" name="dbmethod" value="1">平均</input> <input
						type="radio" name="dbmethod" value="2">计数</input> <input
						type="radio" name="dbmethod" value="3">最大值</input> <input
						type="radio" name="dbmethod" value="4">最小值</input> <!-- <s:radio name="dbmethod" theme="simple" list="#{'sum':'汇总', 'avg':'平均', 'count':'计数', 'max':'最大值', 'min':'最小值'}"/> -->
					</td>
				</tr>
				<td></td>
				<td></td>
				<tr>
					<td class="commFont" align="right">{*[Form]*}:</td>
					<td><s:select name="_formid" id="_formid" list="{}"
							theme='simple' /></td>
				</tr>
				<tr>
					<td>
				<tr>
					<td class="commFont" align="right">
						<div id="columnsLable" style="display: none">{*[Columns]*}:</div>
					</td>
					<td>
						<div id="columns" class="commFont">
					</td>
					<td></td>
				</tr>
				</td>
				</tr>
				<tr>
					<td class="commFont" align="right">开始日期:</td>
					<td><s:textfield name="startdate"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" theme="simple" /></td>
					<td align="right">结束日期:</td>
					<td><s:textfield name="enddate"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" theme="simple" /></td>
				</tr>
				<tr align="center">
					<td colspan="4" nowrap="nowrap">
						<div style="height: 30px; width: 100px;">
							<input type="button" class="activity"
								onclick="if(submit_check()){forms[0].submit();}" value="查询" />
						</div>
					</td>
				</tr>
			</table>

		</s:form>
	</body>
	<script>
		jQuery(document).ready(function() {
			//jQuery("[moduleType='activityButton']").obpmButton(); //重构操作按钮
		});

		document.getElementById('_moduleid').onchange = module_change;
		document.getElementById('_formid').onchange = form_change;
		function module_change() {
			var m = document.getElementById('_moduleid');
			FormHelper.get_formListByModuleType(m.value, function(options) {
				addOptions("_formid", options);
				form_change();
			});

		}

		function form_change() {
			var f = document.getElementById('_formid');//normal form下拉联动
			FormHelper.getFiledsCheckBox(f.value, 'columns', function(str) {
				var func = eval(str)
			});
			if (f.value)
				document.getElementById('columnsLable').style.display = '';
			else
				document.getElementById('columnsLable').style.display = 'none';

		}

		// 增加element options
		function addOptions(elemName, options) {
			var elems = document.getElementsByName(elemName);
			for (var i = 0; i < elems.length; i++) {
				var defVal = elems[i].value;
				$("#" + elems[i].id).html("");
				
				for(var o in options){
					var option = document.createElement("option");
					option.setAttribute("value", o);
					option.text = options[o];
					if(o == defVal){
						option.setAttribute("selected", "true");
					}
					elems[i].appendChild(option);
				}
			}
		}

		//form和模块是必填项
		function submit_check() {
			var formvalue = document.getElementById('_formid').value;
			var modulevalue = document.getElementById('_moduleid').value;

			if (modulevalue == null || modulevalue == '') {
				alert('Pls confirm you have entered the module value!');
				return false;
			}

			if (formvalue == null || formvalue == '') {
				alert('Pls confirm you have entered the form value!');
				return false;
			}
			return true;
		}

		function ev_resetAll() {
			var elements = document.forms[0].elements;
			for (var i = 0; i < elements.length; i++) {
				if (jQuery(elements[i]).attr('fieldType') == 'UserField') {
					elements[i].value = "";
				}
				//alert(elements[i].id + ": "+elements[i].type + " resetable-->" + elements[i].resetable);
				if (elements[i].type == 'text' || elements[i].resetable) {
					elements[i].value = "";
				}
			}
			for (var i = 0; i < arrObject.length; i++) {
				arrObject[i].save("");
			}
		}
	</script>
<script src='<s:url value="/dwr/engine.js"/>'></script>
<script src='<s:url value="/dwr/util.js"/>'></script>
<script src='<s:url value="/dwr/interface/FormHelper.js"/>'></script>
</o:MultiLanguage>
</html>
