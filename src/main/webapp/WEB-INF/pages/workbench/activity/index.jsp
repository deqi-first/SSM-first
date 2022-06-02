<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <base href="<%=basePath%>">
    <title>市场活动主页面</title>
    <script type="text/javascript"
            src="jquery/bootstrap-datetimepicker-master/sample in bootstrap v3/jquery/jquery-1.8.3.min.js"></script>
    <link rel="stylesheet" type="text/css"
          href="jquery/bootstrap-datetimepicker-master/sample in bootstrap v3/bootstrap/css/bootstrap.css">
    <script type="text/javascript"
            src="jquery/bootstrap-datetimepicker-master/sample in bootstrap v3/bootstrap/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css"
          href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css">
    <script type="text/javascript"
            src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript"
            src="jquery/bootstrap-datetimepicker-master/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
    <!--  PAGINATION plugin -->
    <link rel="stylesheet" type="text/css"
          href="jquery/bs_pagination-master/bs_pagination-master/jquery.bs_pagination.min.css">
    <script type="text/javascript"
            src="jquery/bs_pagination-master/bs_pagination-master/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript"
            src="jquery/bs_pagination-master/bs_pagination-master/localization/en.min.js"></script>

    <script type="text/javascript">
        $(function () {
            //给“创建”按钮添加单击事件
            $("#createActivityBtn").click(function () {
                //初始化,每次点击创建按钮，清空上次填写的数据
                $("#create-ActivityForm").get(0).reset();
                //弹出创建市场活动的模态窗口
                $("#create-ActivityModel").modal("show");
            });
            //创建市场活动的模态窗口"保存"按钮的单击事件
            $("#saveActivityBtn").click(function () {
                var owner = $("#create-activityOwner").val();
                var name = $.trim($("#create-activityName").val());
                var startDate = $("#create-activityStartDate").val();
                var endDate = $("#create-activityEndDate").val();
                var cost = $.trim($("#create-activityCost").val());
                var description = $.trim($("#create-activityDescription").val());
                if (owner == "") {
                    alert("所有者不能为空");
                    return;
                }
                if (name == "") {
                    alert("名称不能为空");
                    return;
                }
                if (startDate != "" && endDate != "") {
                    if (endDate < startDate) {
                        alert("结束日期不能比开始日期小");
                        return;
                    }
                }
                var regExp = /^(([1-9]\d*)|0)$/;
                if (!regExp.test(cost)) {
                    alert("成本只能为非负整数");
                    return;
                }
                //发送请求
                $.ajax({
                    url: "/workbench/activity/save.do",
                    data: {
                        activityOwner: owner,
                        activityName: name,
                        activityStartDate: startDate,
                        activityEndDate: endDate,
                        activityCost: cost,
                        activityDescription: description
                    },
                    type: "post",
                    success: function (ret) {
                        if (ret.code == "1") {
                            alert("保存成功");
                            $("#create-ActivityModel").modal("hide");
                            queryActivityByConditionForPage(1,$("#demo_page1").bs_pagination('getOption', 'rowsPerPage'));
                        } else {
                            alert(ret.message);
                            $("#create-ActivityModel").modal("show");
                        }
                    }

                });
            });
            //日历插件
            $("#create-activityStartDate").datetimepicker({
                language: 'zh-CN',
                format: 'yyyy-mm-dd',
                minView: 'month',
                initialDate: new Date(),
                autoclose: true,
                todayBtn: true,
                clearBtn: true
            });
            $("#create-activityEndDate").datetimepicker({
                language: 'zh-CN',
                format: 'yyyy-mm-dd',
                minView: 'month',
                initialDate: new Date(),
                autoclose: true,
                todayBtn: true,
                clearBtn: true
            });
            $("#query_startDate").datetimepicker({
                language: 'zh-CN',
                format: 'yyyy-mm-dd',
                minView: 'month',
                initialDate: new Date(),
                autoclose: true,
                todayBtn: true,
                clearBtn: true
            });
            $("#query_endDate").datetimepicker({
                language: 'zh-CN',
                format: 'yyyy-mm-dd',
                minView: 'month',
                initialDate: new Date(),
                autoclose: true,
                todayBtn: true,
                clearBtn: true
            });
            //当市场活动主页面加载完成，查询所有数据的第一页集街所有数据的总条数
            queryActivityByConditionForPage(1, 5);
            //给查询按钮添加单击事件
            $("#queryActivityBtn").click(function () {
                //查询所有符合条件的数据
                queryActivityByConditionForPage(1, $("#demo_page1").bs_pagination('getOption', 'rowsPerPage'));
            });
            //给全选按钮添加单击事件
            $("#checkAll").click(function () {
                //如果“全选”按钮是选中状态，则列表中所有checkbox都选中
                $("#tbodyId input[type='checkbox']").prop("checked",this.checked);
            });
            //给动态元素添加单击事件
            $("#tbodyId").on("click","input[type='checkbox']",function () {
                //如果列表中的所有checkbox都选中，则全选按钮也选中
                if($("#tbodyId input[type='checkbox']").size()==$("#tbodyId input[type='checkbox']:checked").size()){
                    $("#checkAll").prop("checked",true);
                }else{//如果列表中的所有checkbox至少一个没选中，则全选按钮取消选中
                    $("#checkAll").prop("checked",false);
                }
            })

            //删除市场活动
            $("#deleteActivityBtn").click(function () {
                var ids = $("#tbodyId input[type='checkbox']:checked");
                if(ids.size()==0){
                    alert("请选中要删除的市场活动");
                    return;
                }
                if(window.confirm("确定删除吗？")){
                    var myids = "";
                    $.each(ids,function () {
                        myids+="id="+this.value+"&";
                    })
                    myids=myids.substr(0,myids.length-1);
                    $.ajax({
                        url:"/workbench/activity/delete.do",
                        data:myids,
                        type:"post",
                        dataType: "json",
                        success:function (ret) {
                            if(ret.code==1){
                                alert("删除成功!");
                                queryActivityByConditionForPage(1,$("#demo_page1").bs_pagination('getOption','rowsPerPage'));
                            }else{
                                alert(ret.message);
                            }
                        }
                    })
                }
            })

            //修改市场活动
            $("#editActivityBtn").click(function () {
                //获取列表中被选中的checkbox
                var checkerIds = $("#tbodyId input[type='checkbox']:checked");
                if (checkerIds.size()==0){
                    alert("请选择要修改的市场活动");
                    return;
                }
                if(checkerIds.size()>1){
                    alert("每次只能选中一条数据修改");
                    return;
                }
                // var id = checkerIds.val();
                //get(0)获得的是一个DOM对象
                var id = checkerIds.get(0).value;
                $.ajax({
                    url:"/workbench/activity/selectActivityById.do",
                    data:{
                        id:id
                    },
                    type:"post",
                    dataType:"json",
                    success:function (ret) {
                        $("#edit-id").val(ret.activityId);
                        $("#edit-ActivityOwner").val(ret.activityOwner);
                        $("#edit-ActivityName").val(ret.activityName);
                        $("#edit-startDate").val(ret.activityStartDate);
                        $("#edit-endDate").val(ret.activityEndDate);
                        $("#edit-cost").val(ret.activityCost);
                        $("#edit-describe").val(ret.activityDescription);
                        //弹出模态窗口
                        $("#edit-ActivityModel").modal("show");
                    }
                })
            })
        });

        //封装函数
        function queryActivityByConditionForPage(pageNo, pageSize) {
            var name = $("#query_name").val();
            var owner = $("#query_owner").val();
            var startDate = $("#query_startDate").val();
            var endDate = $("#query_endDate").val();
            $.ajax({
                url: "/workbench/activity/search.do",
                data: {
                    name: name,
                    owner: owner,
                    startDate: startDate,
                    endDate: endDate,
                    pageNo: pageNo,
                    pageSize: pageSize
                },
                type: 'post',
                dataType: 'json',
                success: function (ret) {
                    //显示总条数
                    $("#totalRowsId").text(ret.totalRows);
                    //显示市场活动的列表,遍历activityList,拼接所有行数据
                    var htmlStr = "";
                    $.each(ret.activities, function (index, object) {
                        htmlStr += "<tr>";
                        htmlStr += "<td><input type=\"checkbox\" value=\"" + object.activityId + "\"></td>";
                        htmlStr += "<td><a style=\"text-decoration: none;cursor:pointer;\" onclick=\"window.location.href='#'\">" + object.activityName + "</a></td>";
                        htmlStr += "<td>" + object.activityOwner + "</td>";
                        htmlStr += "<td>" + object.activityStartDate + "</td>";
                        htmlStr += "<td>" + object.activityEndDate + "</td>";
                        htmlStr += "</tr>";
                    });
                    //$("#tbodyId").html(htmlStr);覆盖追加
                    //$("#tbodyId").append(jsp页面片段的字符串);追加显示
                    $("#tbodyId").html(htmlStr);
                    //由于只更新了tbody的内容，所以全选按钮没有更新，如果第一页选中，则第二页也会显示
                    $("#checkAll").prop("checked",false);
                    var totalPages = ret.totalRows % pageSize == 0 ? ret.totalRows / pageSize : ret.totalRows / pageSize + 1;

                    $("#demo_page1").bs_pagination({
                        currentPage: pageNo,//当前页号,相当于pageNo
                        rowsPerPage: pageSize,//每页显示条数，相当于pageSize
                        totalRows: ret.totalRows,//总条数
                        totalPages: totalPages,//总页数
                        visiblePageLinks: 5,//最多可以显示的卡片数
                        showGoToPage: true,//是否显示“跳转到”部分，默认true--显示
                        showRowsPerPate: true,//是否显示“每页显示条数”部分，默认true--显示
                        showRowsInfo: true,//是否显示记录的信息，默认true--显示

                        onChangePage: function (event, pageObj) {
                            queryActivityByConditionForPage(pageObj.currentPage, pageObj.rowsPerPage);
                        }
                    });
                }
            });
        }
    </script>
