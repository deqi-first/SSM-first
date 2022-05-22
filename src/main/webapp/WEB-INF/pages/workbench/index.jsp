<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="jquery/bootstrap-3.4.1/dist/css/bootstrap.min.css">
    <script type="text/javascript" src="jquery/jquery-3.5.1.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-3.4.1/dist/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function () {
            function logout() {
                window.location.href = "settings/qx/user/logout.do";
            }

            function closeModal() {
                $("#closeBtn").click();
            }

            // $("#activityId").click(function () {
            //     window.open("/workbench/activity/toIndex.do", "workAreaFrame")
            // })
            window.open("/workbench/main/index.do", "workAreaFrame")
        });
        window.onload = function () {
            var ps = document.getElementById("navigation").getElementsByTagName("li");
            for (var i in ps) {
                ps[i].onmouseover = function () {
                    this.setAttribute("class", "active");
                }
                ps[i].onmouseout = function () {
                    this.removeAttribute("class");
                }
            }
        }
    </script>
</head>
<body>
<div>
    <%--提示框，默认隐藏--%>
    <div id="isLogout" class="modal fade" tabindex="-1">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button id="closeBtn" type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">提示框</h4>
                </div>
                <div class="modal-body"><p>确定退出吗？</p></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" onclick="logout();">退出</button>
                    <button type="button" class="btn btn-primary" onclick="closeModal();">取消</button>
                </div>
            </div><!-- /.modal-content -->
        </div>
    </div>
    <%--顶部--%>
    <div style="background-color: #3c3c3c;width: 100%;height: 50px;margin-top: -20px">
        <div class="page-header" style="color: wheat;margin-top: 0px;">
            <h3>客户信息管理系统<small>@xmq</small></h3>
            <%--下拉列表--%>
            <div class="btn-group" style="float: right;right:60px; top: -30px;width: 20px;">
                <button type="button" style="width: 70px;text-align: left;" class="btn btn-default dropdown-toggle"
                        data-toggle="dropdown" aria-haspopup="true"
                        aria-expanded="false"><span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                    ${sessionScope.sessionUser.uLoginAct}<span class="caret"></span>
                </button>
                <ul class="dropdown-menu">
                    <li><a>Action</a></li>
                    <li><a>hhh</a></li>
                    <li><a>登录</a></li>
                    <li id="logout" data-target="#isLogout" data-toggle="modal"
                        style="text-align:left;left: 5px;"><a><span class="glyphicon glyphicon-off"
                                                                    aria-hidden="true"></span>
                        退出</a></li>
                </ul>
            </div>
        </div>
    </div>
    <%--中间--%>
    <div style="position: absolute;top:50px;bottom: 30px;left:0px;right: 0px;">
        <%--左侧导航栏--%>
        <div style="left:0px;width: 18%;height: 100%;position: relative;overflow: auto">
            <ul id="navigation" class="nav nav-pills nav-stacked">
                <li role="presentation" class="active"><a href="#">
                    <span class="glyphicon glyphicon-home" aria-hidden="true"></span>
                    工作台</a></li>
                <li role="presentation"><a href="#">
                    <span class="glyphicon glyphicon-tags" aria-hidden="true"></span>
                    动态</a></li>
                <li role="presentation"><a href="#">
                    <span class="glyphicon glyphicon-time" aria-hidden="true"></span>
                    审批</a></li>
                <li role="presentation"><a href="#">
                    <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                    客户公海</a></li>
                <li role="presentation" id="activityId"><a href="/workbench/activity/toIndex.do" target="workAreaFrame">
                    <span class="glyphicon glyphicon-bullhorn" aria-hidden="true"></span>
                    市场活动</a></li>
                <li role="presentation"><a>
                    <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                    线索（潜在客户）</a></li>
                <li role="presentation"><a>
                    <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                    客户</a></li>
                <li role="presentation"><a>
                    <span class="glyphicon glyphicon-earphone" aria-hidden="true"></span>
                    联系人</a></li>
                <li role="presentation"><a>
                    <span class="glyphicon glyphicon-yen" aria-hidden="true"></span>
                    交易</a></li>
                <li role="presentation"><a>
                    <span class="glyphicon glyphicon-phone-alt" aria-hidden="true"></span>
                    售后回访</a></li>
                <li role="presentation"><a>
                    <span class="glyphicon glyphicon-stats" aria-hidden="true"></span>
                    统计图表</a></li>
                <li role="presentation"><a href="#">
                    <span class="glyphicon glyphicon-file" aria-hidden="true"></span>
                    报表</a></li>
                <li role="presentation"><a href="#">
                    <span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span>
                    销售订单</a></li>
                <li role="presentation"><a href="#">
                    <span class="glyphicon glyphicon-send" aria-hidden="true"></span>
                    发货单</a></li>
            </ul>
        </div>
        <%--右侧工作区--%>
        <div id="workArea" style="position:absolute;top:0px;left:18%;width:82%;height:100%;">
            <iframe style="border-width:0px;width:100%;height:100%;" name="workAreaFrame">
            </iframe>
        </div>
    </div> </div>
</body>
</html>
