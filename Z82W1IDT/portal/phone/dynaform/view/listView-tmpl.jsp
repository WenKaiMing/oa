<%@ page language="java" contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp"%>
<script type="text/html" id="listView-tmpl">

<table id='tableList_{{viewId}}' data-column-btn-text='显示列' class='table-column-toggle ui-responsive table-stroke' 
	data-role='table' data-mode='columntoggle'>
	<thead>
		<tr class='{{head.cls}}'>
			<th class='listDataThFirstTd' scope='col'></th>
			{{each head.ths as th i}}
			<th width='{{th.colWidth}}' colFieldName='{{th.colFieldName}}' isOrderBy='{{th.isOrderByField}}' isVisible='{{th.isVisible}}' isHiddenColumn='{{th.isHide}}'
				 data-priority='{{th.priority}}' class='{{th.cls}}' style='display:{{th.display}}' title='{{th.colText}}'>{{th.colText}}{{#th.thArrow}}</th>
			{{/each}}
		</tr>
	</thead>

	<tbody>
		{{each tbody.trs as tr i}}
		<tr class='listDataTr' editType='{{tr.editType}}' docId='{{tr.docId}}' docFormid='{{tr.docFormid}}' isSignatureExist='{{tr.isSignatureExist}}'>
			<td class='listDataTrFirstTd'>
				<input data-enhance='false' type='checkbox' name='_selects' value='{{tr.docId}}'/>
			</td>
			{{each tr.tds as td j}}
			<td class='listDataTrTd' viewTemplateForm='{{td.viewTemplateForm}}' isHiddenColumn='{{td.isHide}}' viewDisplayType='{{td.viewDisplayType}}' title='{{td.title}}' style='color:#{{td.colColor}};font-size:{{td.colFontSize}};display:{{td.display}};background-color:#{{td.colGroundColor}};word-break: break-all;'>
				{{if td.isOperateCol}}
					<input type=button value='{{td.colButtonName}}' docId='{{td.docId}}' colBtnType='{{td.colButtonType}}' 
						colApproveLimit='{{td.colApproveLimit}}' docFormid='{{tr.docFormid}}' isSignatureExist='{{tr.isSignatureExist}}' 
						colTemplateForm='{{td.colTemplateForm}}' colId='{{td.colId}}' colMappingform='{{td.colMappingform}}' 
						colButtonName='{{td.colButtonName}}' jumpMapping="{{td.jumpMapping}}"/>
				{{/if}}

				{{if td.isRowNumCol}}
					{{(i+1)}}
				{{/if}}

				{{if td.isLogoCol}}
					<img src='../../lib/icon/{{td.colIcon}}'/>
				{{/if}}

				{{if td.showIcon}}
					<img style='' src='../../lib/icon/{{td.showIcon}}'/>
				{{/if}}

				{{td.result}}
			</td>
			{{/each}}
		</tr>
		{{/each}}
		{{if !sumTrIsHidden}}
		<tr class='listDataTr'>
			<td class='listDataTrFirstTd'></td>
			{{each foot.tds as td i}}
			<td class='listDataTrTd' style='display:{{td.display}};word-break: break-all;'>
				{{td.sumtotal}}
			</td>
			{{/each}}
		</tr>
		{{/if}}
	</tbody>
</table>
</script>
<!-- 
		{{if }}
		<tr>
			<td scope='col'></th>
			{{each foot.tds as td i}}
			<td scope='col'></th>
			{{/each}}
		</tr>
		{{/if}}
 -->
<script type="text/html" id="listViewFlowCol-tmpl">
<table style='width:100%;border:0;'>
	{{each instances as instance i}}
	<tr>
		<td style='line-height:16px;border-right-width:0;{{if i+1==instances.length}}border-bottom-width:0;{{/if}} border-right-style: none;'>
			{{each instance.nodes as node j}}
			{{node.stateLable}}
			{{/each}}
		</td>
	</tr>
	{{/each}}
</table>
</script>


<script type="text/html" id="listViewPrevAuditNode-tmpl">
<table style='width:100%;border:0;'>
	{{each instances as instance i}}
	<tr>
		<td title='{{instance.prevAuditNode}}' style='line-height:16px;border-right-width:0;{{if i+1==instances.length}}border-bottom-width:0;{{/if}} border-right-style: none;'>
		{{instance.prevNode}}
		</td>
	</tr>
	{{/each}}
</table>
</script>

<script type="text/html" id="listViewPrevAuditUser-tmpl">
<table style='width:100%;border:0;'>
	{{each instances as instance i}}
	<tr>
		<td title='{{instance.prevAuditUser}}' style='line-height:16px;border-right-width:0;{{if i+1==instances.length}}border-bottom-width:0;{{/if}} border-right-style: none;'>
		{{instance.prevUser}}
		</td>
	</tr>
	{{/each}}
</table>
</script>

