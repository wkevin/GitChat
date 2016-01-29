<h1>Git 聊天室</h1>

<!-- MarkdownTOC -->

update time:2016-01-29 09:37

- [起步](#_1)
    - [git是从何而来](#git)
    - [git有哪些好的入门的资料](#git_1)
- [加速](#_2)
    - [怎样才能第一时间得知git上有提交和更新](#git_2)
- [冲刺](#_3)

<!-- /MarkdownTOC -->


# 起步

## git是从何而来

这里有一篇git的创始人Torvalds（同时也是Linux的创始人）的接受中国媒体的一篇访谈录：

* [Linux创始人Linus Torvalds访谈，Git的十年之旅](http://www.wtoutiao.com/a/2287349.html) -- 如果网页链接失效，重新百度即可，类似的访谈录很多，但大多是英文的。

## git有哪些好的入门的资料

当然，我明白你说的是中文资料。

* [Pro Git（中文版）](http://git.oschina.net/progit/)
* [git简明教程](http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)

# 加速

## 怎样才能第一时间得知git上有提交和更新

和团队成员保持紧密合作在敏捷中非常重要，SVN的时候有一个非常优秀的软件 CommitMonitor，能够监控SVNServer的更新，图标是一双大眼睛，悄悄的躲在任务栏，发现更新大眼睛变成红色转啊转的。

git和svn有所不同，svn 有 server，监控器只需要监控server即可，git 没有server，只有hub，或者说每个人电脑里的git都是server，大家通过hub进行同步。监控server和监控hub的思路是有些差别的，各位看官可细细品味。

监控 git hub 的软件有：

- windows 平台
    - SourceLog：https://github.com/tomhunter-gh/SourceLog
    - SCM Notifier： https://github.com/pocorall/scm-notifier
- linux 平台
    - GitMon：https://github.com/spajus/gitmon
    - git-dude： https://github.com/sickill/git-dude
    - git-notifier： http://www.icir.org/robin/git-notifier
- OS.X 平台
    + Gitifier：https://github.com/nschum/Gitifier

但经过我的试用，功能还都不完善，希望它们早日成熟、好用。

目前可以使用 github/gitlab 的 RSS Feed 功能：

针对个人的RSS Feed：
![](img/gitlab-rss-feed-user.png)

针对团队的RSS Feed：
![](img/gitlab-rss-feed-group.png)

使用 RSS Reader（图中使用的是Snafer）订阅的效果：
![](img/gitlab-rss-reader.png)


# 冲刺