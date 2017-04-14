/********************************************************************************
** auth： luojianguang
** date： 2015/5/14 15:09:12
** desc： 收货地址
** Ver.:  V1.0.0
*********************************************************************************/

var Consignee = (function ($) {
    //动态获取地址选项
    var loadArea = function (areaId, grade, success) {
        $.ajax({
            url: '../Account/GetAreaList',
            type: 'get',
            dataType: 'json',
            data: {
                areaId: areaId,
                grade: grade
            },
            success: success
        });
    };
    //获取地址下拉选项
    var getOptions = function (data, type, selectId) {
        var typeDesc = '';
        switch (type) {
            case 1:
                typeDesc = '选择城市';
                break;
            case 2:
                typeDesc = '选择区域';
                break;
        }
        var options = '<option value="">' + typeDesc + '</option>';
        if (data) {
            $.each(data, function (i, e) {
                var selected = e.AreaId == selectId ? 'selected="selected"' : '';
                options += '<option value="' + e.AreaId + '" ' + selected + '>' + e.AreaName + '</option>';
            });
        }
        return options;
    };
    //加载城市
    var loadCity = function (data, selectId) {
        $('#SelectCityId').html(getOptions(data, 1, selectId));
    };
    //加载区域
    var loadDistrict = function (data, selectId) {
        $('#SelectDistrictId').html(getOptions(data, 2, selectId));
    };
    //选择省、市、区
    var loadAddress = function (data) {
        var proviceId = data.ProviceId;
        $('#SelectProviceId').find('option[value=' + proviceId + ']').attr("selected", true);
        var cityId = data.CityId;
        loadCity(data.CityList, cityId);
        var districtId = data.DistrictId;
        loadDistrict(data.DistrictList, districtId);
    };
    //收货地址表单
    var consigneeForm = function () { return $('#saveConsigneeForm'); };
    //重置表单
    var resetConsigneeForm = function () {
        consigneeForm()[0].reset();
        validate().resetForm();
    };
    //自定义验证规则
    var validate = function () {
        var customValidator = function () {
            $.extend($.validator.messages, {
                required: '必填',
                number: '格式错误',
                mobile: '请输入正确的手机号',
                mobileOrTel: '手机、电话必填一项',
                maxlength: '最大长度不能超过{0}'
            });
            $.validator.addMethod("mobileOrTel", function (value, element, param) {
                var targetValue = $(param).val();
                return !(value == '' && targetValue == '');
            });
            $.validator.addMethod("mobile", function (value, element) {
                var length = value.length;
                return this.optional(element) || (length == 11 && util.Validator.isMobile(value));
            }, '手机格式错误');
        };
        customValidator();
        var $form = consigneeForm();
        return $form.validate({
            onkeyup: false,
            ignore:'',
            rules: {
                ConsigneeName: {
                    required: true,
                    maxlength: 20
                },
                ConsigneeMobile: {
                    required:true,
                    mobile: true
                    //mobileOrTel: '#ConsigneeTel'
                },
                ConsigneeAddress: {
                    required: true,
                    maxlength: 500
                },
                DistrictId: {
                    required: true
                },
                PostCode: {
                    number: true
                },
                ConsigneeType: {
                    required:true
                }
            }
        });
    };

    return {
        init: function (args) {
            this.options = $.extend(true, {}, {}, args);
            this.bindEvent();
            util.Pager.init({
                Url: '../Account/GetConsigneeList',
                Pager: 'j_pages',
                Container: '.addressList ul',
                HandlebarID: '#consigneeRow',
                LoadComplete: function (result) {
                    if (result) {
                        $('.consigneeCount').html(result.page.Count);
                    }
                }
            });
            validate();
        },
        bindEvent: function () {
            var _ = this;
            //查询收货地址
            $(document).delegate('.editConsignee', 'click', function () {
                resetConsigneeForm();
                $('#myModal1').find('.btn-save').html('保存');
                $('#myModal1').modal('show');
                var id = $(this).data('id');
                util.Ajax.get('../Account/GetConsignee', { consigneeId: id }, function (result) {
                    var $form = consigneeForm();
                    $form.find('input[name=ConsigneeId]').val(result.data.ConsigneeId);
                    $form.find('input[name=ConsigneeName]').val(result.data.ConsigneeName);
                    $form.find('input[name=ConsigneeMobile]').val(result.data.ConsigneeMobile);
                    $form.find('input[name=ConsigneeAddress]').val(result.data.ConsigneeAddress);
                    $form.find('input[name=ConsigneeTel]').val(result.data.ConsigneeTel);
                    $form.find('input[name=PostCode]').val(result.data.PostCode);
                    $form.find('input[name=ConsigneeType]').val(result.data.ConsigneeType);
                    $form.find('.adrtag').each(function() {
                        var type = $(this).data('type');
                        $(this).removeClass("selected");
                        if (type == result.data.ConsigneeType) {
                            $(this).addClass("selected");
                        }
                    });
                    loadAddress(result.data);
                });
            });
            $(document).find(".adrtag").click(function () {
                var $form = consigneeForm();
                var type = $(this).data("type");
                $form.find('input[name=ConsigneeType]').val(type);
                $form.find(".adrtag").removeClass("selected");
                $(this).addClass("selected");
            });
            $(document).delegate('.ConsigneeTe', 'keypress', function () {
                return /[\d.]/.test(String.fromCharCode(event.keyCode));
            });
            $(document).delegate('.ConsigneeTe', 'keyup', function () {
                this.value = this.value.replace(/[^\.\d]/g, '');
            });
            //重置表单
            $(document).delegate('.addConsignee', 'click', function () {
                resetConsigneeForm();
                $('#myModal1').find('.btn-save').html('保存并添加');
                $('#myModal1').modal('show');
            });
            //加载城市
            $('#SelectProviceId').change(function () {
                var proviceId = $(this).val();
                loadArea(proviceId, 3, function (result) {
                    loadCity(result.data);
                });
                loadDistrict([]);
            });
            //加载区
            $('#SelectCityId').change(function () {
                var cityId = $(this).val();
                loadArea(cityId, 4, function (result) {
                    loadDistrict(result.data);
                });
            });
            //设为默认收货地址
            $(document).delegate('.setDefaultConsignee', 'click', function () {
                var id = $(this).data('id');
                util.Dialog.confirm("确定设为默认地址？", function () {
                    util.Ajax.post('../Account/SetDefaultConsignee', { consigneeId: id }, function (result) {
                        if (result.IsSuccess) {
                            window.location.reload();
                        } else {
                            util.Dialog.alert(result.ErrorMsg);
                        }
                    });
                });
            });
            //保存收货地址
            $(document).delegate('#myModal1 .btn-save', 'click', function () {
                var that = $(this);
                var $form = consigneeForm();
                if (!$form.valid()) {
                    return;
                }
                var data = $form.serializeArray();
                util.Ajax.post('../Account/SaveConsignee', data, function (result) {

                    if (result.IsSuccess) {
                        if (_.options.addCallback) {
                            _.options.addCallback(result.data);
                        } else {
                            window.location.reload();
                        }
                    } else {
                        util.Dialog.alert(result.ErrorMsg);
                    }
                }, that);
            });
            //删除收货地址
            $('.main .addressList').delegate('.del-btn', 'click', function () {
                var id = $(this).data('id');
                util.Dialog.confirm("您确定要删除？", function () { 
                    util.Ajax.post('../Account/DelConsignee', { consigneeId: id }, function (result) {
                        if (result.IsSuccess) {
                            window.location.reload();
                        } else {
                            util.Dialog.alert(result.ErrorMsg);
                        }
                    });
                });
            });
        }
    };
})(jQuery);