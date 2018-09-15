<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/html" id="atp-home">
<div class="page my">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-tab">
            <div class="weui-tab__panel">
            	<div class="weui-search-bar" id="searchBar">
		            <form class="weui-search-bar__form">
		                <div class="weui-search-bar__box">
		                    <i class="weui-icon-search"></i>
		                    <input type="search" class="weui-search-bar__input" id="searchInput" placeholder="搜索" required/>
		                    <a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
		                </div>
		                <label class="weui-search-bar__label" id="searchText">
		                    <i class="weui-icon-search"></i>
		                    <span>搜索</span>
		                </label>
		            </form>
		            <a href="javascript:" class="weui-search-bar__cancel-btn" id="searchCancel">
		            取消</a>
		        </div>
		        <div class="weui-flex text-center my-bar">
		        	<div class="weui-flex__item my-bar__item" data-type="createFolder">+ 新建文件夹</div>
		        	<div class="weui-flex__item my-bar__item" data-type="uploadFile">+ 上传文档</div>
				</div>
		        <div class="weui-cells searchbar-result" id="searchResult" style="display:none;"></div>
		        <div class="weui-cells km-list"></div>
			</div>
            <div class="weui-tabbar">
                <a data-type="my" class="weui-tabbar__item weui-bar__item_on">
                    <span class="weui-tabbar__icon weui-tabbar__my"></span>
                    <p class="weui-tabbar__label">网盘</p>
                </a>
                <a data-type="share" class="weui-tabbar__item">
                    <span class="weui-tabbar__icon weui-tabbar__share"></span>
                    <p class="weui-tabbar__label">分享</p>
                </a>
                <a data-type="public" class="weui-tabbar__item">
                    <span class="weui-tabbar__icon weui-tabbar__public"></span>
                    <p class="weui-tabbar__label">公共</p>
                </a>
                <a data-type="upload" class="weui-tabbar__item">
                	<span class="badge" style="display:none"></span>
                    <span class="weui-tabbar__icon weui-tabbar__upload"></span>
                    <p class="weui-tabbar__label">传输</p>
                </a>
            </div>
        </div>
    </div>
</div>
</script>

<script type="text/html" id="atp-list-item">
{{each datas as value}}
<div class="weui-cell weui-cell_access">
    <div class="weui-cell__bd weui-cell_primary">
		<div class="my-list__item weui-flex">
			<i class="icon-file icon-file-{{if value.fileType=="1" && !value.extendName}}folder{{else}}{{value.extendNameChecked}}{{/if}}"></i>
			<div class="content-box weui-flex__item" style="overflow: hidden;margin-top: -10px;margin-bottom: -10px;">
				<div class="my-list__text" data-id="{{value.id}}" data-fileType="{{value.fileType}}" style="padding: 10px 0px;">
					<h3>{{value.name}}</h3>
					<div class="content__time">{{value.createDate}}</div>
				</div>
				<div class="my-list__operate text-center">
					<div class="weui-flex file-operate" data-id="{{value.id}}" data-fileType="{{value.fileType}}">
						<div class="weui-flex__item" data-active="delete"><div><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAIRSURBVEhL7VW/TxRBGL1We7QzgUQisRICKFpI/FEJoaCwMqGx4XZ2b3dmYW9ms4V/go2JSgGERgsSS3obbQiG8BdQUViIngHB9y3f7A7cXXIeW/qSl9n57n3vzczdzda6QcTpE1+ZHaHMz270pT4UUu9BN8ttvYMbT3vkNrf1Dqxwn5rrkR7kUhu8uHmXNEKaL1zqDj/SD7Hl10Ss/i0aW3mzMm9g8KoTfaXXSONLc2B7c0bpJNuegQoQHufiKij1LyzsGdsjQJmPbaJLU39l+zygg6BvntCIY/7D9nnArIj1Arb1wwpxxusY39k5eIKzXsG4mT8XOv0e2g1n/htHFOJ5ju3PIJLkev4hCxtxcyJYzobsnBjE5raIzHO3Rr8yX6b3nFqLvNi2hKfSaUd0GkTNGbGkH7g1odJHgdSLbi2Q6X2Mc06t5cdmhG1LiKXsBrZ2aIWVBwSqOYojOrLC6gMgpG/eCisPoC/qfwCz/wCYP8Z7on6+VmEA3bi97ID+kGxboi0Aq+VbtjATUTqG6+LFhdq4J/XTYo6fuheaO2xbwov1lBtALxPcTTftnFgPk1tY3bxbC8PlYfviIVIAhbJtiYs7wPMHvtwKM7rUELrl1qBZxVhc9xwwxrYlaHVF0yVJO2fbEo1G4wrSv3Vq+BfCY/dlll1l2/PwkmQAF94nHMX3vqj05yjKrrEdUKv9BYDA0ub8ZJuoAAAAAElFTkSuQmCC" alt="" class="weui-tabbar__icon"></div>删除</div>
						<div class="weui-flex__item" data-active="rename" data-name="{{value.name}}"><div><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAJOSURBVEhLrVS9axRBHN1WVLRSxMLCb0H8VhQlIAhiI9qpWFoYs183M3u5nVk3GPA/0N7S3l4FLQTb2PhRKVEQwZNoDIi+329mL3uXy2XW5MG7vf3N+703Mzu7wVoilvnhWJmZSJnnSZJv42LU1mdDpW9G0lyPlb7mTalboSrG2ASIsuICzP/2KM03XPcG+JnvG2jAROXHnT/5qMFxrOQjlmW+9opSz/kwkvrtuNA7yDgSxQkYPW21Jvdg7FZ/gP6CAP3JmT9QSm30IU8ZmGh19iHst+03n6kGn9tVAFZ4tBcAYcZdnghF5wBm/rMys9SzaZquw/OcjjNzlYWLAWaaCx5IJ8td6PvRb24Jn1dOZtE0wG6L6Q4aW+pZPJNjTmrRJCDNzEGYfF9qzP3dNM23ky7M9JlE6PPc5BuA/d4N7dygsevtYs/3ky5smSNcU0Zwo09AKPVO6H7VTSvicPyhB066dru9qTpVCLjEzSsF0J66t3KJObgw0TaHnDSgLarGQplf5uKoACHE+qphCOfTLD/ppIyo09lKK6LxFQPoheIlK/2oZrpIUZxy0h4aBUQyvwLxG/qPk3O3bk6nhEUDaBagzEM2lOYl3SPksW3UF1kwBN4BcVxuRm2BA+xYl77vsSxOO8lQeAdg9mlljpm/BqfoG+OGl4VXABnhfgb1Z4kqzrHIEyMDMMt7dD9elhvqZ7sJhCi3LL8CZWIurBIjAvQLnJAwFnn0P0ykvgPz+3Y36gGusNZMlL7BAdiaJyh8QPp7uq6WzuedfRmD4B9nX/7B9OBdWQAAAABJRU5ErkJggg==" alt="" class="weui-tabbar__icon"></div>重命名</div>
					</div>				
				</div>
			</div>
			{{if (!value.permissionType || value.permissionType=="1") && showArrow}}
			<div class="my-list__arrow">
				<i class="fa fa-chevron-down"></i>
			</div>
			{{/if}}
		</div>
    </div>
