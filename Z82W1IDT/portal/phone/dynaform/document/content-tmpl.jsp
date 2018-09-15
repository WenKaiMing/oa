<%@ page language="java" contentType="text/html; charset=UTF-8" errorPage="/portal/share/error.jsp"%>
<script type="text/html" id="input-tmpl">
{{if isHide}}
<input type='hidden' name='{{name}}' id='{{id}}' value='{{value}}' isRefreshOnChanged='{{isRefreshOnChanged}}' />
{{if hiddenValue!=''}}
<div class='flexbox'>{{hiddenValue}}</div>
{{/if}}
{{/if}}
{{if !isHide}}
<div class='formfield-wrap {{horizontalClass}}'>
	<label class='field-title contact-name flexlable' for='{{name}}'>{{discript}}</label>
	<div class="flexright">
	{{if showTel}}
	<table width='100%'>
		<tr>
			<td width='95%'>
	{{/if}}
	
	<input class='contactField requiredField {{cssClass}}' placeholder='{{placeholderTip}}' type='{{type}}' id='{{id}}' name='{{name}}' value='{{value}}' data-enhance='false'
	 style='{{style}}' {{readonly}} isRefreshOnChanged='{{isRefreshOnChanged}}' discript='{{discript}}'
 	/>
 	{{if isReadOnlyShowValOnly}}
 	<div id='{{name}}_show' class='showItem'>{{value}}</div>
 	{{/if}}
	{{if showTel}}
			</td>
			<td width='5%'>
				<a href='tel:{{value}}'>
					<span style='width:32px; height:32px; margin:5px; display:block;background:url(../../phone/resource/main/images/tel.png) no-repeat;  background-size:32px 32px;'></span>
				</a>
			</td>
		</tr>
	</table>
	{{/if}}
	</div>
</div>
{{/if}}
</script>

<script type="text/html" id="textarea-tmpl">
{{if isHide}}
<textarea style='display:none' name='{{name}}'>{{value}}</textarea>
{{if hiddenValue!=''}}
<div class='flexbox'>{{hiddenValue}}</div>
{{/if}}
{{/if}}
{{if !isHide}}
<div class='formfield-wrap {{horizontalClass}}'>
	<label class='field-title contact-name flexlable' for='{{name}}'>{{discript}}</label>
	<div class="flexright">
	<textarea rows='5' class='contactField requiredField {{cssClass}}' id='{{id}}' name='{{name}}' discript='{{discript}}' style='{{style}}' {{readonly}} data-enhance='false'  placeholder='{{placeholderTip}}'>{{value}}</textarea>
	{{if isReadOnlyShowValOnly}}
 	<div id='{{name}}_show' class='showItem'>{{if value==""}}&nbsp;{{else}}{{value}}{{/if}}</div>
 	{{/if}}
	</div>
</div>
{{/if}}
</script>

<script type="text/html" id="radio-tmpl">
<div class='formfield-wrap {{horizontalClass}}' style='{{style}}'>
	<label class='field-title contact-name flexlable' for='{{name}}'>{{discript}}</label>
	<div class="flexright">
	<div class='radio-box contactField requiredField'>
	{{each list as radio}}
		<div class='radio-list'>
			<input data-enhance='false' type='radio' id='{{name}}{{radio.i}}' value='{{radio.value}}' name='{{name}}' discript='{{discript}}' class='{{cssClass}}'
				 style='{{style}}' {{isRefresh}} {{readonly}} {{radio.checked}} />
			<label style='display:inline' for='{{name}}{{radio.i}}' style='{{style}}'>{{radio.text}}</label>
		</div>
	{{/each}}
	</div>
	</div>
</div>
{{if hiddenValue!=''}}
<div class='flexbox'>{{hiddenValue}}</div>
{{/if}}
</script>

<script type="text/html" id="checkbox-tmpl">
<div class='formfield-wrap {{horizontalClass}}' style='{{style}}'>
	<label class='field-title contact-name flexlable' for='{{name}}'>{{discript}}</label>
	<div class="flexright">
	<div class='radio-box contactField requiredField'>
	{{each list as checkbox}}
		<div class='radio-list'>
			<input data-enhance='false' type='checkbox' id='{{name}}{{checkbox.i}}' value='{{checkbox.value}}' name='{{name}}' discript='{{discript}}'
				text='{{checkbox.text}}' {{readonly}} {{isRefresh}} style='{{style}}' {{checkbox.checked}} />
			<label style='display:inline;{{style}}' for='{{name}}{{checkbox.i}}'>{{checkbox.text}}</label>
		</div>
	{{/each}}
	</div>
	</div>
