<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Редактор видео</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="/static/css/style.css?version=51">
</head>
<body>
<div id="wrapper" style="background-color: #212121;">
    <div id="MainHeader" style="justify-content: flex-end; align-items: flex-start;">
        <a style="text-decoration: none" href="/"><h1 style="color:red; margin-left:150px; margin-top:20px; margin-right:20px">Your<b style="color:white">Motion</b></h1></a>
    </div>
    <div id="container">
        <div id="content" style="flex-direction:column;margin-top:150px">
            <h3>Изменить профиль</h3>
            <form action="/profile/update/${user.id_user}" method="post" enctype="multipart/form-data">
            Название канала: <input style="color:white" type="text" name="channelname"><br><br>
            Имя пользователя: <input style="color:white"  type="text" name="name"><br><br>
            Фамилия пользователя: <input style="color:white"  type="text" name="surname"><br><br>
            Описание канала: <textarea style="white-space: pre-wrap; color:white" type="text" name="description"></textarea><br><br>
            Страна: <input style="color:white" type="text" name="country"><br><br>
            Смена аватара: <input type="file" name="file"><br><br>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" style="cursor:pointer;color:white" value="Изменить профиль"/>
            </form>
            <br><br>
            <h3>Удалить пользователя(Это действие нельзя отменить!)</h3>
            <form action="/profile/delete/${user.id_user}" method="post" enctype="multipart/form-data">
            <input style="color:white"  type="hidden" name="_csrf" value="${_csrf.token}">
            <input style="cursor:pointer;color:white" type="submit" value="Удалить пользователя"/>
            </form>
            <div>
                <#if deleteMessage??>
                <h1>${deleteMessage}</h1>
                </#if>
                <#if updateMessage??>
                <h1>${updateMessage}</h1>
                </#if>
            </div>
        </div>
    </div>
    </div>
</div>
</body>
</html>