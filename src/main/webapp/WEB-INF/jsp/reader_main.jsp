<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<body background="img/wolf.jpg" style=" background-repeat:no-repeat ;
background-size:100% 100%;
background-attachment: fixed;">
<div id="header"></div>

</body>
</html>
