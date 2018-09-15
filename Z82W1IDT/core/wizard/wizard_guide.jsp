<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<style>
	
</style>

<table style="height:25px;">
	<tr>
		<td style="color:#a6a9ae;font-size:16px; line-height:25px; border-bottom:1px dotted black; vertical-align: top;">{*[page.wizard.steps]*}:
			<span id="s1"><img src='<s:url value="/resource/imgnew/wizard/1_1.gif"/>'/> {*[page.wizard.steps.create.module]*}</span>
				<img src="<s:url value="/resource/imgnew/wizard/b.gif"/>"/>
			<span id="s2"><img src="<s:url value='/resource/imgnew/wizard/1_2.gif'/>"/> {*[page.wizard.steps.create.form]*}</span>
				<img src="<s:url value="/resource/imgnew/wizard/b.gif"/>"/>
			<span id="s3"><img src="<s:url value="/resource/imgnew/wizard/1_3.gif"/>"/> {*[page.wizard.steps.create.flow]*}</span>
				<img src="<s:url value="/resource/imgnew/wizard/b.gif"/>"/>
			<span id="s4"><img src="<s:url value="/resource/imgnew/wizard/1_4.gif"/>"/> {*[page.wizard.steps.create.menu]*}</span>
				<img src="<s:url value="/resource/imgnew/wizard/b.gif"/>"/>
			<span id="s5"><img src="<s:url value="/resource/imgnew/wizard/1_5.gif"/>"/> {*[page.wizard.steps.create.view]*}</span>
		</td>
	</tr>
</table>	