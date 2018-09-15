(function(root){
    var Route = root.Route = {
        init: function (map) {
            var defaultAction = map['*'];
            if(defaultAction){
                Route.defaultAction = defaultAction;
                delete map['*'];
            }
            Route.routes = map;
            init();
            onchange();
        },
        routes: {},
        defaultAction: null
    };
    function onchange(onChangeEvent){
        var newURL = onChangeEvent && onChangeEvent.newURL || window.location.hash;
        var url = newURL.replace(/.*#/, '');
        var found = false;
        for (var path in Route.routes) {
            var reg = getRegExp(path);
            var result = reg.exec(url);
            if(result && result[0] && result[0] != ''){
                var handler = Route.routes[path];
                handler && handler.apply(null, result.slice(1,result.length-1));
                found = true;
            }
        }
        if(!found && Route.defaultAction){
            Route.defaultAction();
        }
    }
    function getRegExp(route){
        var optionalParam = /\((.*?)\)/g;
        var namedParam    = /(\(\?)?:\w+/g;
        var splatParam    = /\*\w+/g;
        var escapeRegExp  = /[\-{}\[\]+?.,\\\^$|#\s]/g;
        route = route.replace(escapeRegExp, '\\$&')
            .replace(optionalParam, '(?:$1)?')
            .replace(namedParam, function(match, optional) {
                return optional ? match : '([^/?]+)';
            })
            .replace(splatParam, '([^?]*?)');
        return new RegExp('^' + route + '(?:\\?([\\s\\S]*))?$');
    }
    function init(){
        if ('onhashchange' in window && (document.documentMode === undefined
            || document.documentMode > 7)) {
            if (this.history === true) {
                setTimeout(function() {
                    window.onpopstate = onchange;
                }, 500);
            }
            else {
                window.onhashchange = onchange;
            }
            this.mode = 'modern';
        } else {
            throw new Error('sorry, your browser doesn\'t support route');
        }
    }
})(window);