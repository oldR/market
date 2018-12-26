<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>数据图表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="shortcut icon" href="./favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="./css/font.css">
    <link rel="stylesheet" href="./css/xadmin.css">
    <script type="text/javascript" src="./js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="./layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="./js/xadmin.js"></script>
    <script type="text/javascript" src="./plugin/echarts.min.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="javascript:void(0)">首页</a>
        <a href="javascript:void(0)">市场送货</a>
        <a>
          <cite>数据图表</cite></a>
      </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
       href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body" style="position: absolute;left:0 ; right:0 ; top:40px ;bottom:0;">
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so" style="text-align:left!important;" action="./echarts" method="get" id="chartForm">
            <label for="L_bDate" class="layui-form-label">
                送货日期
            </label>
            <div class="layui-input-block">
                <input type="text" id="L_bDate" name="bDate" style="width: auto"  required  lay-verify="required" value="${bDate!''}" autocomplete="off" class="layui-input" readonly >
                <button class="layui-btn" onclick="serachForm()"><i class="layui-icon">&#xe615;</i></button>
            </div>
        </form>
    </div>
    <div id="chart1" style="width: 100%;height:calc(100% - 40px)!important;"></div>
</div>
<script>
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('chart1'));
    var d = ${dataMap};
    var cg = ${category};

    var pList = [];//'汉街店','保利店','台北店'
    cg.forEach(function (item,index) {
        pList.push(item.cateName);
    });

    var dataMap = {};
    function dataFormatter(obj) {
        var temp;
        for (var month = 1; month <= 12; month++) {
            var max = 0;
            var sum = 0;
            temp = obj[month];
            for (var i = 0, l = temp.length; i < l; i++) {
                max = Math.max(max, temp[i]);
                sum += temp[i];
                obj[month][i] = {
                    name : pList[i],
                    value : temp[i]
                }
            }
            obj[month + 'max'] = Math.floor(max / 100) * 100;
            obj[month + 'sum'] = sum;
        }
        return obj;
    }

    dataMap.dataPI = dataFormatter(d.dataPI);

    dataMap.dataSI = dataFormatter(d.dataSI);

    dataMap.dataTI = dataFormatter(d.dataTI);

    days = [];//图表底部坐标
    options = [];//图表数据
    xAxis=[];
    year = new Date().getFullYear();
    for (var month = 1; month <= 12; month++) {
        opt = {
            title: {text: month + '月送货金额指标'},
            series: [
                {data: dataMap.dataPI[month + '']},
                {data: dataMap.dataSI[month + '']},
                {data: dataMap.dataTI[month + '']},
                {
                    data: [
                        {name: '汉街店', value: dataMap.dataPI[month + 'sum']},
                        {name: '保利店', value: dataMap.dataSI[month + 'sum']},
                        {name: '台北店', value: dataMap.dataTI[month + 'sum']}
                    ]
                }
            ]
        }
        options.push(opt);

        s = {
            type:'category',
            axisLabel:{'interval':0},
            data:[],
            splitLine: {show: false}
        }
        days = new Date(year, month, 0).getDate();
        for (var j = 1; j <= days; j++) {
            s.data.push(j + "号");
        }
        xAxis.push(s);
    }

    option = {
        baseOption: {
            timeline: {
                // y: 0,
                axisType: 'category',
                // realtime: false,
                // loop: false,
                //autoPlay: true,
                currentIndex: new Date().getMonth(),
                playInterval: 1000,
                // controlStyle: {
                //     position: 'left'
                // },
                data: [
                    '一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'
                ]
            },
            title: {
                subtext: '数据来自${bDate!''}年所有月份'
            },
            tooltip: {
            },
            legend: {
                x: 'right',
                data: pList/*,
                selected: {
                    '台北店': false
                }*/
            },
            calculable : true,
            grid: {
                top: 80,
                bottom: 100,
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'shadow',
                        label: {
                            show: true,
                            formatter: function (params) {
                                return params.value.replace('\n', '');
                            }
                        }
                    }
                }
            },
            xAxis: xAxis[new Date().getMonth()],
            yAxis: [
                {
                    type: 'value',
                    name: '送货金额（元）'
                }
            ],
            series: [
                {name: '汉街店', type: 'bar'},
                {name: '保利店', type: 'bar'},
                {name: '台北店', type: 'bar'},
                {
                    name: '金额占比',
                    type: 'pie',
                    center: ['75%', '35%'],
                    radius: '28%',
                    z: 100
                }
            ]
        },
        options: options
    };
    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
    myChart.on('timelinechanged',function (current) {
        var index = current.currentIndex;
        option.baseOption.timeline.currentIndex = index;
        option.baseOption.xAxis = xAxis[index];
        myChart.setOption(option);
        //console.log(current);
    });
    window.onresize = myChart.resize;//图标自适应
    layui.use(['form','layer','laydate'], function(){
        $ = layui.jquery;
        var form = layui.form
                ,layer = layui.layer,
                laydate = layui.laydate;

        //监听提交
        form.on('submit(add)', function(data){
            console.log(data);
            $.ajax({
                url:'./add',
                data:data.field,
                type:"POST",
                dataType:'JSON',
                success:function (d) {
                    //发异步，把数据提交给php
                    layer.alert("保存成功", {icon: 6},function () {
                        this.index;
                        // 获得frame索引
                        if(window.name != ""){
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            parent.layer.close(index);
                            parent.location.reload();
                        }else{
                            layer.closeAll();
                            $('.layui-form')[0].reset();
                        }
                    });
                }
            });
            return false;
        });

        //执行一个laydate实例
        laydate.render({
            elem: '#L_bDate',
            type: 'year'//指定元素
        });
    });

    function serachForm() {
        $("#chartForm").submit();
    }
</script>
</body>

</html>