</div>
{{if hiddenValue!=''}}
<div class='flexbox'>{{hiddenValue}}</div>
{{/if}}
</script>

<script type="text/html" id="select-tmpl">
<div class='formfield-wrap {{horizontalClass}}' style='{{hideText}}'>
	<label class='field-title contact-name flexlable' for='{{name}}'>{{discript}}</label>
	<div class="flexright">
	<div class='select-box' style='position: relative;{{style}}'>
		<select class='contactField requiredField' id='{{id}}' data-enhance='false' name='{{name}}' fieldType='{{fieldType}}' discript='{{discript}}'
			style='{{style}}' {{readonly}}>
			{{each list as opt}}
			<option value='{{opt.val}}' class='{{opt.cssClass}}' {{opt.selected}}>{{opt.text}}</option>
			{{/each}}
		</select>
		<i class='icon icon-down' style='position: absolute;right: 5px;font-size: 12px;'></i>
	</div>
	{{if isReadOnlyShowValOnly}}
	<div id='{{name}}_show' class='showItem'>{{selectedText}}</div>
	{{/if}}
	</div>
</div>
{{if hiddenValue!=''}}
<div class='flexbox'>{{hiddenValue}}</div>
{{/if}}
</script>

<script type="text/html" id="date-tmpl">
<div class='formfield-wrap {{horizontalClass}}' style='{{hideText}}'>
	<label class='field-title contact-name flexlable' for='{{name}}'>{{discript}}</label>
	<div class="flexright">
	<input class='contactField requiredField Wdate' type='text' id='{{id}}' name='{{name}}' value='{{value}}' limit='{{limit}}' style='{{style}}' discript='{{discript}}'
		fieldType='{{fieldType}}' class='{{cssclass}}' dateFmt='{{dateFmt}}' min_name='{{minName}}' {{isRefresh}} {{otherAttrsHtml}} {{readonly}} />
	{{if isReadOnlyShowValOnly}}
	<div id='{{name}}_show' class='showItem'>{{value}}</div>
	{{/if}}
	</div>
</div>
{{if hiddenValue!=''}}
<div class='flexbox'>{{hiddenValue}}</div>
{{/if}}
</script>

<script type="text/html" id="depart-tmpl">
<div class='formfield-wrap {{horizontalClass}}' style='{{hideText}}'>
	<label class='field-title contact-name flexlable' for='{{name}}'>{{discript}}</label>
	<div class="flexright">
	<div class='select-box' style='{{style}}'>
		<select class='contactField requiredField {{cssclass}}' id='{{id}}' data-enhance='false' name='{{name}}' fieldType='{{fieldType}}'
			style='{{style}}' {{readonly}} {{isRefresh}} {{otherAttrsHtml}} discript='{{discript}}'>
			{{each list as opt}}
			<option value='{{opt.val}}' class='{{opt.cssClass}}' {{opt.selected}}>{{opt.text}}</option>
			{{/each}}
		</select>
		<i class='icon icon-down'></i>
	</div>
	{{if isReadOnlyShowValOnly}}
	<div id='{{name}}_show' class='showItem'>{{selectedText}}</div>
	{{/if}}
	</div>
</div>
{{if hiddenValue!=''}}
<div class='flexbox'>{{hiddenValue}}</div>
{{/if}}
</script>

<script type="text/html" id="treeDepart-tmpl">
<div class='formfield-wrap {{horizontalClass}}' style='{{hideText}}'>
	<label class='field-title contact-name flexlable' for='{{name}}'>{{discript}}</label>
	<div class="flexright">
	<div style='position: relative;{{style}}'>
		<input class='contactField requiredField {{cssClass}}' data-enhance='false' type='text' readonly id='{{textFieldId}}' fieldType='{{fieldType}}'
			value='{{fieldText}}' {{otherAttrsHtml}} style='{{style}}'/>
		<input type='hidden' id='{{valueFieldId}}' name='{{name}}' discript='{{discript}}' fieldType='{{fieldType}}' value='{{fieldValue}}' />
		{{if !isHide}}
		<span data-enhance='false' class='tree-department' title='{{treeTip}}'></span>
		{{/if}}
	</div>
	{{if isReadOnlyShowValOnly}}
	<div id='{{name}}_show' class='showItem'>{{fieldText}}</div>
	{{/if}}
	</div>
</div>
{{if hiddenValue!=''}}
<div class='flexbox'>{{hiddenValue}}</div>
{{/if}}
</script>

