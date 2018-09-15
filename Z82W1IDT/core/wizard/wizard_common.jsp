 <%@ taglib uri="/struts-tags" prefix="s"%>
 <style>
 	.subtitle {padding-left:20px}
 	.title {padding-left:10px;}
 	.selected {color:red; background-color: white}
 </style>
 
 <%
 	String strs = request.getParameter("step");
 %>
 

	<table style="border:1px solid #d4d4d4; background-color:#f2f2f4; height:80%;width:100%;margin-top:25px;">
		<tr id="1" align="left" class="commFont"><td class="title"><em><strong>1.</strong></em>{*[page.wizard.step1.title]*}</td></tr>
		
		<tr id="2" align="left" class="commFont"><td class="title"><em><strong>2.</strong></em>{*[page.wizard.step2.info.title]*}</td></tr>
		<tr id="21" align="left" class="commFont"><td class="subtitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* {*[page.wizard.step2.formtype.description]*}</td></tr>
		<tr id="22" align="left" class="commFont"><td class="subtitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* {*[page.wizard.step2.info.description]*}</td></tr>
		<tr id="23" align="left" class="commFont"><td class="subtitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* {*[page.wizard.step2.fields.description]*}</td></tr>
		<tr id="24" align="left" class="commFont"><td class="subtitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* {*[page.wizard.step2.style.description]*}</td></tr>
		<tr id="25" align="left" class="commFont" style="display: none;"><td class="subtitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* {*[page.wizard.step2.info.subdescription]*}</td></tr>
		<tr id="26" align="left" class="commFont" style="display: none;"><td class="subtitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* {*[page.wizard.step2.fields.subdescription]*}</td></tr>
		<tr id="27" align="left" class="commFont" style="display: none;"><td class="subtitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* {*[page.wizard.step2.style.subdescription]*}</td></tr>
		<tr id="28" align="left" class="commFont" style="display: none;"><td class="subtitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* {*[page.wizard.step2.column.subdescription]*}</td></tr>
		
		<tr id="3" align="left" class="commFont"><td class="title"><em><strong>3.</strong></em>{*[page.wizard.step3.title]*}</td></tr>
		<tr id="31" align="left" class="commFont"><td class="subtitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* {*[page.wizard.step3.description]*}</td></tr>
		<tr id="32" align="left" class="commFont"><td class="subtitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* {*[page.wizard.step3.type.description]*}</td></tr>
		<tr id="33" align="left" class="commFont"><td class="subtitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* {*[page.wizard.step3.role.description]*}</td></tr>
		
		<tr id="4" align="left" class="commFont"><td class="title"><em><strong>4.</strong></em>{*[page.wizard.step4.title]*}</td></tr>
		 
		<tr id="5" align="left" class="commFont"><td class="title"><em><strong>5.</strong></em>{*[page.wizard.step5.title]*}</td></tr>
		<tr id="51" align="left" class="commFont"><td class="subtitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* {*[page.wizard.step5.description]*}</td></tr>
		<tr id="52" align="left" class="commFont"><td class="subtitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* {*[page.wizard.step5.type.description]*}</td></tr>
		<tr id="53" align="left" class="commFont"><td class="subtitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* {*[page.wizard.step5.column.description]*}</td></tr>
		<tr id="54" align="left" class="commFont"><td class="subtitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* {*[page.wizard.step5.filter.description]*}</td></tr>
		<tr id="55" align="left" class="commFont"><td class="title"><em><strong>6.</strong></em>{*[page.wizard.step5.success]*}</td></tr>
		
	</table>
<script type="text/javascript">

	var formType = '<s:property value="content.f_Type"/>';
	if(formType && formType == '01'){
		jQuery("#25").css("display","block");
		jQuery("#26").css("display","block");
		jQuery("#27").css("display","block");
		jQuery("#28").css("display","block");
	}
	var step = '<%=strs %>';
	document.getElementById(step).className = "selected";

</script>
 