// JavaScript Document

//确认订单信息
$(function () {
    //我的易果
    $('.myyiguo').hover(function () {
        $(this).addClass('current');
    }, function () {
        $(this).removeClass('current');
    });

    //手机易果
    $('.mobile').hover(function () {
        $(this).addClass('current');
    }, function () {
        $(this).removeClass('current');
    });

    //电子发票提示框
    $('.promptbox').hover(function () {
        $(this).find('.dorpdown').show();
    }, function () {
        $(this).find('.dorpdown').hide();
    });
});




//抵用券信息
$('.o-voucher .item-tit').click(function () {

    if ($(this).next('.item-wrap').is(':hidden')) {
        $(this).next('.item-wrap').slideDown('slow');
        $(this).addClass("opened");
    } else {
        $(this).next('.item-wrap').slideUp('slow');
        $(this).removeClass("opened");
    }

});
//抵用券信息-优惠券/礼品卡
$('.o-voucher .sub-tit').click(function () {
    if ($(this).siblings('.sub-wrap').is(':hidden')) {
        $(this).siblings('.sub-wrap').slideDown('slow');
        $(this).addClass("opened");
    } else {
        $(this).siblings('.sub-wrap').slideUp('slow');
        $(this).removeClass("opened");
    }

});
$('.o-voucher .give').click(function () {
    $(this).find('.select-gift').slideDown('slow');
});


//赠券三选一
/*$(".give").mouseover(function(){
    $(this).children(".select-gift").css("display","block");
});
$(".give").mouseout(function(){
    $(this).children(".select-gift").css("display","none");
});
$(".select-gift label").click(function(){
    $(".select-gift").css("display","none");
    $(this).parents(".give").addClass("give-seleceed")
});*/
//使用优惠码
$(".use-coupon").click(function () {
    $(this).parents(".sub-wrap").children(".give-seleceed").css("display", "block")
});
//使用礼品卡
$(".use-card").click(function () {
    $(this).parents(".sub-wrap").children(".give-seleceed").css("display", "block")
});
//使用现金券
$(".use-voucher").click(function () {
    $(this).parents(".item-wrap").children(".give-seleceed").css("display", "block")
});
