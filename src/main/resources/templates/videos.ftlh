<!DOCTYPE html>
<html lang="ru">
<head>
    <title>YourMotion</title>
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
            <input  style="width: 45px; height:45px; color:white;font-size: 18px; padding: 0px" type="submit" value="🔎︎"/>
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
            <a href="/">
            <h1 style="text-align: center; margin-bottom: 10px; color:white;margin-top:15px">
            <img style="width:25px; height:25px" src="/static/images/homeico.png">
            Главная
            <img style="width:25px; height:25px" src="/static/images/homeico.png">
            </h1>
            </a>
            _________________________________________
            <#if user.mail??>
            <h3 style="margin-top:5px;margin-bottom:5px;">Канал</h3>
            <h1 style="text-align: center;margin-top:15px;margin-bottom:15px;"><a style="color:white;text-weight:bold"href="/profile/${user.id_user}">${user.channelname}</a></h1>
            <form action="/logout" method="post">
                  <input type="hidden" name="_csrf" value="${_csrf.token}">
                  <input style="cursor:pointer;color:white;width:300px" type="submit" value="Выйти"/>
            </form>
            <#else>
            <h3 id="auth" style="text-align:center; margin-top: 20px"><a style="color:white" href="/login">Войти в аккаунт</a></h3>
            </#if>
            _________________________________________
            <#if user.mail??>
            <h3 style="margin-top:15px;margin-bottom:5px;">Подписки</h3>
            <#list subscribers as sbs>
                <#if sbs.id_sub == user.id_user>
                <div id="userSubs" style="margin-top:10px;margin-bottom:10px">
                <a href="/profile/${sbs.id_user}"><img style="border-radius: 25px;width:50px;height:50px;" src="/avatar/${sbs.id_user}"></a>
                <div id="userName" style="margin-top:15px">
                <a href="/profile/${sbs.id_user}"><h2 style="color:white; margin-left:15px;">${sbs.username}</h2></a>
                </div>
                </div>
                </#if>
            </#list>
            </#if>
            </div>
            <div>
            <p>yourmotion.ru  &copy; 2024-2025. Saar Fedor</p>
            </div>
        </div>
            <div id="Catalog" style="width: 1565px; height: 900px;">
            <#list videos as video>
                <div id="block" style="width: 380px; margin-top:20px">
                <a href="/video/${video.id_video}">
                <img alt="vid_preview" style="background-color: #313131;width:350px;height:200px; border-radius: 15px" src="/image/${video.id_video}">
                <div id="userSubs">
                <img style="border-radius: 15px;" src="/avatar/${video.getUser().getId_user()}">
                <div id="userName">
                <h2 style="color:white; margin-left:15px;">${video.title}</h2>
                <p style="margin-left:15px">${video.getUser().getChannelname()}</p>
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
                    <h1>Таких видео не найдено.</h1>
                </#list>
            </div>
        </div>
    </div>
</div>
</body>
</html>