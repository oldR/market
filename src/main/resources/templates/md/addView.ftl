<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>送货录入</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="shortcut icon" href="./favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="./css/font.css">
    <link rel="stylesheet" href="./css/xadmin.css">
    <script type="text/javascript" src="./js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="./layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="./js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<#setting number_format="0.#####">
<#if !market.id??>
    <div class="x-nav">
          <span class="layui-breadcrumb">
            <a href="javascript:void(0)">首页</a>
            <a href="javascript:void(0)">市场送货</a>
            <a>
              <cite>信息录入</cite></a>
          </span>
        <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
           href="javascript:location.replace(location.href);" title="刷新">
            <i class="layui-icon" style="line-height:30px">ဂ</i></a>
    </div>
</#if>
<div class="x-body">
    <form class="layui-form">
        <input type="hidden" name="id" value="${market.id!''}">
        <div class="layui-form-item">
            <label for="L_bDate" class="layui-form-label">
                <span class="x-red">*</span>送货日期
            </label>
            <div class="layui-input-block">
                <input type="text" id="L_bDate" name="bDate" style="width: 80%"  required  lay-verify="required" placeholder="yyyy-MM-dd"
                       autocomplete="off" class="layui-input" value="<#if market.bDate??>${market.bDate?string('yyyy-MM-dd')}</#if>" readonly>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_storefront" class="layui-form-label">
                <span class="x-red">*</span>店面名称
            </label>
            <div class="layui-input-inline">
                <select name="storefront" id="L_storefront" class="layui-select" lay-verify="required">
                    <option value="">请选择店面</option>
                    <#list category as cate>
                        <option <#if market.storefront??&&market.storefront == cate.cateName>selected</#if> value="${cate.cateName}">${cate.cateName}</option>
                    </#list>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_price" class="layui-form-label">
                <span class="x-red">*</span>金额
            </label>
            <div class="layui-input-block">
                <input type="text" id="L_price" name="price" style="width: 80%" lay-verify="required"
                       autocomplete="off" class="layui-input" value="${market.price!''}">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_isSett" class="layui-form-label">
                是否结算
            </label>
            <div class="layui-input-block">
                <input name="isSett" id="isSett"<#if market.isSett?? && market.isSett == '是'>checked</#if>  lay-skin="switch" lay-text="是|否" type="checkbox">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_address" class="layui-form-label">
                店面地址
            </label>
            <div class="layui-input-block">
                <input type="text" id="L_address" name="address" style="width: 80%" placeholder="店面地址可不输入"
                       autocomplete="off" class="layui-input" value="${market.address!''}">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_reason" class="layui-form-label">
                备注
            </label>
            <div class="layui-input-block">
                   <textarea name="reason" required lay-verify="title" style="width: 80%" placeholder="摘要在10-100之间"
                             class="layui-textarea">${market.reason!''}</textarea>
                </textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_repass" class="layui-form-label">
            </label>
            <button  class="layui-btn" lay-filter="add" lay-submit="">
                    保存
            </button>
        </div>
    </form>
</div>
<script>
    layui.use(['form','layer','laydate'], function(){
        $ = layui.jquery;
        var form = layui.form
                ,layer = layui.layer,
                laydate = layui.laydate;

        //监听提交
        form.on('submit(add)', function(data){
            //console.log(data);
            data.field.isSett = data.field.isSett == undefined ? "否" : "是";
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
            type: 'date'//指定元素
        });
    });
</script>
</body>

</html>