</head>
<body>

<!--创建市场活动的模态框-->
<div class="modal fade" id="create-ActivityModel" tabindex="-1">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">创建市场活动</h4>
            </div>
            <form class="form-inline" id="create-ActivityForm">
                <div class="modal-body col-md-12">
                    <div class="form-group">
                        <label class="col-md-2 control-label">所有者<span style="color: red;">*</span></label>
                        <div class="col-md-10">
                            <select class="form-control" id="create-activityOwner">
                                <c:forEach items="${requestScope.users}" var="u">
                                    <option value="${u.userId}">${u.uLoginAct}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label class="col-md-2 control-label">名称<span style="color:red">*</span></label>
                        <div class="col-md-10"><input type="text" id="create-activityName" class="form-control"/></div>
                    </div>
                    <div class="form-group col-md-12">
                        <label>开始日期</label>
                        <input type="text" class="form-control" id="create-activityStartDate" readonly/>
                        <label>结束日期</label>
                        <input type="text" class="form-control" id="create-activityEndDate" readonly/>
                    </div>
                    <div class="form-group col-md-12">
                        <label>成本</label>
                        <input type="text" class="form-control" id="create-activityCost"/>
                        <label>描述</label>
                        <textarea class="form-control" rows="3" id="create-activityDescription"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="saveActivityBtn">保存</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!--修改市场活动的模态框-->
