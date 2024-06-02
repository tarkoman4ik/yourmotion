<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Редактор видео</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="/static/css/style.css?version=51">
</head>
<body>
            <h3>Изменить профиль</h3>
            <form action="/profile/update/${user.id_user}" method="post" enctype="multipart/form-data">
            Название канала: <input type="text" name="channelname"><br><br>
            Имя пользователя: <input type="text" name="name"><br><br>
            Фамилия пользователя: <input type="text" name="surname"><br><br>
            Описание канала: <textarea type="text" name="description"></textarea><br><br>
            Страна: <input type="text" name="country"><br><br>
            Смена аватара: <input type="file" name="file"><br><br>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" style="cursor:pointer" value="Изменить профиль"/>
            </form>
            <h3>Удалить пользователя(Это действие нельзя отменить!)</h3>
            <form action="/profile/delete/${user.id_user}" method="post" enctype="multipart/form-data">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input style="cursor:pointer" type="submit" value="Удалить пользователя"/>
            </form>
            <div>
                <#if deleteMessage??>
                <h1>${deleteMessage}</h1>
                </#if>
                <#if updateMessage??>
                <h1>${updateMessage}</h1>
                </#if>
            </div>
</body>
</html>