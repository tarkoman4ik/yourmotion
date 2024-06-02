<!DOCTYPE html>
<html lang="ru">
<head>
    <title>${video.title}</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="/static/css/style.css?version=51">
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
        <div id="onlyvideo">
            <div id="videowatch">
                <video controls style="width:1280px;height:720px; border-radius: 15px">
                <source src="/target/classes/uploads/${video.getUser().getId_user()}/${video.title}.mp4" type="video/mp4">
                </video>
                <h1 style="margin-top: 20px">${video.title}</h1>
                <div id="userSubs">
                <a href="/profile/${video.getUser().getId_user()}"><img style="border-radius: 25px;" src="/avatar/${video.getUser().getId_user()}"></a>
                <div id="userName">
                <h2><a style="color:white"href="/profile/${video.getUser().getId_user()}">${video.getUser().getChannelname()}</a></h2>
                <p>${video.getUser().getSubscribers()} подписчиков</p>
                </div>
                <div>
                <#if user.id_user??>
                <#if user.id_user != video.getUser().getId_user()>
                <button class="subscribeButton" type="button">Подписаться</button>
                </div>
                <div style="margin-left: 600px">
                <#else>
                </div>
                <div style="margin-left: 700px">
                </#if>
                <#else>
                <a href="/login"><button class="subscribeButton" type="button">Подписаться</button></a>
                </div>
                <div style="margin-left: 600px">
                </#if>
                <button style="width:120px; height:40px; background-color: white; margin: 15px 0px 15px 0px; border-radius: 35px 0px 0px 35px;" class="subscribeButton"><img style="border-radius: 10px 10px 0px 0 px;width:30px; margin: 0px; height:30px; background-color: white" src="/static/images/like.png"><b>          10</b></button>
                <button style="width:120px; height:40px; background-color: white; margin: 15px 0px 15px 0px; border-radius: 0px 35px 35px 0px;" class="subscribeButton"><b>20          </b><img style="border-radius: 10px 10px 0px 0 px;width:30px; margin: 0px; height:30px; background-color: white" src="/static/images/dislike.png"></button>
                </div>
                </div>
                <div id="description">
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
                    <#setting time_format="HH:mm">
                    <#setting locale="ru_RU">
                    <h3>${video.views} ${view} загружен ${video.upload?datetime.iso?date} в ${video.upload?datetime.iso?time}
                    <br>
                    <h3 style="margin-top:10px">${video.description}</h3>
                </div>
            </div>
        </div>
        </div>
    </div>
</div>
</body>
</html>