</div>
{{/each}}
{{if pageCount > 1}}
<div id="pagination" class="weui-flex text-center" data-page="{{pageNo}}" data-pageCount="{{pageCount}}" data-path="{{path}}">
	<div class="weui-flex__item"><a class="pre-page {{if pageNo-1 <= 0}}inactive{{/if}}" node-type="pre-page">上一页</a></div>
	<div class="weui-flex__item"><a class="next-page {{if pageNo+1 > pageCount}}inactive{{/if}}" node-type="next-page">下一页</a></div>
</div>
{{/if}}
</script>

<script type="text/html" id="atp-search-list-item">
{{each datas as value}}
<div class="weui-cell weui-cell_access">
    <div class="weui-cell__bd weui-cell_primary">
		<div class="my-list__item weui-flex">
			<i class="icon-file icon-file-{{value.extendNameChecked}}"></i>
			<div class="content-box weui-flex__item" style="overflow: hidden;margin-top: -10px;margin-bottom: -10px;">
				<div class="my-list__text" data-id="{{value.id}}" data-fileType="{{value.fileType}}" style="padding: 10px 0px;">
					<h3>{{value.name}}.{{value.extendName.toLowerCase()}}</h3>
					<div class="content__time">{{value.createDate}}</div>
				</div>
				<div class="my-list__operate text-center">
					<div class="weui-flex file-operate" data-id="{{value.id}}" data-fileType="{{value.fileType}}">
						<div class="weui-flex__item" data-active="delete"><div><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAIRSURBVEhL7VW/TxRBGL1We7QzgUQisRICKFpI/FEJoaCwMqGx4XZ2b3dmYW9ms4V/go2JSgGERgsSS3obbQiG8BdQUViIngHB9y3f7A7cXXIeW/qSl9n57n3vzczdzda6QcTpE1+ZHaHMz270pT4UUu9BN8ttvYMbT3vkNrf1Dqxwn5rrkR7kUhu8uHmXNEKaL1zqDj/SD7Hl10Ss/i0aW3mzMm9g8KoTfaXXSONLc2B7c0bpJNuegQoQHufiKij1LyzsGdsjQJmPbaJLU39l+zygg6BvntCIY/7D9nnArIj1Arb1wwpxxusY39k5eIKzXsG4mT8XOv0e2g1n/htHFOJ5ju3PIJLkev4hCxtxcyJYzobsnBjE5raIzHO3Rr8yX6b3nFqLvNi2hKfSaUd0GkTNGbGkH7g1odJHgdSLbi2Q6X2Mc06t5cdmhG1LiKXsBrZ2aIWVBwSqOYojOrLC6gMgpG/eCisPoC/qfwCz/wCYP8Z7on6+VmEA3bi97ID+kGxboi0Aq+VbtjATUTqG6+LFhdq4J/XTYo6fuheaO2xbwov1lBtALxPcTTftnFgPk1tY3bxbC8PlYfviIVIAhbJtiYs7wPMHvtwKM7rUELrl1qBZxVhc9xwwxrYlaHVF0yVJO2fbEo1G4wrSv3Vq+BfCY/dlll1l2/PwkmQAF94nHMX3vqj05yjKrrEdUKv9BYDA0ub8ZJuoAAAAAElFTkSuQmCC" alt="" class="weui-tabbar__icon"></div>删除</div>
						<div class="weui-flex__item" data-active="rename" data-name="{{value.name}}"><div><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAJOSURBVEhLrVS9axRBHN1WVLRSxMLCb0H8VhQlIAhiI9qpWFoYs183M3u5nVk3GPA/0N7S3l4FLQTb2PhRKVEQwZNoDIi+329mL3uXy2XW5MG7vf3N+703Mzu7wVoilvnhWJmZSJnnSZJv42LU1mdDpW9G0lyPlb7mTalboSrG2ASIsuICzP/2KM03XPcG+JnvG2jAROXHnT/5qMFxrOQjlmW+9opSz/kwkvrtuNA7yDgSxQkYPW21Jvdg7FZ/gP6CAP3JmT9QSm30IU8ZmGh19iHst+03n6kGn9tVAFZ4tBcAYcZdnghF5wBm/rMys9SzaZquw/OcjjNzlYWLAWaaCx5IJ8td6PvRb24Jn1dOZtE0wG6L6Q4aW+pZPJNjTmrRJCDNzEGYfF9qzP3dNM23ky7M9JlE6PPc5BuA/d4N7dygsevtYs/3ky5smSNcU0Zwo09AKPVO6H7VTSvicPyhB066dru9qTpVCLjEzSsF0J66t3KJObgw0TaHnDSgLarGQplf5uKoACHE+qphCOfTLD/ppIyo09lKK6LxFQPoheIlK/2oZrpIUZxy0h4aBUQyvwLxG/qPk3O3bk6nhEUDaBagzEM2lOYl3SPksW3UF1kwBN4BcVxuRm2BA+xYl77vsSxOO8lQeAdg9mlljpm/BqfoG+OGl4VXABnhfgb1Z4kqzrHIEyMDMMt7dD9elhvqZ7sJhCi3LL8CZWIurBIjAvQLnJAwFnn0P0ykvgPz+3Y36gGusNZMlL7BAdiaJyh8QPp7uq6WzuedfRmD4B9nX/7B9OBdWQAAAABJRU5ErkJggg==" alt="" class="weui-tabbar__icon"></div>重命名</div>
					</div>				
				</div>
			</div>
			<div class="my-list__arrow">
				<i class="fa fa-chevron-down"></i>
			</div>
		</div>
    </div>
