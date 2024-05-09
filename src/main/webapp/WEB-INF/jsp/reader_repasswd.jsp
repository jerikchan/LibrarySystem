<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${readercard.name}的主页</title>
    
    <script>
        window.addEventListener('DOMContentLoaded', function() {
            var header = document.getElementById('header');
            var xhr = new XMLHttpRequest();
            xhr.open('GET', 'reader_header.html', true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    header.innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        });
    </script>
</head>
<body background="img/lizhi.jpg" style=" background-repeat:no-repeat ;
background-size:100% 100%;
background-attachment: fixed;">
<div id="header"></div>
<c:if test="${!empty succ}">
    <div class="alert alert-success alert-dismissable">
        <button type="button" class="close" data-dismiss="alert"
                aria-hidden="true">
            &times;
        </button>
            ${succ}
    </div>
</c:if>
<c:if test="${!empty error}">
    <div class="alert alert-danger alert-dismissable">
        <button type="button" class="close" data-dismiss="alert"
                aria-hidden="true">
            &times;
        </button>
            ${error}
    </div>
</c:if>

<div class="col-xs-6 col-md-offset-3" style="position: relative;">
    <div class="panel panel-primary ">
        <div class="panel-heading">
            <h3 class="panel-title">密码修改</h3>
        </div>
        <div class="panel-body">
            <form method="post" action="reader_repasswd_do" class="form-inline" id="repasswd">
                <div class="input-group">
                    <input type="password" id="oldPasswd" name="oldPasswd" placeholder="输入旧密码" class="form-control"
                           class="form-control">
                    <input type="password" id="newPasswd" name="newPasswd" placeholder="输入新密码" class="form-control"
                           class="form-control">
                    <input type="password" id="reNewPasswd" name="reNewPasswd" placeholder="再次输入新密码"
                           class="form-control" class="form-control">
                    <em id="tishi" style="color: red"></em>
                    <br/>
                    <span>
                            <input type="submit" value="提交" class="btn btn-default">
            </span>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener('keyup', function() {
        if (document.getElementById('newPasswd').value !== document.getElementById('reNewPasswd').value && document.getElementById('newPasswd').value !== '' && document.getElementById('reNewPasswd').value !== '' && document.getElementById('newPasswd').value.length === document.getElementById('reNewPasswd').value.length) {
            document.getElementById('tishi').textContent = '提示:两次输入的新密码不同，请检查!';
        } else {
            document.getElementById('tishi').textContent = '';
        }
    });

    document.getElementById('repasswd').addEventListener('submit', function(event) {
        if (document.getElementById('oldPasswd').value === '' || document.getElementById('newPasswd').value === '' || document.getElementById('reNewPasswd').value === '') {
            document.getElementById('tishi').textContent = '提示:请填写完整!';
            event.preventDefault();
        } else if (document.getElementById('newPasswd').value !== document.getElementById('reNewPasswd').value) {
            document.getElementById('tishi').textContent = '提示:两次输入的新密码不同，请检查!';
            event.preventDefault();
        }
    });
</script>


</body>
</html>
