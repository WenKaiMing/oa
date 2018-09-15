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
