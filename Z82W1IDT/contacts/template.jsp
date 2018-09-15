<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/html" id="atp-contacts-select-item">
{{each list as val}}
<div class="select-item" data-id="{{val.id}}" data-dept="{{val.dept}}" data-email="{{val.email}}" data-mobile="{{val.mobile}}" data-mobile2="{{val.mobile2}}">
	<div class="select-face">
		{{if val.avatar == ""}}
			<div class="noAvatar">{{val.name.length <= 2 ? val.name : (val.name ? val.name.substring(val.name.length - 2) : val.name)}}</div>
		{{else}}
			<img class="avatar" src="{{val.avatar}}">
		{{/if}}
    	<i class="fa fa-minus-square"></i>
    </div>
    <div class="select-name">{{val.name}}</div>
</div>
{{/each}}
</script>
<script type="text/html" id="atp-contacts-list-item">
{{each list as value r}}
{{if value.type == 1}}
<div class="weui_cell">
	{{if select}}
	<label class="weui_check_label" for="item-{{value.id}}" data-id="{{value.id}}" data-name="{{value.name}}" data-avatar="{{value.avatar}}" >
		<div class="weui_cell_hd">
	    	<input type="{{inputType}}" class="weui_check" name="_select" data-id="{{value.id}}" id="item-{{value.id}}" data-name="{{value.name}}" data-dept="{{value.dept}}" data-mobile="{{value.mobile}}" data-mobile2="{{value.mobile2}}" data-email="{{value.email}}" data-avatar="{{value.avatar}}">
	        <i class="weui_icon_checked"></i>
	    </div>
    </label>
	{{/if}}
    <div class="weui_cell_bd weui_cell_primary">
    	<a class="weui_cell" data-id="{{value.id}}" data-type="{{value.type}}" data-name="{{value.name}}" data-dept="{{value.dept}}" data-mobile="{{value.mobile}}" data-mobile2="{{value.mobile2}}" data-email="{{value.email}}" data-avatar="{{value.avatar}}" data-href="#/show/:{{value.id}}/:{{showtype}}-{{value.type}}">
			<div class="weui_cell_hd">
			{{if value.avatar == ""}}
				<div class="noAvatar">{{value.name.length <= 2 ? value.name : value.name.substring(value.name.length - 2)}}</div>
			{{else}}
				<img class="avatar" src="{{value.avatar}}">
			{{/if}}
			</div>
		    <div class="weui_cell_primary">
		    	<p>{{value.name}}</p>
		        <p style="color:#A5A5A5;">{{value.mobile}}</p>
		    </div>
			{{if !select}}
			<div class="weui_cell_ft"></div>
			{{/if}}
		</a>
    </div>
</div>
{{else}}
<div class="weui_cell">
	{{if select}}
	<label class="weui_check_label"></label>
	{{/if}}
    <div class="weui_cell_bd weui_cell_primary">
        <a class="weui_cell" data-id="{{value.id}}" data-type="{{value.type}}" data-name="{{value.name}}" data-dept="{{value.dept}}" data-mobile="{{value.mobile}}" data-mobile2="{{value.mobile2}}" data-email="{{value.email}}" data-avatar="{{value.avatar}}"  data-href="#/list/:{{value.id}}/:{{showtype}}-{{value.type}}">
		    <div class="weui_cell_hd"><i class="fa fa-folder"></i></div>
		    <div class="weui_cell_primary">
		        <p>{{value.name}}</p>
		    </div>
		    <div class="weui_cell_ft">{{!userCounts || userCounts[r] == 0 ? "" : userCounts[r]}}</div>
		</a>
    </div>
</div>
{{/if}}
{{/each}}
{{if showtype == "all" && pageCount && pageCount > 1}}
<div id="pagination" class="weui-flex text-center" data-page="{{pageNo}}" data-pageCount="{{pageCount}}" data-type="{{showtype}}">
	<div class="weui-flex__item"><a class="pre-page {{if pageNo-1 <= 0}}inactive{{/if}}" node-type="pre-page">上一页</a></div>
	<div class="weui-flex__item"><a class="next-page {{if pageNo+1 > pageCount}}inactive{{/if}}" node-type="next-page">下一页</a></div>
