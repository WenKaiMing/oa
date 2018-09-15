<%@ page pageEncoding="UTF-8"%>
<%@ page import="cn.myapps.core.user.action.WebUser"%>
<%@ page import="cn.myapps.constans.Web"%>
<%@ page import="java.util.*"%>
<% 
	String skinType = (String)request.getSession().getAttribute("SKINTYPE");
%>
<%@ page import="cn.myapps.core.workflow.FlowState"%>
<%@ page import="cn.myapps.core.workflow.FlowType"%>
<%@ page import="cn.myapps.core.workflow.element.*"%>
<%@ page import="cn.myapps.core.workflow.storage.definition.ejb.*"%>
<%@ page import="cn.myapps.util.ProcessFactory" %>
<%@page import="cn.myapps.util.StringUtil"%>

<o:MultiLanguage value="FRONTMULTILANGUAGETAG">
	<s:token name="token"/>
	<!-- 流程提交面板 -->
	<div id="flowprocessDiv" class="searchDiv" >
		<s:hidden name="_signature" />
		<s:hidden id="submitTo" name="submitTo" value="%{#parameters.submitTo}"></s:hidden>
		<s:hidden id="_subFlowApproverInfo" name="_subFlowApproverInfo"
			value="%{#parameters._subFlowApproverInfo}"></s:hidden>
		<s:hidden id="_circulatorInfo" name="_circulatorInfo" value=""></s:hidden>
		<s:hidden id="_subFlowApproverInfoAll" name="_subFlowApproverInfoAll"
			value=""></s:hidden>
		<input type="hidden" id="input_hidden_id"/>

          <div class="row">
              <div class="col-xs-6" id="flowHtmlText">
                  <fieldset>
                      <legend>{*[cn.myapps.core.dynaform.document.submit_to]*}</legend>
                      <!-- <div class="radio">
                          <label>
                              <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
                              部门主管审批 </label>
                      </div> -->
                  </fieldset>
              </div>
              <div class="col-xs-6" id="flowHtmlForm">
                  <fieldset>
                      	<legend>{*[cn.myapps.core.dynaform.document.opinion]*}</legend>
                      	<div id="textarea_counter"><span class="count">0</span>/140</div>
						<s:textarea name="_attitude"  placeholder="{*[cn.myapps.core.workflow.approve_remarks]*}"
							cssClass="form-control" rows="4" maxlength="140" value="%{#parameters._attitude}"/>
						<!-- 
						<select id="fieldset_remark_usual" name="selse" style="margin:10px;width:120px;"><option>{*[cn.myapps.core.dynaform.document.common_opinion]*}</option></select>
						 -->
						<div class="fieldset_remark_button">
							<span id="fieldset_remark_usual"><span>常用意见</span><i class="fa fa-sort-desc"></i></span>
							<button id="btn_undo" type="button" class="btn btn-reset fr" onclick="$sigdiv.jSignature('clear');"></button>
	                        <button type="button" class="btn btn-pen fr write" onclick="jQuery('#signature_box,#btn_undo').toggle(200)"></button>
							<!-- <button type="button" onclick="jQuery('#signature_box,#btn_undo').toggle(200)">手签意见</button> -->
							<!-- <button id="btn_undo" type="button" style="display:none" onclick="$sigdiv.jSignature('clear');">重写</button> -->
                  		</div>
                  </fieldset>
              </div>
			</div>
			<div id="signature_box" style="padding-top:10px;display:none;">
				<div id="signature"></div>
			</div>
			<div id="div_button_place" class="button-css text-center"></div>
          	<div class="clearfix"></div>
      </div>
      
      
    <!-- 流程催办面板 -->
	<div id="flow-reminder-panel" class="searchDiv" style="display:none;">
		<div class="row">
			<div class="col-xs-6 flowHtmlText">
				<fieldset id="flow-reminder-text-up">
					<legend>{*[cn.myapps.core.dynaform.document.reminder]*}</legend>
					<div>
						<div class="flow-reminder-panel-node-list"></div>
					</div>
				</fieldset>
			</div>
			<div class="col-xs-6 flowremark">
				<fieldset id="flow-reminder-remark-box">
					<legend>{*[cn.myapps.core.dynaform.document.remarks]*}</legend>
					<div class="flow-reminder-counter" id="flow-reminder-counter"><span class="flow-reminder-num">0</span>/140</div>
					<section class="flow-reminder-panel-attitude">
						<s:textarea name="_reminderContent" rows="3" placeholder="{*[cn.myapps.core.dynaform.document.say_something]*}"
								cssStyle="padding:10px;width:96%;*width:90%;height:100%;overflow:auto;border:none;resize:none;outline:none;" value="%{#parameters._reminderContent}" maxlength="140"/>
					</section>
				</fieldset>
			</div>
		</div>	
		<div id="div_button_place" class="button-css flow-reminder-panel-footer">
			<a href='##' id='btn-flow-reminder' class='btn btn-primary fr'><span>{*[cn.myapps.core.dynaform.document.reminder]*}</span></a>
		</div>
		<div class="clearfix"></div>
	</div>
<!--[if lt IE 9]>
<script type="text/javascript" src='<s:url value="/portal/share/script/jSignature/flashcanvas.js"/>'></script>
<![endif]-->
<script id="mode_id" type="text/x-jquery-tmpl">
	<option id="${id}">${name}</option>
</script>
<script>
var skinType='<%=skinType%>',
	$sigdiv,
	subFlowApproverInfo =[],
	subFlowApproverInfoAll =[],
	
	Multilingual = {
		specifyAuditor : '{*[cn.myapps.core.workflow.choose_specify_auditor]*}',
		chooseaction : '{*[page.workflow.chooseaction]*}',
		noaction : '{*[page.workflow.noaction]*}',
		suspend : '{*[cn.myapps.core.workflow.suspend]*}',
		recover : '{*[cn.myapps.core.workflow.recover]*}',
		workflowRetracement : '{*[cn.myapps.core.workflow.retracement]*}',
		Retracement : '{*[Retracement]*}',
		addAuditor : '{*[cn.myapps.core.workflow.add_auditor]*}',
		workflowAddAuditor : '{*[cn.myapps.core.workflow.add_auditor]*}',
		editAuditor : '{*[Edit_Auditor]*}',
		workflowAdjustment : '{*[WorkflowAdjustment]*}',
		flowTerminate : '{*[cn.myapps.core.dynaform.activity.type.flow_terminate]*}',
		rejectConfirm : '{*[cn.myapps.core.workflow.reject_confirm]*}',
		reminder : '{*[cn.myapps.core.dynaform.document.reminder]*}',
		nodeNeedReminders : '{*[cn.myapps.core.dynaform.document.reminder.please_tick_the_process_node_need_reminders]*}',
		theNoteReminders : '{*[cn.myapps.core.dynaform.document.reminder.please_fill_in_the_note_reminders]*}',
		noteTooLong : '{*[cn.myapps.core.dynaform.document.reminder.reminders_note_too_long]*}',
		commit : '{*[Confirm_To_Commit]*}',
		userSelect : '{*[User]*}{*[Select]*}',
		flowUserSelect : '{*[cn.myapps.core.workflow.user_select]*}',
		confirmTo : '{*[Confirm_To_Commit]*}'
	};

jQuery(function(){
	$sigdiv = $("#signature").jSignature({'UndoButton':false,width:$("#flowprocessDiv").width(),height:'200px',color:'#000',lineWidth:0});
	FlowPanel.init();
	FlowProcess.bindEvent();
});
</script>
</o:MultiLanguage>
