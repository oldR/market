layui.use(['laypage', 'layer'], function () {
    var laypage = layui.laypage
        , layer = layui.layer;
    laypage.render({
        elem: 'page'
        , count: $("#totalCount").val()
        ,limit:10
        ,curr:$("#currentPage").val()
        , prev: '<em>上一页</em>'
        , next: '<em>下一页</em>'
        , first: '首页'
        , last: '尾页'
        ,layout: ['first','last','prev', 'page', 'next', 'skip','count']
        ,jump: function(obj, first){
            //obj包含了当前分页的所有参数，比如：
 /*           console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
            console.log(obj.limit); //得到每页显示的条数*/

            if(!first) {
                $("#currentPage").val(obj.curr);
                $("form").submit();
            }
        }
    });
})