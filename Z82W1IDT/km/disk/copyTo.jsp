<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="myapps" prefix="o"%>
<s:bean name="cn.myapps.km.disk.ejb.NDirHelper" id="nd"></s:bean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><o:MultiLanguage>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>{*[cn.myapps.km.disk.copy]*}</title>
<link href='<s:url value="/km/script/dtree/dtree.css" />' rel="StyleSheet" type="text/css" />
<script type="text/javascript" src='<s:url value="/km/script/dtree/dtree.js"/>'></script>
</head>
<body>
<s:form action="" method="post" theme="simple" >
<s:hidden name="ndiskid" id="ndiskid" value="%{#parameters.ndiskid}"></s:hidden>
<div class="dtree" style="overflow:auto;">
	<p><a href="javascript: d.openAll();">open all</a> | <a href="javascript: d.closeAll();">close all</a></p>
	<script type="text/javascript">
		d = new dTree('d');

		<s:iterator value="#nd.getNDirByNDisk(#parameters.ndiskid)" id="dir">
			<s:if test="parentId != null && parentId != '' " >
				d.add('<s:property value="id" />','<s:property value="parentId" />','<s:property value="name" />');
			</s:if>
			<s:else>
				d.add('<s:property value="id" />',-1,'<s:property value="name" />');
			</s:else>
		</s:iterator>
		document.write(d);
	</script>

</div>
</s:form>
</body>
</o:MultiLanguage></html>