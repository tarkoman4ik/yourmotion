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
        <h3>Добавить видео ${user.channelname}</h3>
        <form action="/video/create" method="post" enctype="multipart/form-data">
            Название видео: <input type="text" name="title"><br><br>
            Описание видео: <textarea  style="white-space: pre-wrap;" type="text" name="description"></textarea><br><br>
            Превью видео: <input type="file" accept=".png, .jpg, .jpeg|image/*" name="file"><br><br>
            Видео: <input type="file" accept=".mp4" name="videofile"><br><br>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" style="cursor:pointer;color:green" value="Добавить видео"/>
        </form>
        <h3>Изменить видео</h3>
        <form action="/video/update" method="post" enctype="multipart/form-data">
        <select name="update_id">
            <option disabled>Выберите видео</option>
            <#list user.getVideos() as video>
                <option value="${video.id_video}">${video.title}</option>
            </#list>
        </select>
        Название видео: <input type="text" name="title"><br><br>
        Описание видео: <textarea  style="white-space: pre-wrap;" type="text" name="description"></textarea><br><br>
        Превью видео: <input type="file" name="file"><br><br>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="submit" style="cursor:pointer;color:white" value="Изменить видео"/>
        </form>
        <h3>Удалить видео</h3>
        <form action="/video/delet" method="post" enctype="multipart/form-data">
        <select name="delete_id">
            <option disabled>Выберите видео</option>
            <#list user.getVideos() as video>
                <option value="${video.id_video}">${video.title}</option>
            </#list>
        </select>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input style="cursor:pointer;color:red" type="submit" value="Удалить видео"/>
        </form>
        <div>
            <#if deleteMessage??>
            <h1>${deleteMessage}</h1>
            </#if>
            <#if updateMessage??>
            <h1>${updateMessage}</h1>
            </#if>
            <#if createMessage??>
            <h1>${createMessage}</h1>
            </#if>
            </div>
        </div>
    </div>
    </div>
</div>
</body>
</html>