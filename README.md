<h1>Git 聊天入门</h1>

**Git 可以很复杂，Git 也可以很简单。**

读一本Git的书和读一篇Git的文章给人的知识含量是不同的，但给人的愉悦感也是迥异的。本文不想写成一本书，至少不想让你有读书的感觉，但也不想像一篇文章似的只给你一个git的知识点。本文只是想从实际使用的角度，让大家都掌握 git 最简单，但又最有用的那些知识点。—— 因为本来这些问题都是来自于我和朋友们的聊天，可以说是我们的闲聊集，哪会有什么高深的理论？

经常见路边扯着喉咙吆喝的自由职业者，也有不少用喇叭录上一段反复播放的，前者有诚意、后者有效率 —— 我很有诚意，但本文就是那个喇叭。

--- 

<!-- MarkdownTOC -->

update time:2016-02-04 00:48

- [Round 1](#round1)
    - [git在哪里](#git)
    - [Git for Windows 咋用](#gitforwindows)
    - [先单机玩玩还是先弄来个别人的git库](#git_1)
    - [如何在本机git我的日记](#git_2)
    - [每次都要敲add、commit、status，嫌累了](#addcommitstatus)
    - [有些文件不希望被git管理](#git_3)
- [Round 2](#round2)
    - [我要筛选 git log](#gitlog)
    - [觉得 git log 中的时间看着困难，精简下呗](#gitlog_1)
    - [我要定制 git log，不想一页看不了几条](#gitlog_2)
    - [oneline太简陋了，我想一行里面看到hash、author、date、message](#onelinehashauthordatemessage)
    - [git log 已经很好了，但好像还是缺点啥](#gitlog_3)
    - [git log --fuller 中的 author 和 commit 啥关系](#gitlogfullerauthorcommit)
- [Round 3](#round3)
    - [我要能像TortoiseSVN那样左右两栏对比看diff](#tortoisesvndiff)
    - [我用ubuntu，我要修改git commint时的默认编辑器](#ubuntugitcommint)
    - [我想做个分支（branch），怎么做](#branch)
    - [分支要合并到主干或其他分支，怎么merge](#merge)
- [Round 4](#round4)
    - [想看看别人的git库了](#git_4)
    - [公司访问不了外网的github，咋办](#github)
    - [如何与别人合作](#_1)
    - [怎样才能第一时间得知git上有提交和更新](#git_5)
    - [github的工作流](#github_1)
- [Round 5](#round5)
    - [git是从何而来](#git_6)
    - [git有哪些好的入门的资料](#git_7)
    - [重新梳理git的软件](#git_8)
    - [导出某个子目录及其log成为一个新的repo](#logrepo)
    - [git和SVN在元数据存储上有什么区别](#gitsvn)
- [Round 6](#round6)
    - [用Git进行“不留痕迹的”协同开发](#git_9)
    - [Git多用户间协作还有什么引人入胜之处](#git_10)

<!-- /MarkdownTOC -->

---

# Round 1

![](img/run-buffalo.jpg)


## git在哪里

* Unix系（Ubuntu/Fedora/MAC-OS.X/……）默认就有，打开terminal，输入`git --version`，就在那里了
* Windows上要安装：[Git for Windows](https://github.com/git-for-windows/git)
    - 提供我们团队FTP的下载链接：[Git-2.7.0-32-bit.exe](ftp://emb:zteemb@10.9.111.222/Soft/Develop/Git/Git4Windows/Git-2.7.0-32-bit.exe)

## Git for Windows 咋用

一路“下一步”安装完即可。

![](img/git4windows-install.png)

1. Git Bash: Linux 风格的命令行，如： /user/bin
2. Git CMD： Windows风格的命令行，即：C:\system
3. Git GUI: 图形化界面
4. 其实还有一个： ${安装目录}/bin/sh.exe —— 我喜欢直接用这个

![](img/git4windows-sh.png)

对比一下1和4：

![](img/git4windows-gitbash.png)
![](img/git4windows-bin.png)

* 1和4的图标不同，4其实是Windows自身的cmd窗口
* 4由于是Windows自身cmd窗口，所以对中文支持较好

所以建议您直接用4：**直接双击或在cmd中打开 ${安装目录}/bin/sh.exe 来运行MinGW环境和git**

## 先单机玩玩还是先弄来个别人的git库

先单机玩玩吧，理由如下：

git 和 svn 最大的区别：

* svn是集中式管控：所有库（repo）的内容都在server上，离了server连 svn log 都看不了，更别说提交代码了
* git是分布式管控：每个git项目里面的.git文件夹中都包括了所有的库（repo）内容，可以看log、提交代码、创建分支、打tag……
    - 两台电脑的git库之间是**同步（sync）**的概念，大家都是平等的

所以说我们还是先练习一下除了sync之外的基础命令吧，会了这些之后，至少你能在本机快乐的写日记了。

>我看到有些小伙伴还在用类似EDiary等日记本软件或PIM软件来写每天的日记，积累了这么多年的日记，一旦win10上运行不了EDiary可咋整？还是赶紧试试用纯文本+Markdown来写日记，用git本地做版本管理吧！

下文我使用个人日记的小项目来演示本机的git操作

## 如何在本机git我的日记

OK，让我们从头开始，跟着做一遍吧，Good Luck ……

* 做一下git要求的最基本的两个配置：name 和 email
```cmd
MBP:~ wangkevin$ git config --global user.name wkevin
MBP:~ wangkevin$ git config --global user.emal wkevin27@gmail.com
```
* 创建一个文件夹并写一篇日记
```cmd
MBP:demo wangkevin$ mkdir mydiary
MBP:demo wangkevin$ cd mydiary
$ cat >diary.md
# Diary

## 2016.1.31
回家过年^C
$ ls
diary.md
$ cat diary.md 
# Diary

## 2016.1.31
回家过年
```
* `git init`:在文件夹中创建git库
```cmd
$ git init
Initialized empty Git repository in /Users/wangkevin/workspace/kproject/demo/mydiary/.git/
```
* 和SVN有.svn类似，git也有.git
```cmd
$ ls -a
.       ..      .git        diary.md
$ ls .git
HEAD        config      hooks       objects
branches    description info        refs
$ cat .git/config
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
    ignorecase = true
    precomposeunicode = true
```
* `git status`：显示一个未被管控的文件(Untracked files) diary.md
```cmd
$ git status
On branch master

Initial commit

Untracked files:
  (use "git add <file>..." to include in what will be committed)

    diary.md

nothing added to commit but untracked files present (use "git add" to track)
```
* `git add filename`：将文件纳入管理，filename 支持通配符，最常用的就是点(.)表示所有文件
```cmd
$ git add diary.md 
```
* `git status` 显示此文件待提交（to be committed），此时文件已经开始被git管理了，文件进入一种暂存状态（stage），如果想反悔可以用`git rm --cached`使其进入unstage状态
```cmd
$ git status
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

    new file:   diary.md
```
* `git status -s` -short 短模式
```cmd
$ git status -s
A  diary.md
```
* `git status -b` -branch 显示分支，`git status`不带参数默认就是-b的，所以常和短模式合作，合并为一个sb，哈哈
```cmd
$ git status -sb
## Initial commit on master
A  diary.md
```
* `git commit`: 将文件从暂存态提交入库 —— 暂存就像回收站（删除前给你一个check的机会，多次操作放入回收站的文件可以一次清空），多次操作放入暂存，最后考虑成熟了，check OK了，再commit提交
```cmd
$ git commit
[master (root-commit) 14dd781] create mydiary
 1 file changed, 4 insertions(+)
 create mode 100644 diary.md
```
* 执行 `git commit` 后会自动打开一个编辑器（编辑器是可配置的，以后再说怎么配置），比如 vi，进行提交log的撰写，保存退出即提交成功，不保存退出即放弃提交
```vi
  1 
  2 # Please enter the commit message for your changes. Lines starting
  3 # with '#' will be ignored, and an empty message aborts the commit.
  4 # On branch master
  5 #
  6 # Initial commit
  7 #
  8 # Changes to be committed:
  9 #   new file:   diary.md
 10 #
```
* 再查`git status`，都已经提交干净了
```cmd
$ git status
On branch master
nothing to commit, working directory clean
$ git status -s
```
* 现在可以看log了
```cmd
$ git log
commit 14dd7815fcf56c961e11c52e96e2fc3fbd7d0543
Author: wkevin <wkevin27@gmail.com>
Date:   Sun Jan 31 11:39:55 2016 +0800

    create mydiary
```
* git 和 svn 不同，没有一个数字递增的节点号，而是一串40Bytes的哈希字符，指定一个提交只需要给出这个字符串即可，当然不能让你每次都把40个字符全输入一遍，只需要输入够区分提交的即可（一般是前7位），如果咱的库规模还很小，前4位也行哦（下文中的“6784”）
```cmd
$ git lg
 b81373d | 2016-01-31 15:49:08 +0800 | 2016-01-31 15:49:08 +0800 |  wkevin  add .gitignore file
 67840e1 | 2016-01-31 12:20:26 +0800 | 2016-01-31 12:20:26 +0800 |  wkevin  2.2日记
 bf36ab9 | 2016-01-31 12:19:33 +0800 | 2016-01-31 12:19:33 +0800 |  wkevin  2.1的日记
 14dd781 | 2016-01-31 11:39:55 +0800 | 2016-01-31 11:39:55 +0800 |  wkevin  create mydiary
$ git log 6784
commit 67840e1813af1084abd5d07d2e2a2e185c679f09
Author: wkevin <wkevin27@gmail.com>
Date:   Sun Jan 31 12:20:26 2016 +0800

    2.2日记

```
* 每天可以随时写日记、随时`git add`、适时`git commit`，经过一段时间，你的diary库就越来越让你爱不释手了
```cmd
$ git log
commit 67840e1813af1084abd5d07d2e2a2e185c679f09
Author: wkevin <wkevin27@gmail.com>
Date:   Sun Jan 31 12:20:26 2016 +0800

    2.2日记

commit bf36ab9b0d489a2eda911be9e01bddc395fc29e0
Author: wkevin <wkevin27@gmail.com>
Date:   Sun Jan 31 12:19:33 2016 +0800

    2.1的日记

commit 14dd7815fcf56c961e11c52e96e2fc3fbd7d0543
Author: wkevin <wkevin27@gmail.com>
Date:   Sun Jan 31 11:39:55 2016 +0800

    create mydiary
```
* 觉得`git log`默认显示的内容不爽？想看更详细的、或更简略的？——别急，统统没问题，各种参数全方位满足你的各种需求，但这里先不说，后文慢慢来，先不要用这些复杂的参数来打击自己吧，不过来个一步简洁到位的的命令：`git shortlog` —— 什么？太简洁了？哈哈，别急，从简洁到纸到复杂到翔全都有，慢慢来。
```cmd
$ git shortlog
wkevin (3):
      create mydiary
      2.1的日记
      2.2日记
```

如果只是做个**日记本**，自己写、自己看、绝不给别人看、绝不上网……这些命令就差不多够了！

哇！好累啊，可以休息一下了，就这些命令，玩几天，把日记写上一个礼拜，然后我们再继续。如果你不打算继续了，也没关系，这些命令就写日记--够用了！


## 每次都要敲add、commit、status，嫌累了

用git写了一些日记，你肯定有了新需求，能回来接着读说明你是个积极追求上进的好同学，我们继续聊！

有这样的问题说明你已经是git的初级用户了，并且听了我的建议：“使用命令行，远离GUI” —— 我一点都不奇怪，绝大部分程序猿一旦用上git都会上瘾的，会频繁的`git commit`，然后在`git log`中寻觅自己的成就感，否则吃不好饭、睡不好觉……呵呵

言归正传。

别名（alias）是linux系统的基本概念，在git中也如鱼得水：

* 这样设置别名
```cmd
$ git config --global alias.st  "status"
```
* 然后就可以这样操作了
```cmd
$ git st
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

    modified:   diary.md

no changes added to commit (use "git add" and/or "git commit -a")
```
* 换个别名玩玩
```cmd
$ git config --global alias.st  "status -sb"
$ git st
## master
 M diary.md
```
* 把让你烦的命令都用2个字来别名一下吧。比如：
```cmd
$ git config --global alias.ci  "commit"
```

## 有些文件不希望被git管理

问：markdown写的 diary.md ，会在本地生成 diary.html 检查和欣赏一下，但其实是不需要 commit 的，如何在 `git commit` 的时候忽略它们。

答：`git commit`的时候已经不能忽略了，要忽略需要在`git add`的时候，通过编辑**.gitignore文件**让add命令忽略它们。

* diary.html 就是我们不想提交的过程文件
```cmd
$ git st
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

    modified:   diary.md

Untracked files:
  (use "git add <file>..." to include in what will be committed)

    diary.html

no changes added to commit (use "git add" and/or "git commit -a")
```
* 手工生成一个**.gitignore**的文件，写入含有通配符的文件名（即：后缀名为html的文件）
```cmd
$ cat >.gitignore
*.html
^C
$ cat .gitignore 
*.html
```
* diary.html 已经被自动忽略。
```cmd
$ git st
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

    modified:   diary.md

Untracked files:
  (use "git add <file>..." to include in what will be committed)

    .gitignore

no changes added to commit (use "git add" and/or "git commit -a")
```


# Round 2

![](img/gray-owl-mouse-sw.jpg)

## 我要筛选 git log


* 可以只看某个子目录或某个文件的log
* 可以从某个提交开始看
```cmd
$ git log 6784
commit 67840e1813af1084abd5d07d2e2a2e185c679f09
Author: wkevin <wkevin27@gmail.com>
Date:   Sun Jan 31 12:20:26 2016 +0800

    2.2日记
```
* 可以只看某个人的log
```cmd
$ git log --author=wkevin
commit 67840e1813af1084abd5d07d2e2a2e185c679f09
Author: wkevin <wkevin27@gmail.com>
Date:   Sun Jan 31 12:20:26 2016 +0800

    2.2日记
……
```
* --author 支持匹配
```cmd
$ git log --author=wke
commit 67840e1813af1084abd5d07d2e2a2e185c679f09
Author: wkevin <wkevin27@gmail.com>
Date:   Sun Jan 31 12:20:26 2016 +0800

    2.2日记
……
```
* --author 的一个错误匹配
```cmd
$ git log --author=wken
$ 
```
* --author 上使用通配符
```cmd
$ git log --author=wke.*n
commit 67840e1813af1084abd5d07d2e2a2e185c679f09
Author: wkevin <wkevin27@gmail.com>
Date:   Sun Jan 31 12:20:26 2016 +0800

    2.2日记
```


## 觉得 git log 中的时间看着困难，精简下呗

* 使用 --date=short
```cmd
$ git log --pretty=medium --date=short
commit 67840e1813af1084abd5d07d2e2a2e185c679f09
Author: wkevin <wkevin27@gmail.com>
Date:   2016-01-31

    2.2日记

commit bf36ab9b0d489a2eda911be9e01bddc395fc29e0
Author: wkevin <wkevin27@gmail.com>
Date:   2016-01-31

    2.1的日记

commit 14dd7815fcf56c961e11c52e96e2fc3fbd7d0543
Author: wkevin <wkevin27@gmail.com>
Date:   2016-01-31

    create mydiary
```

## 我要定制 git log，不想一页看不了几条

默认的`git log`一条commit log至少需要6行来显示，一页顶多看个5、6条，很不方便。如果单条达到10行的话，一页也就看个2、3条。像linux这样的项目，经常遇到长篇大论的log，内容倒是详实了，但很难做一览表式的查询。

下面我们祭出 git log 的必杀技： --pretty 或 --format

`git log --pretty=xxx` 等价于 `git log --format=xxx`, xxx 可以是这些：

* oneline：只显示一行
* short
* medium
* full
* fuller：会看到有两个角色：author（作者） 和 commit（提交人）
* email
* raw
* format:'......'

其中`oneline`能够帮你精简log

```cmd
$ git log --pretty=oneline
67840e1813af1084abd5d07d2e2a2e185c679f09 2.2日记
bf36ab9b0d489a2eda911be9e01bddc395fc29e0 2.1的日记
14dd7815fcf56c961e11c52e96e2fc3fbd7d0543 create mydiary
```

其实 `--oneline` 也是一个单独的参数

```cmd
$ git log --oneline
67840e1 2.2日记
bf36ab9 2.1的日记
14dd781 create mydiary
```

## oneline太简陋了，我想一行里面看到hash、author、date、message

那需要用上 --pretty=formate:"......"参数了

format 参数很多，没必要逐一掌握，除了你是强迫症患者 -- 凑巧本文不使用强迫症的视角，哈哈

我常用的有：

* %h：commit hash
* %ai: author date
* %an: author name
* %ci: commit date
* %cn: commit name
* %s: log message

示例：

* 只看日期、作者、log（专业术语是：subject）
```cmd
$ git log --pretty=format:'%ad %an %s'
Sun Jan 31 15:49:08 2016 +0800 wkevin add .gitignore file
Sun Jan 31 12:20:26 2016 +0800 wkevin 2.2日记
Sun Jan 31 12:19:33 2016 +0800 wkevin 2.1的日记
Sun Jan 31 11:39:55 2016 +0800 wkevin create mydiary
```
* 日期太碍眼，精简一下
```cmd
$ git log --pretty=format:'%ad %an %s' --date=short
2016-01-31 wkevin add .gitignore file
2016-01-31 wkevin 2.2日记
2016-01-31 wkevin 2.1的日记
2016-01-31 wkevin create mydiary
```
* 不好了，但太精简了，咋只有date，没有time
```cmd
$ git log --pretty=format:'%ad %an %s' --date=local
Sun Jan 31 15:49:08 2016 wkevin add .gitignore file
Sun Jan 31 12:20:26 2016 wkevin 2.2日记
Sun Jan 31 12:19:33 2016 wkevin 2.1的日记
Sun Jan 31 11:39:55 2016 wkevin create mydiary
```
* commit hash 最好也能加上
```cmd
$ git log --pretty=format:'%h %ad %an %s' --date=local
b81373d Sun Jan 31 15:49:08 2016 wkevin add .gitignore file
67840e1 Sun Jan 31 12:20:26 2016 wkevin 2.2日记
bf36ab9 Sun Jan 31 12:19:33 2016 wkevin 2.1的日记
14dd781 Sun Jan 31 11:39:55 2016 wkevin create mydiary
```

最后，你还需这样：
```cmd
$ git config --global --replace-all alias.lg   "log --pretty=format:'%h %ad %an %s' --date=local"
```

## git log 已经很好了，但好像还是缺点啥

那就是颜色了，加上颜色让字段分的更加清晰

```cmd
git config --global --replace-all alias.lg  "log --pretty=format:'%C(auto) %h | %ai | %Cred %an %Cgreen %s'"
```

![](img/git-lg-with-color.png)

为什么改用`%ai`，不用`%ad`了？
`%ad`会受到`--date=xxx`的影响，`%ai`不会。所以限制了`%ad`的使用，如果常从github上拿代码，会看到世界各地的提交人和提交时间，我还是希望分一下时区的，所以用了`%ai`。

比如我们来查看linux的源码：

![](img/git-lg-by-linux.png)

## git log --fuller 中的 author 和 commit 啥关系

必须要说了，git的设计者的设计思路是：希望提交人（执行`git commit`的人）能够把author写明白，而不是据为己有。所以git的作者（author）和提交人（commit）可以不是同一个人。

```cmd
$ git commit --author=wkevin --date='2016-01-30 22:04:04 +0800'
```

上面的命令可以在commit的同时指定提交内容的author和AUTHOR_DATE，这个恐怕要靠提交者（committer）的记忆力和公德心了，把这段代码的真是author的名字和写就时间录进去，而不是让git默认的把自己的name和提交时间（COMMITTER_DATE）录入库中。

在没有github之前，一个开源项目通常还是只设置几个有权限的提交人，大家想贡献代码就发patch给有权限的人，然后有权人commit。但自从有了github，发明了fork（fork并不属于git，而是github的独创哦）和PR（Pull-Request），让这个过程更加的轻便，也让项目的发展更加《失控》，有能力的人可以在自己的领地fork并发展一个项目，PR或不PR给原作者全凭个人喜好，原作者如果“懒政”，其他人完全可以独立发展。—— 每个人都在自己的库里commit，使得committer和author通常都是一个人，大家都是通过PR给其他人，而不是发送patch了。—— 所以 `--author` 这个参数已经很久不用一次了。


# Round 3

![](img/boy-buffaloes-india-sw.jpg)

## 我要能像TortoiseSVN那样左右两栏对比看diff

这个必须有！

git和TortoiseSVN相比是不恰当的，git要和subversion比较，它们两个是协议；TortoiseGit才是和TortoiseSVN比较，这两个是前端。Subversion的前端并不多，除了TortoiseSVN并没有更多的选择，git的前端却不少：TortoiseGit、GitForWindows、Github for Desktop……

前端对协议进行了封装（比如默认安装的TortoiseSVN都已经找不到`svn`等命令，所以也不能运行`svn log`、`svn commit`）和更多的图形化工作（图标重绘、文本比较工具……）的事情留在后面慢慢说，回到比较工具上来：除非你是要制作补丁包，或者改动很小，否则你几乎不会想直接查看`git diff`，配置好第三方比较工具的调用方法是必须要做的 —— 这个懒偷不得。

**git中查看差异有两个命令**:

1. `git diff`: 在Terminal中按照Linux的传统方式生成patch
![](img/git-diff.png)
2. `git difftool`: 使用第三方工具显示差异
![](img/git-difftool-merge.png       

git 调用第三方工具是灵活的，当然TortoiseSVN调用第三方diff/Merge工具也是可定制的，并且用户不指定第三方工具的话，TortoiseSVN项目自己做了一个比较工具TortoiseMerge来作为默认，TortoiseGit也是有默认的。git则需要收工设置。

比较工具有很多，列几个本人用过的：

* 收费的
    - [Beyond Compare](http://www.scootersoftware.com) -- Win、Linux、OS.X
    - [Araxis Merge](http://www.araxis.com) -- Win、OS.X
    - [UltraCompare](http://www.ultraedit.com/products/ultracompare.html) -- Win,本来是UE的一个插件，近几年独立出来了
* 免费但不开源的
    - [DiffMerge](http://www.sourcegear.com/diffmerge/downloads.php) -- Win、Linux、OS.X
* 开源的：
    - [Meld](http://meldmerge.org) -- Win、Linxu、OS.X
        + Linux上直接 yum 或 apt-get 安装
        + Win上下载exe安装
        + OS.X 上通过macports安装 —— macports

用哪个呢？这是萝卜白菜的事情，不要纠结，你用惯了哪个就是哪个，git调用它们的方法配置是大同小异。我不能每种软件在每个系统中都试一遍，所以只能条目列在这里，但我本人没搞过的就空着了，看官自己百度一下吧，照葫芦画瓢能力强的话也用不着百度。

* **Araxis Merge**
    - OS.X: `vi ~/.gitconfig`，加入：
    ```
    difftool.prompt=false
    diff.tool=araxis
    merge.tool=araxis
    mergetool.araxis.path=/Applications/Araxis Merge.app/Contents/Utilities/compare
    difftool.araxis.path=/Applications/Araxis Merge.app/Contents/Utilities/compare
    ```
    - Linux
    - Windows
* **BeyondCompare**
    - OS.X
    - Linux
    - Windows
    ```cmd
    $ git config --global diff.tool bc3
    $ git config --global difftool.bc3.path "c:/program files/beyond compare 3/bcomp.exe"
    ```
* **DiffMerge**
    - OS.X
    - Linux
    - Windows
    ```cmd
    $ git config --global diff.tool diffmerge
    $ git config --global difftool.diffmerge.cmd 'diffmerge "$LOCAL" "$REMOTE"'
    ```

除此之外，还可以配置一项：

```cmd
$ git config --global difftool.prompt false 
```

OK，弄好了吧，我们来总结一下其知识点，如果不想看，可以跳过去看下条了。

* 配置方法两种：
    1. 通过 `git config ...` 命令
    2. 通过 `vi ~/.gitconfig` 直接修改git的配置文件，方法1最终也是落实到2上
* 配置命令有两个：
    1. cmd：git在执行某个difftool的时候，执行的命令，用户没有定义的话，会使用tool的名字做默认启动；如果用户定义的话，就必须加上 $LOCAL $REMOTE
    2. path: 用于定位不在PATH变量里的命令，但不需要加 $LOCAL $REMOTE

## 我用ubuntu，我要修改git commint时的默认编辑器

`update-alternatives --config editor`

## 我想做个分支（branch），怎么做



## 分支要合并到主干或其他分支，怎么merge

* 通用配置
```cmd
$ git config --global mergetool.diffmerge.trustExitCode true
```
* **BeyondCompare**
    - OS.X
    - Linux
    - Windows
    ```cmd
    $ git config --global merge.tool bc3
    $ git config --global mergetool.bc3.path "c:/program files/beyond compare 3/bcomp.exe"
    $ git mergetool
    ```
* **DiffMerge**
    - OS.X
    - Linux
    - Windows
    ```cmd
    $ git config --global merge.tool diffmerge
    $ git config --global mergetool.diffmerge.cmd 'diffmerge --merge --result="$MERGED" "$LOCAL" "$(if test -f "$BASE"; then echo "$BASE"; else echo "$LOCAL"; fi)" "$REMOTE"'
    ```


# Round 4

![](img/children-dam-bali-sw.jpg)

## 想看看别人的git库了

是不是已经不满足于只管理个本机的日记了？太好了，git天生就是为了程序猿合作用的，几条关键的命令要出厂了：

* `git clone [url] [localname]`  


## 公司访问不了外网的github，咋办

```cmd
$ git config --global http.proxy http://proxysz.zte.com.cn:80
```

## 如何与别人合作

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


## github的工作流

[Understanding the GitHub Flow](https://guides.github.com/introduction/flow/)

# Round 5

![](img/elephants-sand-river-sw.jpg)

## git是从何而来

这里有一篇git的创始人Torvalds（同时也是Linux的创始人）的接受中国媒体的一篇访谈录：

* [Linux创始人Linus Torvalds访谈，Git的十年之旅](http://www.wtoutiao.com/a/2287349.html) -- 如果网页链接失效，重新百度即可，类似的访谈录很多，但大多是英文的。

## git有哪些好的入门的资料

当然，我明白你说的是中文资料。

* [Pro Git（中文版）](http://git.oschina.net/progit/)
* [git简明教程](http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)

## 重新梳理git的软件

是时候看一下git的 [维基百科][gitwiki] 了：

[gitwiki]: https://en.wikipedia.org/wiki/Git_(software)

>Git is a widely-used source code management system for software development. It is a distributed revision control system with an emphasis on speed,[6] data integrity,[7] and support for distributed, non-linear workflows.[8] Git was initially designed and developed in 2005 by Linux kernel developers (including Linus Torvalds) for Linux kernel development.[9]

>As with most other distributed version control systems, and unlike most client–server systems, every Git working directory is a full-fledged repository with complete history and full version-tracking capabilities, independent of network access or a central server.[10] Like the Linux kernel, Git is free software distributed under the terms of the GNU General Public License version 2.

    - UI前端也有，比如github出品的 [github desktop](https://desktop.github.com)

    + [Git for Windows](https://github.com/git-for-windows/git)
        * 第一代的名字叫[msysGit](https://github.com/msysgit/git)，基于 msys（属于 MinGW）—— 2015年底已废弃
        * 第二代重新建立了github项目[Git for Windows](https://github.com/git-for-windows/git)，基于 msys2（不再属于MinGW），英语有自信的可以读读它的[背景](https://github.com/git-for-windows/git/wiki)
    + [TortoiseGit](http://code.google.com/p/tortoisegit/)：类似TortoiseSVN，可以做图标重绘。

## 导出某个子目录及其log成为一个新的repo

```
cd oldrepo
git subtree split -P subdir -b newbranch
gitk newbranch

mkdir ../newrepo.git
cd ../newrepo.git
git init
git config --bool core.bare true

cd ../oldrepo
git push ../newrepo.git newbranch:master #newrepo.git is a pure repo without my files

cd ..
git clone newrepo.git
```

## git和SVN在元数据存储上有什么区别

svn是基于增量存储的，两次提交对于repo来说只保存变化量，git不使用svn的增量方式保存数据，而是使用快照。因为git的分布式特性，并没有一颗树一样成长的repo，repo更像是一张网式的成长，节点与节点之间可能会绕很远才能找到亲戚关系，所以增量无从谈起。

证明：

* A、B两个git clone
* A的commit 时间比 B 晚
* A先push
* B在push时失败，先pull，再次commit
* A一次ci，B两次ci —— 比svn多了一次ci，因为svn中B是先merge后ci，git中是先ci后merge再ci
* B再push
* git log：ci的顺序是：B的ci、A的ci、B的merge后ci —— **B的ci会插入到A的ci前面**


# Round 6

![](img/black-trevally-sardines-sw.jpg)

## 用Git进行“不留痕迹的”协同开发 

* 需求：协同开发：调试期间多人之间代码依赖，相互调用，使用头文件……
* 设计：用SVN也可以协同开发，但会在服务器上留下大量无效的调试记录
* 操作：git方式：**将本机库开放给同伴，合作开发完成后使用 git rebase -i 清理**
    - 准备
        + A君
            * .git目录下新建git-daemon-export-ok文件，表明该工程允许非授权访问
                - cd /path/to/project.git
                - touch git-daemon-export-ok
            * git daemon --reuseaddr --base-path=/opt/git/ /opt/git/
            * 告诉B君你的IP
        + B君
            * git checkout git://your_ip_address/project
    - 调试过程
        + A君快乐的随意本机修改并git commit
        + B君随时随地的git pull
    - 调试完成后
        + A君
            * git rebase -i将本地的提交进行清理
            * 将一次记录git push到服务器上


## Git多用户间协作还有什么引人入胜之处

* 集中式工作流
![](img/workflow.onecore.png)
* 集成管理员工作流
![](img/workflow.manager.png)
* 司令与副官流程（Linux）
![](img/workflow.many.layers.png)