</div>
{{/if}}
</script>
<script type="text/html" id="atp-contacts-list-item-all">
<div class="weui_cell select-all">
	{{if select && multiple}}
	<label class="weui_check_label" for="all">
		<div class="weui_cell_hd">
	    	<input type="{{inputType}}" class="weui_check" name="all" id="all">
	        <i class="weui_icon_checked"></i>
		</div>
    </label>
	{{/if}}
    <div class="weui_cell_bd weui_cell_primary breadcrumb">
		<div class="weui_cell" >
			{{each list as breadcrumbMain}}
			<a class="breadcrumb-item" data-showtype="{{breadcrumbMain.type}}"><span>{{breadcrumbMain.name}}</span></a> 
			{{/each}}
			<i class="fa fa-angle-double-right"></i>
			{{each current as breadcrumbItem}}
			<a><span>{{breadcrumbItem.name}}</span></a> 
			{{/each}}
		</div>
	</div>
</div>
</script>
<script type="text/html" id="atp-contacts-show">
<div class="weui_cells" data-userid="{{id}}">
	<div class="contacts-show-avatar text-center">
		{{if avatar != ""}}
		<img class="blur" src="{{avatar}}">
		<div class="avatar-panel">
			<img class="avatar" src="{{avatar}}">
	   		<div class="avatar-name">{{name}}</div>
		</div>
		{{else}}
		<img class="blur" src="data:image/png;base64,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">
		<div class="avatar-panel">
			<div class="noAvatar">{{name.length <= 2 ? name : name.substring(name.length - 2)}}</div>
	   		<div class="avatar-name">{{name}}</div>
		</div>
		{{/if}}
		<div class="favorite" data-isFavorite="{{isFavorite ? "1" : "2"}}">
			{{if isFavorite}}
 			<i class="fa fa-star"></i>
			{{else}}
 			<i class="fa fa-star-o"></i>
			{{/if}}
		</div>
	</div>
</div>
<div class="weui_cells">
	{{if mobile!=""}}
  	<div class="weui_cell contacts-show-mobile">
		<div class="mobileCon">
        	<p class="contacts-show-item">手机<span class="contacts-show-txt">{{mobile}}</span></p>
			<div class="handle">
				<a class="tel"  data-mobile="{{mobile}}"><img alt="" src="./images/tel.png"/></a>
				<a class="sms" href="sms:{{mobile}}"><img alt="" src="./images/sms.png"/></a>
			</div>
		</div>
    </div>
	{{/if}}
	{{if mobile2!=""}}
	<div class="weui_cell contacts-show-mobile2">
		<div class="mobileCon">
        	<p class="contacts-show-item">手机<span class="contacts-show-txt">{{mobile2}}</span></p>
			<div class="handle">
				<a class="tel"  data-mobile="{{mobile2}}"><img alt="" src="./images/tel.png"/></a>
				<a class="sms" href="sms:{{mobile2}}"><img alt="" src="./images/sms.png"/></a>
			</div>
		</div>
    </div>
	{{/if}}
	{{if email!=""}}
    <div class="weui_cell contacts-show-email">
        <a href="mailto:{{email}}">
			<p class="contacts-show-item">邮箱<span class="contacts-show-txt">{{email}}</span></p>
			<img alt="" src="./images/email.png"/>
		</a>
    </div>
	{{/if}}
</div>
<div class="weui_cells_title"></div>
<div class="weui_cells">
    <div class="weui_cell contacts-show-dept">
     	<p class="contacts-show-item">部门<span class="contacts-show-txt">{{dept}}</span></p>
    </div>
