<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <link rel="stylesheet" href="jquery/bootstrap-3.4.1/dist/css/bootstrap.min.css">
    <script type="text/javascript" src="jquery/jquery-3.5.1.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-3.4.1/dist/js/bootstrap.min.js"></script>
    <script type="text/javascript">

        $(function () {
            //给“创建”按钮添加单击事件
            $("#createActivityBtn").click(function () {
                //初始化工作
                //任意js代码
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
                if(!regExp.test(cost)){
                    alert("成本只能为非负整数");
                    return;
                }
                //发送请求
                $.ajax({
                    url:"/workbench/activity/save.do",
                    data:{
                        activityOwner:owner,
                        activityName:name,
                        activityStartDate:startDate,
                        activityEndDate:endDate,
                        activityCost:cost,
                        activityDescription:description
                    },
                    type:"post",
                    success:function (ret) {
                        if(ret.code=="1"){
                            alert("保存成功");
                            $("#create-ActivityModel").modal("hide");
                        }else{
                            alert(ret.message);
                            $("#create-ActivityModel").modal("show");
                        }
                    }

                });
            });
        });
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
                        <input type="text" class="form-control" id="create-activityStartDate"/>
                        <label>结束日期</label>
                        <input type="text" class="form-control" id="create-activityEndDate"/>
                    </div>
                    <div class="form-group col-md-12">
                        <label>成本</label>
                        <input type="text" class="form-control" id="create-activityCost"/>
                    </div>
                    <div class="form-group col-md-12">
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
                <div class="modal-body col-md-12">
                    <div class="form-group">
                        <label class="col-md-2 control-label">所有者<span style="color: red;">*</span></label>
                        <div class="col-md-10">
                            <select class="form-control">
                                <c:forEach items="${requestScope.users}" var="u">
                                    <option value="${u.userId}">${u.uLoginAct}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label class="col-md-2 control-label">名称<span style="color:red">*</span></label>
                        <div class="col-md-10"><input type="text" class="form-control"/></div>

                    </div>
                    <div class="form-group col-md-12">
                        <label>开始日期</label>
                        <input type="text" class="form-control"/>
                        <label>结束日期</label>
                        <input type="text" class="form-control"/>
                    </div>
                    <div class="form-group col-md-12">
                        <label>成本</label>
                        <input type="text" class="form-control"/>
                    </div>
                    <div class="form-group col-md-12">
                        <label>描述</label>
                        <textarea class="form-control" rows="3"></textarea>
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
                <div class="col-xs-2">
                    <div class="input-group">
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button">名称</button>
                            </span>
                        <input type="text" class="form-control">
                    </div><!-- 名称 -->
                </div><!-- /.col-lg-2 -->
                <div class="col-xs-2">
                    <div class="input-group">
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button">所有者</button>
                            </span>
                        <input type="text" class="form-control">
                    </div><!-- 所有者 -->
                </div><!-- /.col-lg-2 -->
                <div class="col-xs-2">
                    <div class="input-group">
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button">开始日期</button>
                            </span>
                        <input type="text" class="form-control">
                    </div><!-- 开始日期-->
                </div><!-- /.col-lg-2 -->
                <div class="col-xs-2">
                    <div class="input-group">
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button">结束日期</button>
                            </span>
                        <input type="text" class="form-control">
                    </div><!-- 结束日期-->
                </div><!-- /.col-lg-2 -->
                <div class="col-xs-2">
                    <button type="button" class="btn btn-sm btn-success">查询</button>
                </div>
            </div><!-- /.row -->
        </div>
    </div>
    <br/><br/>
    <!--操作按钮-->
    <div class="btn-group" role="group">
        <button type="button" style="pointer-events:auto" class="btn btn-primary" id="createActivityBtn">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
            创建
        </button>
        <button type="button" class="btn btn-default" data-toggle="modal" data-target="#edit-ActivityModel">
            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
            修改
        </button>
        <button type="button" class="btn btn-warning">
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
            <th><input type="checkbox"></th>
            <th>名称</th>
            <th>所有者</th>
            <th>开始日期</th>
            <th>结束日期</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td><input type="checkbox"></td>
            <td>hhh</td>
            <td>hhh</td>
            <td>hhh</td>
            <td>hhh</td>
        </tr>
        </tbody>
    </table>
    <!--分页查询-->
    <div class="col-md-12">
        <button class="btn btn-default col-md-1">共xx条数据</button>
        <div class="btn-group  col-md-4" role="group" aria-label="...">
            <button class="btn btn-default">显示</button>
            <div class="btn-group" role="group">
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false">
                    10
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu">
                    <li><a href="#">10</a></li>
                    <li><a href="#">20</a></li>
                </ul>
            </div>
            <button class="btn btn-default">条/页</button>
        </div>
        <div class="col-md-4">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li>
                        <a href="#" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <li><a href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">5</a></li>
                    <li>
                        <a href="#" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
