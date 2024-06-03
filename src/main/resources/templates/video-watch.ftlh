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
    <div style="display:flex">
    <div id="container">
        <div id="content">
        <div id="onlyvideo">
            <div id="videowatch">
                <video controls style="width:1280px;height:720px; border-radius: 15px">
                <source nonstarter="this.volume=0.4" src="/target/classes/uploads/${video.getUser().getId_user()}/${video.title}.mp4" type="video/mp4">
                </video>
                <h1 style="margin-top: 20px">${video.title}</h1>
                <div id="userSubs">
                <a href="/profile/${video.getUser().getId_user()}"><img style="border-radius: 25px;" src="/avatar/${video.getUser().getId_user()}"></a>
                <div id="userName">
                <h2><a style="color:white"href="/profile/${video.getUser().getId_user()}">${video.getUser().getChannelname()}</a></h2>
                <#assign count=0>
                <#list subscribers as sbs>
                    <#if sbs.id_user == video.getUser().getId_user()>
                    <#assign count = count + 1>
                    </#if>
                </#list>
                <p>${count} подписчиков</p>
                </div>
                <div>
                <#if user.id_user??>
                <#if user.id_user != video.getUser().getId_user()>
                <#assign check = 0>
                <#list subscribers as sb>
                    <#if (sb.id_sub == user.id_user) && (sb.id_user == video.getUser().getId_user())>
                    <#assign check=check+1>
                    </#if>
                </#list>
                <#if check == 0>
                <form action="/subscribe/create/${id_video}" method="post">
                <input style="text-weight:bold;cursor:pointer;width:150px;padding:0px;margin-left:15px;margin-top:15px;color:black;background-color:white" type="submit" value="Подписаться">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                </form>
                <#else>
                <form action="/subscribe/delete/${id_video}" method="post">
                <input style="text-weight:bold;cursor:pointer;width:150px;padding:0px;margin-left:15px;margin-top:15px;color:black;background-color:white" type="submit" value="Отписаться">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                </form>
                </#if>
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
                    <h3>${video.views} ${view} загружен ${video.upload?datetime.iso?date} в ${video.upload?datetime.iso?time}</h3>
                    <br>
                    <h3>Описание:</h3>
                    <h3 style="margin-top:10px;font-weight:normal">${video.description}</h3>
                </div>
            </div>
            <div style="display:flex;margin-left:50px;margin-top:15px;flex-direction:column">
            <#if user.mail??>
            <div style="display:flex;flex-direction:row;">
            <a href="/profile/${user.id_user}"><img style="border-radius: 25px;width:50px;height:50px" src="/avatar/${user.id_user}"></a>
            <form style="display:flex;justify-content:space-between;margin-left:10px;" action="/comm/add/${video.id_video}" method="POST">
            <textarea placeholder="Введите комментарий" style="font-size: 18px;width:930px; background-color: #212121; border:0px;color: white; resize: none;" name="comment"></textarea>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input style="cursor:pointer;color:black;max-height: 150px;overflow-x: hidden;overflow-y:auto;width:250px;text-align:center;box-sizing:content-box;background-color:lightblue" type="submit" value="Оставить комментарий">
            </form>
            </div>
            ————————————————————————————————————————————————————————————————————————————————
            <br>
            </#if>
            <#if comments?has_content>
            <#list comments as comment>
                <#if comment.getVid().getId_video() == video.id_video>
                <div id="userSubs" style="margin-top:10px;margin-bottom:10px">
                <img style="border-radius: 25px;width:50px;height:50px;" src="/avatar/${comment.id_user}">
                <div id="userName">
                <h2 style="color:white; margin-left:15px;">${comment.username}</h2>
                <p style="color:white; margin-left:15px;text-weight:normal;font-size:16px;">${comment.message}</p>
                </div>
                </div>
                </#if>
            </#list>
            </#if>
            </div>
        </div>
        </div>
    </div>
    <div id="sidebar2" style="width:480px;margin-left: 20px;display:flex;flex-direction:column;justify-content:flex-start">
    <#list videos as video2>
        <#if video2.id_video != video.id_video>
        <div id="block" style="display:flex;width:480px; margin-top:10px;margin-bottom:0px">
        <a href="/video/${video2.id_video}">
        <img alt="vid_preview" style="background-color: #313131;width:175px;height:100px; border-radius: 15px" src="/image/${video2.id_video}">
        </a>
        <a style="margin-top:15px;" href="/video/${video2.id_video}">
        <h2 style="color:white; margin-left:15px;">${video2.title}</h2>
        <p style="margin-left:15px">${video2.getUser().getChannelname()}</p>
        <#setting time_format="HH:mm">
        <#setting locale="ru_RU">
        <#assign n2 = video2.views % 100>
        <#if (n2 gte 11)&&(19 gte n2)>
        <#assign view = "просмотров">
        <#else>
        <#assign n1 = video2.views % 10>
        <#if n1 == 1>
        <#assign view = "просмотр">
        <#elseif (n1 gte 2)&&(4 gte n1)>
        <#assign view = "просмотра">
        <#else>
        <#assign view = "просмотров">
        </#if>
        </#if>
        <p style="margin-left:15px">${video2.views} ${view} • ${video2.upload?datetime.iso?date} в ${video2.upload?datetime.iso?time}</p>
        </a>
        </div>
        </#if>
        </#list>
    </div>
    </div>
</div>
</body>
</html>