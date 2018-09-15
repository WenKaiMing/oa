var DD_belatedPNG = {
    ns: "DD_belatedPNG",
    imgSize: {},
    delay: 10,
    nodesFixed: 0,
    createVmlNameSpace: function() {
        document.namespaces && !document.namespaces[this.ns] && document.namespaces.add(this.ns, "urn:schemas-microsoft-com:vml")
    },
    createVmlStyleSheet: function() {
        var e,
        t;
        e = document.createElement("style"),
        e.setAttribute("media", "screen"),
        document.documentElement.firstChild.insertBefore(e, document.documentElement.firstChild.firstChild),
        e.styleSheet && (e = e.styleSheet, e.addRule(this.ns + "\\:*", "{behavior:url(#default#VML)}"), e.addRule(this.ns + "\\:shape", "position:absolute;"), e.addRule("img." + this.ns + "_sizeFinder", "behavior:none; border:none; position:absolute; z-index:-1; top:-10000px; visibility:hidden;"), this.screenStyleSheet = e, t = document.createElement("style"), t.setAttribute("media", "print"), document.documentElement.firstChild.insertBefore(t, document.documentElement.firstChild.firstChild), t = t.styleSheet, t.addRule(this.ns + "\\:*", "{display: none !important;}"), t.addRule("img." + this.ns + "_sizeFinder", "{display: none !important;}"))
    },
    readPropertyChange: function() {
        var e,
        t,
        n;
        e = event.srcElement;
        if (!e.vmlInitiated) return; (event.propertyName.search("background") != -1 || event.propertyName.search("border") != -1) && DD_belatedPNG.applyVML(e);
        if (event.propertyName == "style.display") {
            t = e.currentStyle.display == "none" ? "none": "block";
            for (n in e.vml) e.vml.hasOwnProperty(n) && (e.vml[n].shape.style.display = t)
        }
        event.propertyName.search("filter") != -1 && DD_belatedPNG.vmlOpacity(e)
    },
    vmlOpacity: function(e) {
        if (e.currentStyle.filter.search("lpha") != -1) {
            var t = e.currentStyle.filter;
            t = parseInt(t.substring(t.lastIndexOf("=") + 1, t.lastIndexOf(")")), 10) / 100,
            e.vml.color.shape.style.filter = e.currentStyle.filter,
            e.vml.image.fill.opacity = t
        }
    },
    handlePseudoHover: function(e) {
        setTimeout(function() {
            DD_belatedPNG.applyVML(e)
        },
        1)
    },
    fix: function(e) {
        if (this.screenStyleSheet) {
            var t,
            n;
            t = e.split(",");
            for (n = 0; n < t.length; n++) this.screenStyleSheet.addRule(t[n], "behavior:expression(DD_belatedPNG.fixPng(this))")
        }
    },
    applyVML: function(e) {
        e.runtimeStyle.cssText = "",
        this.vmlFill(e),
        this.vmlOffsets(e),
        this.vmlOpacity(e),
        e.isImg && this.copyImageBorders(e)
    },
    attachHandlers: function(e) {
        var t,
        n,
        r,
        i,
        s,
        o;
        t = this,
        n = {
            resize: "vmlOffsets",
            move: "vmlOffsets"
        };
        if (e.nodeName == "A") {
            i = {
                mouseleave: "handlePseudoHover",
                mouseenter: "handlePseudoHover",
                focus: "handlePseudoHover",
                blur: "handlePseudoHover"
            };
            for (s in i) i.hasOwnProperty(s) && (n[s] = i[s])
        }
        for (o in n) n.hasOwnProperty(o) && (r = function() {
            t[n[o]](e)
        },
        e.attachEvent("on" + o, r));
        e.attachEvent("onpropertychange", this.readPropertyChange)
    },
    giveLayout: function(e) {
        e.style.zoom = 1,
        e.currentStyle.position == "static" && (e.style.position = "relative")
    },
    copyImageBorders: function(e) {
        var t,
        n;
        t = {
            borderStyle: !0,
            borderWidth: !0,
            borderColor: !0
        };
        for (n in t) t.hasOwnProperty(n) && (e.vml.color.shape.style[n] = e.currentStyle[n])
    },
    vmlFill: function(e) {
        if (!e.currentStyle) return;
        var t,
        n,
        r,
        i,
        s,
        o;
        t = e.currentStyle;
        for (i in e.vml) e.vml.hasOwnProperty(i) && (e.vml[i].shape.style.zIndex = t.zIndex);
        e.runtimeStyle.backgroundColor = "",
        e.runtimeStyle.backgroundImage = "",
        n = !0;
        if (t.backgroundImage != "none" || e.isImg) e.isImg ? e.vmlBg = e.src: (e.vmlBg = t.backgroundImage, e.vmlBg = e.vmlBg.substr(5, e.vmlBg.lastIndexOf('")') - 5)),
        r = this,
        r.imgSize[e.vmlBg] || (s = document.createElement("img"), r.imgSize[e.vmlBg] = s, s.className = r.ns + "_sizeFinder", s.runtimeStyle.cssText = "behavior:none; position:absolute; left:-10000px; top:-10000px; border:none; margin:0; padding:0;", o = function() {
            this.width = this.offsetWidth,
            this.height = this.offsetHeight,
            r.vmlOffsets(e)
        },
        s.attachEvent("onload", o), s.src = e.vmlBg, s.removeAttribute("width"), s.removeAttribute("height"), document.body.insertBefore(s, document.body.firstChild)),
        e.vml.image.fill.src = e.vmlBg,
        n = !1;
        e.vml.image.fill.on = !n,
        e.vml.image.fill.color = "none",
        e.vml.color.shape.style.backgroundColor = t.backgroundColor,
        e.runtimeStyle.backgroundImage = "none",
        e.runtimeStyle.backgroundColor = "transparent"
    },
    vmlOffsets: function(e) {
        var t,
        n,
        r,
        i,
        s,
        o,
        u,
        a,
        f,
        l,
        c;
        t = e.currentStyle,
        n = {
            W: e.clientWidth + 1,
            H: e.clientHeight + 1,
            w: this.imgSize[e.vmlBg].width,
            h: this.imgSize[e.vmlBg].height,
            L: e.offsetLeft,
            T: e.offsetTop,
            bLW: e.clientLeft,
            bTW: e.clientTop
        },
        r = n.L + n.bLW == 1 ? 1: 0,
        i = function(e, t, n, r, i, s) {
            e.coordsize = r + "," + i,
            e.coordorigin = s + "," + s,
            e.path = "m0,0l" + r + ",0l" + r + "," + i + "l0," + i + " xe",
            e.style.width = r + "px",
            e.style.height = i + "px",
            e.style.left = t + "px",
            e.style.top = n + "px"
        },
        i(e.vml.color.shape, n.L + (e.isImg ? 0: n.bLW), n.T + (e.isImg ? 0: n.bTW), n.W - 1, n.H - 1, 0),
        i(e.vml.image.shape, n.L + n.bLW, n.T + n.bTW, n.W, n.H, 1),
        s = {
            X: 0,
            Y: 0
        };
        if (e.isImg) s.X = parseInt(t.paddingLeft, 10) + 1,
        s.Y = parseInt(t.paddingTop, 10) + 1;
        else for (f in s) s.hasOwnProperty(f) && this.figurePercentage(s, n, f, t["backgroundPosition" + f]);
        e.vml.image.fill.position = s.X / n.W + "," + s.Y / n.H,
        o = t.backgroundRepeat,
        u = {
            T: 1,
            R: n.W + r,
            B: n.H,
            L: 1 + r
        },
        a = {
            X: {
                b1: "L",
                b2: "R",
                d: "W"
            },
            Y: {
                b1: "T",
                b2: "B",
                d: "H"
            }
        },
        o != "repeat" || e.isImg ? (l = {
            T: s.Y,
            R: s.X + n.w,
            B: s.Y + n.h,
            L: s.X
        },
        o.search("repeat-") != -1 && (c = o.split("repeat-")[1].toUpperCase(), l[a[c].b1] = 1, l[a[c].b2] = n[a[c].d]), l.B > n.H && (l.B = n.H), e.vml.image.shape.style.clip = "rect(" + l.T + "px " + (l.R + r) + "px " + l.B + "px " + (l.L + r) + "px)") : e.vml.image.shape.style.clip = "rect(" + u.T + "px " + u.R + "px " + u.B + "px " + u.L + "px)"
    },
    figurePercentage: function(e, t, n, r) {
        var i,
        s;
        s = !0,
        i = n == "X";
        switch (r) {
        case "left":
        case "top":
            e[n] = 0;
            break;
        case "center":
            e[n] = .5;
            break;
        case "right":
        case "bottom":
            e[n] = 1;
            break;
        default:
            r.search("%") != -1 ? e[n] = parseInt(r, 10) / 100: s = !1
        }
        return e[n] = Math.ceil(s ? t[i ? "W": "H"] * e[n] - t[i ? "w": "h"] * e[n] : parseInt(r, 10)),
        e[n] % 2 === 0 && e[n]++,
        e[n]
    },
    fixPng: function(e) {
        e.style.behavior = "none";
        var t,
        n,
        r,
        i,
        s;
        if (e.nodeName == "BODY" || e.nodeName == "TD" || e.nodeName == "TR") return;
        e.isImg = !1;
        if (e.nodeName == "IMG") {
            if (e.src.toLowerCase().search(/\.png$/) == -1) return;
            e.isImg = !0,
            e.style.visibility = "hidden"
        } else if (e.currentStyle.backgroundImage.toLowerCase().search(".png") == -1) return;
        t = DD_belatedPNG,
        e.vml = {
            color: {},
            image: {}
        },
        n = {
            shape: {},
            fill: {}
        };
        for (i in e.vml) if (e.vml.hasOwnProperty(i)) {
            for (s in n) n.hasOwnProperty(s) && (r = t.ns + ":" + s, e.vml[i][s] = document.createElement(r));
            e.vml[i].shape.stroked = !1,
            e.vml[i].shape.appendChild(e.vml[i].fill),
            e.parentNode.insertBefore(e.vml[i].shape, e)
        }
        e.vml.image.shape.fillcolor = "none",
        e.vml.image.fill.type = "tile",
        e.vml.color.fill.on = !1,
        t.attachHandlers(e),
        t.giveLayout(e),
        t.giveLayout(e.offsetParent),
        e.vmlInitiated = !0,
        t.applyVML(e)
    }
};
try {
    document.execCommand("BackgroundImageCache", !1, !0)
} catch(r) {}
DD_belatedPNG.createVmlNameSpace(),
DD_belatedPNG.createVmlStyleSheet()