<%@ page contentType="text/html;charset=UTF-8"  language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图书馆首页</title>
    
    <style>
        #login{
           height: 50%;
            width: 28%;
            margin-left: auto;
            margin-right: auto;
            margin-top: 5%;
            display: block;
            position: center;
        }

        .form-group {
            margin-bottom: 0;
        }
        * {
            padding:0;
            margin:0;
        }
    </style>
</head>
<body background="img/timg.jpg" style=" background-repeat:no-repeat ;
background-size:100% 100%;
background-attachment: fixed;">
<c:if test="${!empty error}">
    <script>
            alert("${error}");
            window.location.href="login.html";
</script>
</c:if>
<h2 style="text-align: center; color: white; font-family: '华文行楷'; font-size: 500%">图 书 馆</h2>

<div class="panel panel-default" id="login">
    <div class="panel-heading" style="background-color: #fff">
        <h3 class="panel-title">请登录</h3>
    </div>
    <div class="panel-body">
        <div class="form-group">
            <label for="id">账号</label>
            <input type="text" class="form-control" id="id" placeholder="请输入账号">
        </div>
        <div class="form-group">
            <label for="passwd">密码</label>
            <input type="password" class="form-control" id="passwd" placeholder="请输入密码">
        </div>
        <div class="checkbox text-left">
            <label>
                <input type="checkbox" id="remember">记住密码
            </label>
        </div>

        <p style="text-align: right;color: red;position: absolute" id="info"></p><br/>
        <button id="loginButton"  class="btn btn-primary  btn-block">登陆
        </button>
    </div>
</div>
    <script>
        document.getElementById("id").addEventListener("keyup", function() {
            if (isNaN(document.getElementById("id").value)) {
                document.getElementById("info").textContent = "提示:账号只能为数字";
            } else {
                document.getElementById("info").textContent = "";
            }
        });
        // 记住登录信息
        function rememberLogin(username, password, checked) {
            document.cookie = "loginStatus=" + JSON.stringify({
                username: username,
                password: password,
                remember: checked
            }) + "; expires=30; path=/";
        }
        // 若选择记住登录信息，则进入页面时设置登录信息
        function setLoginStatus() {
            var loginStatusText = (document.cookie.match(/(?:(?:^|.*;\s*)loginStatus\s*\=\s*([^;]*).*$)|^.*$/) || [])[1];
            if (loginStatusText) {
                var loginStatus
                try {
                    loginStatus = JSON.parse(loginStatusText);
                    var idInput = document.getElementById("id");
                    var passwdInput = document.getElementById("passwd");
                    var rememberCheckbox = document.getElementById("remember");

                    if (loginStatus) {
                        idInput.value = loginStatus.username;
                        passwdInput.value = loginStatus.password;
                        rememberCheckbox.checked = true;
                    }
                } catch (e) {
                    console.error(e);
                }
            }
        }

        // 设置登录信息
        setLoginStatus();
        document.getElementById("loginButton").addEventListener("click", function () {
            var id = document.getElementById("id").value;
            var passwd = document.getElementById("passwd").value;
            var remember = document.getElementById("remember").checked;
            if (id == '') {
                document.getElementById("info").textContent = "提示:账号不能为空";
            } else if (passwd == '') {
                document.getElementById("info").textContent = "提示:密码不能为空";
            } else if (isNaN(id)) {
                document.getElementById("info").textContent = "提示:账号必须为数字";
            } else {
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "/api/loginCheck", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        var data = JSON.parse(xhr.responseText);
                        if (data.stateCode.trim() === "0") {
                            document.getElementById("info").textContent = "提示:账号或密码错误！";
                        } else if (data.stateCode.trim() === "1") {
                            document.getElementById("info").textContent = "提示:登陆成功，跳转中...";
                            window.location.href = "/admin_main.html";
                        } else if (data.stateCode.trim() === "2") {
                            if (remember) {
                                rememberLogin(id, passwd, remember);
                            } else {
                                document.cookie = "loginStatus=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
                            }
                            document.getElementById("info").textContent = "提示:登陆成功，跳转中...";
                            window.location.href = "/reader_main.html";
                        }
                    }
                };
                xhr.send("id=" + id + "&passwd=" + passwd);
            }
        });
    </script>
</div>

</body>
</html>
