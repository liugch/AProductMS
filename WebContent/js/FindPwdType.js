var FindType = {
    ValitedUrl: "/FindPwdType/"
}
FindType.Valited = {
    ChangeFindPwdType: function () {
        if ($("#FindPwdType").val() == 'mobile') {
            $("#divmobile").show();
            $("#divemail").hide();
        }
        else if ($("#FindPwdType").val() == 'email') {
            $("#divemail").show();
            $("#divmobile").hide();
        }
    },

    SendCodeClick: function (ctrl) {

        if ($(ctrl).attr("disabled") == "disabled") {
            return false;
        }

        var UserID = $("#UserID").val();

        GetRemoteContent(FindType.ValitedUrl + "SendVerifyCode", { UserID: UserID }, ctrl, FindType.Valited.SendVerifyCodeCallBack);
    },

    SendVerifyCodeCallBack: function (ctrl, data) {

        if (data["ErrorCode"] == 'No') {
            alert(FindType.ErrorString.SendSMSFail);
            return false;
        }
        else if (data["ErrorCode"] == 'Yes') {
            VerifyCodeButtonText(ctrl, 60);
        }
    },

    VerifyCodeValited: function () {
        var UserID = $("#UserID").val();
        var code = $.trim($("#txtmcode").val());

        if (code == '') {
            alert(FindType.ErrorString.NoVerifyCode);
            return false;
        }

        GetRemoteContent(FindType.ValitedUrl + "VerifyCodeValited", { UserID: UserID, Code: code }, '', FindType.Valited.VerifyCodeCallBack);
    },

    VerifyCodeCallBack: function (ctrl, data) {

        if (data["ErrorCode"] == 'Fail') {
            alert(data["ErrorMsg"]);
            return false;
        }
        else if (data["ErrorCode"] == 'Success') {
            window.location = data["ErrorMsg"];
        }
    },

    SendEmail: function () {
        $("#emailtip").hide();
        var UserID = $("#UserID").val();
        GetRemoteContent(FindType.ValitedUrl + "SendEmail", { UserID: UserID }, '', FindType.Valited.SendMailCallBack);
    },

    SendMailCallBack: function (ctrl, data) {
        if (data["ErrorCode"] == 'Success')
            $("#emailtip").show();
        else
            alert(data["ErrorMsg"]);
    }
}

function VerifyCodeButtonText(ctrl, time) {

    $(ctrl).html(FindType.ErrorString.VerifyCodeRemainTime + time + FindType.ErrorString.VerifyCodeSecond);
    $(ctrl).attr("disabled", true);
    $(ctrl).css("color", "gray");

    if (time > 0) {

        var temp = time - 1;
        window.setTimeout(function () { VerifyCodeButtonText(ctrl, temp) }, 1000);

    }
    else {
        $(ctrl).attr("disabled", false);
        $(ctrl).html(FindType.ErrorString.GetVerifyCode);
        $(ctrl).attr("style", "");
    }
}

function GetRemoteContent(url, postData, valitedCtrl, func) {

    $.ajax({
        type: "POST",
        url: url,
        data: postData,
        dataType: "json",
        success: function (data) {
            if (data != null) {
                func(valitedCtrl, data);
            }
        }
    });
}

$(function () {
    $("#FindPwdType").change(function () { return FindType.Valited.ChangeFindPwdType() });
    $("#FindPwdType").change();
    $("#btnmcode").click(function () { return FindType.Valited.SendCodeClick($("#btnmcode")); });
    $("#btnmverify").click(function () { return FindType.Valited.VerifyCodeValited(); });
    $("#btnemail").click(function () { return FindType.Valited.SendEmail(); });
})