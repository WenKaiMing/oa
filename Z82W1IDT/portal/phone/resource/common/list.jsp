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
