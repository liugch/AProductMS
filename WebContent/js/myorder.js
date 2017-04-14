
var pageQuestData = {
    timeRange: 0,
    orderState: '',
    pageData: {
        Index: 0,
        PageSize: 5,
        Count: 0,
        PagesCount: 0
    }
};

function applyDate(pageData) {
    if (pageData != undefined && pageData != "") {
        pageQuestData.pageData = pageData;
    }

    util.Ajax.get_load("../Trade/GetAllOrders",
    {
        index: pageQuestData.pageData.Index,
        pageSize: pageQuestData.pageData.PageSize,
        timeRange: pageQuestData.timeRange,
        orderState: pageQuestData.orderState
    },
        function(result) {
            if (result) {
                $(".j_allorderli").utastebars({
                    tpl: $("#allorderstpl"),
                    context: result,
                    emptytext: "<div class='order-none'>亲爱的易果用户，您目前尚无记录呦～<a href='http://www.yiguo.com/'>快去逛逛吧</a>～</div>"
                });
                //$(".countdown").each(function () {
                //    var ele = $(this);
                //    common.countDown(ele.attr("id"), ele.data("time"));
                //});
                common.pagePlugins.init("j_pages", result.page, applyDate);
                $("#j_pages").addClass("j_active");
                pageQuestData.pageData.PagesCount = result.page.PagesCount;
            }
        }, $("#allorderlst"));
};

function failurOrder(oid) {
    $.ajax({
        type: "post",
        data: { "oid": oid },
        url: "../Trade/FailurOrder",
        success: function (result) {
            if (result.flag) {
                util.Dialog.alert("取消成功");
                applyDate();
            } else {
                util.Dialog.alert(result.msg);
            }
        }
    });
}

$(function () {
    applyDate();

    $("#selspan").on("change", function () {
        pageQuestData.pageData.Index = 0;
        pageQuestData.timeRange = $("#selspan").val();
        applyDate();
    });

    $("#selstate").on("change", function () {
        pageQuestData.pageData.Index = 0;
        pageQuestData.orderState = $("#selstate").val();
        applyDate();
    });

    $("#allorderlst").on("click", ".cancel", function () {
        var ele = $(this),
            oid = ele.data("oid");
        util.Dialog.confirm("是否要取消订单", function () { failurOrder(oid); });
    });

});
