<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Registration</title>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="/static/css/register.css?version=51">
</head>
<body>
<div class="content">
<h1>Регистрация</h1>
<form id="registerForm" action="/registration" method="post" enctype="multipart/form-data">
    Имя канала: <input type="text" name="channelname"><br>
    Имя пользователя: <input type="text" name="name"><br>
    Фамилия пользователя: <input type="text" name="surname"><br>
    Страна: <input type="text" name="country"><br>
    Эл.почта: <input type="email" name="mail"><br>
    Пароль: <input type="password" name="password"><br>
    <input type="hidden" name="_csrf" value="${_csrf.token}">
    <input type="submit" value="Зарегистрироваться"/><br>
    <a style="color:black" href="/login">← Назад</a>
</form>
<#if errorMessage??>
<h2 style="color:red">${errorMessage}</h2>
</#if>
</div>
</body>
</html>