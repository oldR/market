<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>市场管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="shortcut icon" href="./favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="./css/font.css">
    <link rel="stylesheet" href="./css/xadmin.css">
    <script type="text/javascript" src="./js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="./layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="./js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <script src="./common/pagination.js"></script>
</head>

<body>
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="javascript:void(0)">首页</a>
        <a href="javascript:void(0)">市场送货</a>
        <a><cite>送货列表</cite></a>
      </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
       href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div id="vueApp" class="x-body">
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so" action="./listView" method="get" id="pageForm">
            <input type="text" class="layui-input" placeholder="日期范围" name="startTime" readonly id="startTime" value="${searchForm.startTime!""}">
            <#--<input class="layui-input" placeholder="截止日" name="endTime" readonly id="endTime" value="${searchForm.endTime!""}">-->
            <input type="text" name="storefront" placeholder="店面名称"  autocomplete="off" class="layui-input" value="${searchForm.storefront!""}">
            <input type="hidden" id="totalCount" value="${marketList.totalCount}">
            <input type="hidden" name="currentPage" id="currentPage" value="${marketList.currentPage}">
            <button class="layui-btn" onclick="serachForm()"><i class="layui-icon">查询&#xe615;</i></button>
            <button type="button" onclick="resetForm()" class="layui-btn layui-btn-primary">重置</button>
        </form>
    </div>
<#--<xblock>
        <button class="layui-btn layui-btn-danger" onclick="delAll()"><i class="layui-icon"></i>批量删除</button>-->
        <#--<button class="layui-btn" onclick="x_admin_show('添加新闻','addView',600,400)"><i class="layui-icon"></i>添加
        </button>
        <span class="x-right" style="line-height:40px">共有数据：${newsList.totalCount} 条</span>
    </xblock>-->
    <table class="layui-table">
        <thead>
        <tr>
            <th>日期</th>
            <th>门店</th>
            <th>地址</th>
            <th>金额</th>
            <th>是否结算</th>
            <th>备注</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
            <#if marketList.list ??>
                <#list marketList.list as market>
                    <tr>
                        <td>${market.bDate?string('yyyy-MM-dd')!''}</td>
                        <td>${market.storefront!''}</td>
                        <td>${market.address!''}</td>
                        <td>${market.price!''}</td>
                        <td>${market.isSett!''}</td>
                        <td>${market.reason!''}</td>
                        <td>
                            <a onclick="x_admin_show('修改送货信息','addView?id='+${market.id},null,550)" href="javascript:;">
                            <i class="layui-icon">&#xe642;</i>
                            <a title="删除" onclick="member_del(this,${market.id})" href="javascript:;">
                                <i class="layui-icon">&#xe640;</i>
                            </a>
                        </a></td>
                    </tr>
                </#list>
            </#if>
        </tbody>
    </table>
    <div id="page" style="text-align: center">

    </div>
</div>
</body>
<script>

    function member_del(object, id) {
        var _this = this;
        layer.confirm('确认要删除吗？', function (index) {
            //发异步删除数据
            $.ajax({
                url: './delete',
                dataType: 'JSON',
                type: 'POST',
                data: {
                    id: id
                },
                success: function (e) {
                    $(_this).parents("tr").remove();
                    $("#currentPage").val(0);
                    location.reload();
                    layer.close();
                    layer.msg('已删除!', {icon: 1, time: 1000});
                }
            })
        });
    }
    function serachForm() {
        $("#currentPage").val(0);
        $("#pageForm").submit();
    }

    function resetForm() {
        var _input = $("#pageForm input[type='text']");
        for(var i=0;i<_input.length;i++){
            $(_input[i]).val("");
        }
    }

    layui.use('laydate', function () {
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#startTime',
            type: 'date'//指定元素
            ,range: true
        });

        //执行一个laydate实例
        //laydate.render({
        //    elem: '#endTime',
        //    type: 'date'//指定元素
        //});
    });

</script>

</html>