</div>
</script>
<script type="text/html" id="tpl_contacts_main">
<div class="bd" style="height: 100%;">
    <div class="weui_tab">
		<div class="weui_search_bar" id="search_bar">
		        <form class="weui_search_outer">
		            <div class="weui_search_inner">
		                <i class="weui_icon_search"></i>
		                <input type="search" class="weui_search_input" id="search_input" placeholder="请输入姓名或首字母、电话" required/>
		                <a href="javascript:" class="weui_icon_clear" id="search_clear"></a>
		            </div>
		            <label for="search_input" class="weui_search_text" id="search_text">
		                <i class="weui_icon_search"></i>
		                <span>搜索</span>
		            </label>
		        </form>
				<div class="contacts-search-index"><i class="fa fa-sort-alpha-asc"></i></div>
		        <a href="javascript:" class="weui_search_cancel" id="search_cancel">取消</a>
    		</div>
			<div class="contacts-search-index-panel" style="display:none;">
	    		<div class="contacts-search-index-item text-center">A</div>
				<div class="contacts-search-index-item text-center">B</div>
				<div class="contacts-search-index-item text-center">C</div>
				<div class="contacts-search-index-item text-center">D</div>
				<div class="contacts-search-index-item text-center">E</div>
				<div class="contacts-search-index-item text-center">F</div>
				<div class="contacts-search-index-item text-center">G</div>
				<div class="contacts-search-index-item text-center">H</div>
				<div class="contacts-search-index-item text-center">I</div>
				<div class="contacts-search-index-item text-center">J</div>
				<div class="contacts-search-index-item text-center">K</div>
				<div class="contacts-search-index-item text-center">L</div>
				<div class="contacts-search-index-item text-center">M</div>
				<div class="contacts-search-index-item text-center">N</div>
				<div class="contacts-search-index-item text-center">O</div>
				<div class="contacts-search-index-item text-center">P</div>
				<div class="contacts-search-index-item text-center">Q</div>
				<div class="contacts-search-index-item text-center">R</div>
				<div class="contacts-search-index-item text-center">S</div>
				<div class="contacts-search-index-item text-center">T</div>
				<div class="contacts-search-index-item text-center">U</div>
				<div class="contacts-search-index-item text-center">V</div>
				<div class="contacts-search-index-item text-center">W</div>
				<div class="contacts-search-index-item text-center">X</div>
				<div class="contacts-search-index-item text-center">Y</div>
				<div class="contacts-search-index-item text-center">Z</div>
    		</div>
        <div class="weui_navbar" {{if tabLength <=1}} style="display:none;" {{/if}}>
            <div class="weui_navbar_item" data-showtype="all" {{if !all}} style="display:none;" {{/if}} >
                <i class="fa fa-list-ul fa-c9989b8"></i> 
                <div>全部</div>
            </div>
            <div class="weui_navbar_item" data-showtype="dept" {{if !dept}} style="display:none;" {{/if}} >
                <i class="fa fa-users fa-cfe943c"></i>
                <div>部门</div>
            </div>
            <div class="weui_navbar_item" data-showtype="role" {{if !role}} style="display:none;" {{/if}} >
                <i class="fa fa-user fa-c76c06b"></i>
                <div>职务</div>
            </div>
            <div class="weui_navbar_item" data-showtype="favorite" {{if !favorite}} style="display:none;" {{/if}} >
                <i class="fa fa-star fa-cf6bf27"></i>
                <div>常用</div>
            </div>
        </div>

        <div class="weui_tab_bd contacts-list" {{if tabLength <=1}} style="padding-top: 0px;" {{/if}}>
			
		    <div class="contacts-search-show">
				<div class="weui_cells weui_cells_access weui_cells_checkbox"></div>
			</div>
        </div>
    </div>
</div>
</script>	
<script type="text/html" id="tpl_contacts_list">
	<div class="weui_cells weui_cells_checkbox weui_cells_access"></div>
</script>
<script type="text/html" id="tpl_contacts_show"></script>