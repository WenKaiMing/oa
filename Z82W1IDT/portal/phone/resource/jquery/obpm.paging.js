(function($) {
	$.fn.obpmPaging = function(callbackFn) {
		return this.each(function() {
			var $pagingDiv = $(this);
			$pagingDiv.addClass("pagingDiv");
			$pagingDiv.html(pageHTML($pagingDiv.attr("_pageNow"), $pagingDiv
					.attr("_totalRows"), $pagingDiv.attr("_linesPerPage")));

			if (callbackFn) {
				$pagingDiv.find("a").click(function() {
					var $a = $(this);
					$a.addClass("page-active").siblings().removeClass("page-active");
					var pageNo = $a.attr("_pageNo");
					callbackFn(pageNo);
				});
			}
		});
	};

	function pageHTML(pageNow, totalRows, linesPerPage) {
		// pageNow = 当前页
		// totalRows = 总条数
		// 获取当前页之后，可通过Ajax进行返值。
		// 每页条数
		// var linesPerPage = 10;
		// 分页总数
		var pageTotal = Math.ceil(totalRows / linesPerPage);
		// page分割数量
		var pageSize = 10;
		var pageSlipt = pageSize / 2;
		var pageHTML = new Array;
		// alert("pageTotal-->"+pageTotal+" pageSize-->"+pageSize +" pageNow-->"
		// + pageNow);
		if (totalRows > pageSize) {
			if (pageTotal > pageSize) {
				var countBegin = (pageNow - pageSlipt) + 1 > 0 ? (pageNow - pageSlipt) + 1
						: 1;
				var countEnd = (pageNow + pageSlipt) < pageTotal ? (pageNow + pageSlipt)
						: pageTotal;
				countEnd = countEnd < pageSize ? pageSize : countEnd;
				countBegin = countEnd - pageNow < pageSlipt ? countBegin
						- (pageSlipt - (countEnd - pageNow)) : countBegin;
				if (countBegin > 1) {
					pageHTML += "<a id='first' _pageNo='" + i + "'>第一页(1)</a>";
				}

				for (i = countBegin; i <= countEnd; i++) {
					if (i == pageNow) {
						pageHTML += "<a _pageNo='" + i
								+ "' class='page-active'>" + i + "</a>";
					} else {
						pageHTML += "<a _pageNo='" + i + "'>" + i + "</a>";
					}
				}
				if (countEnd < pageTotal) {
					pageHTML += "<a id='last' _pageNo='" + i + "'>最后一页("
							+ pageTotal + ")</a>";
				}
			} else {
				for (i = 1; i <= pageTotal; i++) {
					if (i == pageNow) {
						pageHTML += "<a  _pageNo='" + i
								+ "' class='page-active'>" + i + "</a>";
					} else {
						pageHTML += "<a  _pageNo='" + i + "'>" + i + "</a>";
					}
				}
			}
			return pageHTML;
		}
	}

})(jQuery);