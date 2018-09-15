var slider = function ()
{
    function f(l)
    {
        e && (l = n + 1), l %= 5, r && (r.end(), r = null), i && (i.end(), i = null), r = new ElAnim(u[l], 
        {
            'opacity' : {
                from : 0, to : 1
            }
        }, s, o), r.onend = function ()
        {
            r = null, t && (clearTimeout(t), t = null), e && (t = setTimeout(f, 6e3));
        },
        r.onplay = function ()
        {
        	u.item(l).css("z-index","0");
        	u.item(n).css("z-index","-1");
        },
        i = new ElAnim(u[n], {
            'opacity' : {
                from : 1, to : 0
            }
        }, s, o), i.onend = function ()
        {
            i = null;
        },
        r.play(), i.play(), a.item(n).css("opacity", "0").css("filter", "alpha(opacity=0)"), a.item(l).css("opacity", 
        "1").css("filter", "alpha(opacity=100)"), n = l
    }
    function l()
    {
        u = W("#slider .page"), a = W("#slider .switch img"), u.first().css("opacity", "1").css("filter", 
        "alpha(opacity=100)"), a.first().css("opacity", "1").css("filter", "alpha(opacity=100)"), t = setTimeout(f, 
        6e3), W("#slider .switch a").on("mouseover", function (r)
        {
            e = !1;
            var i = parseInt(W(this).attr("data-index"));
            if (i == n) {
                return;
            }
            t && (clearTimeout(t), t = null), f(i, !0);
        }).on("mouseout", function (n)
        {
            e = !0, t && (clearTimeout(t), t = null), t = setTimeout(f, 6e3);
        })
    }
    var e = !0, t, n = 0, r, i, s = 1500, o = QW.Easing.easeNone, u, a;
    return {
        init : l
    }
}();
slider.init();