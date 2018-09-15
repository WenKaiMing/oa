<!-- webwork url -->
<s:if test="datas.pageNo != null && datas.pageNo!=''">
	<input type="hidden" name="_currpage" value='<s:property value="datas.pageNo"/>' />
</s:if><s:else>
	<input type="hidden" name="_currpage" value='<s:property value="#parameters._currpage"/>' />
</s:else>
<s:if test="datas.linesPerPage != null && datas.linesPerPage!=''">
	<input type="hidden" name="_pagelines" value='<s:property value="datas.linesPerPage"/>' />
</s:if><s:else>
	<input type="hidden" name="_pagelines" value='<s:property value="#parameters._pagelines"/>' />
</s:else>
<s:if test="datas.rowCount != null && datas.rowCount!=''">
 	<input type="hidden" name="_rowcount" value='<s:property value="datas.rowCount"/>' />
</s:if><s:else>
	<input type="hidden" name="_rowcount" value='<s:property value="#parameters._rowcount"/>' />
</s:else>


<s:if test="#parameters.domain != null">
<s:hidden name="domain" value="%{#parameters.domain}"/>
</s:if>
<s:else>
<s:hidden name="domain" value="%{#session.FRONT_USER.domainid}"/>
</s:else>

<s:if test="#parameters.application != null">
<s:hidden name="application" value="%{#parameters.application}"/>
</s:if>
<s:elseif test="content.applicationid != null">
<s:hidden name="application" value="%{content.applicationid}"/>
</s:elseif>
<s:else>
<s:hidden name="application" value="%{#request.application}"/>
</s:else>