<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Редактор видео</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="/static/css/style.css?version=51">
    <script src ="/static/js/video-manage.js"></script>
</head>
<body>
            <h3>Добавить видео ${user.name}</h3>
            <form action="/video/create" method="post" enctype="multipart/form-data">
                Название видео: <input type="text" name="title"><br><br>
                Описание видео: <textarea type="text" name="description"></textarea><br><br>
                Превью видео: <input type="file" name="file"><br><br>
                Видео: <input type="file" name="videofile"><br><br>
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" value="Добавить видео"/>
            </form>

            <form action="/video/create" method="post" enctype="multipart/form-data">
                Название видео: <input type="text" name="title"><br><br>
                Описание видео: <textarea type="text" name="description"></textarea><br><br>
                Превью видео: <input type="file" name="file"><br><br>
                Видео: <input type="file" name="videofile"><br><br>
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" value="Изменить видео"/>
            </form>

            <h3>Удалить видео</h3>
            <form action="/video/delet" method="post">
            <select name="id_video">
                <option disabled>Выберите видео</option>
                <#list user.getVideos() as video>
                    <option value="${video.id_video}">${video.title}</option>
                </#list>
            </select>
            <input style="cursor:pointer" type="submit" value="Удалить видео"/>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            </form>
</body>
</html>