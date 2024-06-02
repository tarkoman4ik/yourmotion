<!DOCTYPE html>
<html lang="ru">
<head>
    <title>${owner.channelname}</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="/static/css/style.css?version=51">
    <link rel="icon" href="/static/images/whiteico.ico" type="image/x-icon">
</head>
<body>
<div id="wrapper" style="background-color: #212121;">
    <div id="MainHeader" style="justify-content: flex-end; align-items: flex-start;">
        <a style="text-decoration: none" href="/"><h1 style="color:red; margin-left:150px; margin-top:20px">Your<b style="color:white">Motion</b></h1></a>
        <div id="BottomHeader" style="margin-left: 250px;">
        <form action="/" method="get">
            <input style="width: 650px; height:45px; color: white;" type="text" name="title" placeholder="Введите запрос" autocomplete="off">
            <input style="width: 45px; height:45px; color:white;font-size: 18px; padding: 0px" type="submit" value="🔎︎"/>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
        </form>
        <#if user.mail??>
        <a href="/profile/${user.id_user}"><img style="margin-left: 350px;border-radius: 20px; width: 50px; height: 50px" src="/avatar/${user.id_user}"></a>
        <#else>
        <a href="/login"><img style="margin-left: 350px;border-radius: 20px; width: 50px; height: 50px" src="/static/images/userprofile.png"></a>
        </#if>
        </div>
    </div>
    <div id="container">
        <div id="content">
        <div id="sidebar">
            <div id="sidebar-content">
            <#if user.mail??>
            <#if user.id_user == owner.id_user>
            <a href="/profile/${owner.id_user}">
            <h1 style="text-align: center; margin-bottom: 10px; color:white">
            Ваш канал
            </h1>
            </a>
            ___________________________________
            <h1 style="text-align: center;margin-top:15px;margin-bottom:15px;"><a style="color:white;text-weight:bold"href="/profile/${owner.id_user}">${user.channelname}</a></h1>
            <form action="/logout" method="post">
                  <input type="hidden" name="_csrf" value="${_csrf.token}">
                  <input style="cursor:pointer;color:white;width:300px" type="submit" value="Выйти"/>
            </form>
            <#else>
            <a href="/profile/${owner.id_user}">
            <h1 style="text-align: center; margin-bottom: 10px; color:white">
            Канал
            </h1>
            </a>
            <h1 style="text-align: center;margin-top:15px;margin-bottom:15px;"><a style="color:white;text-weight:bold"href="/profile/${owner.id_user}">${owner.channelname}</a></h1>
            </#if>
            <#else>
            <a href="/profile/${owner.id_user}">
            <h1 style="text-align: center; margin-bottom: 10px; color:white">
            Канал
            </h1>
            </a>
            <h1 style="text-align: center;margin-top:15px;margin-bottom:15px;"><a style="color:white;text-weight:bold"href="/profile/${owner.id_user}">${owner.channelname}</a></h1>
            ___________________________________
            <h3 id="auth" style="text-align:center; margin-top: 20px"><a style="color:white" href="/login">Войти в аккаунт</a></h3>
            </#if>
            ___________________________________
            <#if user.mail??>
            <#if user.id_user==owner.id_user>
            <h3 style="margin-top:15px;margin-bottom:5px;">Редакторы</h3>
            <h2 style="margin:10px;"><a style="color:white;" href="/video-manager">  • Редактор видео</a></h2>
            <h2 style="margin:10px;"><a style="color:white;" href="/profile-manager">  • Редактор профиля</a></h2>
            </#if>
            </#if>
            </div>
            <div>
            <p>yourmotion.ru  &copy; 2024-2025. Saar Fedor</p>
            </div>
        </div>
            <#assign count=0>
            <#list owner.getVideos() as cntvid>
                <#assign count = count + 1>
            </#list>
            <div style="display:flex;flex-direction:column">
            <div id="userSubs" style="margin-bottom:18px">
            <a href="/profile/${owner.id_user}"><img style="border-radius: 80px; width: 150px; height:150px; margin-left: 50px;" src="/avatar/${owner.id_user}"></a>
            <div id="userName" style="justify-content:center">
            <h1 style="margin-left:35px"><a style="color:white; font-size: 48px;"href="/profile/${owner.id_user}">${owner.channelname}</a></h1>
            <p style="font-size:18px">${owner.subscribers} подписчиков • ${count} видео</p>
            </div>
            </div>
            ____________________________________________________________________________________________________________________________________________________________________
            <h3 style="margin-top:15px;margin-left:15px;">Видео</h3>
            <div id="Catalog" style="width: 1565px; height: 900px;">
            <#list videos as video>
                <div id="block" style="width: 380px; margin-top:20px">
                <a href="/video/${video.id_video}">
                <img alt="vid_preview" style="background-color: #313131;width:350px;height:200px; border-radius: 15px" src="/image/${video.id_video}">
                <div id="userSubs">
                <div id="userName">
                <h2 style="color:white; margin-left:15px;">${video.title}</h2>
                <p style="margin-left:15px"> </p>
                <#setting time_format="HH:mm">
                <#setting locale="ru_RU">
                <#assign n2 = video.views % 100>
                <#if (n2 gte 11)&&(19 gte n2)>
                <#assign view = "просмотров">
                <#else>
                <#assign n1 = video.views % 10>
                <#if n1 == 1>
                <#assign view = "просмотр">
                <#elseif (n1 gte 2)&&(4 gte n1)>
                <#assign view = "просмотра">
                <#else>
                <#assign view = "просмотров">
                </#if>
                </#if>
                <p style="margin-left:15px">${video.views} ${view} • ${video.upload?datetime.iso?date} в ${video.upload?datetime.iso?time}</p>
                </div>
                </div>
                </a>
                </div>
                <#else>
                    <h1>Нет видео.</h1>
                </#list>
            </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>