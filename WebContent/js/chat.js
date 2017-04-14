
var chat = {};
chat.test = false;
chat.DOMAIN = {
    onlineservice: "http://chat.yiguo.com/OnlineService/Chat",
    detail: "http://www.yiguo.com/product",
    www: "http://www.yiguo.com",
    home: "http://www.home.com"
};
chat.DOMAIN.test = {
    onlineservice: "http://easemob.yiguo.com/OnlineService/Chat",
    detail: "http://www.yiwww01.com/product/",
    www: "http://www.yiwww01.com/",
    home: "http://www.home.com"
};

var getdomain = function() {
    if (chat.test) {
        return  chat.DOMAIN.test;
    } else {
        return chat.DOMAIN;
    }
};
chat.url = getdomain();

var urlroute = function () {
    var url = window.parent.location.href;
    if (url.indexOf(chat.url.detail) >= 0) {
        return detailcontrol(url);
    } else if (url.indexOf(chat.url.www) >= 0) {
        return wwwcontrol(url);
    } else if (url.indexOf(chat.url.home) >= 0) {
        return homecontrol(url);
    }
    return chat.url.onlineservice;
};

var detailcontrol = function (u) {
    var result = chat.url.onlineservice,
        p1 = $(".summary-name h1").text(),
        p2 = $(".summary-price strong").text(),
        param = "会话来自：官网详情" + u + "\r商品：" + p1 + "\r价格：" + p2;
    if (u !== "" && u != undefined) {
        result += "?param=" + encodeURI(param);
    }
    return result;
};

var wwwcontrol = function(u) {
    var result = chat.url.onlineservice,
        param = "会话来自：官网首页" + u;
    if (u !== "" && u != undefined) {
        result += "?param=" + encodeURI(param);
    }
    return result;
};

var homecontrol = function (u) {
    var result = chat.url.onlineservice,
        param = "会话来自：官网用户中心" + u;
    if (u !== "" && u != undefined) {
        result += "?param=" + encodeURI(param);
    }
    return result;
};

$(function() {
    $("a[id^='calltool']").on("click", function () {
        var ele = $("a.calltool-min");
        loadchat();
        if ($("iframe[id^='callos_']").css("width") === "0px") {
            ele.parent("div").show();
            $("iframe[id^='callos_']").css({ "width": "400px", "height": "500px" });
        }
    });
    $("a.calltool-min").on("click", function () {
        var ele = $(this);
        if ($("iframe[id^='callos_']").css("width") === "400px") {
            ele.parent("div").hide();
            $("iframe[id^='callos_']").css({ "width": "0px", "height": "0px" });
        }
    });

});


var loadchat = function() {
    var callos = $("iframe[id^='callos_']");
    if (callos.length <= 0) {
        var i = $("<iframe></iframe>");
        var src = urlroute();
        i.attr("id", "callos_" + (new Date).getTime()).attr("name", "callos_" + (new Date).getTime());
        $(i).css({"z-index": " 199","overflow": " hidden","position": "fixed","bottom": "10px","right": "10px","border": "medium none","width": " 0px"," height": " 0px"," display": " block"," transition": " all 0.01s ease 0s"," visibility": " visible"," left": " auto"," top": " auto"," box-shadow": " 0px 4px 8px rgba(0, 0, 0, 0.2)"," border-radius": " 4px"});
        i.attr("src", src);
        document.body.appendChild(i[0]);
    }
};




! function (e, t) {
    var s = $("#sidebar");
    if (s.length > 0) {
        var sa = s.children("a:first");
        sa.addClass("s-btn service").attr("id", "calltool_" + (new Date).getTime());

    }
        var a = '<a class="calltool-min" href="javascript:void(0);">一</a>';
        var d = $("<div></div>");
        d.addClass("service-entry").html(a);
        document.body.appendChild(d[0]);
}(window, void 0);




