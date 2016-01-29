<h1>Git 聊天室</h1>

<!-- MarkdownTOC -->

update time:2016-01-29 10:33

- [起步](#_1)
    - [git在哪里](#git)
    - [Git for Windows 咋用](#gitforwindows)
- [加速](#_2)
    - [git是从何而来](#git_1)
    - [git有哪些好的入门的资料](#git_2)
    - [怎样才能第一时间得知git上有提交和更新](#git_3)
- [冲刺](#_3)

<!-- /MarkdownTOC -->


# 起步

## git在哪里

* Unix系（Ubuntu/Fedora/MAC-OS.X/……）默认就有：有且仅有command line
* Windows目前有两大软件：
    + [Git for Windows](https://github.com/git-for-windows/git)
        * 第一代的名字叫[msysGit](https://github.com/msysgit/git)，基于 msys（属于 MinGW）—— 2015年底已废弃
        * 第二代重新建立了github项目[Git for Windows](https://github.com/git-for-windows/git)，基于 msys2（不再属于MinGW），英语有自信的可以读读它的[背景](https://github.com/git-for-windows/git/wiki)
    + [TortoiseGit](http://code.google.com/p/tortoisegit/)：类似TortoiseSVN，可以做图标重绘。
    + 个人建议：
        * 使用git请把重心放在：使用命令行
        * 只安装 **Git for Windows** 就行了

## Git for Windows 咋用

提供我们团队FTP的下载链接：[Git-2.7.0-32-bit.exe](ftp://emb:zteemb@10.9.111.222/Soft/Develop/Git/Git4Windows/Git-2.7.0-32-bit.exe)

一路“下一步”安装完即可。

![](img/git4windows-install.png)

* Git Bash: Linux 风格的命令行，如： /user/bin
* Git CMD： Windows风格的命令行，即：C:\system
* Git GUI: 图形化界面

# 加速

## git是从何而来

这里有一篇git的创始人Torvalds（同时也是Linux的创始人）的接受中国媒体的一篇访谈录：

* [Linux创始人Linus Torvalds访谈，Git的十年之旅](http://www.wtoutiao.com/a/2287349.html) -- 如果网页链接失效，重新百度即可，类似的访谈录很多，但大多是英文的。

## git有哪些好的入门的资料

当然，我明白你说的是中文资料。

* [Pro Git（中文版）](http://git.oschina.net/progit/)
* [git简明教程](http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)

为什么把git的历史和资料放在**加速**章节，而不是**起步**？—— 答案很简单：“10分钟了还不能开玩，心情多糟糕啊！”。

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