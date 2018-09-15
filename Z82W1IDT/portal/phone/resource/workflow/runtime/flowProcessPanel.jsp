<%@ page pageEncoding="UTF-8"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.myapps.core.workflow.FlowState"%>
<%@ page import="cn.myapps.core.workflow.FlowType"%>
<%@ page import="cn.myapps.core.workflow.element.*"%>
<%@ page import="cn.myapps.core.workflow.storage.definition.ejb.*"%>
<%@ page import="cn.myapps.util.ProcessFactory" %>
<%@page import="cn.myapps.util.StringUtil"%>
<style>
#flowHtmlText fieldset{
margin:0px;
padding:10px;
border:0px;
background:#fff;
position:relative;
}
#flowHtmlText fieldset legend{
position:absolute;
top:10px;
color:#777777;
}
#flowHtmlText fieldset select{
margin-left:50px;
width:auto;
float:right;
margin-bottom:0px;
font-size:12px;
padding:0px;
}
#flowHtmlText fieldset div{
margin-left:70px;
text-align:right;
}
#flowHtmlText fieldset div label
{
color:#b7b7b7;
font-size:12px;
}
#flowHtmlText fieldset div label input
{
vertical-align:sub;
margin-right:5px;
}
.test-body
{
position:fixed;
top:0;
right:0;
bottom:0;
left:0;
}

.flowToPerson .flowToPerson-Input{
  border: 0px;
  margin: 0px 10px;
  border-bottom: 1px solid #C9C9C9;
  border-radius: 0px;
  height: 22px;
  font-size: 12px;
  width: 150px;
  overflow-x: auto;
}

</style> 
<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<s:token name="token"/>
<header class="bar bar-nav"><h1 class="title">提交</h1></header>

<div class="reimburse" style="position: absolute;top: 44px;right: 0;bottom: 0px;left: 0;z-index:1;">
<div class="flowIs">
	<div class="card_app">
		<div id="flowHtmlText" class="flowHtmlText"></div>
	</div>
	<div class="card_space">
		备注：
	</div>
	<div class="card_app" style="padding:10px">
		<div class="formfield-wrap">
			<input class="contactField requiredField" type="text" name="_attitude" style="margin: 0px;">
			<select id="fieldset_remark_usual" name="selse" style="margin:10px 0px 0px;padding: 5px;"><option>常用意见</option></select>
		</div>
		
	</div>
	<div class="card_space">
		执行情况：<button class="btn pull-right" type="button" data-enhance="false" onclick="$sigdiv.jSignature('clear');">重写</button>
		<div class="clearfix"></div>
	</div>
 	<div class="card_app">
		<div class="con">
			<div class="pen"><div id="signature" style="margin-top:15px;"></div></div>
			<div class="clearfix"></div>
			<s:hidden name="_signature" />
			<s:hidden id="submitTo" name="submitTo" value="%{#parameters.submitTo}"></s:hidden>
			<s:hidden id="_subFlowApproverInfo" name="_subFlowApproverInfo"
				value="%{#parameters._subFlowApproverInfo}"></s:hidden>
			<s:hidden id="_circulatorInfo" name="_circulatorInfo" value=""></s:hidden>
			<s:hidden id="_subFlowApproverInfoAll" name="_subFlowApproverInfoAll"
				value=""></s:hidden>
			<input type="hidden" id="input_hidden_id"/>
		</div>
	</div>
	<div style="height:57px"></div>
	</div>
  </div>
<div class="card_space_fix zindex20">
		<table>
			<tbody>
				<tr id="div_button_place"></tr>
			</tbody>
		</table>
	</div>
</o:MultiLanguage>