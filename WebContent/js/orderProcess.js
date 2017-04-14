//2015-10-8 lijun v1.0
G.app.orderprocess = {};
G.app.orderprocess.data = function () {
    return {
        ConsigneeId: "",
        DeliveryDate: "",
        DeliveryPeriod: 0,
        Freight: 0,//运费
        DeliveryMethod: "",
        UsePrePay: 0,//1=使用，默认0不使用或没有预存款
        IsDisplyPrice: 0,//配送单上不显示价格（仅在非货到付款时有效）
        PaymentId: "",
        InvoiceId: "",
        InvoiceStyle: "",
        InvoiceContent: "",
        LotteryCommodityId512: "",
        LotteryCommodityId: "",//绑定账户的优惠券
        LotteryCommodityChooseId: [],//绑定账户的优惠券64item
        CouponCode: "",//礼品卡
        LotteryCommodityId0: [],
        LotteryCommodityId128: [],
        ECouponCode: "",//非绑定账户的优惠券
        LotteryCommodityChooseId2: [],//非绑定账户的优惠券64
        //CardCode: "",//手动激活的礼品卡 作废 
        CashVouchersCode: [],//现金券
        //Card: {},
        //CashVoucher: {}
        Commodities: "",//商品字符串
        CommoditiesMoney: 0.00,//商品金额
        //zk
        CategoryDiscount:0.00,//
        DiscountCoupon: 0.00,//优惠券_优惠的金额
        DiscountCard :0.00,//礼品卡_优惠的金额
        CashVoucherDiscount:0.00,//cashvoucher
        UserDiscount: 0.00,//用户折扣
        //预存款抵扣
        DepositDeduction: 0.00,
        Discount: 0.00,//优惠金额
        UB: 0,//悠币
        Step: 99,
        OrderUserName: "",
        OrderUserMobile: "",
        CustomDelivery: {DeliveryId:""}
    }
};
G.app.orderprocess.orderPageData = {};
G.app.orderprocess.onlineVoucher = false;
G.app.orderModule = {
    initReceiving: function () {
        XF.widget.msgbox.show("数据加载中...", 0, 8000, true);
        var t = G.app.OrderTPL;
        var s = G.app.OrderMsg;
        var p = G.app.orderprocess;
        var isContinue = false;
        var defaultConsigneeId = "";
        G.util.ajax.asyncPost("/Order1Receiving/index?datestamp=" + new Date().getTime(), { datestamp: new Date().getTime() }, function (d) {
            if (d.ReturnState != 3 || !d.O) {
                XF.widget.msgbox.hide();
                G.ui.popup.showMsg(d.ReturnMsg, 2, $.noop);
                return;
            }
            var consignee = d.O;
            //未登录
            if (!consignee.UserId) {
                XF.widget.msgbox.hide();
                G.ui.popup.showMsg('请先登陆！', 1, function () {
                    location.href = G.logic.constants.login;
                });
                return;
            }
            var lstConsignee = consignee.LstConsignee
            if (lstConsignee.length > 0) {

                var count = 0;
                $.each(lstConsignee, function (i, item) {
                    count++;

                    if (i < 3) {
                        $.tmpl(t.Consignee_Default, item).appendTo("#receive1");
                    } else {
                        $.tmpl(t.Consignee_Default, item).hide().appendTo("#receive1");
                    }
                })
                if (count > 3) {
                    $("#receive3").show();
                    //收货信息  收起展开其他地址
                    $('.oReceiveClose').unbind("click").click(function () {
                        if ($("#receive1 li").size() > 3) {
                            if ($(this).html() == "收起其他地址") {
                                if ($("#receive1 li:lt(3) input:checked").size() > 0) {//存在选中
                                    $("#receive1 li:gt(2)").hide();
                                } else {
                                    $("#receive1 li:gt(1)").filter(function (i) { return $(this).find("input:checked").size() < 1 }).hide();
                                    //$("#receive1 li:gt(1)").filter("input:not(:checked)").hide();
                                }
                                $(this).text('展开其他地址');
                            } else {
                                $("#receive1 li").show();
                                $(this).text('收起其他地址');
                            }
                        }
                    });
                } else {
                    $("#receive3").hide();
                    $('.oReceiveClose').hide();
                }
            } else {
                $("#receive3").hide();
            }
            //绑定address事件.
            G.app.orderprocess.address.addressBind();
            G.app.orderprocess.customDelivery.bindEvent();
            //选中默认收货地址
            if (consignee.DefaultConsigneeId.length > 0) {
                defaultConsigneeId = consignee.DefaultConsigneeId;
            } else {
                //配送信息(请选择收货信息后确认配送信息),支付信息(请选择配送信息后确认支付方式)
                p.delivery.notSelectReceiving();
            }
            isContinue = true;
            if (isContinue) {
                //事件初始化
                p.event.init();
                if (defaultConsigneeId.length > 0) {
                    var jo = $("#order1 .o-receive li");
                    $.each(jo, function (i, item) {
                        var consigneeId = $(item).find("#ConsigneeId").html();
                        if (defaultConsigneeId == consigneeId) {
                            $(item).find("input").click();
                        }
                    });
                }
                else {
                    XF.widget.msgbox.hide();
                }
            } else {
                XF.widget.msgbox.hide();
            }
            
        });
    }
};
G.app.orderprocess.event = {
    init: function () {
        var p = G.app.orderprocess;
        p.address.init();
        p.invoice.init();
        p.payment.init();
        p.coupon.init();
        $("#OrderUserMobile").blur(function () {
            if ($("#OrderUserMobile").val().length > 0 && !G.util.validation.isMobile($("#OrderUserMobile").val())) {
                G.alert.warn("订货人手机格式有误，请重新输入！");
                return;
            }
        });
        G.app.orderSubmit.orderLock = 0;
    }
};
G.app.orderprocess.address = {
    currConsigneeId: "",
    clearTheAddress: function () {
        $("#theAddressForm").find("input,select").not(":submit,hidden").filter("input").val("").end().filter("select").first().val("").siblings().empty();
    },
    init: function () {
        var self = this;
        var t = G.app.OrderTPL;
        G.app.orderCity.init();
        //使用新地址
        $("#theAddress").unbind("click").click(function () {
            if ($("#order1 #receive1").find("li").size() >= 20) {
                G.alert.warn("地址最多不能超过20个！");
                return;
            }
            self.clearTheAddress();
            $("#theAddressForm").find("#ConsigneeId").val("");
            $("#theAddressForm").find(".adrtag").removeClass("selected");
            $("#myModal1").show();
        });
        $("#myModal1").find(".modal-header a.close").unbind("click").click(function () {
            $("#myModal1").hide();
        });
        $("#theAddressForm").find(".adrtag").click(function() {
            var $form = $("#theAddressForm");
            var type = $(this).data("type");
            $form.find("#ConsigneeType").val(type);
            $form.find(".adrtag").removeClass("selected");
            $(this).addClass("selected");
        });
        $.extend($.validator.messages, {
            required: ' 必填',
            mobile: ' * 请输入正确的手机号'
        });
        $.validator.addMethod("mobile", function (value, element) {
            var length = value.length;
            return this.optional(element) || (length == 11 && G.util.validation.isMobile(value));
        }, ' * 手机格式错误');

        $("#theAddressForm").validate({
            rules: {
                ConsigneeName: { required: true },
                ConsigneeTel:{maxlength:25},
                ConsigneeMobile: { required: true, mobile: true },
                DistrictId: { required: true },
                AreaId: {required: true },
                ConsigneeAddress: { required: true },
                ConsigneeType: {required:true}
            },
            messages: {
                ConsigneeName: { required: " * 收货人姓名必填" },
                ConsigneeTel: { maxlength: " * 号码过长" },
                ConsigneeMobile: { required: " * 手机号码必填" },
                DistrictId: { required: " * 必选" },
                AreaId: {required: " * 必选"},
                ConsigneeAddress: { required: " * 详细地址必填" },
                ConsigneeType: {required:"* 请选择收货地址类型"}
            },
            keyup: false,
            ignore:"",
            submitHandler: function (form) {
                //保存收货地址
                var isOuterLoop = $("select#DistrictId").val();
                if (isOuterLoop == "0" || isOuterLoop == "1") {
                    $("#IsOuterLoop").val(isOuterLoop);
                } else {
                    $("#IsOuterLoop").val("");
                }
                var addressInfo = self.AddressInfo();
                var addressForm = $("#theAddressForm");
                var status = 0;
                if ($.trim(addressForm.find("#ConsigneeId").val()) != "") {
                    addressInfo.ConsigneeId = addressForm.find("#ConsigneeId").val();
                    status = 1;//alter
                } else {
                    status = 2;//add
                }
                addressInfo.ConsigneeName = encodeURIComponent(addressForm.find("#ConsigneeName").val());
                addressInfo.ConsigneeMobile = addressForm.find("#ConsigneeMobile").val();
                addressInfo.ConsigneeAddress = encodeURIComponent(addressForm.find("#ConsigneeAddress").val());
                addressInfo.ConsigneeTel = addressForm.find("#ConsigneeTel").val();
                addressInfo.PostCode = addressForm.find("#PostCode").val();
                addressInfo.ConsigneeType = addressForm.find("#ConsigneeType").val();
                if ($.trim(addressForm.find("#AreaId").val()) != "") {
                    addressInfo.AreaId = addressForm.find("#AreaId").val();
                    if ($.trim(addressForm.find("#DistrictId").val()) != "") {
                        addressInfo.DistrictId = addressForm.find("#DistrictId").val();
                    }
                }
                addressInfo.IsOuterLoop = $("#IsOuterLoop").val();
                var province = addressForm.find("#ProvinceId")[0];
                var area = addressForm.find("#AreaId")[0];
                addressInfo.ProvinceId = $(province).val();
                addressInfo.ProvinceName = province.options[province.selectedIndex].text;
                addressInfo.AreaName = area.options[area.selectedIndex].text;
                G.util.ajax.post("/Order1Receiving/PostConsignee?datestamp=" + new Date().getTime(), addressInfo, function (d) {
                    if (d.ReturnState == 3) {
                        $("#myModal1").find("a.close").click();
                        var o = d.O;
                        if (status == 2) {//add
                            $.tmpl(t.Consignee_Default, o).prependTo("#receive1");
                            G.app.orderprocess.address.addressBind();
                            $("#receive1 li").first().find("input").click();
                        } else {
                            //$("#myModal1").find("a.close").click();
                            var currli = null;
                            $("#receive1 li").find('span[id="ConsigneeId"]').each(function (i, item) {
                                if ($(item).html() == o.ConsigneeId) {
                                    currli = $(item).closest("li");
                                }
                            });
                            currli.find("strong").html(decodeURIComponent(addressInfo.ConsigneeName));
                            currli.find('span[id="ConsigneeMobile"]').html(addressInfo.ConsigneeMobile);
                            currli.find('span[id="ConsigneeName"]').html(decodeURIComponent(o.ConsigneeName));
                            currli.find('span[id="ConsigneeAddress"]').html(decodeURIComponent(o.ConsigneeAddress));
                            currli.find('span[id="ProvinceId"]').html(addressInfo.ProvinceId);
                            currli.find('span[id="AreaId"]').html(addressInfo.AreaId);
                            currli.find('span[id="DistrictId"]').html(addressInfo.DistrictId);
                            currli.find('span[id="IsOuterLoop"]').html(addressInfo.IsOuterLoop);
                            currli.find('span[id="ConsigneeType"]').html(addressInfo.ConsigneeType);
                            var consigneeTypeName = ["", "公司", "家庭"][addressInfo.ConsigneeType];
                            if (currli.find('.adrtag')) {
                                currli.find('.adrtag').html(consigneeTypeName);
                            } else {
                                currli.find("input").after('<span class="adrtag">' + consigneeTypeName + '</span>');
                            }
                            currli.find("strong").next().html(addressInfo.ProvinceName + ' ' + addressInfo.AreaName + ' ' + decodeURIComponent(o.ConsigneeAddress) + ',' + addressInfo.ConsigneeMobile + ' ' + addressInfo.ConsigneeTel);
                            if ($("#receive1 li").find(":checked").first().closest("li").find('span[id="ConsigneeId"]').html() == o.ConsigneeId) {
                                //收货地址改成外环以外不支持定时配
                                if (addressInfo.IsOuterLoop == 1) {
                                    $("#theSelectedPeriod").html("0");
                                }
                                currli.first().find("input").click();
                            } else {
                                G.ui.popup.showMsg("修改成功！", 3, $.noop);
                            }
                        }
                    } else {
                        G.ui.popup.showMsg(d.ReturnMsg, 2, $.noop);
                    }
                });
                return false;
            }
        });
    },
    theAddressEvent: function () {
        var jo = $("#order1 .o-receive li");
        if (jo.size() >= 20) {
            $("#theAddress").removeAttr("href");
        } else {
            $("#theAddress").attr("href", "#myModal1");
        }
    },
    addressBind: function () {
        //绑定事件.
        var self = this;
        var jo = $("#order1 .o-receive li");
        jo.each(function(index,item) {
            var consigneeType = $(item).find(".adrtag");
            if (consigneeType.html() == '') {
                consigneeType.remove();
            }
        });
        G.app.orderprocess.address.theAddressEvent();
        //选中
        jo.find("input").unbind("click").click(function () {
            var li = $(this).closest("li");
            self.addressSelected(li);
        });
        //设为默认地址
        jo.find("a.btn-setdefault").each(function (i, item) {
            $(this).unbind("click").click(function () {
                var consigneeId = $(this).closest("li").find("#ConsigneeId").html();
                G.util.ajax.post("/Order1Receiving/SetDefaultConsignee?datestamp=" + new Date().getTime(), { "consigneeId": consigneeId }, function (d) {
                    if (d.ReturnState == 3) {
                        //不触发选中该地址事件
                        G.ui.popup.showMsg("设置成功！", 3, $.noop);
                    } else {
                        G.ui.popup.showMsg(d.ReturnMsg, 2, $.noop);
                    }
                });
            });
        });
        //编辑
        jo.find("a.btn-edit").each(function (i, item) {
            $(this).unbind("click").click(function () {
                //编辑成功后，不触发选中该地址事件。替换该地址的值
                var li = $(this).closest("li");
                $("#theAddressForm").find("#ConsigneeId").val(li.find("#ConsigneeId").html());
                $("#theAddressForm").find("#ConsigneeName").val(li.find("#ConsigneeName").html());
                $("#theAddressForm").find("#ConsigneeMobile").val(li.find("#ConsigneeMobile").html());
                $("#theAddressForm").find("#ConsigneeAddress").val(li.find("#ConsigneeAddress").html());
                $("#theAddressForm").find("#ConsigneeTel").val(li.find("#ConsigneeTel").html());
                $("#theAddressForm").find("#PostCode").val(li.find("#PostCode").html());
                var consigneeType = li.find("#ConsigneeType").html();
                $("#theAddressForm").find('.adrtag').each(function () {
                    var type = $(this).data('type');
                    $(this).removeClass("selected");
                    if (type == consigneeType) {
                        $(this).addClass("selected");
                    }
                });
                if (consigneeType == "0") {
                    consigneeType = "";
                }
                $("#theAddressForm").find("#ConsigneeType").val(consigneeType);
                //城市
                var city = G.app.orderCity;
                var provinceId = li.find("#ProvinceId").html();
                var areaId = li.find("#AreaId").html();
                var districtId = li.find("#DistrictId").html();
                var isOuterLoop = li.find("#IsOuterLoop").html();
                city.bindAll(provinceId, areaId, districtId, isOuterLoop);
                
                $("#myModal1").show();
            });
        });
        //删除
        jo.find("a.btn-del").each(function (i, item) {
            $(this).unbind("click").click(function () {
                var o = this;
                var consigneeId = $(this).closest("li").find("#ConsigneeId").html();
                G.ui.popup.showMsg("请确认删除？", { okFn: function () { self.deleteAddress(o, consigneeId); G.app.orderprocess.address.theAddressEvent(); }, btns: 3, okText: "删除", cancelText: "取消" });
            });
        });
    },
    deleteAddress: function (o, consigneeId) {
        G.util.ajax.post("/Order1Receiving/DeleteConsignee?datestamp=" + new Date().getTime(), { "consigneeId": consigneeId }, function (d) {
            if (d.ReturnState == 3) {
                //检查删除地址是否为当前选中地址，是：删除后，选中排序第一的地址；不是：直接删除
                var isChk = $(o).closest("li").find("input").attr("checked");
                if (isChk) {
                    $(o).closest("li").remove();
                    $("#receive1").find("li").first().find("input").click();
                } else {
                    $(o).closest("li").remove();
                }
                //G.alert.warn("删除成功！");
            } else {
                G.ui.popup.showMsg(d.ReturnMsg, 2, $.noop);
            }
        });
    },
    addressSelected: function (li,isLoadCustomDelivery) {
        var self = this;
        if (XF.widget.msgbox.isShow() == false) {
            XF.widget.msgbox.show("数据加载中...", 0, 8000, true);
        }
        //验证收货地址是否可以配送
        var consigneeId = li.find("#ConsigneeId").html();
        var consigneeName = li.find("#ConsigneeName").html();
        var consigneeMobile = li.find("#ConsigneeMobile").html();
        var consigneeTel = li.find("#ConsigneeTel").html();
        if (!isLoadCustomDelivery) {
            G.app.orderprocess.customDelivery.clearCustomDelivery();
        }
        var data = G.app.orderSubmit.getOrderData();
        
        data.ConsigneeId = consigneeId;
        G.util.ajax.asyncPost("/Order2Delivery/Index?datestamp=" + new Date().getTime(), data, function (d) {
            if (d.ReturnState == 3) {
                obj = d.O;
                G.app.orderprocess.orderPageData = d.O;
                var orderPageData = G.app.orderprocess.orderPageData;
                if (orderPageData == null) {//如果地址不能配送的话，恢复到原来的选择地址
                    self.recoverPreSelected(self.currConsigneeId);
                    return;
                } else {
                    self.currConsigneeId = consigneeId;
                    G.app.orderSubmit.enableSubmitBtn();
                    li.siblings().each(function() {
                        $(this).find("input").parent().removeClass("selected");
                    });
                    li.find("input").parent().addClass("selected");
                }
                var p = G.app.orderprocess;
                p.delivery.clearHtml();

                //load配送信息=>load支付信息 sync
                //p.delivery.clearHtml();
                
                G.app.orderprocess.customDelivery.loadCustomDelivery(data.CustomDelivery.DeliveryId, orderPageData.CustomDeliveryList, { ConsigneeName: consigneeName, ConsigneeMobile: consigneeMobile, ConsigneeTel: consigneeTel });
                p.delivery.loadDelivery(orderPageData.OrderDelivery2);
                p.payment.loadPayment(orderPageData.OrderPayment3);
                //p.commodities.loadCommodities(orderPageData)
                G.app.orderprocess.giftCommodities.loadCommodities(orderPageData.LstCommodityInfo5Gift);
                G.app.orderSubmit.initMoney(orderPageData.OrderMoney7);
                if (p.coupon.hasLoadData == false) {
                    p.coupon.init();//重新选择地址后会清空优惠代码 
                } else {
                    p.coupon.reSelectedCoupon(orderPageData.OrderCoupon6);
                }
                XF.widget.msgbox.hide();
            } else {
                if (self.currConsigneeId != consigneeId) {
                    self.recoverPreSelected(self.currConsigneeId);
                } else {
                    G.app.orderSubmit.disabledSubmitBtn();
                }
                XF.widget.msgbox.hide();
                G.alert.warn(d.ReturnMsg);
            }
        });
    },
    recoverPreSelected: function (currConsigneeId) {
        $("#receive1 li").find("#ConsigneeId").each(function (i, item) {
            var input = $(item).closest("li").find("input");
            input.removeAttr("checked");
            input.parent().removeClass("selected");
            if ($(item).html() == currConsigneeId) {
                input.click();
            }
        });
        G.app.orderSubmit.disabledSubmitBtn();
        ////p.delivery.notSelectReceiving();
        ////step1:清除当前选中的不可达地址
        //$("#receive1 li").find(":checked").first().removeAttr("checked");
        ////step2:恢复原来的地址 
        //if (currConsigneeId.length > 0) {
        //    $("#receive1 li").find("#ConsigneeId").each(function (i, item) {
        //        if ($(item).html() == currConsigneeId) {
        //            $(item).closest("li").find(":radio").first().attr("checked", "checked");
        //            G.app.orderSubmit.enableSubmitBtn();//提交按钮也同时恢复.
        //        }
        //    })
        //} else {
        //    G.app.orderSubmit.disabledSubmitBtn();
        //}

        XF.widget.msgbox.hide();
        return;
    },
    getOrderPageData: function (consigneeId) {
        //验证收货地址是否可以配送
        var obj = null;
        //var data = { "ConsigneeId": consigneeId };
        var data = G.app.orderSubmit.getOrderData();
        data.ConsigneeId = consigneeId;
        G.util.ajax.post("/Order2Delivery/Index?datestamp=" + new Date().getTime(), data, function (d) {
            if (d.ReturnState == 3) {
                obj = d.O;
            } else {
                G.ui.popup.showMsg(d.ReturnMsg, 2, $.noop);
            }
        });
        return obj;//must sync
    },
    AddressInfo: function () {
        return {
            ConsigneeId: "",
            ConsigneeName: "",
            ConsigneeMobile: "",
            AreaId: "",
            DistrictId: "",
            IsOuterLoop: "",
            ConsigneeAddress: "",
            ConsigneeTel: "",
            PostCode: "",
            ProvinceId: "",
            ProvinceName: "",
            AreaName: "",
            ConsigneeType: 0
        };
    }
};
G.app.orderprocess.customDelivery = {
    clearCustomDelivery: function() {
        $("#customDelivery").find(".pickup-addr").html("");
        $(".selectCustomDeliveryTips").hide();
    },
    loadCustomDelivery: function (DeliveryId,OrderCustomDelivery, ConsigneeInfo) {
        var customDeliverys = [];
        if (OrderCustomDelivery) {
            $.each(OrderCustomDelivery, function (i, item) {
                var checked = "";
                var checkedCss = "";
                if (item.DeliveryId == DeliveryId) {
                    checked = "checked";
                    checkedCss = "selected";
                    $(".selectCustomDeliveryTips").show();
                }
                customDeliverys.push('<li><label class="' + checkedCss + '"><input type="checkbox" name="" data-id="' + item.DeliveryId + '" ' + checked + '><span>' + item.AddressDetail + '，'+item.ContactName+" "+ item.ContactPhone + '</span><b></b></label></li>');
            });
        }
        if (customDeliverys.length > 0) {
            $("#customDelivery").find(".pickup-addr").html(customDeliverys.join(''));
            $("#customDelivery").show();
            if (ConsigneeInfo) {
                $("#customDelivery").find("input[name=Custom-ConsigneeName]").val(ConsigneeInfo.ConsigneeName);
                $("#customDelivery").find("input[name=Custom-ConsigneePhone]").val(ConsigneeInfo.ConsigneeMobile != "" ? ConsigneeInfo.ConsigneeMobile : ConsigneeInfo.ConsigneeTel);
            }
        } else {
            $("#customDelivery").find(".pickup-addr").html("");
            $("#customDelivery").hide();
            $("#customDelivery").find("input[name=Custom-ConsigneeName]").val("");
            $("#customDelivery").find("input[name=Custom-ConsigneePhone]").val("");
        }
    },
    bindEvent: function() {
        $("#customDelivery").find(".pickup-addr").delegate("input[type=checkbox]", "click", function () {
            var isCheck = $(this).is(':checked');
            $("#customDelivery").find(".pickup-addr input[type=checkbox]").each(function () {
                $(this).removeAttr("checked");
                $(this).parent().removeClass("selected");
            });
            if (isCheck) {
                $(this).attr("checked", true);
                $(this).parent().addClass("selected");
                $("#receive1").parent().hide();
                $("#customDelivery").find(".selectedConsignee").show();
            } else {
                $("#receive1").parent().show();
                $("#customDelivery").find(".selectedConsignee").hide();
            }
            G.app.orderprocess.address.addressSelected($("#order1 .o-receive li").find("input:checked").eq(0).closest("li"),true);
        });
        $("#customDelivery").delegate(".selectedConsignee", "click", function () {
            $("#receive1").parent().show();
            $(this).hide();
        });
        $("#myModal3").delegate(".btn-save", "click", function () {
            $("#customDelivery").find(".pickup-agree input").attr("checked", true);
        });
    }
};
G.app.orderprocess.delivery = {
    clearHtml: function () {
        //$(".o-delivery").html("");
        //$(".o-payment").html("");
        $(".o-delivery").empty();
        $(".o-payment").empty();
    },
    notSelectReceiving: function () {
        $(".o-delivery").html('<div style="color:red;">请选择收货信息后确认送货时间！</div>');
        $(".o-payment").html('<div style="color:red">请选择收货信息后确认支付方式！</div>');
    },
    loadDelivery: function (OrderDelivery2) {
        var obj = OrderDelivery2;
        //G.app.orderprocess.data.orderDelivery = obj;
        //获取并赋值配送信息
        $("#deliveryTmpl").tmpl(obj).appendTo(".o-delivery");
        var ary = obj.DeliveryDateList;
        var len = ary.length;

        //DateList 展示 头和body分开处理
        $("#myModal2 .modal-body").find("thead tr").find("th").first().siblings().remove();
        $.each(ary, function (i, item) {
            var th = '<th>' + item.Week + '<br>' + item.Day + '</th>';
            $("#myModal2 .modal-body").find("thead tr").append(th);
        });
        var dayStr = "全天09:00-21:00";
        if ($("#customDelivery").find(".pickup-addr input:checked").length > 0) {
            dayStr = "全天11:00-19:00";
        }
        $("#myModal2 .modal-body").find("tbody tr").eq(0).find("td").eq(0).html(dayStr);
            
        var SelectedDateCol = obj.SelectedDateCol;
        var DefaultDeliveryPeriod = obj.DefaultDeliveryPeriod;
        if (obj.IsTiming) {
            $("#myModal2").find(".modal-body p").show();
            $("#myModal2 .modal-body").find("tbody tr").each(function (i, item) {
                $(item).find("td").first().siblings().remove();
                var td = '<td><a href="###">可选</a></td>';
                var tdSelected = '<td class="selected"><a href="#">已选</a><b></b></td>';
                for (var j = 0; j < len; j++) {
                    if (i == DefaultDeliveryPeriod && j == SelectedDateCol) {
                        $(item).append(tdSelected).show();
                    } else {
                        $(item).append(td).show();
                    }
                }
            });
        } else {//不显示上午、下午、晚上
            //$("#myModal2").find(".modal-body p").hide();
            //$("#myModal2 .modal-body").find("tbody tr").first().siblings().remove();
            $("#myModal2 .modal-body").find("tbody tr").first().siblings().hide();
            var tr1 = $("#myModal2 .modal-body").find("tbody tr").first();
            tr1.find("td").first().siblings().remove();
            var td = '<td><a href="###">可选</a></td>';
            var tdSelected = '<td class="selected"><a href="#">已选</a><b></b></td>';
            for (var j = 0; j < len; j++) {
                if (j == SelectedDateCol) {
                    tr1.append(tdSelected);
                } else {
                    tr1.append(td);
                }
            }
        }
        //更新运费金额
        G.app.orderSubmit.setFreight(obj.Freight);
        //刷新应付款 
        G.app.orderSubmit.calPayables();

        //设定时间选择事件，清除老的选中，标记新的选中。
        this.selectedEvent(ary);
    },
    selectedEvent: function (ary) {
        var self = this;
        $("#myModal2 .modal-body tbody").find("tr").each(function (i, item) {
            $(item).find("td").first().siblings().unbind("click").click(function () {
                XF.widget.msgbox.show("数据加载中...", 0, 8000, true);
                clearTimeout(self.timeoutHandle);
                //$("#myModal2 .modal-body tbody").find("tr td").filter(".selected").removeClass("selected").find("b").remove();
                //$(this).addClass("selected").append('<b></b>');
                //$("#theTimecolse").click();

                //赋值选中时间
                var indexX = $(this).index() - 1;
                var obj = ary[indexX];
                var indexY = $(this).parent("tr").index();
                $("#theDeliveryDate").html(obj.Week + " " + obj.Day + " " + obj.Period[indexY]);
                $("#theSelectedDeliveryDate").html(obj.DateString);
                $("#theSelectedPeriod").html(indexY);
                //选中定时配增加附加费的，重新计算运费(定时配上午、下午、晚上，活鲜运费) 运费不变的不用重新计算  
                if (indexY > 0 || 1 == 1) {
                    if ($("#receive1 li").find(":checked").size() <= 0) {
                        XF.widget.msgbox.hide();
                        G.alert.warn("请选择送货地址！");
                        return;
                    }
                    var li = $("#receive1 li").find(":checked").first().closest("li");
                    var consigneeId = li.find("#ConsigneeId").html();
                    //var data = { "ConsigneeId": consigneeId, "deliveryPeriod": indexY };
                    var data = G.app.orderSubmit.getOrderData();
                    data.ConsigneeId = consigneeId;
                    data.DeliveryPeriod = indexY;
                    var innerSelf = this;
                    G.util.ajax.asyncPost("/Order2Delivery/GetFreight?datestamp=" + new Date().getTime(), data, function (d) {
                        if (d.ReturnState == 3) {
                            var orderPageData = d.O;
                            G.app.orderSubmit.setFreight(orderPageData.OrderDelivery2.Freight);
                            //G.app.orderSubmit.initMoney(orderPageData.OrderMoney7);
                            G.app.orderSubmit.calPayables();
                            //新的选中项
                            $("#myModal2 .modal-body tbody").find("tr td").filter(".selected").find("a").html("可选");
                            $("#myModal2 .modal-body tbody").find("tr td").filter(".selected").removeClass("selected").find("b").remove();
                            $(innerSelf).addClass("selected").append('<b></b>');
                            $(innerSelf).find("a").html("已选");
                            $("#theTimecolse").click();
                            XF.widget.msgbox.hide();
                        } else {
                            XF.widget.msgbox.hide();
                            if (d.ReturnMsg == null) {
                                G.ui.popup.showMsg("操作出错，请刷新页面重试！", 2, $.noop);
                            } else {
                                G.ui.popup.showMsg(d.ReturnMsg, 2, $.noop);
                            }
                        }
                    });
                }
            });
        });
    },
    reCalFreight: function () {
        //重新计算运费

        //修改运费值界面显示

        //刷新计算应付款
        G.app.orderSubmit.calPayables();
    }
};
G.app.orderprocess.payment = {
    clearHtml: function () {
        $(".o-delivery").empty();
        $(".o-payment").empty();
    },
    notSelectReceiving: function () {
        $(".o-delivery").html('<div style="color:red;">请选择收货信息后确认送货时间！</div>');
        $(".o-payment").html('<div style="color:red">请选择收货信息后确认支付方式！</div>');
    },
    init: function () {
        //支付方式-修改
        $(".method .edit").unbind("click").click(function () {
            if ($(".o-pay").is(':hidden')) {
                $(".o-pay").slideDown('slow');
                $(".method").slideUp('slow');
            } else {
                $(".o-pay").slideUp('slow');
                $(".method").slideDown('slow');
            }
        });
        //支付方式-选择其他支付方式
        $(".selectother").unbind("click").click(function () {
            if ($(".other").is(':hidden')) {
                $(".other").slideDown('slow');
            } else {
                $(".other").slideUp('slow');
            }
        });
        $("#order3 .o-pay").find(":radio").filter("input[tagid!='']").each(function (i, item) {
            $(item).unbind("click").click(function () {
                $("#theOnlinePay").removeAttr("checked");
                $("#order3 .o-pay").hide();
                if ($(this).closest(".onlinePaymentList").length>0) {
                    $("#theOnlinePay").attr("checked", "checked");
                }
                var paymentId = $(this).attr("tagId");
                var paymentName = $(this).attr("tagName");
                var paymentIcon = $(this).parent().find('.pay-bank>img');
                
                
                if (paymentId == "A4C0B15B-B686-48A4-9684-2CF61FAAA13D" || paymentId == "065A7A0C-B42C-4445-8B80-5686C48E4666") {
                    $("#chkIsDisplyPrice").removeAttr("checked");
                }
                if (paymentIcon.length > 0 && paymentIcon.attr("src") != '') {
                    $("#order3 .method").find("#paymentIcon").find("img").attr("src", paymentIcon.attr("src"));
                    $("#order3 .method").find("#paymentIcon").show();
                } else {
                    $("#order3 .method").find("#paymentIcon").find("img").attr("src", "");
                    $("#order3 .method").find("#paymentIcon").hide();
                }
                $("#order3 .method").find("#paymentName").html(paymentName);
                $("#order3 .method").find("#paymentId").html(paymentId);
                $("#order3 .method").show();
                $(this).closest(".o-pay").find("input").each(function () {
                    $(this).parent().removeClass("on");
                });
                $(this).parent().addClass("on");
                if ($("#thePrePay").is(":checked") && G.app.orderSubmit.getPayables()==0) {
                    $("#thePrePay").removeAttr("checked");
                    G.app.orderSubmit.calPayables();
                }
            });
        });
        $("#thePrePay").unbind("click").click(function () {
            if ($("#thePrePay").attr("checked")) {
                $("#paymentId").html($("#thePrePay").attr("tagid"));
                $("#paymentName").html($("#thePrePay").attr("tagname"));
                $("#paymentIcon").hide();
            } else {
                if ($("#paymentId").html() == "79D283C3-9539-48FA-BEE8-8B4D728FB5CF" || $("#paymentName").html() == "预存款余额") {
                    var payment = G.app.orderSubmit.getPaymentEle();
                    if (payment) {
                        $("#paymentId").html(payment.attr("tagid"));
                        $("#paymentName").html(payment.attr("tagname"));
                        var paymentIcon = payment.parent().find('.pay-bank>img');
                        if (paymentIcon.length > 0 && paymentIcon.attr("src") != '') {
                            $("#paymentIcon").find("img").attr("src", paymentIcon.attr("src"));
                            $("#paymentIcon").show();
                        }
                        
                    } else {
                        $("#paymentId").empty();
                        $("#paymentName").empty();
                    }
                }
            }
            G.app.orderSubmit.calPayables();
        });
    },
    setPayment: function (o) {
        $("#paymentId").html(o.attr("tagid"));
        $("#paymentName").html(o.attr("tagname"));
        var paymentIcon = o.parent().find('.pay-bank>img');
        if (paymentIcon.length > 0 && paymentIcon.attr("src") != '') {
            $("#paymentIcon").find("img").attr("src", paymentIcon.attr("src"));
            $("#paymentIcon").show();
        } else {
            $("#paymentIcon").find("img").attr("src", "");
            $("#paymentIcon").hide();
        }
    },
    loadPayment: function (OrderPayment3) {
        $(".o-payment").empty();
        var obj = OrderPayment3;
        $("#paymentTmpl").tmpl(obj).appendTo(".o-payment");
        //支付处理页面显示控制
        if (obj.DisabledDeposits) {
            $("#thePrePay").attr("disabled", true).closest("label").css("color", "#DAD0D3");
        } else {
            if (obj.UsePrePay==1) {
                $("#thePrePay").removeAttr("disabled").attr("checked", true);
                this.setPayment($("#thePrePay"));
                ////计算预存款实际抵扣金额
                //$("#hidDepositDeduction").val(obj.Deposits);
            }
        }
        if (obj.SelectedPaymentId.length > 0) {
            var t = $("#order3 .o-payment").find("input[tagid='" + obj.SelectedPaymentId + "']");
            if (t.size() > 0) {
                t.first().removeAttr("disabled").attr("checked", true);
                this.setPayment(t.first());
                //SandPay，Guanaitong，TongLianPay支付时，显示；否则不显示.
                var paymentId=obj.SelectedPaymentId;
                if (paymentId == "C49A0810-3965-4B8C-B7CB-B03BD5FABBEE" || paymentId == "803A72C9-0053-4926-9F90-0C1B9EC98FFA" || paymentId == "D371CFAC-78FA-42C6-A528-34CF6880104B") {
                    $("#" + paymentId).show();
                } 
            }
        }
        if (obj.DisabledPaymentIds.length > 0) {
            $.each(obj.DisabledPaymentIds, function (i, o) {
                var t = $("#order3 .o-payment").find("input[tagid='" + o + "']");
                if (t.size() > 0) {
                    t.first().attr("disabled", true).closest("div.o-pay-label").addClass("disabled");
                }
            });
        }
        if (obj.IsDisplyPrice==1) {
            $("#chkIsDisplyPrice").attr("checked", true);
        }
        //不选择默认支付方式，不默认使用预付款余额 
        this.init();
    }
};
G.app.orderprocess.invoice = {
    init: function () {
        //$("#theInvoiceTitle").hide();
        $(".o-invoice-info").find("#some").unbind("click").click(function (i, item) {
            $("#theInvoiceTitle").show();
        });
        $(".o-invoice-info").find("#one").unbind("click").click(function (i, item) {
            $("#theInvoiceTitle").hide();
        });
        var self = this;
        //发票4  点击需要发票
        $(".o-invoice input:checkbox").unbind("change").change(function () {
            if ($(".o-invoice-item").is(':hidden')) {
                $(".o-invoice-item").slideDown('slow');
            } else {
                $(".o-invoice-item").slideUp('slow');
            }
        });
        $('.o-invoice-item .add-info').unbind("click").click(function () {
            if ($(".o-invoice-info").is(':hidden')) {
                $(".o-invoice-info").slideDown('slow');
            } else {
                $(".o-invoice-info").slideUp('slow');
            }
        });

        $('.o-invoice-item .j_style label').unbind("click").click(function () {
            if ($(this).hasClass("selected") || $(this).hasClass("disabled")) return;
            $(this).addClass("selected").siblings("label").removeClass("selected");
            var style = $(this).data("style");
            if (style === 1) {
                $(".o-invoice-item .j_content").hide();
            } else {
                $(".o-invoice-item .j_content").show();
                $(".o-invoice-item .j_content label").eq(1).addClass("selected").siblings("label").removeClass("selected");
            }
        });

        $('.o-invoice-item .j_content label').unbind("click").click(function () {
            $(this).addClass("selected").siblings("label").removeClass("selected");
        });

        $(".o-invoice-item .o-invoice-list").find("input:radio").each(function (i, item) {
            $(item).unbind("click").click(function() {
                $(item).closest("label").addClass("selected").closest(".o-invoice-list").siblings(".o-invoice-list").find("label").removeClass("selected");
                if ($(item).siblings("span.item-type").text() == "普通发票（单位）") {
                    $('.o-invoice-item .j_style label:contains("纸质发票")').addClass("selected").siblings("label").removeClass("selected").addClass("disabled");
                    $(".o-invoice-item .j_content").show();
                } else {
                    $('.o-invoice-item .j_style label').removeClass("disabled");
                }
            });
        });

        //add invoice
        $("#theInvoiceSave").unbind("click").click(function () {
            self.addInvoice();
        });

        //delete Invoice
        $(".o-invoice-item ").find(".o-invoice-list .btn-del").each(function (i, item) {
            $(item).unbind("click").click(function () {
                G.ui.popup.showMsg("请确认删除？", { okFn: function () { self.delInvoice(item); }, btns: 3, okText: "删除", cancelText: "取消" });
            });
        });

        //cancel Invoice
        $("#theInvoiceCancel").unbind("click").click(function () {
            if ($(".o-invoice-info").is(':hidden')) {
                //$(".o-invoice-info").slideDown('slow');
            } else {
                $(".o-invoice-info").slideUp('slow');
            }
        });
    },
    delInvoice: function (item) {
        var UserInvoiceId = $(item).siblings("#UserInvoiceId").html();
        G.util.ajax.post("/Order4Invoice/DelInvoice?datestamp=" + new Date().getTime(), { "UserInvoiceId": UserInvoiceId }, function (d) {
            if (d.ReturnState == 3) {
                $(item).closest(".o-invoice-list").remove();
            } else {
                G.ui.popup.showMsg(d.ReturnMsg, 2, $.noop);
            }
        });
    },
    addInvoice: function () {
        if ($("#order4 .o-invoice-item").find(".o-invoice-list").size() >= 4) {
            G.alert.warn("最多添加四个发票！");
            return;
        }

        var self = this;
        var tempInvoiceTitle = "";
        var info = self.InvoiceInfo();
        var chk = $("#one").attr("checked");
        if (chk) {
            info.InvoiceTitle = "个人";
            info.UnitName = "个人";
            tempInvoiceTitle = G.util.html.encode("个人");
        } else {
            tempInvoiceTitle = G.util.html.encode($("#theInvoiceTitle").val());
            info.InvoiceTitle =encodeURIComponent($("#theInvoiceTitle").val());
            info.UnitName = "单位";
            if ($.strlen($.trim($("#theInvoiceTitle").val())) == 0) {
                G.alert.warn("单位发票抬头不能为空！");
                return;
            }
            if ($.strlen($("#theInvoiceTitle").val()) > 100) {
                G.alert.warn("单位发票抬头过长！");
                return;
            }
        }
        
        var hasSame=false;
        $("#order4 .o-invoice-item").find(".o-invoice-list").each(function (i, item) {
            if ($(item).find(".item-tit").html().substring(5) == tempInvoiceTitle) {
                hasSame = true;
                return;
            }
        });
        if (hasSame) {
            G.alert.warn("已存在相同的发票抬头！");
            return;
        }
        info.InvoiceContent = "水果";
        G.util.ajax.post("/Order4Invoice/AddInvoice?datestamp=" + new Date().getTime(), info, function (d) {
            if (d.ReturnState == 3) {
                //新增发票信息 事件 发票只做删除和添加操作，无修改操作。新增发票保存，收起新增，并默认选中最新加入的发票.
                var invoice = d.O;
                $('.o-invoice-item .j_content').after($.tmpl(G.app.OrderTPL.InvoiceTPL, invoice));
                //$.tmpl(G.app.OrderTPL.InvoiceTPL, invoice).prependTo(".o-invoice-item");
                self.init();
                $(".o-invoice-item").find(".o-invoice-list").find("input:radio").first().attr("checked", "checked").closest(".o-invoice-list").siblings(".o-invoice-list").find("label").removeClass("selected");
                $("#theInvoiceCancel").click();
            } else {
                G.ui.popup.showMsg(d.ReturnMsg, 2, $.noop);
            }
        });
    },
    InvoiceInfo: function () {
        return {
            UnitName: "",
            InvoiceTitle: "",
            InvoiceContent: ""
        }
    }
};
G.app.orderprocess.commodities = {
    clearHtml: function () {
        //$("#order5 .o-commodity").html("");
        $("#order5 .o-commodity").empty();
    },
    loadCommodities: function (orderPageData) {
        this.clearHtml();
        var obj = orderPageData.LstCommodityInfo5;

        $(".o-commodity").setTemplateElement("commoditiesTmpl").processTemplate(obj);
        //$("#commoditiesTmpl2").tmpl(obj).appendTo($(".o-commodity"));
        //console.log("end_LstCommodityInfo5");
    }
};
G.app.orderprocess.giftCommodities = {
    loadCommodities: function(orderGifts) {
        $(".o-commodity").find(".orderGiftCommodity").remove();
        if (orderGifts && orderGifts.length > 0) {
            $.each(orderGifts, function (index, item) {
                var tips = '<i class="i-butui" title="不支持七天无理由退换货"></i>';
                if (item.SmallCategoryId && item.SmallCategoryId.toUpperCase().indexOf('8076E80B-AF49-4C0F-A71C-233C6548F4D0') >= 0) {
                    tips = '<i class="i-tuihuo" title="支持七天无理由退换货"></i>';
                }
                $(".o-commodity tbody").append("<tr class='orderGiftCommodity'><td><a href='" + (G.DOMAIN.www + '/product/' + item.CommodityCode + '.html') + "'>" + item.CommodityName + "</a>" + tips + "</td><td>￥0.00</td><td>" + item.CommodityAmount + "</td><td>" + item.Spec + "</td><td>￥0.00</td></tr>");
            });
        }
    }
};
G.app.orderprocess.coupon = {
    hasLoadData: false,
    prevOrderCoupon: {},
    init: function () {
        this.initdata();
        this.eventBind();
        this.newEventBind();
        G.app.orderSubmit.enableSubmitBtn();
        G.app.orderSubmit.calPayables();
    },
    initdata: function () {
        var self = this;
        var totalCount = 0;
        //load 绑定账户的优惠券
        var data = {};//userId,areaCode
        G.util.ajax.post("/Order6CardCoupons/GetLotteryList?datestamp=" + new Date().getTime(), data, function (d) {
            if (d.ReturnState == 3) {
                var obj = d.O;
                var ary512 = [];
                var ary0 = [];
                var ary128 = [];
                //var ary64 =[];
                var aryNormal = [];
                if (obj && obj.length > 0) {
                    $.each(obj, function (i, item) {
                        if (item.LotteryType == 512) {
                            ary512.push(item);
                        } else if (item.LotteryType == 0) {// && item.UseCount == -1
                            ary0.push(item);
                        } else if (item.LotteryType == 128 || item.LotteryType == 4096) {
                            ary128.push(item);
                        } else if (item.LotteryType == 256) {//暂时不做，db没有数据
                            ary128.push(item);
                        } else if (item.LotteryType == 8) {//充值

                        } else if (item.LotteryType == 1 || item.LotteryType == 2 || item.LotteryType == 4 || item.LotteryType == 64 || item.LotteryType == 1024||item.LotteryType==2048) {
                            aryNormal.push(item);
                            //if (item.LotteryType == 64) {
                            //    ary64.push(item);
                            //}
                        }
                    });
                    var youyuehuiCount = ary512.length;
                    $("#youyuehuiCount").html("(" + youyuehuiCount + ")");
                    self.loadYouyuehuiCoupon(ary512);
                    var lotteryCount = aryNormal.length + ary0.length + ary128.length;
                    $("#lotteryCount").html("(" + lotteryCount + ")");
                    self.loadUserBindCoupon(aryNormal);
                    self.load_0_Coupon(ary0);
                    self.load_128_Coupon(ary128);
                    totalCount += (youyuehuiCount + lotteryCount);
                    //if (ary64.length > 0) {

                    //}
                }
            } else {
                //G.ui.popup.showMsg(d.ReturnMsg, 2, $.noop);
            }
        });
        //load礼品卡
        G.util.ajax.post("/Order6CardCoupons/GetCardList?datestamp=" + new Date().getTime(), data, function (d) {
            if (d.ReturnState == 3) {
                var obj = d.O;
                var cardCount = obj.length;
                $("#cardCount").html("(" + cardCount + ")");
                totalCount += cardCount;
                self.loadCards(obj);
            } else {
                //G.ui.popup.showMsg(d.ReturnMsg, 2, $.noop);
            }
        });
        $("#totalCount").html(totalCount);
        self.hasLoadData = true;
    },
    reSelectedCoupon: function (orderCoupon) {
        var self = this;
        //console.log(orderCoupon.Coupon);
        //console.log(orderCoupon.CouponList);
        //step1:clear old selected & cancel btn
        var tmpBase = $("#order6").find(".o-voucher").find(".item");
        tmpBase.find(":radio").not("input[name^='theUserBindXget1']").not("input[name='theECouponXget1']").removeAttr("checked")
        tmpBase.find(":radio").not("input[name^='theUserBindXget1']").not("input[name='theECouponXget1']").next().find(".cancel").remove();
        tmpBase.find(":checkbox").not("input[name^='theUserBindXget1']").not("input[name='theECouponXget1']").removeAttr("checked");
        tmpBase.find(":checkbox").not("input[name^='theUserBindXget1']").not("input[name='theECouponXget1']").next().find(".cancel").remove();
        //save orderCoupon
        self.prevOrderCoupon = orderCoupon;
        if (orderCoupon == null) return;
        //step2:recover new selected
        var coupon = orderCoupon.Coupon;
        var couponList = orderCoupon.CouponList;
        var LstCashVoucher = orderCoupon.LstCashVoucher;
        var couponKind = 0;
        var couponCode = "";
        if (coupon && coupon != null && coupon.CouponCode != null && coupon.CouponCode.length > 0) {
            couponKind = coupon.CouponKind;
            couponCode = coupon.CouponCode;
            if (couponKind == 1)//非绑定账户的优惠券
            {
                if ($("#posManualECoupon").find(".hidval").find("#ECouponCode").first().html() == couponCode) {
                    $("#posManualECoupon").find(":radio").first().attr("checked", "checked").next().append("<span class='cancel'><a href='###'>取消</a></span>");
                }
            } else if (couponKind == 2) {//绑定账户的优惠券
                $("#theUserBindCoupon").find("li").find(".hidval").find("#LotteryCommodityCode").each(function (i, item) {
                    if ($(item).html() == couponCode) {
                        $(item).closest("li").find(":radio").first().attr("checked", "checked").next().append("<span class='cancel'><a href='###'>取消</a></span>");
                        return;
                    }
                });
            } else if (couponKind == 3) {//礼品卡
                $("#theUserBindCard").find(".hidval").find("#CouponCode").each(function (i, item) {
                    if ($(item).html() == couponCode) {
                        $(item).closest("li").find(":radio").first().attr("checked", "checked").next().append("<span class='cancel'><a href='###'>取消</a></span>");
                        return;
                    }
                });
            }
        }
        if (couponList && couponList != null && couponList.length > 0) {//可多选的券
            $.each(couponList, function (i, o) {
                if (o.LotteryType == 512) {//多选1
                    $("#theyouyuehuiCoupon").find(".hidval").find("#LotteryCommodityCode").each(function (i, item) {
                        if ($(item).html() == o.CouponCode) {
                            $(item).closest("li").find(":radio").first().attr("checked", "checked").next().append("<span class='cancel'><a href='###'>取消</a></span>");
                            return;
                        }
                    });
                } else if (o.LotteryType == 0) {//多选
                    $("#theUserBindCoupon_0").find(".hidval").find("#LotteryCommodityCode").each(function (i, item) {
                        if ($(item).html() == o.CouponCode) {
                            $(item).closest("li").find(":checkbox").first().attr("checked", "checked").next().append("<span class='cancel'><a href='###'>取消</a></span>");
                        }
                    });
                } else if (o.LotteryType == 128 || o.LotteryType == 256 || o.LotteryType == 4096) {//多选
                    $("#theUserBindCoupon_128").find(".hidval").find("#LotteryCommodityCode").each(function (i, item) {
                        if ($(item).html() == o.CouponCode) {
                            $(item).closest("li").find(":checkbox").first().attr("checked", "checked").next().append("<span class='cancel'><a href='###'>取消</a></span>");
                        }
                    });
                }
            })
        }
        //现金券
        if (LstCashVoucher && LstCashVoucher != null && LstCashVoucher.length > 0) {
            $.each(LstCashVoucher, function (i, o) {
                $("#posManualCashVoucher").find("li").find(".hidval").find("#CashVouchersCode").each(function (i, item) {
                    if ($(item).html() == o.CashVouchersCode) {
                        $(item).closest("li").find(":checkbox").first().attr("checked", "checked").next().append("<span class='cancel'><a href='###'>取消</a></span>");
                        //return;//multiple
                    }
                });
            });
        }
        //step3:加取消事件和按钮 inner
        $("#order6").find(".o-voucher").find(".item").find(".cancel").unbind("click").click(function () {
            $(this).closest("li").find("input").not("input[name^='theUserBindXget1']").not("input[name='theECouponXget1']").removeAttr("checked");
            self.selectedAndCancelCoupon(this, 0);
        });
    },
    //绑定账户的优惠代码 绑定事件
    loadYouyuehuiCoupon: function (ary) {
        $("#theyouyuehuiCoupon").empty();
        $.each(ary, function (i, obj) {
            $("#youyuehuiCouponTmpl").tmpl(obj).appendTo($("#theyouyuehuiCoupon"));
        });
    },
    loadUserBindCoupon: function (ary) {
        $("#theUserBindCoupon").empty();
        $.each(ary, function (i, obj) {
            if (obj.LotteryType == 1 || obj.LotteryType == 2 || obj.LotteryType == 1024 || obj.LotteryType == 2048) {//1:满多少钱折扣金额;2:买特定商品抵用金额（抵扣金额累加）
                $("#userBindCoupon_1_2_Tmpl").tmpl(obj).appendTo($("#theUserBindCoupon"));
            } else if (obj.LotteryType == 4) {//4:买满多少钱送商品
                $("#userBindCoupon_4_Tmpl").tmpl(obj).appendTo($("#theUserBindCoupon"));
            } else if (obj.LotteryType == 64) {//64:满足多少元X选一，超过多少元选全部
                var LstXget1 = obj.Xget1;//lst
                if (LstXget1.length > 0) {
                    $("#userBindCoupon_64_Tmpl").tmpl(obj).appendTo($("#theUserBindCoupon"));
                    //load 64
                    var xget1 = obj.LotteryValidate2.Xget1;//bool
                    if (xget1) {
                        $("#theUserBindCoupon").find("li").last().find(".select-gift").setTemplateElement("userBindCoupon_64_One_Tmpl").processTemplate(LstXget1).show();
                        var chooseId = obj.LotteryValidate2.DefaultSelectedId64;
                        $("#theUserBindCoupon").find("li").last().find(".select-gift").find("span.xget1").each(function (i, item) {
                            if ($(item).html() == chooseId) {
                                $(item).siblings(":radio").first().attr("checked", true);
                            }
                        })
                    } else {
                        $("#theUserBindCoupon").find("li").last().find(".select-gift").setTemplateElement("userBindCoupon_64_All_Tmpl").processTemplate(LstXget1).show();
                    }
                }
            }
        });
    },
    load_0_Coupon: function (ary) {
        $("#theUserBindCoupon_0").empty();
        $.each(ary, function (i, obj) {
            $("#userBindCoupon_0_Tmpl").tmpl(obj).appendTo($("#theUserBindCoupon_0"));
        });
    },
    load_128_Coupon: function (ary) {
        $("#theUserBindCoupon_128").empty();
        $.each(ary, function (i, obj) {
            $("#userBindCoupon_128_Tmpl").tmpl(obj).appendTo($("#theUserBindCoupon_128"));
        });
    },
    loadCards: function (o) {
        $("#theUserBindCard").empty();
        $.each(o, function (i, obj) {
            $("#userBindCard_Tmpl").tmpl(obj).appendTo($("#theUserBindCard"));
        });
    },
    selectedAndCancelCoupon: function (o, sc) {//sc:1=selected,0=cancel
        var self = this;
        //校验 
        //1：收货地址必须选择；
        if ($("#receive1 li").find(":checked").size() <= 0) {
            G.alert.warn("请先选择收货信息！");
            return;
        }
        //作废：优惠券和礼品卡不能同时使用，512，0，128可以在优惠券内多选   
        //2：reSelectedCoupon
        XF.widget.msgbox.show("数据加载中...", 0, 300000, true);
        //step=6
        var data = G.app.orderSubmit.getOrderData();
        data.Step = 6;
        G.util.ajax.asyncPost("/Order6CardCoupons/SelectedCoupon?datestamp=" + new Date().getTime(), data, function (d) {
                if (d.ReturnState == 3) {
                    //手动输入部分验证加载不变，点选事件统一调用点击事件.
                    //调整变化项：运费，支付方式限制，金额Panel刷新（优惠金额，运费），将有效的优惠代码置为选中
                    var orderPageData = d.O;
                    var p = G.app.orderprocess;
                    p.payment.loadPayment(orderPageData.OrderPayment3);
                    self.reSelectedCoupon(orderPageData.OrderCoupon6);
                    G.app.orderSubmit.initMoney(orderPageData.OrderMoney7);
                    G.app.orderprocess.giftCommodities.loadCommodities(orderPageData.LstCommodityInfo5Gift);
                    //G.app.orderSubmit.calPayables();
                    XF.widget.msgbox.hide();
                } else {
                    self.reSelectedCoupon(self.prevOrderCoupon);
                    XF.widget.msgbox.hide();
                    G.alert.warn(d.ReturnMsg);
                }
            }
        );
    },
    //卡券事件
    newEventBind: function () {
        var self = this;
        //$("#order6").find(".o-voucher").find(".item:first").find(":radio").removeAttr("checked").end().find(":checked").removeAttr("checked");
        $("#order6").find(".o-voucher").find(".item").find(":radio,:checkbox").not("input[name^='theUserBindXget1']").not("input[name='theECouponXget1']").unbind("click").click(function () {
            if ($(this).next().find(".cancel").size() > 0 && $(this).attr("type") == "radio") {
                return;//已经选中的不再重复操作
            }
            if (!$(this).attr("checked")) {
                $(this).attr("checked", true);
            }
            self.selectedAndCancelCoupon(this, 1);
        });
    },
    obsoleteEventBind: function () {
        //--作废 begin-------
        var self = this;
        var provinceId = $("#receive1 li").find(":checked").closest("li").find("#ProvinceId").html();
        //一.绑定账户的优惠券：
        //使用悠悦会优惠券512 点选事件 ok
        $("#theyouyuehuiCoupon li").find(":radio").each(function (i, item) {//512满多少钱送单一商品
            $(item).unbind("click").click(function () {
                //验证LimitPrice是否符合条件 提交到服务端会重新验证
                var limitPrice = $(this).closest("li").find(".hidval").find("span[id='LimitPrice']").html();
                if (limitPrice == "") { limitPrice = 0; }
                limitPrice = parseFloat(limitPrice);
                var commoditiesMoney = $("#order7 .right").eq(0).find("span").html();
                commoditiesMoney = parseFloat(commoditiesMoney);
                if (commoditiesMoney >= limitPrice) {
                    G.alert.right("使用成功！");
                    return;
                } else {
                    G.alert.warn("购物金额必须大于" + limitPrice + "元");
                    $(this).removeAttr("checked");
                    return;
                }
            });
        });

        //使用优惠券 1,2 4,64 点选事件 
        $("#theUserBindCoupon li").find(":radio").each(function (i, item) {
            $(item).unbind("click").click(function () {
                var commoditiesMoney = $("#order7 .right").eq(0).find("span").html();
                commoditiesMoney = parseFloat(commoditiesMoney);
                var DiscountCoupon = parseFloat($("#hidDiscountCoupon").val());
                var base = $(this).closest("li").find(".hidval");
                var LotteryCommodityId = base.find("span[id='LotteryCommodityId']").html();
                var LotteryType = base.find("span[id='LotteryType']").html();
                var LimitPrice = base.find("span[id='LimitPrice']").html();
                var LimitPrice2 = base.find("span[id='LimitPrice2']").html();

                var PaymentType = base.find("span[id='PaymentType']").html();
                var PaymentId = base.find("span[id='PaymentId']").html();

                LimitPrice = parseFloat(LimitPrice);
                var Discount = parseFloat(base.find("span[id='Discount']").html());
                var CommodityId = base.find("span[id='CommodityId']").html();
                var Batch = base.find("span[id='Batch']").html();

                var selectedPaymentId = "";
                if (PaymentType) {
                    if (PaymentId.length > 0) {
                        if ($("#order3 .o-payment").is(':hidden')) {
                            G.alert.warn("请选择支付方式！");
                            return
                        }
                    }
                }

                //服务端做公共验证
                var cv = self.commonValidate_UserBindCoupon(LotteryCommodityId, provinceId, selectedPaymentId);
                if (cv == null) {
                    G.alert.right("验证失败，请刷新页面重试！");
                    return;
                }
                if (cv.ReturnState != 3) {//清除选中checked标识
                    G.alert.warn(cv.ReturnMsg);
                    $(this).removeAttr("checked");
                    return;
                }
                var lotteryValidate = cv.O;
                if (lotteryValidate.LotteryType == 1) //1满多少钱折扣金额
                {
                    DiscountCoupon = lotteryValidate.Discount;
                    $("#hidDiscountCoupon").val(DiscountCoupon);
                    G.app.orderSubmit.calPayables();
                    $(this).closest("li").siblings().find(":radio").attr("disabled", true);
                    $("#theUserBindCard li").find(":radio").attr("disabled", true);//把礼品卡置为失效
                    //G.alert.right("操作成功！");
                }
                else if (lotteryValidate.LotteryType == 4) {//4买满多少钱送单一商品
                    $(this).closest("li").siblings().find(":radio").attr("disabled", true);
                    $("#theUserBindCard li").find(":radio").attr("disabled", true);
                }
                else if (lotteryValidate.LotteryType == 2) {//2买特定商品抵用
                    DiscountCoupon = lotteryValidate.Discount;
                    $("#hidDiscountCoupon").val(DiscountCoupon);
                    G.app.orderSubmit.calPayables();
                    $(this).closest("li").siblings().find(":radio").attr("disabled", true);
                    $("#theUserBindCard li").find(":radio").attr("disabled", true);
                    //G.alert.right("操作成功！");
                }
                else if (lotteryValidate.LotteryType == 64) {//64满足多少元选全部,超过多少元选全部.
                    if (lotteryValidate.Discount > 0) {
                        $("#hidDiscountFreight").val(lotteryValidate.Discount);//免运费的优惠代码
                        G.app.orderSubmit.calPayables();
                    }
                    var xget1 = lotteryValidate.Xget1;
                    var LstXget1 = lotteryValidate.LstXget1;
                    if (xget1) {
                        $(this).closest("li").find(".select-gift").setTemplateElement("userBindCoupon_64_One_Tmpl").processTemplate(LstXget1).show();
                        var chooseId = lotteryValidate.DefaultSelectedId64;
                        $(this).closest("li").find(".select-gift").find("span.xget1").each(function (i, item) {
                            if ($(item).html() == chooseId) {
                                $(item).siblings(":radio").first().attr("checked", true);
                            }
                        })
                    } else {
                        $("this").closest("li").find(".select-gift").setTemplateElement("userBindCoupon_64_All_Tmpl").processTemplate(LstXget1).show();
                    }
                    $(this).closest("li").siblings().find(":radio").attr("disabled", true);
                    $("#theUserBindCard li").find(":radio").attr("disabled", true);
                } else {

                }
                //操作返回信息
                G.alert.right(cv.ReturnMsg);
            });
        });

        //礼品卡 点选事件 和优惠券不能同时使用
        $("#theUserBindCard li").find(":radio").each(function (i, item) {
            $(item).unbind("click").click(function () {//礼品卡抵扣钱
                var commoditiesMoney = $("#hidAllCommodityMoney").val() //$("#order7 .right").eq(0).find("span").html();
                commoditiesMoney = parseFloat(commoditiesMoney);
                var freight = G.app.orderSubmit.getFreight(); //parseFloat($("#order7 .right").eq(1).find("span").html());
                var DiscountCard = 0;

                var base = $(this).closest("li").find(".hidval");

                var CouponId = base.find("span[id='CouponId']").html();
                var CouponCode = base.find("span[id='CouponCode']").html();
                var StartDate = base.find("span[id='StartDate']").html();
                var EndDate = base.find("span[id='EndDate']").html();
                var CouponPrice = base.find("span[id='CouponPrice']").html();
                CouponPrice = parseFloat(CouponPrice);
                var Batch = base.find("span[id='Batch']").html();
                var Disabled = base.find("span[id='Disabled']").html();

                if (CouponPrice <= G.util.math.add(commoditiesMoney, freight)) {
                    DiscountCard += CouponPrice;
                } else {
                    DiscountCard += G.util.math.add(commoditiesMoney, freight);
                }
                $("#hidDiscountCard").val(DiscountCard);
                G.app.orderSubmit.calPayables();
                $(this).closest("li").siblings().find(":radio").attr("disabled", true);
                $("#theyouyuehuiCoupon li").find(":radio").attr("disabled", true);//把用户绑定的券置为失效
                $("#theUserBindCoupon li").find(":radio").attr("disabled", true);
                $("#theUserBindCoupon_0 li").find(":checkbox").attr("disabled", true);
                $("#theUserBindCoupon_128 li").find(":checkbox").attr("disabled", true);
                G.alert.right("抵扣金额：" + DiscountCard);
            });
        });

        //可多选优惠券：0,128 点选事件 
        //0:赠送商品
        $("#theUserBindCoupon_0 li").find(":checkbox").each(function (i, item) {
            $(item).unbind("click").click(function () {
                //clinet端验证
                var commoditiesMoney = $("#order7 .right").eq(0).find("span").html();
                commoditiesMoney = parseFloat(commoditiesMoney);
                var base = $(this).closest("li").find(".hidval");
                var LimitPrice = base.find("span[id='LimitPrice']").html();
                LimitPrice = parseFloat(LimitPrice);

                if (commoditiesMoney >= LimitPrice) {
                    G.alert.right("操作成功！");
                } else {
                    G.alert.warn("购物金额必须满" + LimitPrice + "元才能使用！");
                    $(this).removeAttr("checked");
                    return;
                }
            });
        });
        //买某些分类的商品抵扣钱    
        $("#theUserBindCoupon_128 li").find(":checkbox").each(function (i, item) {
            $(item).unbind("click").click(function () {
                var LotteryCommodityIds = [];
                $("#theUserBindCoupon_128").find(":checked").each(function (i, item) {
                    var LotteryCommodityId = $(item).closest("li").find(".hidval").find("span[id='LotteryCommodityId']").html();
                    LotteryCommodityIds.push(LotteryCommodityId);
                });
                if (LotteryCommodityIds.length <= 0) return;
                //128买某些分类的商品抵扣钱
                var cv = self.commonValidate_UserBindCoupon128(LotteryCommodityIds);
                if (cv.ReturnState != 3) {
                    G.alert.warn(cv.ReturnMsg);
                    $(this).removeAttr("checked");
                    return;
                }

                $("#hidDiscountCoupon128").val(cv.O.Discount);
                G.app.orderSubmit.calPayables();
            });
        });
        //--作废 end-------
    },//作废
    eventBind: function () {
        var self = this;
        //self.obsoleteEventBind();作废
        //二.手动输入优惠码- 非绑定 
        $("#btnManualECoupon").unbind("click").click(function () {
            var ECouponCode = $.trim($("#theECouponCode").val());
            if (ECouponCode.length == 0) {
                G.alert.warn("请输入优惠码");
                return;
            }
            $("#posManualECoupon ul").empty();//先清空原来的li 非绑定的优惠代码一次只能使用一张券，不能使用多张
            G.util.ajax.post("/Order6CardCoupons/GetECouponByCode?datestamp=" + new Date().getTime(), { "ECouponCode":encodeURIComponent(ECouponCode) }, function (d) {
                if (d.ReturnState == 3) {
                    var obj = d.O;//YgwFctECoupon
                    if (obj.ECouponType == 2) {
                        self.load_2_ECoupon(obj);
                        //self.click_2_ECoupon();
                    } else if (obj.ECouponType == 128) {
                        self.load_128_ECoupon(obj);
                    } else if (obj.ECouponType == 4) {
                        self.load_4_ECoupon(obj);
                        //self.click_4_ECoupon();
                    } else if (obj.ECouponType == 256) {
                        self.load_256_ECoupon(obj);
                    } else if (obj.ECouponType == 8) {
                        self.load_8_ECoupon(obj);
                        //self.click_8_ECoupon();
                    } else if (obj.ECouponType == 64) {
                        self.load_64_ECoupon(obj);
                        //self.click_64_ECoupon();
                    } else {
                        if (obj.ECouponPrice > 0) {
                            self.load_256_ECoupon(obj);
                        } else {
                            self.load_8_ECoupon(obj);
                        }
                    }
                    $("#posManualECoupon").show();
                    //点击选中事件
                    self.newEventBind();
                    //self.click_x_ECoupon(obj.ECouponType);
                    //if (obj.ECouponType == 8 || obj.ECouponType == 64) {
                        $("#posManualECoupon ul li").find("input[name='rdiECoupon']").click();
                    //} 
                } else {
                    G.ui.popup.showMsg(d.ReturnMsg, 2, $.noop);
                }
            });
        });
        //三.礼品卡激活、绑定 ok
        $("#btnManualCard").unbind("click").click(function () {
            var cardCode = $.trim($("#txtCardCode").val());
            var cardPwd = $.trim($("#txtCardPwd").val());
            if (cardCode.length == 0 || cardPwd.length == 0) {
                G.alert.warn("礼品卡号和密码不能为空！");
                return
            }
            //防止重复绑定
            var hasExists = false;
            $("#posManualCard ul").find("li").find(".hidval").find("#CouponCode").each(function (i, item) {
                if ($(item).html() == cardCode) {
                    hasExists = true;
                    G.alert.warn("礼品卡已在下方列表中，请直接选择使用！");
                    return;
                }
            });
            if (hasExists) return;
            var data = { "cardCode": encodeURIComponent(cardCode), "cardPwd": encodeURIComponent(cardPwd) };
            G.util.ajax.postSF("/Order6CardCoupons/ActivateCard?datestamp=" + new Date().getTime(), data, function (d) {
                var obj = d.O;
                self.loadManualActivateCard(obj);
                $("#posManualCard").show();
                self.newEventBind();
                //self.click_Manual_Card_Bind();
                ////点击最后绑定的一条
                //$("#posManualCard ul li").find(":radio").last().click();
            });
        });
        //四.绑定现金券 现金券一次可以使用N张
        $("#btnManualCashVoucher").unbind("click").click(function () {
            var cashVoucher = $.trim($("#txtCashVoucher").val());
            var cashVoucherPwd = $.trim($("#txtCashVoucherPwd").val());
            if (cashVoucher.length == 0 || cashVoucherPwd.length == 0) {
                G.alert.warn("现金券券号和密码不能为空！");
                return
            }
            //检查是否存在已久加载的相同券，服务端做同样验证.
            var hasExists = false;
            if ($("#posManualCashVoucher ul li").size() > 0) {
                $("#posManualCashVoucher ul li").each(function (i, item) {
                    if ($(item).find(".hidval").find("#CashVouchersCode").html() == cashVoucher) {
                        hasExists = true;
                        G.alert.warn("现金券已在下方列表中，请选择使用！");
                        return;
                    }
                })
            }
            if (hasExists) return;
            //$("#posManualCashVoucher ul").empty();//清空原来的li;一次可以使用多个
            var data = { "cashVoucher": encodeURIComponent(cashVoucher), "cashVoucherPwd": encodeURIComponent(cashVoucherPwd) };
            G.util.ajax.postSF("/Order6CardCoupons/BindCashVoucher?datestamp=" + new Date().getTime(), data, function (d) {
                var obj = d.O;
                obj.CashVouchersPwd = cashVoucherPwd;
                self.loadManualBindCashVoucher(obj);
                $("#posManualCashVoucher").show();
                self.newEventBind();
                //self.click_Manual_CashVoucher_Bind();//作废独立处理
                //$("#posManualCashVoucher ul li").find(":checkbox").last().click();
            });
        });
    },
    //绑定账户的优惠代码 公共验证
    commonValidate_UserBindCoupon: function (LotteryCommodityId, provinceId, selectedPaymentId) {//return o;
        var o = null
        var data = { "LotteryCommodityId": LotteryCommodityId, "provinceId": provinceId, "selectedPaymentId": selectedPaymentId };
        G.util.ajax.post("/Order6CardCoupons/CommonValidate_UserBindCoupon?datestamp=" + new Date().getTime(), data, function (d) {
            o = d;
        });
        return o;
    },//作废
    commonValidate_UserBindCoupon128: function (LotteryCommodityIds) {
        var o = null
        var data = { "lotteryCommodityIds": LotteryCommodityIds };
        G.util.ajax.post("/Order6CardCoupons/CommonValidate_UserBindCoupon128?datestamp=" + new Date().getTime(), data, function (d) {
            o = d;
        });
        return o;
    },//作废
    //非绑定账户的优惠代码 公共验证
    commonValidate_ECoupon: function (eCouponCode, provinceId, selectedPaymentId) {
        var o = null
        var data = { "eCouponCode": eCouponCode, "provinceId": provinceId, "selectedPaymentId": selectedPaymentId };
        G.util.ajax.post("/Order6CardCoupons/commonValidate_ECoupon?datestamp=" + new Date().getTime(), data, function (d) {
            o = d;
        });
        return o;
    },//作废
    //非绑定账户的优惠代码：绑定与选中事件
    load_2_ECoupon: function (o) {//2:满多少钱抵扣多少钱
        $("#posManualECoupon ul").empty();//清空原来的li
        $("#eCoupon_2_Tmpl").tmpl(o).appendTo($("#posManualECoupon ul"));
    },
    load_128_ECoupon: function (o) {//2:满多少钱抵扣多少钱
        $("#posManualECoupon ul").empty();//清空原来的li
        $("#eCoupon_128_Tmpl").tmpl(o).appendTo($("#posManualECoupon ul"));
    },
    load_4_ECoupon: function (o) {//4:购买商品折扣钱
        $("#posManualECoupon ul").empty();//清空原来的li
        $("#eCoupon_4_Tmpl").tmpl(o).appendTo($("#posManualECoupon ul"));
    },
    load_256_ECoupon: function (o) {//256:买指定商品减钱，仅减一次
        $("#posManualECoupon ul").empty();//清空原来的li
        $("#eCoupon_256_Tmpl").tmpl(o).appendTo($("#posManualECoupon ul"));
    },
    load_8_ECoupon: function (o) { //8:满多少钱送商品
        $("#posManualECoupon ul").empty();//清空原来的li
        $("#eCoupon_8_Tmpl").tmpl(o).appendTo($("#posManualECoupon ul"));
    },
    load_64_ECoupon: function (o) {//64:满足多少元X选一，超过多少元选全部
        $("#posManualECoupon ul").empty();//清空原来的li
        var LstXget1 = o.Xget1;//lst
        if (LstXget1.length > 0) {
            $("#eCoupon_64_Tmpl").tmpl(o).appendTo($("#posManualECoupon ul"));
            //load 64
            var xget1 = o.ECouponValidate2.Xget1;
            if (xget1) {
                $("#posManualECoupon ul").find("li").find(".select-gift").setTemplateElement("eCoupon_64_One_Tmpl").processTemplate(LstXget1).show();
                var chooseId = o.ECouponValidate2.DefaultSelectedId64;
                $("#posManualECoupon ul").find("li").find(".select-gift").find("span.xget1").each(function (i, item) {
                    if ($(item).html() == chooseId) {
                        $(item).siblings(":radio").first().attr("checked", true);
                    }
                })
            } else {
                $("#posManualECoupon ul").find("li").find(".select-gift").setTemplateElement("eCoupon_64_All_Tmpl").processTemplate(LstXget1).show();
            }
        }
    },
    click_x_ECoupon: function (x) {
        var self = this;
        $("#posManualECoupon ul li").find(":radio").unbind("click").click(function () {
            var base = $(this).closest("li").find(".hidval");
            var eCouponCode = base.find("span[id='ECouponCode']").html();
            var provinceId = $("#receive1 li").find(":checked").closest("li").find("#ProvinceId").html();
            var selectedPaymentId = "";
            //服务端做所有的验证
            var cv = self.commonValidate_ECoupon(eCouponCode, provinceId, selectedPaymentId);
            if (cv.ReturnState != 3) {
                if (cv.ReturnMsg == null) {
                    G.alert.warn("操作出错，请稍后重试！");
                } else {
                    G.alert.warn(cv.ReturnMsg);
                }
                //G.alert.warn(cv.ReturnMsg);
                $(this).removeAttr("checked");
                return;
            }
            var eCouponValidate = cv.O;
            var freight = G.app.orderSubmit.getFreight();
            var sumTotal = G.app.orderSubmit.getCommoditiesMoney();
            var userDiscount = G.app.orderSubmit.getUserDiscount();
            switch (x) {
                case 2://满多少钱抵扣多少钱
                    var discount = eCouponValidate.Discount;
                    if (eCouponValidate.ContainsFreightWord) {
                        if (eCouponValidate.ContainsWDWord) {
                            if (freight > 10) {
                                discount = discount + 10;
                            } else {
                                if (sumTotal - discount < 100) {
                                    discount = discount + 10;
                                } else {
                                    //discount = discount;
                                }
                            }
                        } else {
                            if (sumTotal - discount < 100) {
                                discount = discount + 10;
                            } else {
                                //discount = discount;
                            }
                        }
                    } else {
                        //discount = discount;
                    }
                    $("#hidDiscountCoupon").val(discount)
                    G.app.orderSubmit.calPayables();
                    G.alert.right(cv.ReturnMsg);
                    break;
                case 4://购买商品折扣钱
                    var comnum = eCouponValidate.CommodityCount;
                    var tmpZkUserMoney = 0.00;
                    if (eCouponValidate.ContainsBMOOWord) {
                        tmpZkUserMoney = userDiscount;
                    }
                    var tmpZk = 0 - tmpZkUserMoney;
                    if (eCouponValidate.ContainsFreightWord) {
                        if ((sumTotal - discount * comnum) < 100) {
                            tmpZk += discount * comnum + 10;
                        } else {
                            tmpZk += discount * comnum;
                        }
                    } else {
                        tmpZk += discount * comnum;
                    }
                    $("#hidDiscountCoupon").val(tmpZk)
                    G.app.orderSubmit.calPayables();
                    G.alert.right(cv.ReturnMsg);
                    break;
                case 8://满多少钱送商品
                    if (eCouponValidate.ContainsFreightWord) {
                        var freight = parseFloat($("#hidFreight").val());
                        if (freight > 0) {
                            var discount = eCouponValidate.Discount;
                            if (sumTotal - discount < 100) {
                                discount = 10;
                                //$("#hidDiscountCoupon").val(discount);
                                $("#hidDiscountFreight").val(discount);
                            }
                        }
                    }
                    //else if (eCouponValidate.NoFreight) {
                    //    $("#hidFreight").val(0.00);
                    //}
                    G.app.orderSubmit.calPayables();
                    G.alert.right(cv.ReturnMsg);
                    break;
                case 64://满足多少元X选一，超过多少元选全部 
                    var xget1 = eCouponValidate.Xget1;
                    var LstXget1 = eCouponValidate.LstXget1;
                    if (xget1) {
                        $(this).closest("li").find(".select-gift").setTemplateElement("eCoupon_64_One_Tmpl").processTemplate(LstXget1).show();
                        var chooseId = eCouponValidate.DefaultSelectedId64;
                        $(this).closest("li").find(".select-gift").find("span.xget1").each(function (i, item) {
                            if ($(item).html() == chooseId) {
                                $(item).siblings(":radio").first().attr("checked", true);
                            }
                        })
                    } else {
                        $(this).closest("li").find(".select-gift").setTemplateElement("eCoupon_64_All_Tmpl").processTemplate(LstXget1).show();
                    }
                    break;
                default:
                    break;
            }
        });
    },//作废
    //Manual Card
    loadManualActivateCard: function (o) {
        $("#manualActivateCard_Tmpl").tmpl(o).appendTo($("#posManualCard ul"));
    },
    click_Manual_Card_Bind: function () {//验证在前面的查询部分全部做了，此处只做绑定操作
        $("#posManualCard ul li").find(":radio").unbind("click").click(function () {
            var discount = parseFloat($(this).closest("li").find(".hidval").find("#Price").html());
            $("#hidDiscountCard").val(discount);
            G.app.orderSubmit.calPayables();
        });
    },//作废
    //Manual CashVoucher
    loadManualBindCashVoucher: function (o) {
        $("#manualCashVoucher_Tmpl").tmpl(o).appendTo($("#posManualCashVoucher ul"));
    },
    click_Manual_CashVoucher_Bind: function () {//验证在前面的查询部分全部做了，此处只做绑定操作
        $("#posManualCashVoucher ul li").find(":checkbox").unbind("click").click(function () {
            var discount = parseFloat($(this).closest("li").find(".hidval").find("#Price").html());
            var oldDiscount = parseFloat($("#hidDiscountCashVoucher").val());
            var hasChecked = $(this).is(":checked")
            if (hasChecked) {
                $("#hidDiscountCashVoucher").val(oldDiscount+discount);
            } else {
                $("#hidDiscountCashVoucher").val(oldDiscount-discount);
            }           
            G.app.orderSubmit.calPayables();
        });
    }//作废
};
G.app.orderSubmit = {
    orderLock: 0,
    initMoney: function (OrderMoney7) {
        //$("#hidCommodities").val(OrderMoney7.Commodities);
        $("#hidAllCommodityMoney").val(OrderMoney7.AllCommodityMoney);
        $("#serverFreight").html(OrderMoney7.Freight);
        $("#hidFreight").val(OrderMoney7.Freight);
        $("#hidDepositDeduction").val(OrderMoney7.Deposit);//此处是剩余预存款金额，预存款抵扣依靠this.calPayables();根据是否使用预存款计算出来抵扣金额
        $("#hidUB").val(OrderMoney7.UB);
        //partial discout
        $("#hidDiscountCoupon").val(OrderMoney7.DiscountCoupon);//所有的优惠代码折扣都合在一起.
        $("#hidUserDiscount").val(OrderMoney7.UserDiscount);
        $("#hidCategoryDiscount").val(OrderMoney7.CategoryDiscount);
        //$("#hidDiscountCoupon128").val(OrderMoney7.DiscountCoupon128);
        $("#hidDiscountCard").val(OrderMoney7.DiscountCard);
        $("#hidDiscountCashVoucher").val(OrderMoney7.DiscountCashVoucher);//现金券单独验证
        //var discount = OrderMoney7.UserDiscount + OrderMoney7.DiscountCoupon;
        $("#hidDiscount").val(OrderMoney7.Discount);//没有现金券
        this.calPayables();
    },
    getCommoditiesMoney: function () {
        return parseFloat($("#hidAllCommodityMoney").val());
    },
    getFreight: function () {
        var freight = parseFloat($("#hidFreight").val());
        return freight;
        //运费一律经服务端计算，不在有折扣运费概念
        //var discountFreight = parseFloat($("#hidDiscountFreight").val());
        //var math = G.util.math;
        //return math.sub(freight, discountFreight);
    },
    getUserDiscount: function () {
        return parseFloat($("#hidUserDiscount").val());
    },
    setFreight: function (freight) {
        $("#hidFreight").val(freight);
        $("#serverFreight").html(freight);
    },
    calPayables: function () {//每次修改金额后，重新计算应付款
        var hidAllCommodityMoney = parseFloat($("#hidAllCommodityMoney").val());

        var hidFreight = G.app.orderSubmit.getFreight(); //parseFloat($("#hidFreight").val());
        var hidDepositDeduction = parseFloat($("#hidDepositDeduction").val());//预存款金额
        var hidDiscount = parseFloat($("#hidDiscount").val());
        var hidUB = parseFloat($("#hidUB").val());
        //
        var hidUserDiscount = parseFloat($("#hidUserDiscount").val());
        var hidDiscountCoupon = parseFloat($("#hidDiscountCoupon").val());
        var hidCategoryDiscount = parseFloat($("#hidCategoryDiscount").val());
        var hidDiscountCashVoucher = parseFloat($("#hidDiscountCashVoucher").val());
        var hidDiscountCard = parseFloat($("#hidDiscountCard").val());
        
        //hidDiscount = hidDiscountCoupon + hidDiscountCard + hidDiscountCashVoucher + hidUserDiscount + hidCategoryDiscount;
        

        var math = G.util.math;
        var v1 = math.add(parseFloat(hidAllCommodityMoney), parseFloat(hidFreight));
        var vPayNoDeposit = math.sub(v1, hidDiscount);
        if (vPayNoDeposit < 0) {
            hidDiscount = v1;
            if (hidUserDiscount + vPayNoDeposit >= 0) {//修正用户折扣
                hidUserDiscount=hidUserDiscount + vPayNoDeposit;
                $("#hidUserDiscount").val(hidUserDiscount);
            } else {
                hidDiscountCashVoucher = hidDiscountCashVoucher +vPayNoDeposit;
            }
            vPayNoDeposit = 0;
        }
        //调整值
        $("#hidDiscountCashVoucher").val(hidDiscountCashVoucher);//现金券
        $("#hidDiscount").val(hidDiscount);//update Discount 优惠券+用户折扣+现金券

        var base7 = $("#order7 .right");
        base7.eq(0).find("span").html(math.changeTwoDecimal_f(hidAllCommodityMoney));
        base7.eq(1).find("span").html(math.changeTwoDecimal_f(hidFreight));
        base7.eq(3).find("span").html(math.changeTwoDecimal_f(hidDiscount));
      
        var desiredDeposit = 0.00;
        if ($("#thePrePay").attr("checked") && hidDepositDeduction > 0)//使用了预存款
        {
            if (hidDepositDeduction >= vPayNoDeposit) {
                desiredDeposit = vPayNoDeposit;
            } else {
                desiredDeposit = hidDepositDeduction;
            }
        }
        base7.eq(2).find("span").html(math.changeTwoDecimal_f(desiredDeposit));
        base7.eq(4).find("span").html(math.changeTwoDecimal_f(hidUB));

        var base71 = $("#order71 .right span");
        base71.eq(1).find("em").last().html(math.changeTwoDecimal_f(hidAllCommodityMoney));
        base71.eq(0).find("em").last().html(math.changeTwoDecimal_f(hidFreight));
        var thePayables = base71.eq(2).find("em").last();

        var v2 = math.add(parseFloat(desiredDeposit), parseFloat(hidDiscount));
        var payables = math.sub(v1, v2);
        thePayables.html(math.changeTwoDecimal_f(payables));

        window.__zp_tag_params = {
            pagetype: "SampleChoose",
            p_zp_conversion: "e578c476192f20c9ee970d5671ee2e89",
            p_zp_convinfo: "," + math.changeTwoDecimal_f(payables) + ""
        };

    },
    getPayables:function(){
        var base71 = $("#order71 .right span");
        var thePayables = base71.eq(2).find("em").last();
        return parseFloat(thePayables.html());
    },
    disabledSubmitBtn: function () {
        $("#btnOrderSubmit").css("background-color", "rgb(202, 201, 201)").unbind("click");
    },
    enableSubmitBtn: function () {
        var self = this;
        $("#btnOrderSubmit").css("background-color", "#ff5317").unbind("click").click(function () {
            self.orderSubmit();
        });
    },
    getPaymentEle: function () {
        return $("#order3 .o-pay").find("input[name=payment]:checked").first();
    },
    orderSubmit: function () {
        if (this.orderLock > 0) return;
        this.orderLock = this.orderLock + 1;
        $("#btnOrderSubmit").css("background-color", "rgb(202, 201, 201)").css("Cursor", "wait");//text
        G.app.Loading.open();
      
        if ($("#order2 .o-delivery").has(".table").size() == 0) {
            G.app.Loading.close();
            this.orderLock = 0;
            $("#btnOrderSubmit").css("background-color", "rgb(255, 83, 23)").css("Cursor", "pointer");
            G.alert.warn("请先确认配送信息！");
            return
        }
        var isUseCustomDelivery = $("#customDelivery").find(".pickup-addr input:checked").length > 0;
        if (isUseCustomDelivery && $("#customDelivery").find(".pickup-agree input:checked").length == 0) {
            G.app.Loading.close();
            this.orderLock = 0;
            $("#btnOrderSubmit").css("background-color", "rgb(255, 83, 23)").css("Cursor", "pointer");
            G.alert.warn("请确认已阅读并同意《易果生鲜自提服务协议》！");
            return
        }
        //if ($("#order3 .o-payment .method").is(':hidden')) {
        if ($("#order3 .o-payment").is(':hidden')) {
            G.app.Loading.close();
            this.orderLock = 0;
            $("#btnOrderSubmit").css("background-color", "rgb(255, 83, 23)").css("Cursor", "pointer");
            G.alert.warn("请选择支付方式！");
            return
        }

        if ($("#order4").find(".o-invoice").find(":checkbox").is(":checked")) {
            if ($("#order4").find(".o-invoice").find(".o-invoice-list").find("input[name='theInvoice']").is(":checked") == false) {
                G.app.Loading.close();
                this.orderLock = 0;
                $("#btnOrderSubmit").css("background-color", "rgb(255, 83, 23)").css("Cursor", "pointer");
                G.alert.warn("请选择发票！");
                return;
            }
        }
        if ($.trim($("#txtWebRemark").val()).length > 200) {
            G.app.Loading.close();
            this.orderLock = 0;
            $("#btnOrderSubmit").css("background-color", "rgb(255, 83, 23)").css("Cursor", "pointer");
            G.alert.warn("补充说明内容过长！");
            return;
        }
        if ($("#OrderUserMobile").val().length > 0 && !G.util.validation.isMobile($("#OrderUserMobile").val())) {
            G.app.Loading.close();
            this.orderLock = 0;
            $("#btnOrderSubmit").css("background-color", "rgb(255, 83, 23)").css("Cursor", "pointer");
            G.alert.warn("订货人手机格式有误，请重新输入！");
            return;
        }
        if ($.trim($("#OrderUserMobile").val()).length > 0 || $.trim($("#OrderUserName").val()).length > 0) {
            if ($.trim($("#OrderUserMobile").val()).length > 0 && $.trim($("#OrderUserName").val()).length > 0) {

            } else {
                G.app.Loading.close();
                this.orderLock = 0;
                $("#btnOrderSubmit").css("background-color", "rgb(255, 83, 23)").css("Cursor", "pointer");
                G.alert.warn("订货人姓名和订货人手机必须同时输入！");
                return;
            }
        }

        var UsePrePay = 0;
        if ($("#thePrePay").attr("checked")) {
            UsePrePay = 1;
        } else {
            UsePrePay = 0;
        }
        var PaymentId = G.app.orderSubmit.getPaymentEle().attr("tagid");
        if (UsePrePay == 1) {
            var payables = parseFloat($("#order71 span.fs14").find("em").last().html());
            if (payables > 0 && !PaymentId) {
                G.app.Loading.close();
                this.orderLock = 0;
                $("#btnOrderSubmit").css("background-color", "rgb(255, 83, 23)").css("Cursor", "pointer");
                G.alert.warn("请选择支付方式！");
                return;
            }
        } else {
            if (!PaymentId) {
                G.app.Loading.close();
                this.orderLock = 0;
                $("#btnOrderSubmit").css("background-color", "rgb(255, 83, 23)").css("Cursor", "pointer");
                G.alert.warn("请选择支付方式！");
                return;
            }
        }
        
        //提交数据到服务端，服务端再统一验证数据的正确性，不符合的提示并刷新页面.
        var data = this.getOrderData();

        if (isUseCustomDelivery) {
            var customDeliveryErrorMsg = "";
            if (data.CustomDelivery.ConsigneeName == "" || data.CustomDelivery.ConsigneeName.length > 10 || (/<|>/.test(data.CustomDelivery.ConsigneeName))) {
                customDeliveryErrorMsg = "请填写正确的提货人姓名";
            }
            if (customDeliveryErrorMsg == "" && (data.CustomDelivery.ConsigneePhone == "" || data.CustomDelivery.ConsigneePhone.length>11)) {
                customDeliveryErrorMsg = "请填写正确提货人电话";
            }
            if (customDeliveryErrorMsg == "" && data.CustomDelivery.ConsigneePhone.length == 11 && !(/^((1[0-9]{1})+\d{9})$/.test(data.CustomDelivery.ConsigneePhone))) {
                customDeliveryErrorMsg = "提货人手机格式有误";
            }
            if (customDeliveryErrorMsg != "") {
                G.app.Loading.close();
                this.orderLock = 0;
                $("#btnOrderSubmit").css("background-color", "rgb(255, 83, 23)").css("Cursor", "pointer");
                G.alert.warn(customDeliveryErrorMsg);
                return;
            }
        }
        if (data.PaymentId == "C49A0810-3965-4B8C-B7CB-B03BD5FABBEE" && G.app.orderSubmit.getPayables() > 0) {
            if ($.trim(data.InvoiceId).length > 0) {
                G.app.Loading.close();
                this.orderLock = 0;
                $("#btnOrderSubmit").css("background-color", "rgb(255, 83, 23)").css("Cursor", "pointer");
                G.alert.warn("杉德支付不能选择发票！");
                return;
            }
        }
        if (data.PaymentId == "803A72C9-0053-4926-9F90-0C1B9EC98FFA" && G.app.orderSubmit.getPayables() > 0) {
            if ($.trim(data.InvoiceId).length > 0) {
                G.app.Loading.close();
                this.orderLock = 0;
                $("#btnOrderSubmit").css("background-color", "rgb(255, 83, 23)").css("Cursor", "pointer");
                G.alert.warn("关爱通支付不能选择发票！");
                return;
            }
        }
        if (data.PaymentId == "D371CFAC-78FA-42C6-A528-34CF6880104B" && G.app.orderSubmit.getPayables()>0) {
            if ($.trim(data.InvoiceId).length > 0) {
                G.app.Loading.close();
                this.orderLock = 0;
                $("#btnOrderSubmit").css("background-color", "rgb(255, 83, 23)").css("Cursor", "pointer");
                G.alert.warn("通联支付不能选择发票！");
                return;
            }
        }
        if (data.Discount != data.CategoryDiscount + data.UserDiscount + data.DiscountCard + data.CashVoucherDiscount + data.DiscountCoupon) {
            G.alert.warn("页面数据发生变化[101]，请刷新页面重试！");
            G.app.Loading.close();
            this.orderLock = 0;
            $("#btnOrderSubmit").css("background-color", "rgb(255, 83, 23)").css("Cursor", "pointer");
            return;
        }
        if (data.IsDisplyPrice == 1) {//配送单上不显示价格（仅在非货到付款时有效）
            var Payables=parseFloat($.trim($("#order71").find("span.fs14").find("em").last().html()));
            if (Payables > 0 && (data.PaymentId.toUpperCase() == "A4C0B15B-B686-48A4-9684-2CF61FAAA13D" || data.PaymentId.toUpperCase() == "065A7A0C-B42C-4445-8B80-5686C48E4666")) {//
                G.app.Loading.close();
                this.orderLock = 0;
                $("#btnOrderSubmit").css("background-color", "rgb(255, 83, 23)").css("Cursor", "pointer");
                G.alert.warn("货到付款不支持配送单上不显示价格！");
                return;
            }
        }

        _smq.push(['custom', 'index', '订单']);

        var self = this;
        self.asyncAjaxPost("/OrderInfo/OrderSubmit?datestamp=" + new Date().getTime(), data,
            function (d) {
                if (d.ReturnState == 3) {
                    var o = d.O;
                    window.location = G.DOMAIN.test.trade + "/Rush/" + o.OrderId;
                } else {
                    G.app.Loading.close();
                    self.orderLock = 0;
                    $("#btnOrderSubmit").css("background-color", "rgb(255, 83, 23)").css("Cursor", "pointer");
                    G.ui.popup.showMsg(d.ReturnMsg, 2, $.noop);
                }
            },
            function (XMLHttpRequest, textStatus, errorThrown) {
                G.app.Loading.close();
                self.orderLock = 0;
                $("#btnOrderSubmit").css("background-color", "rgb(255, 83, 23)").css("Cursor", "pointer");
                G.ui.popup.showMsg(errorThrown || textStatus, "2", $.noop);
                return;
            }
        );
    },
    getOrderData: function () {
        var d = G.app.orderprocess.data();
        if ($("#receive1 li").find(":checked").size() > 0) {
            d.ConsigneeId = $("#receive1 li").find(":checked").first().closest("li").find("#ConsigneeId").html();
        }
        if ($("#customDelivery").find(".pickup-addr input:checked").length > 0) {
            d.CustomDelivery.DeliveryId = $("#customDelivery").find(".pickup-addr input:checked").eq(0).data("id");
            d.CustomDelivery.ConsigneeName = $("#customDelivery").find("input[name=Custom-ConsigneeName]").val();
            d.CustomDelivery.ConsigneePhone = $("#customDelivery").find("input[name=Custom-ConsigneePhone]").val();
        }

        if ($("#theSelectedDeliveryDate").size() > 0) {
            d.DeliveryDate = $("#theSelectedDeliveryDate").html();
        }
        if ($("#theSelectedPeriod").size()>0) {
            d.DeliveryPeriod = parseInt($("#theSelectedPeriod").html());
        }
        if ($("#theDeliveryMethod").size() > 0) {
            d.DeliveryMethod = $("#theDeliveryMethod").html();
        }
        
        d.Freight = this.getFreight();
        if ($("#thePrePay").attr("checked")) {
            d.UsePrePay = 1;
        } else {
            d.UsePrePay = 0;
        }
        d.PaymentId = G.app.orderSubmit.getPaymentEle().attr("tagid");

        if ($("#order4 .o-invoice").find("input[type='checkbox']").first().is(":checked")) {
            if ($("#order4").find(".o-invoice-item").find(".o-invoice-list").find(":checked").size() > 0) {
                d.InvoiceId = $("#order4").find(".o-invoice-item").find(".o-invoice-list").find(":checked").first().siblings("span[id='UserInvoiceId']").html();

                d.InvoiceStyle = $("#order4").find(".o-invoice-item").find(".j_style label.selected").data("style");
                d.InvoiceContent = $("#order4").find(".o-invoice-item").find(".j_content label.selected").text();
            }
        }
        //512
        if ($("#theyouyuehuiCoupon li").find(":checked").size() > 0) {
            d.LotteryCommodityId512 = $("#theyouyuehuiCoupon li").find(":checked").closest("li").find(".hidval").find("span[id='LotteryCommodityId']").html();
        }
        //UserBindCoupon
        if ($("#theUserBindCoupon li").find(":checked").filter("input[name='theUserCoupon']").size() > 0) {
            d.LotteryCommodityId = $("#theUserBindCoupon li").find(":checked").filter("input[name='theUserCoupon']").closest("li").find(".hidval").find("span[id='LotteryCommodityId']").html();
            if ($("#theUserBindCoupon li").find(":checked").filter("input[name='theUserCoupon']").closest("li").find(".hidval").find("span[id='LotteryType']").html() == "64") {
                if ($("#theUserBindCoupon li").find(":checked").filter("input[name='theUserCoupon']").closest("li").find(".select-gift").find(":radio").size() > 0) {
                    var chooseCommodityId = $("#theUserBindCoupon li").find(":checked").filter("input[name='theUserCoupon']").closest("li").find(".select-gift").find(":checked").siblings("span.xget1").first().html();
                    d.LotteryCommodityChooseId.push(chooseCommodityId);
                } else {
                    $("#theUserBindCoupon li").find(":checked").filter("input[name='theUserCoupon']").closest("li").find(".select-gift").find("span.getAll").each(function (i, item) {
                        var chooseCommodityId = $(item).html();
                        d.LotteryCommodityChooseId.push(chooseCommodityId);
                    });
                }
            }
        }
        //礼品卡
        if ($("#theUserBindCard li").find(":checked").size() > 0) {
            d.CouponCode = $("#theUserBindCard li").find(":checked").closest("li").find(".hidval").find("span[id='CouponCode']").html();
        }
        //非绑定的优惠券
        if ($("#posManualECoupon ul li").find(":checked").filter("input[name='rdiECoupon']").size() > 0) {
            d.ECouponCode = $("#posManualECoupon ul li").find(":checked").filter("input[name='rdiECoupon']").closest("li").find(".hidval").find("span[id='ECouponCode']").html();
            if ($("#posManualECoupon li").find(":checked").filter("input[name='rdiECoupon']").closest("li").find(".hidval").find("span[id='ECouponType']").html() == "64") {
                if ($("#posManualECoupon li").find(":checked").filter("input[name='rdiECoupon']").closest("li").find(".select-gift").find(":radio").size() > 0) {
                    var chooseCommodityId = $("#posManualECoupon li").find(":checked").filter("input[name='rdiECoupon']").closest("li").find(".select-gift").find(":checked").siblings("span.xget1").first().html();
                    d.LotteryCommodityChooseId2.push(chooseCommodityId);
                } else {
                    $("#posManualECoupon li").find(":checked").filter("input[name='rdiECoupon']").closest("li").find(".select-gift").find("span.getAll").each(function (i, item) {
                        var chooseCommodityId = $(item).html();
                        d.LotteryCommodityChooseId2.push(chooseCommodityId);
                    });
                }
            }
        }
        //0
        if ($("#theUserBindCoupon_0 li").size() > 0) {
            if ($("#theUserBindCoupon_0 li").find(":checked").size() > 0) {
                $("#theUserBindCoupon_0 li").find(":checked").each(function (i, item) {
                    d.LotteryCommodityId0.push($(item).closest("li").find(".hidval").find("span[id='LotteryCommodityId']").html())
                });
            }
        }
        //128
        if ($("#theUserBindCoupon_128 li").size() > 0) {
            if ($("#theUserBindCoupon_128 li").find(":checked").size() > 0) {
                $("#theUserBindCoupon_128 li").find(":checked").each(function (i, item) {
                    d.LotteryCommodityId128.push($(item).closest("li").find(".hidval").find("span[id='LotteryCommodityId']").html())
                });
            }
        }

        //if ($("#posManualCard ul li").size() > 0) {
        //    d.CouponCode = $("#posManualCard ul li").find(".hidval").find("span[id='CouponCode']").html();
        //}
        //CashVoucher
        if ($("#posManualCashVoucher ul li").size() > 0) {
            if ($("#posManualCashVoucher ul li").find(":checked").size() > 0) {
                $("#posManualCashVoucher ul li").find(":checked").each(function (i, item) {
                    var CashVouchersCode = $(item).closest("li").find(".hidval").find("span[id='CashVouchersCode']").html();
                    var CashVouchersPwd = $(item).closest("li").find(".hidval").find("span[id='CashVouchersPassword']").html();
                    d.CashVouchersCode.push(CashVouchersCode + "|" + CashVouchersPwd);
                    //d.CashVouchersCode.push(CashVouchersCode);
                });
                var hidDiscountCashVoucher = parseFloat($("#hidDiscountCashVoucher").val());//现金券
                d.CashVoucherDiscount = hidDiscountCashVoucher;
                //d.CashVoucher = { "CashVouchersCode": $("#txtCashVoucher").val(), "CashVouchersPassword": $("#txtCashVoucherPwd").val() };
                //d.CashVouchersCode = $("#posManualCashVoucher ul li").find(".hidval").find("span[id='CashVouchersCode']").html();
            }
        }
        if ($.trim($("#txtWebRemark").val()) != "") {
            d.WebRemark =encodeURIComponent($.trim($("#txtWebRemark").val()));
        }

        d.Commodities = $("#hidCommodities").val();
        d.CommoditiesMoney = parseFloat($("#order7 .right").eq(0).find("span").html());
        d.DepositDeduction = parseFloat($("#order7 .right").eq(2).find("span").html());

        d.Discount = parseFloat($("#order7 .right").eq(3).find("span").html());
        
        d.CategoryDiscount = parseFloat($("#hidCategoryDiscount").val());
        d.UserDiscount = parseFloat($("#hidUserDiscount").val());
        d.DiscountCoupon = parseFloat($("#hidDiscountCoupon").val());
        d.DiscountCard = parseFloat($("#hidDiscountCard").val());
        //d.CashVoucherDiscount = parseFloat($("#hidDiscountCashVoucher").val());
        if ($("#chkIsDisplyPrice").is(":checked")) {
            d.IsDisplyPrice = 1;
        }
        var OrderUserName = "";
        var OrderUserMobile = "";
        if ($.trim($("#OrderUserName").val()).length > 0) {
            OrderUserName = $.trim($("#OrderUserName").val());
            d.OrderUserName =encodeURIComponent(OrderUserName);
        }
        if ($.trim($("#OrderUserMobile").val()).length > 0) {
            OrderUserMobile = $.trim($("#OrderUserMobile").val());
            d.OrderUserMobile = encodeURIComponent(OrderUserMobile);
        }
        return d;
    },
    timeoutHandle: function () {
        //G.app.Loading.close();
        window.setTimeout(function () {
            G.app.Loading.close();
            G.app.orderSubmit.orderLock = 0;
            $("#btnOrderSubmit").css("background-color", "rgb(255, 83, 23)").css("Cursor", "pointer");
        }, 500);
    },
    asyncAjaxPost: function (url, data, sucfunc, errFunc) {
        $.ajax({
            url: url,
            type: "post",
            async: true,
            data: data,
            dataType: "json",//统一json
            success: function (d) {
                sucfunc(d);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown, d) {
                errFunc(d);
                G.ui.popup.showMsg(errorThrown || textStatus, "2", $.noop);
                return;
            }
        });
    }
};
G.app.OrderTPL = {
    Consignee_Default: '<li><label class=""><input type="radio" name="receive"><span class="adrtag">${ConsigneeTypeName}</span><strong>${ConsigneeName}</strong><span>${FullConsigneeAddress} ，${ConsigneeMobile} </span><span style="display:none;" class="orange">此地址尚不支持配送，请选择其他地址</span><a href="###" class="btn-setdefault">设为默认地址</a><a  data-toggle="modal" href="#myModal1" data-backdrop="static" class="btn-edit">编辑</a><a href="###" class="btn-del">删除</a><b></b></label><span id="ConsigneeId" style="display:none;">${ConsigneeId}</span><span id="ConsigneeName" style="display:none;">${ConsigneeName}</span><span id="ConsigneeMobile" style="display:none;">${ConsigneeMobile}</span><span id="ConsigneeTel" style="display:none;">${ConsigneeTel}</span><span id="ProvinceId" style="display:none;">${ProvinceId}</span><span id="AreaId" style="display:none;">${AreaId}</span><span id="DistrictId" style="display:none;">${DistrictId}</span><span id="ConsigneeAddress" style="display:none;">${ConsigneeAddress}</span><span id="PostCode" style="display:none;">${PostCode}</span><span id="IsOuterLoop" style="display:none;">${IsOuterLoop}</span><span id="IsDefault" style="display:none;">${IsDefault}</span><span id="ConsigneeType" style="display:none;">${ConsigneeType}</span></li>',
    InvoiceTPL: '<div class="o-invoice-list"><label class="selected"><input type="radio" name="theInvoice"/><span class="item-type">普通发票（${UnitName}）</span><span class="item-tit">发票抬头：${InvoiceTitle}</span><a href="###" class="btn-del">删除</a><span id="UserInvoiceId" style="display:none;">${UserInvoiceId}</span><b></b></label></div>'
};
G.app.OrderMsg = {
    defaultDeliveryShow: '<div style="font-weight:bold;">请选择有效的收货信息后确认配送信息！</div>',
    defaultPaymentShow: '<div style="font-weight:bold">请选择有效的收货信息后确认支付方式！</div>'
};
