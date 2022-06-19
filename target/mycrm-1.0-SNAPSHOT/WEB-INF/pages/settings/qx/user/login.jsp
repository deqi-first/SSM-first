<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="jquery/bootstrap-3.4.1/dist/css/bootstrap.min.css"/>

    <script type="text/javascript" src="jquery/jquery-3.5.1.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-3.4.1/dist/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        //给整个浏览器窗口添加键盘按下事件
        $(window).keydown(function (e) {
            //回车键的keyCode是13
            if(e.keyCode==13){
                $("#loginBtn").click();
            }
        })
        $(function () {
            $("#loginBtn").click(function () {
                //trim()去除空格
                let loginAct1 = $.trim($("#loginAct").val());
                let loginPwd1 = $.trim($("#loginPwd").val());
                //attr获取属性值，获取不到值是true或者false的属性值，例如checkbox，selected，readonly，disabled
                // $("#isRemPwd").attr("")
                //prop()专门用来获取值是true或者false的函数
                let isRemPwd1 = $("#isRemPwd").prop("checked")
                //表单数据
                if (loginAct1 == "" || loginPwd1 == "") {
                    alert("Username or Password can't be null!!");
                    return;
                }
                $.ajax({
                    url: "settings/qx/user/login.do",
                    data: {
                        loginAct: loginAct1,
                        loginPwd: loginPwd1,
                        isRemPwd: isRemPwd1
                    },
                    type: "post",
                    dataType: "json",
                    success: function (ret) {
                        if (ret.code == "1") {
                            window.location.href = "/workbench/index.do";//跳转到controller，不能直接跳转到静态页面
                        } else {
                            $("#msg").html(ret.message);
                        }
                    },
                    beforeSend: function () {//当ajax向后台发送请求之前，会自动执行本函数该函数的返回值能够决定ajax是否真正向后台发送请求：
                        //如果该函数返回true，则ajax会正在向后台发送请求，否则，如果该函数返回false则ajax放弃向后台发送请求
                        $("#msg").text("正在努力验证....");
                        return true;

                    }
                })

            });
        })
    </script>
</head>
<body>
<div style="position: relative;background-color: black">
    <img src="image/xanadu.jpg" style="width: 50%;height: 100%;">
    <div style="position:absolute;top:10px;right:5px;width: 50%;float: right;">
        <div class="modal-dialog" role="document" style="width: 80%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">登录</h4>
                </div>
                <form class="form-horizontal">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">Username</label>
                            <div class="col-sm-10">
                                <input id="loginAct" name="loginAct" value="${cookie.loginAct.value}" type="text" class="form-control" id="inputEmail3"
                                       placeholder="Username">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword3" class="col-sm-2 control-label">Password</label>
                            <div class="col-sm-10">
                                <input id="loginPwd" value="${cookie.loginPwd.value}" name="loginPwd" type="password" class="form-control"
                                       id="inputPassword3" placeholder="Password">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <div class="checkbox">
                                    <label>
                                        <input id="isRemPwd" name="isRemPwd" type="checkbox"> Remember me
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button id="loginBtn" type="button" class="btn btn-default">Login in
                                </button>
                            </div>
                        </div>
                        <div><span style="color: red" id="msg"></span></div>

                    </div>
                </form>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->


    </div>
</div>
</body>
</html>