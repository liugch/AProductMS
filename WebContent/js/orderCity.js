G.app.orderCity = (function () {
    //load all province 默认选中当前城市
    var provinceData = [];
    var cityData = [];
    var districtData = [];
    var areaIdSH = "312D0556-0671-4F2E-8BAC-7B8873B5A03A";
    var areaIdBJ = "EABBE02F-59E0-46E6-90E7-CD8A89DBB98F";
    var districtDataSH = [{ AreaId: 0, AreaName: '外环以内' }, { AreaId: 1, AreaName: '外环以外' }];
    var districtDataBJ = [{ AreaId: 0, AreaName: '五环以内' }, { AreaId: 1, AreaName: '五环以外' }];
    var loadProvinceData = function () {
        if (provinceData.length <= 0) {
            $.ajax({
                url: "/Order1Receiving/GetProvinceList",
                async: false,
                success: function (d) {
                    provinceData = d;
                }
            });
        }
        return provinceData;
    };

    var loadCityData = function (provinceId) {
        if (provinceId.length <= 0) {
            return [];
        } else {
            if (!cityData[provinceId]) {
                $.ajax({
                    url: "/Order1Receiving/GetCityList",
                    data: "provinceId=" + provinceId,
                    dataType:"json",
                    async: false,
                    success: function (d) {
                        cityData[provinceId] = d;
                    }
                });
            }
            return cityData[provinceId];
        }
    };
    var loadDistrictData = function (areaId) {
        if (areaId.length <= 0) {
            return [];
        } else {
            if (!cityData[areaId]) {
                $.ajax({
                    url: "/Order1Receiving/GetDistrictList",
                    data: "cityId=" + areaId,
                    dataType: "json",
                    async: false,
                    success: function (d) {
                        cityData[areaId] = d;
                    }
                });
            }
            return cityData[areaId];
        }
    };
    var getOptions = function (data, selectId) {
        var options = '<option value="">选择</option>';
        if (data) {
            $.each(data, function (i, e) {
                var selected = e.AreaId == selectId ? 'selected="selected"' : '';
                options += '<option value="' + e.AreaId + '" ' + selected + '>' + e.AreaName + '</option>';
            });
        }
        return options;
    };
    return {
        bindSelect: function (o, type, selectedId) {
            var data = [];
            switch (type) {
                case "province":
                    data = loadProvinceData();
                    break;
                case "city":
                    data = loadCityData(selectedId);
                    break;
                case "district":
                    data = loadDistrictData(selectedId);
                    break;
                case "districtSH":
                    data = districtDataSH;
                    break;
                case "districtBJ":
                    data = districtDataBJ;
                    break;
            }
            var options = getOptions(data, selectedId);
            $(o).html(options);
            //$("select#ProvinceId").html(options);
        },
        bindAll: function (provinceId, areaId, districtId, isOuterLoop) {
            this.bindProvince();
            $("select#ProvinceId").val(provinceId);
            this.bindCity();
            $("select#AreaId").val(areaId);
            this.bindDistrict(isOuterLoop);
            provinceId = provinceId.toUpperCase();
            if (provinceId != areaIdSH&&provinceId!= areaIdBJ) {
                $("select#DistrictId").val(districtId);
            }
        },
        bindProvince: function () {
            this.bindSelect("select#ProvinceId", "province", "");
        },
        bindCity: function () {
            var provinceId = $("select#ProvinceId").val();
            //if (provinceId == "") return;//todo:错误处理
            this.bindSelect("select#AreaId", "city", provinceId);
            this.bindSelect("select#DistrictId", "district", "");
        },
        bindDistrict: function (isOuterLoop) {
            if (!isOuterLoop) {
                isOuterLoop = "";
            }
            var areaId = $("select#AreaId").val();
            var provinceId = $("select#ProvinceId").val();
            areaId = areaId.toUpperCase();
            if (areaId.length > 0) {
                provinceId = provinceId.toUpperCase();
                if (provinceId == areaIdSH) {
                    this.bindSelect("select#DistrictId", "districtSH", isOuterLoop);
                } else if (provinceId == areaIdBJ) {
                    this.bindSelect("select#DistrictId", "districtBJ", isOuterLoop);
                } else {
                    this.bindSelect("select#DistrictId", "district", areaId);
                }
            }
        },
        init: function () {
            var self = this;
            //this.bindSelect("select#ProvinceId", "province", "");
            this.bindProvince();
            $("select#ProvinceId").bind("change", function () {
                self.bindCity();
            });

            $("select#AreaId").bind("change", function () {               
                self.bindDistrict();
            });

            $("select#DistrictId").bind("change", function () {
                var tempVal = $("select#DistrictId").val();
                if (tempVal != "")
                {
                    if (tempVal == "1" || tempVal == "2") {
                        $("#IsOuterLoop").val(tempVal);
                    } else {
                        $("#IsOuterLoop").val("");
                    }
                }

            });
        }
    };
})();
