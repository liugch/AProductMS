(function() {
    var a = window.XF = {};
    a.widget = {};
    if (typeof(a.widget.msgbox) == "undefined") {
        a.widget.msgbox = {}
    }
    a.widget.msgbox._timer = null;
    a.widget.msgbox._center = function(c) {
        var b = $(window);
        c.css({
            position: "absolute",
            top: (b.height() - c.height()) / 2.2 + document.documentElement.scrollTop + document.body.scrollTop
        })
    };
    a.widget.msgbox.isShow = function () {
        if ($("#xf_msgbox").size() > 0) {
            return true;
        } else {
            return false;
        }
    };
    a.widget.msgbox.show = function(b, d, f, c) {
        if ($("#xf_msgbox").size() > 0) {
            $("#xf_msgbox,#msgbox_overlay").remove()
        }
        if (a.widget.msgbox._timer != null) {
            window.clearTimeout(a.widget.msgbox._timer)
        }
        var e = {
            0: "loading",
            1: "succ",
            2: "fail",
            3: "hits",
            4: "none"
        };
        var g = $(['<div  id="xf_msgbox" class="xf_msgbox_wrap">', '<span id="mode_tips" class="xf_msgbox_layer">', '<span class="gtl_ico_' + e[d] + '"></span>', '<em class="gtl_text_' + e[d] + '">' + b + "</em>", '<span class="gtl_end"></span>', "</span>", "</div>", '<div id="msgbox_overlay"></div>'].join(""));
        $("body").append(g);
        a.widget.msgbox._center($("#xf_msgbox"));
        if (typeof(c) != "undefind") {
            if (c == true) {
                $("#msgbox_overlay").show()
            }
        }
        if (typeof(f) != "undefind") {
            a.widget.msgbox._timer = window.setTimeout(function() {
                a.widget.msgbox.hide()
            },
            f)
        }
    };
    a.widget.msgbox.hide = function() {
        $("#msgbox_overlay").remove();
        $("#xf_msgbox").fadeOut().remove()
    }
})();