<script type="text/html" id="user-tmpl">
<div class='formfield-wrap {{horizontalClass}}' style='{{hideText}}'>
	<label class='field-title contact-name flexlable' for='{{name}}'>{{discript}}</label>
	<div class="flexright">
	<div class='userSelectBox' style='{{style}}'>
		<input type='hidden' id='{{id}}' name='{{name}}' discript='{{discript}}' value='{{idValues}}' fieldType='{{fieldType}}' />
		<input class='contactField requiredField userField {{cssClass}}' data-enhance='false' type='text' id='{{id}}_text' name='{{name}}_text'
			value='{{value}}' title='{{title}}' _id='{{id}}' _subGridView='{{subGridView}}' {{readonly}} {{isRefresh}} {{otherAttrsHtml}} />
		<span class='selectBtn select icon icon-person' title='选择'></span>
		<span class='selectBtn clear icon icon-trash' title='清除'></span>
	</div>
	{{if isReadOnlyShowValOnly}}
	<div id='{{name}}_show' class='showItem'>{{value}}</div>
	{{/if}}
	</div>
</div>
{{if hiddenValue!=''}}
<div class='flexbox'>{{hiddenValue}}</div>
{{/if}}
</script>

<script type="text/html" id="suggest-tmpl">
<div class='formfield-wrap  {{horizontalClass}}' style='{{hideText}}'>
	<label class='field-title contact-name  flexlable' for='{{name}}'>{{discript}}</label>
	<div class="flexright">
	<input type='text' class='contactField form-control' GridType='suggestField' value='{{text}}' id='{{id}}_show' name='{{name}}_show'
		fieldType='{{fieldType}}' autocomplete='off' {{readonly}} {{isRefresh}} {{otherAttrsHtml}} style='{{style}}' />
	<input type='hidden' value='{{value}}' id='{{id}}' name='{{name}}' discript='{{discript}}' fieldType='{{fieldType}}' GridType='suggestField' resetable=true />
	{{if isReadOnlyShowValOnly}}
	<div id='{{name}}_show1' class='showItem'>{{text}}</div>
	{{/if}}
	</div>
</div>
{{if hiddenValue!=''}}
<div class='flexbox'>{{hiddenValue}}</div>
{{/if}}
</script>

<script type="text/html" id="button-tmpl">
<a class='{{activityType}} btn btn-block {{activityCss}}' data-transition='fade'>{{val}}</a>
</script>

<script type="text/html" id="viewDialog-tmpl">
<button style='color:#767673' class='btn btn-gray btn-block' type='button' title='{{value}}' name='{{name}}' {{readonly}} ><i class='icon iconfont'>&#xe617;</i> {{value}}</button>
</script>

<script type="text/html" id="tab-tmpl">
<div id='{{id}}' class='basictab' style='margin-bottom: 10px;border-bottom: 1px solid #CACACA;padding-bottom: 10px;overflow-x: auto;'>
	<table cellSpacing='0' cellPadding='0'><tr>
		{{each list as tit}}
		<td>
			<div id='li_{{tit.formId}}' style='{{tit.style}}'>
				<a class='btn btn-positive btn-outlined' style='margin-right:10px;cursor:pointer' id='{{tit.formId}}'
					 rel='content_{{tit.formId}}' title='{{tit.name}}' >{{tit.name}}</a>
			</div>
		</td>
		{{/each}}
	</tr></table>
