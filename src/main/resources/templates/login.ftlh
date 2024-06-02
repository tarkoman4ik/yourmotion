<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Login</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="/static/css/login.css?version=51">
</head>
<body>
<div class="container">
<h1>Авторизация</h1>
<form id="loginForm" action="/login" method="post">
    Эл.почта: <input type="email" name="username"><br>
    Пароль: <input type="password" name="password"><br>
    <input type="hidden" name="_csrf" value="${_csrf.token}">
    <input type="submit" value="Вход"/>
    <p>Ещё нет аккаунта? <a href="/registration">Создайте </a>его прямо сейчас!</p>
    <a style="color:black" href="/">← Назад</a>
</form>
</div>
</body>
</html>