<div class="modal fade" id="edit-ActivityModel" tabindex="-1">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改市场活动</h4>
            </div>
            <form class="form-inline">
                <input type="hidden" id="edit-id">
                <div class="modal-body col-md-12">
                    <div class="form-group">
                        <label class="col-md-2 control-label">所有者<span style="color: red;">*</span></label>
                        <div class="col-md-10">
                            <select class="form-control" id="edit-ActivityOwner">
                                <c:forEach items="${requestScope.users}" var="u">
                                    <option value="${u.userId}">${u.uLoginAct}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label class="col-md-2 control-label">名称<span style="color:red">*</span></label>
                        <div class="col-md-10"><input type="text" class="form-control" id="edit-ActivityName"/></div>

                    </div>
                    <div class="form-group col-md-12">
                        <label>开始日期</label>
                        <input type="text" class="form-control" id="edit-startDate"/>
                        <label>结束日期</label>
                        <input type="text" class="form-control" id="edit-endDate"/>
                    </div>
                    <div class="form-group col-md-12">
                        <label>成本</label>
                        <input type="text" class="form-control" id="edit-cost"/>
                    </div>
                    <div class="form-group col-md-12">
                        <label>描述</label>
                        <textarea class="form-control" rows="3" id="edit-describe"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary">保存</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!--主页面-->
<div>
    <!--搜索-->
    <div>
        <h2>市场活动列表</h2>
        <hr/>
        <div>
            <div class="row">
                <div class="col-xs-3">
                    <div class="input-group">
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button">名称</button>
                            </span>
                        <input type="text" class="form-control" id="query_name">
                    </div><!-- 名称 -->
                </div>
                <div class="col-xs-3">
                    <div class="input-group">
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button">所有者</button>
                            </span>
                        <input type="text" class="form-control" id="query_owner">
                    </div><!-- 所有者 -->
                </div>
                <div class="col-xs-3">
                    <div class="input-group">
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button">开始日期</button>
                            </span>
                        <input type="text" class="form-control" id="query_startDate">
                    </div><!-- 开始日期-->
                </div>
                <div class="col-xs-3">
                    <div class="input-group">
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button">结束日期</button>
                            </span>
                        <input type="text" class="form-control" id="query_endDate">
                    </div><!-- 结束日期-->
                </div>
                <div class="col-xs-3">
                    <button id="queryActivityBtn" type="button" class="btn btn-success">查询</button>
                </div>
            </div>
        </div>
    </div>
    <br/><br/>
    <!--操作按钮-->
    <div class="btn-group" role="group">
        <button type="button" style="pointer-events:auto" class="btn btn-primary" id="createActivityBtn">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
            创建
        </button>
        <button type="button" class="btn btn-default" id="editActivityBtn">
            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
            修改
        </button>
        <button type="button" class="btn btn-warning" id="deleteActivityBtn">
            <span class="glyphicon glyphicon-minus" aria-hidden="true"></span>删除
        </button>
        <div class="btn-group" role="group">
            <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-import"
                                                                aria-hidden="true"></span>上次到列表数据（导入）
            </button>
            <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-export"
                                                                aria-hidden="true"></span>下载戴列表数据（批量导入）
            </button>
            <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-export"
                                                                aria-hidden="true"></span>下载列表数据（选择导出）
            </button>
        </div>
    </div>
    <!--表格-->
    <table class="table table-striped text-left">
        <thead>
        <tr>
            <th><input type="checkbox" id="checkAll"></th>
            <th>名称</th>
            <th>所有者</th>
            <th>开始日期</th>
            <th>结束日期</th>
        </tr>
        </thead>
        <tbody id="tbodyId">

        </tbody>
    </table>
    <!--分页查询-->
    <div class="col-md-12" id="demo_page1">
    </div>
</div>
</body>
</html>
