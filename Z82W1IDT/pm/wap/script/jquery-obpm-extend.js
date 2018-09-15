jQuery.extend({
	par2Json : function(string,overwrite){//param to json
		var obj = {}, pairs = string.split('&'), d = decodeURIComponent, name, value;
		jQuery.each(pairs, function(i, pair) {
			pair = pair.split('=');
			name = d(pair[0]);
			value = pair[1];
			obj[name] = overwrite || !obj[name] ? value : [].concat(obj[name])
					.concat(value);
		});
		return obj;
	},

	json2Par : function(o, pre) {//json to param
		var undef, buf = [], key, e = encodeURIComponent;
		for (key in o) {
			undef = o[key] == 'undefined';
			$.each(undef ? key : o[key], function(val, i) {
				buf.push("&", e(key), "=", (val != key || !undef) ? e(val) : "");
			});
		}
		if (!pre) {
			buf.shift();
			pre = "";
		}
		return pre + buf.join('');
	},
	
	obj2Str : function(o){//obj to str
		var r = [];
		if (typeof o == "string" || o == null) {
			return o;
		}
		if (typeof o == "object") {
			if (!o.sort) {
				r[0] = "{";
				for ( var i in o) {
					var str = HTMLEncode(jQuery.obj2Str(o[i]));
					
					r[r.length] = "\"" + i + "\"";
					r[r.length] = ":";
					r[r.length] = "\"" + str + "\"";
					r[r.length] = ",";
				}
				r[r.length - 1] = "}";
			} else {
				r[0] = "[";
				for ( var i = 0; i < o.length; i++) {
					r[r.length] = jQuery.obj2Str(o[i]);
					r[r.length] = ",";
				}
				r[r.length - 1] = "]";
			}
			return r.join("");
		}
		return o.toString();
	},
	json2Str: function(o) { //json数组转换成json字符串
        if (o == undefined) {
            return "";
        }
        var r = [];
        if (typeof o == "string") return "\"" + o.replace(/([\"\\])/g, "\\$1").replace(/(\n)/g, "\\n").replace(/(\r)/g, "\\r").replace(/(\t)/g, "\\t") + "\"";
        if (typeof o == "object") {
            if (!o.sort) {
                for (var i in o)
                    r.push("\"" + i + "\":" + jQuery.json2Str(o[i]));
                if (navigator.userAgent.indexOf("MSIE 9.0")<0 && !!document.all && !/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/.test(o.toString)) {
                    r.push("toString:" + o.toString.toString());
                }
                r = "{" + r.join() + "}";
            } else {
                for (var i = 0; i < o.length; i++)
                    r.push(jQuery.json2Str(o[i]));
                r = "[" + r.join() + "]";
            }
            return r;
        }
        return o.toString().replace(/\"\:/g, '":""');
    },
	  jQueryValues: function(object) {
	    var values = [];
	    for (var property in object)
	      values.push(object[property]);
	    return values;
	  }
});

jQuery.cachedScript = function( url, options ) {
 
  // Allow user to set any option except for dataType, cache, and url
  options = $.extend( options || {}, {
    dataType: "script",
    cache: true,
    url: url
  });
 
  // Use $.ajax() since it is more flexible than $.getScript
  // Return the jqXHR object so we can chain callbacks
  return jQuery.ajax( options );
};
 