</div>
</script>
<script type="text/html" id="tabCollapse-tmpl">
<div moduletype="TabNormal" tabid="">
	<div style="display" id="title" fieldid="{{fieldId}}">
		{{each list_title as title}}
		<div formid="{{title.formid}}" ishidden="{{title.ishidden}}" isrefreshonchanged="{{title.isrefreshonchanged}}" name="{{title.name}}"></div>
		{{/each}}
	</div>

	<div id="tabcontainer" class="tabcontainer">
		{{each list_content as content}}
		<div formid="{{content.formid}}" ishidden="{{content.ishidden}}">
		{{#content.content}}
		</div>
		{{/each}}
	</div>
</div>
</script>

<script type="text/html" id="included-tmpl">
	<a id='{{id}}' isRelate='{{isRelate}}' istab='{{istab}}'
	   getName='{{name}}' fixation='{{fixation}}' fixationHeight='{{fixationHeight}}' src='{{url}}' isRefreshOnChanged='{{isRefreshOnChanged}}'
	   name='display_view' type='includedView'>
		<div class="weui-cell__ad" title="{{name}}">{{name}}</div>
		<span class="weui-cell weui-cell_access">
			<div class="weui-cell__hd"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAMAAAEX2zkjAAAAAXNSR0IArs4c6QAAAdRQTFRFAAAAgP+AVf+qbdttYN+AVeNxTeZmVd1mUN9wVd9qUuBmTuJsS9xkTt1nTdllTNlkTtpmTdplTNlkS9llTdpkTdpjTthkTdllTNlkTNpkS9tlTdhkTdljS9hlTdlkTNljS9lkS9hjTdlkTNljS9llTNhkTNhjS9lkTNlkS9ljTNlkTNlkS9ljTNlkTNhjS9hkTNhjS9lkTNlkTNhjTNlkTNlkS9ljTNljS9lkS9ljTNhkS9hjTNhkTNlkS9ljS9hjTdhkTthmT9hmT9lnUdloUtlpU9lqVNprVdpsVtpsV9puW9txXNtyYNx1Yt13Y914Zd16Zt16Z957ad59at5+a99/bt+Bb9+CcOCDceCEc+CGduGIe+KMg+SThuSWh+WXi+Wai+abjeacleijl+ilmOimnOmpnuqrn+qsouquqOyzre24ru25r+25sO67s+69tO6+te+/t+/BufDDuvDDvvDGvvHHwfHJxfLMxvLOx/LOy/PSzvTUz/TV0vXY0/XZ1fXa1vbc1/bc2Pbd2fbe4Pjk4fjl4vjm4/nn5Pnn5Pno5/nq6frs6vrt6/rt7/vx8Pvy8vzz8/z09f339v339/34+P35+v77/P78/f79/v7+////Kt+wpgAAAD90Uk5TAAIDBwgJCg8QGBkaMzQ1SktMV1hZWlxdXmFiY2R3eHl6i4yNjqusrbO0tcfIydjZ2uPk5ejp6u/w8fP09fb3irOjBQAAAudJREFUSMeNVQlbEzEQHXoIFsp9KSAKclgrSJGKxTYICoKoaFVURFQUwfvGAzzwBg9EEWT+rNkku0m2KfC+r5vJvJnJzGZ2CgCQoD8gFqwF6XKQII5Zu/5prmQchGptS/68TjhFl5leRwtOOC5z6eM4Ia3QyGR6xBjldjAJiQzIUWF5tUiRIj/a7BNimBtlW3LcdskF8DPh9KISbNgK3sA3SX6StXkynSSzRGyuWYy9QZFNGYtw3KmhkCj1QIYiM/jbndy3S63MTqBEK0CDh+plEPIYv33AZSZmQZ7UD7L0fr7l57dJIkmJZ7gkEmtiy0Mc4YQD8PLXP0ofIwrRAVDFhE+IOK86UGxOzbZVFJijqyNK7ZBZx5WxMnDBV9uciIYK3OpqJ84Bv6IOaEfscfRFrpwSQh9MyZYzHsNbZ9EiiuL+0rsuJmyiBSh6xFd/cYjlBlAv9e+tO3qU2sEEJ0WfUxRoxAR93ONEyEUM/MELTI4KomcFGTE422WXIoy/2qEEmjlxFYmLqIWYtdzgxBVJ+KCUh3pKyAzqd87W87QX8JzUV1NiCxePdhNXk2hvUSAA6iSQKLav0OUTlJe+Ve0qj9YmpTGurs8EI7LK6jvUqB0N5VmQDp4KQ96swys9BvNgGmvhk+syLyLrokTt9AjZAFqzTS9pTVRy+21GsvPWP2T4Mkz0KVZqtB9FXLpM174HiHM9jrocwBsz2R9exSkhDiC+kPfigxrjAUl0+rdvxfGl2CnmWlqH/tuIC0cksdc9gU/efX5ROozTor9f0ifFPmXXNU0NfozqKemIij80Xt4yzh9LqUFHSJ3mk4hnhXgG8abRgY7JOmczhPi6k0ndbxBPmewbrNG7X+a0gLj48s7Ub8RfJ0z27ezj8LdIzaGJOcTVz+O9xnwiYjZn7N5Y74Xld5QTX988HtS+oMJ1XOLFKd9oYI3EwgHzGPBXtRveTLUf1oQ3r6axqS0eb2vaVZPvTaH/A1Om9EwUKb3jAAAAAElFTkSuQmCC" alt="" style="width:20px;margin-right:8px;display:block"></div>
			<div class="weui-cell__bd">明细</div>
			<div class="weui-cell__ft">
				<span class="weui-badge" style="margin-right: 4px;margin-top: -4px;">{{viewTotalNum}}条数据</span>
			</div>
		</span>
	</a>
</script>

<script type="text/html" id="survey-tmpl">
<div id="survyfield_container_{{id}}" class="survyfield_container">
	{{each list as ques}}
	<div class="question-content" id="question-content-{{ques.id}}">
		<div class="question-content-title"><b></b>{{ques.topic}}</div>
		<div class="question-content-answer">
			<table id="question-content-answer-{{ques.id}}" width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr id="question-{{ques.id}}-answerrow-{{i}}">
					<td style="min-height: 26px; padding-right: 10px;">
						{{each ques.subList as opt}}
						<{{opt.tagName}} id="question-{{ques.id}}-answer-{{opt.i}}" name="question-{{ques.id}}-answer" ordernumber="{{opt.i}}" 
							type="{{opt.type}}" value="" data-type="{{opt.type}}" data-custom="true"  data-text="{{opt.text}}" {{disabled}}>
						{{if opt.type=="textarea"}}
							{{opt.value}}
						</{{opt.tagName}}>
						{{/if}}
						<label for="question-{{ques.id}}-answer-{{opt.i}}">{{opt.text}}</label>
							{{if opt.type=="radio" && opt.custom}}
							<input id="question-{{ques.id}}-answer-value" name="question-{{ques.id}}-answer-value" type="text" value="" {{disabled}}>
							{{/if}}
						{{/each}}
			</table>
		</div>
	</div>
	{{/each}}
	<div class="space-content"></div>
</div>
</script>

<script type="text/html" id="takePhoto-tmpl">
<div class="formfield-wrap {{horizontalClass}}" style="{{hideStyle}}">
	<label class="field-title contact-name flexlable" for="{{name}}">{{discript}}</label>
	<div class="flexright">
	<a data-id="{{id}}" class="btn btn-gray btn-block btn-photo" style="{{btnHideStyle}}">
		<i class="icon iconfont {{disabledClazz}}">
			{{photoIcon}}
		</i>
	</a>
	<input type="hidden" id="{{id}}" name="{{name}}" discript='{{discript}}' fieldType="{{tagName}}" value="{{value}}" />
	<div class="btn-box-pic">
		<img id="{{id}}_img" src="{{contextPath}}{{value}}" style="{{style}}">
	</div>
	</div>
</div>
{{if hiddenValue!=''}}
<div class='flexbox'>{{hiddenValue}}</div>
{{/if}}
</script>

<script type="text/html" id="map-tmpl">
<input type='hidden' id='{{id}}' name='{{name}}' discript='{{discript}}' fieldType='{{fieldType}}' value='{{value}}' />
<label for='{{name}}'>{{discript}}</label>
{{if openType=='dialog'}}
<table style='width:100%;height:100%;margin:0px;'>
	<tr>
		<td style='border:0'>
			<input type='button' value='{{mapLabel}}' name='btnSelectDept' {{readonly}} />
		</td>
	</tr>
</table>
{{else}}
<iframe name='baidumap' id='baidumap' style='margin:0px;width:100%;height:{{iframeH}}px;' frameborder=0 
	src='{{srcEnvironment}}/portal/share/component/map/form/baiduMap.jsp?type={{openType}}&fieldID=&applicationid={{application}}&displayType={{displayType}}'>
</iframe>
{{/if}}
</script>

<script type="text/html" id="gps-tmpl">
<div class="formfield-wrap {{horizontalClass}}" style="{{style}}">
	<label class="field-title contact-name flexlable" for="{{name}}">{{discript}}</label>
	<div class="flexright">
	<ul class="table-view table-address">
		<li class="table-view-cell">
			<a class="navigate-right location" data-transition="slide-in">
				<span class="badge">
					{{if showLocation}}
					<p class="refresh">获取位置</p>
					{{/if}}
				</span>
				<div class="text">
					<i class="icon icon-add iconfont">&#xe613;</i>
					<p class="add address-text"> &nbsp;</p>
				</div>
			</a>
		</li>
	</ul>
	</div>
</div>
</script>

<script type="text/html" id="recordPanel-tmpl">
<div id="weixinRecord_container_{{id}}" class="formfield-wrap {{horizontalClass}}">
	<label class='field-title contact-name flexlable' for='{{name}}'>{{discript}}</label>
	<div class="flexright">
	<div>
		<div class="formfield-wrap record-panel" style="{{style}}">
			<div class="record-box">
				<a class="btn btn-block btn-record startRecord" >我要说话</a>
			</div>
		</div>
		<div class="formfield-wrap player-panel" style="{{playStyle}}margin-bottom:10px;">
			<div class="record-box">
				<a class="btn-sound-play">
					<div class="sound-play-arrow"></div>
					<div class="sound-play-box">
						<div class="play-ico sound-play-ico sound-stop"></div>
						<div class="sound-play-time">{{count}}</div>
					</div>
				</a>
				<a class="btn-sound-space"></a>
				<a class="btn-sound-delete" style="{{delStyle}}">
					<span class="icon icon-close"></span>
				</a>
				<div class="sound-delete-box">
					<div class="header">提示</div>
					<div class="contenter"><p>确认删除当前？</p></div>
					<div class="foot">
						<a class="btn pull-right  btn-link red btn-delete" data-ignore="push">删除</a>
						<a class="btn pull-right btn-link gay btn-cancel">取消</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	{{if hasValue}}
	<audio><source src="{{path}}" type="audio/mpeg" /></audio>
	{{/if}}
	</div>
</div>
</script>

<script type="text/html" id="recordControl-tmpl">
<div id='wxRec_{{id}}' class='bigrec-box' style='z-index: 9999;'>
	<div class="modal modal-iframe recording-panel">
		<div class="record-play-box">
			<div class="record-play-ico">
				<div class="sound-box"></div>
			</div>
			<div class="sound-text">
                <p style="color:red;font-size: 12px;margin: 6px 0">(60s后自动停止录音并上传)</p>
				<p>正在录音</p>
				<p class="time-total">0</p>
			</div>
			<div class="btn-record-stop text-center">
				<span class="icon icon-stop stopRecord"></span>
				<p>停止</p>
			</div>
		</div>
	</div>
</div>
</script>

<script type="text/html" id="qrcode-tmpl">
<div id="qrcode_container_{{id}}" class="formfield-wrap {{horizontalClass}}">
	<label class='field-title contact-name flexlable' for='{{name}}' style='display:block'>{{discript}}</label>
	<div class="qrcode_canvas flexright"></div>
</div>
</script>

<script type="text/html" id="wordOld-tmpl">
<label for='{{name}}'>{{discript}}</label>
{{if openInDiv}}
<input type='hidden' name='{{name}}' discript='{{discript}}' id='{{id}}' value='{{getItemValue}}' />
<input type='hidden' id='{{getId}}' value='{{secondvalue}}' />
<button class='button-class' type='button' {{readonly}}><img src='../../share/images/view/word.gif'></img></button>
{{else}}
<input type='hidden' name='{{name}}' id='{{getId}}' value='{{getItemValue}}' />
<iframe fieldName='{{name}}' id='{{getId}}' name='word' frameborder='0' width='100%' height='645px' scrolling='no' 
	style='overflow:visible;z-index:-1px;' type='word' src='{{url}}' ></iframe>
{{/if}}
</script>

<script type="text/html" id="html-tmpl">
<div class="formfield-wrap" style="{{style}}">
	{{if isReadonly}}
		<label for='{{name}}'>{{discript}}</label>
		<div class='html-edit' readonly='readonly' name='{{name}}' discript='{{discript}}' style='font-size:16px;'>{{#text}}</div>
	{{else}}
		<label class='field-title field-html contact-name' for='{{name}}'>{{discript}}</label>
		<div class='html-edit' id='{{id}}' name='{{name}}' discript='{{discript}}'>
			<iframe class="html-edit-panel" style="border: black thin;width:100%; height:200px;"></iframe>
		</div>
	{{/if}}
</div>
{{if hiddenValue!=''}}
<div class='flexbox'>{{hiddenValue}}</div>
{{/if}}
</script>

<script type="text/html" id="history-tmpl">
{{if show}}
<div style='list-style-type:none;margin-left: 3px;margin-right: 3px;margin-top: 3px;margin-bottom: 3px;' name='{{name}}' discript='{{discript}}'>
	<label class='field-title contact-name' for='{{name}}'>{{discript}}</label>
	{{if showDiagram}}
	<li>
		<img src='{{flowDiagram}}' style='width:100%' />
	</li>
	{{/if}}

	{{if showText}}
	<li>
		<table cellSpacing='0' cellPadding='1' name='{{name}}' discript='{{discript}}' width='100%' align='center' style='border:solid #cccccc;border-width:1px 0px 0px 1px;'>
			{{each trLists as tr}}
			{{if tr.i==0}}
			<thead>
				<tr style='line-height:22px;'>
					{{each tr.tdLists as td}}
					<th style='align:center;font-family: Arial;border:solid #cccccc;border-width:0px 1px 1px 0px;background-color:#EFF0F1;width:{{td.width}}' >{{#td.text}}</th>
					{{/each}}
				</tr>
			</thead>
			{{/if}}
			
			{{if tr.i==1}}
			<tbody>
			{{/if}}
				{{if tr.i!=0}}
				<tr style='line-height:22px;'>
					{{each tr.tdLists as td}}
					<td style='font-family: Arial;border:solid #cccccc;border-width:0px 1px 1px 0px;align:center;'>
						{{#td.text}}
						{{if td.isSign}}
						<a href='data:{{td.type}},{{td._data}}' target='_blank' title='查看大图' >
							<img height='32px' src='data:{{td.type}},{{td._data}}'>
						</a>
						{{/if}}
					</td>
					{{/each}}
				</tr>
				{{/if}}
			{{if tr.i==1}}
			</tbody>
			{{/if}}
			{{/each}}
		</table>
	</li>
	{{/if}}
</div>
{{/if}}
</script>

<script type="text/html" id="reminderHistory-tmpl">
<div id="flowReminderHistoryField_container_{{id}}" style="list-style-type:none;margin-left: 3px;margin-right: 3px;margin-top: 3px;margin-bottom: 3px;">
	<div class='field-title'>{{discript}}</div>
	<table cellSpacing='0' cellPadding='1' name='{{name}}' discript='{{discript}}' width='100%' align='center' style='border:solid #cccccc;border-width:1px 0px 0px 1px;'>
		{{each trLists as tr}}
		{{if tr.i==0}}
		<thead>
			<tr style='line-height:22px;'>
				{{each tr.tdLists as td}}
				<th style='align:center;font-family: Arial;border:solid #cccccc;border-width:0px 1px 1px 0px;background-color:#EFF0F1;width:{{td.width}}' >{{#td.text}}</th>
				{{/each}}
			</tr>
		</thead>
		{{/if}}
		
		{{if tr.i==1}}
		<tbody>
		{{/if}}
			{{if tr.i!=0}}
			<tr style='line-height:22px;'>
				{{each tr.tdLists as td}}
				<td style='font-family: Arial;border:solid #cccccc;border-width:0px 1px 1px 0px;align:center;'>
					{{#td.text}}
					{{if td.isSign}}
					<a href='data:{{td.type}},{{td._data}}' target='_blank' title='查看大图' >
						<img height='32px' src='data:{{td.type}},{{td._data}}'>
					</a>
					{{/if}}
				</td>
				{{/each}}
			</tr>
			{{/if}}
		{{if tr.i==1}}
		</tbody>
		{{/if}}
		{{/each}}
	</table>
</div>
</script>

<script type="text/html" id="imageUpload-tmpl">
<div id="weixinImageUpload_container_{{id}}" class="formfield-wrap {{horizontalClass}}">
	<label class="field-title contact-name flexlable" for="{{discription}}">{{discription}}</label>
	<input type="hidden" tagName="ImageUploadField" fieldType="ImageUploadField" name="{{name}}" discript='{{discript}}' value='{{value}}' id="{{id}}"/>
	<div class="flexright">
	<div class="smallpic image-list" style="margin-top:0px;">
		{{each list as img}}
		<a data-ignore="push" class="image-item" data-name="{{img.name}}" data-path="{{img.path}}" >
			<img src="{{contextPath + img.path}}"/>
		</a>
		{{/each}}
		{{if showBtn}}
		<a data-ignore="push" class="btn-upload"><span class="icon icon-plus"></span></a>
		{{/if}}
		<div style="clear:both;"></div>
	</div>
	</div>
</div>
</script>

<script type="text/html" id="imageUploadPrev-tmpl">
<div _pid="{{id}}" class="modal bigpic preview-panel">
	<div class="bigpicbox">
		<div class="content">
			<div class="lookImg">
				<img class="preview-item" src="" />
			</div>
		</div>
		<div class="bar bar-standard bar-footer">
			<a class="btn pull-left btn-close">退出预览</a>
				{{if !readonly}}
				{{if showBtn}}
				<a class="btn btn-negative pull-right btn-delete-popup" data-ignore="push">删除</a>
				{{/if}}
				{{/if}}
		</div>
	</div>
</div>
</script>

<script type="text/html" id="fileUpload-tmpl">
<input type='hidden' name='{{name}}' discript='{{discript}}' value='{{value}}' fieldType='{{tagName}}' id='{{id}}'/>
<div class='upload-box formfield-wrap {{horizontalClass}}'>
	<label class='field-title contact-name flexlable' for='{{name}}'>{{discript}}</label>
	<div class="flexright">
	<div class='filePanel'>
		<div id='{{uploadList}}' GridType='uploadFile'>
		</div>
		{{if !(readonly && readOnlyShowValOnly)}}
		<div class='fileBtn btnAdd'><image src='./resource/component/upload/images/addTo.png'/>{{uploadLabel}}</div>
		{{/if}}
	</div>
	</div>
</div>
</script>

<script type="text/html" id="fileUploadCon-tmpl">
<div class="hidepic" id="{{uploadListId}}showFileDiv">
	{{each files as file}}
	<span class="fileRow" isPreView="{{file.isPreView}}" data-id="{{file._id}}" data-webPath="{{file.webPath}}" 
		data-showName="{{file.showName}}" data-realName="{{file.realName}}" data-url="{{file.url}}" 
		data-extname="{{file.fileType}}" data-url="{{file.url}}" data-extname="{{file.fileType}}">
		<a class="pic {{file.imgCss}}"></a>
		<a class="fileTitle" type="show" style="cursor:pointer;">{{file.title}}</a>
		<a class="extname" >{{file.fileType}}</a>
		{{if !readonly}}
		<a class="del">x</a>
		{{/if}}
	</span>
	{{/each}}
</div>
</script>

<script type="text/html" id="atp-flowpanel-committo">
<input id='_currentNodeId' name='_currentNodeId' type='hidden' value='{{currentNodeId}}'>
<input id='splitToken' name='splitToken' type='hidden' value='{{splitToken}}' />
<input id='isToPerson' name='isToPerson' type='hidden'  value='{{isToPerson}}' />
{{each nodeSelectList as value}}
<div class="weui-cells weui-cells_checkbox flow-submit__nextNode" style="margin-top:-1px" data-Id="{{value.id}}">
	<label class="weui-cell  weui-check__label" for="next_{{value.nextNodeId}}">
		<div class="weui-cell__hd">
	      	<input {{if value.nextNodeType == "checkbox"}}type="checkbox"{{else}}type="radio"{{/if}} class="weui-check" name="_nextids" id="next_{{value.nextNodeId}}" value="{{value.nextNodeId}}" {{if value.checked == "checked"}}checked{{/if}} islock="{{value.lock}}">
	        <i class="weui-icon-checked"></i>
	    </div>
	    <div class="weui-cell__bd">{{value.nextNodeName}}</div>
	</label>
	{{if value.nodeToPerson == "true"}}
	<div class="weui-cell">
		<div class="flow-submit__user-panel">
			<div class="flow-submit__user-select-box">
	      		<div name="{{value.nextNodeName}}" class="flow-submit__user-avatar approver flow-submit__user-select"></div>
	    	</div>
		</div>
	</div>
	{{/if}}
	<input id="isToPerson_{{value.nextNodeId}}" name="isToPerson_{{value.nextNodeId}}" type="hidden" value="true" />
	<input id="{{value.id}}" name="{{value.id}}" type="hidden" readonly="true" />
	<input id="{{value.id}}_text" name="{{value.id}}_text" type="hidden" class="flowToPerson-Input" readonly="true" 
		nextNodeId="{{value.nextNodeId}}" docid="{{value.docId}}" flowid="{{value.flowId}}" value="{{value.value}}"/>
	<input id="{{value.hiddenIds}}" name="{{value.hiddenIds}}" type="hidden" value=""/>	
</div>
{{/each}}

{{if nodeCopyList.length > 0}}
<div class="weui-cells__title">抄送给</div>
{{each nodeCopyList as value}}
<div class="weui-cells weui-cells_checkbox flow-submit__copyTo" data-Id="{{value.id}}">	
	<div class="weui-cell">
		<div class="flow-submit__user-panel">        
			<div class="flow-submit__user-select-box">
	      		<div name="copyto_user_select" class="flow-submit__user-avatar flow-submit__user-select"></div>
	    	</div>
		</div>
	</div>
	<input id='_circulator' _id='_circulator' name='_circulator' class='copyToPerson-Input' 
		nextNodeId='{{value.nextNodeId}}' docid='{{value.docId}}' flowid='{{value.flowId}}' readonly='true' 
		type='hidden' size='10' />
	<input id='_circulator_text' _id='_circulator_text' name='_circulator_text' type="hidden"/>
</div>
{{/each}}
{{/if}}
</script>

<script type="text/html" id="atp-flowpanel-selectUser">
{{each data as value}}
<div class="flow-submit__user" data-id="{{value.value}}" data-name="{{value.text}}" data-input="{{inputID}}">
	<div name="{{value.text}}" class="flow-submit__user-avatar" style="background: #A2A2A2;">
		{{if value.avatar && value.avatar !=""}}
		<img class="avatar" src="{{value.avatar}}">
		{{else}}
		<div class="noAvatar">{{value.text.substr(0,2)}}</div>
		{{/if}}
		<i class="fa fa-minus-square"></i>
	</div>
	<div class="flow-submit__user-name">{{value.text}}</div>
</div>        		
{{/each}}
</script>

<script type="text/html" id="atp-flowpanel-commonOpitions">
{{each data as value}}
<div class="weui-cell weui-cell_access flow-submit__proposal_0left">
	<div class="weui-cell__bd">{{value.content}}</div>
</div>    		
{{/each}}
</script>