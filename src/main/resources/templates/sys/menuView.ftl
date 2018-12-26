<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>系统菜单设置</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="shortcut icon" href="./favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="./css/font.css">
    <link rel="stylesheet" href="./css/xadmin.css">
    <script type="text/javascript" src="./js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="./layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="./js/xadmin.js"></script>

    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
</head>

<body>
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="javascript:void(0)">首页</a>
        <a href="javascript:void(0)">系统设置</a>
        <a><cite>菜单设置</cite></a>
      </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
       href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div id="vueApp" class="x-body">
    <button type="button" class="layui-btn" onclick="add()">新增根节点</button>
    <table class="layui-table" id="treeTable" lay-filter="treeTable"> </table>
</div>
</body>
<script>
    var editObj = null, ptable = null, treeGrid = null, tableId = 'treeTable', layer = null,parseData,windowHeight;
    function getClientHeight()
    {
        var clientHeight=0;
        if(document.body.clientHeight&&document.documentElement.clientHeight)
        {
            clientHeight = (document.body.clientHeight<document.documentElement.clientHeight)?document.body.clientHeight:document.documentElement.clientHeight;
        }
        else
        {
            clientHeight = (document.body.clientHeight>document.documentElement.clientHeight)?document.body.clientHeight:document.documentElement.clientHeight;
        }
        return clientHeight;
    }
    windowHeight = getClientHeight()-140;
    layui.config({
        base: '/layui/lay/modules/'
    }).extend({
        treeGrid: 'treeGrid'
    }).use(['jquery', 'treeGrid', 'layer'], function () {
        var laydate = layui.laydate;
        treeGrid = layui.treeGrid;//很重要

        ptable = treeGrid.render({
            id: tableId
            , elem: '#' + tableId
            , url: './menuJson'
            , cellMinWidth: 100
            , idField: 'id'//必須字段
            , treeId: 'id'//树形id字段名称
            , treeUpId: 'parentId'//树形父id字段名称
            , treeShowName: 'name'//以树形式显示的字段
            //, heightRemove: [".dHead", 10]//不计算的高度,表格设定的是固定高度，此项不生效
            //, height: 'auto'
            , isFilter: false
            , iconOpen: false//是否显示图标【默认显示】
            , isOpenDefault: true//节点默认是展开还是折叠【默认展开】
            , loading: true
            , method: 'get'
            , isPage: false
            , cols: [[
                {type: 'numbers'}
                , {field: 'id', width: 100, title: 'ID'}
                , {field: 'name', width: 200, title: '菜单名称', edit: 'text'}
                , {field: 'icon', width: 100, title: '图标'
                    ,templet:function (d) {
                        return '<i class="iconfont">' + d.icon + '</i>';
                    }
                }
                , {field: 'url', width: 200, title: '链接', edit: 'text'}
                , {field: 'isSort', width: 100, title: '排序', edit: 'text'}
                , {field: 'useYn', width: 100, title: '是否启用'
                    ,templet:function (d) {
                        if(d.useYn == 0)
                            return '<input type="checkbox" name="switch"  lay-text="启用|停用" lay-skin="switch">';
                        else
                            return '<input type="checkbox" name="switch"  lay-text="启用|停用"  checked="" lay-skin="switch">';

                    }
                }
                , {
                    width: 100, title: '操作', align: 'center'/*toolbar: '#barDemo'*/
                    , templet: function (d) {
                        var html = '';
                        if(d.parentId == 0){
                            var addBtn = '<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="add">添加</a>';
                            var delBtn = '<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>';
                            html = addBtn + delBtn;
                        }else{
                            var addBtn = '<a class="layui-btn layui-btn-primary layui-btn-xs layui-btn-disabled">添加</a>';
                            var delBtn = '<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>';
                            html = addBtn + delBtn;

                        }
                        return html;
                    }
                }
            ]]
            , parseData: function (res) {//数据加载后回调
                parseData = res;
                return res;
            }
            , onClickRow: function (index, o) {
                console.log(index, o, "单击！");
            }
            , onDblClickRow: function (index, o) {
                console.log(index, o, "双击");
            }
        });
        treeGrid.on('tool(' + tableId + ')', function (obj) {
            if (obj.event === 'del') {//删除行
                del(obj);
            } else if (obj.event === "add") {//添加行
                add(obj);
            }
        });
    });

    function del(obj) {
        layer.confirm("你确定删除数据吗？如果存在下级节点则一并删除，此操作不能撤销！", {icon: 3, title: '提示'},
                function (index) {//确定回调
                    obj.del();
                    layer.close(index);
                }, function (index) {//取消回调
                    layer.close(index);
                }
        );
    }

    var i = 1008;

    function add(pObj) {
        var pdata = pObj ? pObj.data : {};
        var param = {
            name:'',//菜单名称
            icon:'',//菜单图标
            url:'',//链接URL
            isSort:'',//排序
            useYn:'1'//是否启用 默认启用
        };

        if(pObj == undefined){
            var m = [];
            var data = parseData.data;
            data.forEach(function (item,index) {
                if(item.parentId == 0)
                    m.push(item.id)
            });
            var s1 = m[0];
            for(var i = 1;i<m.length;i++){
                if (s1 < m[i]) s1 = m[i];//获取当前节点下子节点最大的ID，用于递增子节点ID
            }
            //console.log(s1)
            param.id = ++s1;//菜单ID，默认递增
            param.parentId = 0;//获取父节点ID
            param.lay_table_index = 0;
            pdata.lay_table_index = -1;
        }else{
            var children = pdata ? pdata.children : "";
            var s2 = children.length > 0 ? children[0].id : 0;
            for (var i = 1; i < children.length; i++) { //循环数组
                if (s2 < children[i].id) s2 = children[i].id;//获取当前节点下子节点最大的ID，用于递增子节点ID
            }
            if (s2 == 0)
                s2 = pdata.id + "0";
            param.id = ++s2;//菜单ID，默认递增
            param.parentId = pdata ? pdata.id : 0;//获取父节点ID
        }
        var i = pdata ? pdata[treeGrid.config.indexName] + 1 : 0;
        treeGrid.addRow(tableId, i, param);
    }
</script>

</html>