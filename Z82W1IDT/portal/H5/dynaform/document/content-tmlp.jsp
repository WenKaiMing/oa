<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8" errorPage="/portal/share/error.jsp"%>

<script type="text/html" id="commonOpitionsNew-tmpl">
			<li>
				<a class="text" id="{{id}}" title="{{content}}">{{content}}</a>
				<i class="fa fa-check" aria-hidden="true"></i>
				<a class="editSub" style="display: {{showVal}};">编辑</a>
				<a class="del" style="display: {{showVal}};">删除</a>
			</li>
</script>
<script type="text/html" id="commonOpitions-tmpl">
<section id="commonOpinions" class="commonOpinions" style="display:none;">
	<ul>
		{{each list as opt}}
		<li>
			<a class="text" id="{{opt.id}}" title="{{opt.content}}">{{opt.content}}</a>
			<a class="editSub" style="display: none;">编辑</a>
			<a class="del" style="display: none;">删除</a>
		</li>
		{{/each}}
		<div class="edit" style="display:none;">
			<input type="text" name="options"/>
			<span class="save">保存</span>
			<span class="cancel">取消</span>
		</div>
		<div class="addBtn">
			<i class="fa" aria-hidden="true"></i>
			<span>添加常用意见</span>
		</div>
		<div class="editBtn">
			<i class="fa" aria-hidden="true"></i>
			<span>编辑意见</span>
		</div>
	</ul>
</section>
</script>
<script type="text/html" id="fileUpload-tmpl">
<div class="item">
	{{if supportSorting}}
		<div class="sort">
		{{if firstUp}}
			<a class="firstUp"></a>
		{{else}}
			<a class="up" title="向上移"></a>
		{{/if}}
		{{if lastDown}}
			<a class="lastDown"></a>
		{{else}}
			<a class="down" title="向下移"></a>
		{{/if}}
		</div>
	{{/if}}
	<a class="fieldName" type="show" isPreView="{{isPreView}}" data-id="{{_id}}" data-webPath="{{webPath}}" data-showName="{{showName}}" data-realName="{{realName}}" data-url="{{url}}" data-extname="{{extname}}">
	 	<span class="pic {{imgCss}}"></span>
	 	<span class="fieldTitle">{{title}}</span>
	</a>
	<div class="operate">
		<a class="fieldSize" style="display:none;"></a>
		<a class="fieldload" style="cursor:pointer;"><i class="icon icon-load"></i>下载</a>
		{{if !readonly}}
		<div class="deleteCon">
			<a class="first_delete" style="cursor:pointer;"><i class="icon icon-del"></i>删除</a>
			<div class="sub_deleteBox hide">
				<div class="sub_deleteContent">
					<p>确定删除附件？</p>
					<div class="sub_operate">
						<a class="sub_cancel">取消</a>
						<a class="del">确认</a>
					</div>
					<span class="arrowBox arrowBottom"><span class="arrow"></span></span>
				</div>
			</div>
		</div>
		{{/if}}
	</div>
	<a class="showOperate" title="操作"><span class="img"></span></a>
</div>
</script>