</div>
{{/each}}
</script>

<script type="text/html" id="atp-upload-list-item">
{{each list as value}}
<div class="weui-cell weui-cell_access">
    <div class="weui-cell__bd weui-cell_primary">
		<div class="my-upload-list__item weui-flex" data-id="{{value.id}}">
			<i class="icon-file icon-file-{{value.extendName.toLowerCase()}}"></i>
			<div class="content-box weui-flex__item">
				<h3 class="content__txt weui-flex">
					<span class="content__title weui-flex__item">{{value.name}}</span>
					<span class="content__status {{if value.renderStatus == "上传完成"}}color_09bb07{{/if}}">{{value.renderStatus}}</span>
				</h3>
				<div class="content__info weui-flex">
					<span class="content__onwer">{{onwer}}</span>
					<span class="content__size weui-flex__item"></span>
					<span class="content__time text-right">{{value.renderSize}}</span>
				</div>
			</div>
		</div>
    </div>
</div>
{{/each}}
</script>


<script type="text/html" id="atp-preview">
<div id="preview" class="page preview" data-url="{{if pdfUrl && pdfUrl!=""}}{{pdfUrl}}{{else}}{{url}}{{/if}}">
    <div class="page__bd" style="height: 100%;">
    	<div id="show-preview" style="height: {{windowHeight-66}}px;">
			<div class="no-view">
				<i id="noViewIcon" class="icon_show_{{extendNameChecked}}"></i>
			</div>
			<div id="fileName-hack" class="file-name">{{title}}</div>
		</div>
        <div class="km-preview_download">
			<a href="{{url}}" class="weui-btn weui-btn_primary">打开({{fileSize}})</a>
		</div>
    </div>
</div>
</script>

<script type="text/html" id="atp-preview-placeholder">
<div class="no-preview__box">
	<i class="icon-file-big icon-file-big-{{extendName.toLowerCase()}}"></i>
	<div class="no-preview__text">文件无法预览</div>
</div>
</script>

<script type="text/html" id="atp-pagination">
<div class="pages" id="pagination" node-type="pagination">
	<a class="pre-page" node-type="pre-page">上一页</a>
	<a class="next-page" node-type="next-page">下一页</a>
</div>
</script>

<script type="text/html" id="atp-kmdisable">
<div class="text-center" style="color:#616161;height:100%">
	<img src="images/icon_kmdisable.png" style="margin-top:40%">
	<div>您没有权限使用知识文档库 </div>
	<div style="font-size:12px;">请联系系统管理员</div>
</div>
</script>