<!-- webwork url -->
<%@ taglib uri="/struts-tags" prefix="s"%>

<!-- add if else dolly 2011-3-9 -->
<s:if test="#parameters._currpage != null && #parameters._currpage!=''">
	<input type="hidden" name="_currpage" value='<s:property value="#parameters._currpage"/>' />
</s:if>
<s:else>
	<input type="hidden" name="_currpage" value='<s:property value="datas.pageNo"/>' />
</s:else>

<s:if test="#parameters._pagelines != null && #parameters._pagelines!=''">
	<input type="hidden" name="_pagelines" value='<s:property value="#parameters._pagelines"/>' />
</s:if>
<s:else>
	<input type="hidden" name="_pagelines" value='<s:property value="datas.linesPerPage"/>' />
</s:else>

<s:if test="#parameters._rowcount != null && #parameters._rowcount!=''">
 	<input type="hidden" name="_rowcount" value='<s:property value="#parameters._rowcount"/>' />
</s:if>
<s:else>
	<input type="hidden" name="_rowcount" value='<s:property value="datas.rowCount"/>' />
</s:else>

<s:if test="#parameters.domain != null">
<s:hidden name="domain" value="%{#parameters.domain}"/>
</s:if>
<s:else>
<s:hidden name="domain" value="%{#session.FRONT_USER.domainid}"/>
</s:else>

<s:hidden id="id" name="content.id" />
<s:hidden id="sortId" name="content.sortId" />

<s:if test="#parameters.application != null">
<s:hidden name="application" id="application" value="%{#parameters.application}" />
</s:if>
<s:else>
<s:hidden name="application" id="application" value="%{content.applicationid}"/>
</s:else>
