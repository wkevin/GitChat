<h1>Git 聊天入门</h1>

俊建 Kevin

**自序**

读一本Git的书和读一篇Git的文章给人的知识含量是不同的，但给人的愉悦感也是迥异的。本文不想让您有读书的感觉、不追求知识全面、架构完整，但也不想只罗列一些git的知识点，搞的像一个Tip集。本文会从实际使用的角度，以聊天问答的形式，从浅入深，逐步展露git的若干方面。

本文分Round进行，每局并不以git命令的逻辑来分类，而是以**使用git完成任务的水平来分解阶段**。一些问题原本来自于我和朋友们的聊天，闲聊之余，记录成集，不要期待有什么高深的理论，让你每读完一个Round，可以小试牛刀，然后烹茶小饮、若有所思……是我最想要的。

git 有自己的 [user manunal](https://www.kernel.org/pub/software/scm/git/docs/user-manual.html)，和官方宝书（[英文版](http://git-scm.com/book/en/v2)、[中文版](http://git-scm.com/book/zh/v2)、[国内备份](http://www.kancloud.cn/kancloud/progit)），如果你读来无碍，请忽视本文，本文与它们相比只是个小人书、连环画，或者作为它们的一个补充。我在写每个Topic的时候也都在想：是不是书里已经有了？我是不是重复了？是不是删掉算了？—— 经常在知识点完整和拾遗之间反复权衡，但想到碎片化阅读越来越普及、学东西主要靠百度的今天，我写点东西发出来应该也是有益的。


---

# Round 1 : 起步

![](img/run-buffalo.jpg)


## git在哪里

* Unix系（Ubuntu/Fedora/macOS/……）默认就有，打开terminal，输入`git --version`，就在那里了
* Windows上要安装：[Git for Windows](https://github.com/git-for-windows/git)

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
$ git config --global user.name wkevin
$ git config --global user.emal wkevin27@gmail.com
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
aster (root-commit) 14dd781] create mydiary
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

---

如果只是让git管理个**日记本**，自己写、自己看、绝不给别人看、绝不上网……这些命令就差不多够了！

哇！好累啊，可以休息一下了，就这些命令，玩几天，把日记写上一个礼拜，然后我们再继续。如果你不打算继续了，也没关系，这些命令就写日记--够用了！

第一局，Over！

# Round 2 : 优雅

![](img/gray-owl-mouse-sw.jpg)

欢迎回来，能回来接着读说明你是个积极追求上进的好同学，我们继续聊！

用git写了一些日记，你肯定有了新需求，最令你恼火的可能有：

* 敲命令真烦人，尤其还辣么长的命令
* 看log真晃眼，不清爽
* 提交之前还要来个add，啥子意思

## 每次都要敲add、commit、status，嫌累了


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

## oneline太简陋了，一行里面看到hash、author、date、message

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

上面的命令可以在commit的同时指定提交内容的author和AUTHOR_DATE，这个恐怕要靠提交者（committer）的记忆力和公德心了，把这段代码真实author的名字和写就时间录进去，而不是让git默认的把自己的name和提交时间（COMMITTER_DATE）录入库中。

在没有github之前，一个开源项目通常还是只设置几个有权限的提交人，大家想贡献代码就发patch给有权限的人，然后有权人commit。但自从有了github，发明了fork（fork并不属于git，而是github的独创哦）和PR（Pull-Request），让这个过程更加的轻便，也让项目的发展更加《失控》，有能力的人可以在自己的领地fork并发展一个项目，PR或不PR给原作者全凭个人喜好，原作者如果“懒政”，其他人完全可以独立发展。—— 每个人都在自己的库里commit，使得committer和author通常都是一个人，大家都是通过PR给其他人，而不是发送patch了。—— 所以 `--author` 这个参数已经很久不用一次了。


## 看log的时候能否把修改了哪些文件也列出来

```cmd
$ git log --stat
```

## 看tag的时候能否把日期时间也列出来

`git tag` 貌似是完成不了这个任务，只能拜托`git log`了。

关键是 `--simplify-by-decoration` 参数， refs/heads 和 refs/tags 都算一种 decoration，再联合 --tags 就可以了：

```cmd
$ git log --tags --simplify-by-decoration --pretty="format:%ci %d"
```

下面这句可以按常规log来显示，每个hash后面跟的就是tag

```cmd
$ git log --decorate=full --simplify-by-decoration
```

或者用 for-each-ref 命令也是极好的：

```cmd
$ git for-each-ref --format="%(creatordate)  %(refname:short) " refs/tags/*
```

## 我要能像TortoiseSVN那样左右两栏对比看diff

这个必须有！

>git和TortoiseSVN相比是不恰当的，git要和subversion比较，它们两个是协议；TortoiseGit才是和TortoiseSVN比较，这两个是前端。Subversion的前端并不多，除了TortoiseSVN并没有更多的选择，git的前端却不少：TortoiseGit、GitForWindows、Github for Desktop……

>前端对协议进行了封装（比如默认安装的TortoiseSVN都已经找不到`svn`等命令，所以也不能运行`svn log`、`svn commit`）和更多的图形化工作（图标重绘、文本比较工具……）的事情留在后面慢慢说，回到比较工具上来：除非你是要制作补丁包，或者改动很小，否则你几乎不会想直接查看`git diff`，配置好第三方比较工具的调用方法是必须要做的 —— 这个懒偷不得。

>git 调用第三方工具是灵活的，当然TortoiseSVN调用第三方diff/Merge工具也是可定制的，并且用户不指定第三方工具的话，TortoiseSVN项目自己做了一个比较工具TortoiseMerge来作为默认，TortoiseGit也是有默认的。git则需要手工设置。

**git中查看差异有两个命令**:

1. `git diff`: 在Terminal中按照Linux的传统方式生成patch
![](img/git-diff.png)
2. `git difftool`: 使用第三方工具显示差异
![](img/git-difftool-merge.png)       

`git difftool` 命令能够调用的第三方比较工具有很多，列几个本人用过的：

* 收费的
    - [Beyond Compare](http://www.scootersoftware.com) -- Win、Linux、macOS
    - [Araxis Merge](http://www.araxis.com) -- Win、macOS
    - [UltraCompare](http://www.ultraedit.com/products/ultracompare.html) -- Win,本来是UE的一个插件，近几年独立出来了
* 免费但不开源的
    - [DiffMerge](http://www.sourcegear.com/diffmerge/downloads.php) -- Win、Linux、macOS
* 开源的：
    - [Meld](http://meldmerge.org) -- Win、Linxu、macOS

用哪个呢？这是萝卜白菜的事情，不要纠结，你用惯了哪个就是哪个（我相信你的电脑上肯定已经有了一个文本比较工具，用它就是了，本着开放、开源、和跨平台的原则，我个人推荐Meld）。git调用它们的方法配置是大同小异。我不能每种软件在每个系统中都试一遍，所以只能条目列在这里，但我本人没搞过的就空着了，看官自己百度一下吧，照葫芦画瓢能力强的话也用不着百度。

* **Araxis Merge**
    - macOS: `vi ~/.gitconfig`，加入：
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
    - macOS
    - Linux
    - Windows
    ```cmd
    $ git config --global diff.tool bc3
    $ git config --global difftool.bc3.path "c:/program files/beyond compare 3/bcomp.exe"
    ```
* **DiffMerge**
    - macOS
    - Linux
    - Windows
    ```cmd
    $ git config --global diff.tool diffmerge
    $ git config --global difftool.diffmerge.cmd 'diffmerge "$LOCAL" "$REMOTE"'
    ```
* **Meld**
    - macOS
    - Linux
    - Windows

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

肯定还是有些完美主义者，一台电脑上安装了多个比较软件，想要不断切换 —— 也是没问题的。

* 可以配置多个cmd
```cmd
$ git config --global difftool.bc.cmd 'beyondcompare "$LOCAL" "$REMOTE"'
$ git config --global difftool.am.cmd 'araxismerge "$LOCAL" "$REMOTE"'
$ git config --global difftool.dm.cmd 'diffmerge "$LOCAL" "$REMOTE"'
```
* 根据需求随时切换
```cmd
$ git config --global diff.tool bc
```
或
```cmd
$ git config --global diff.tool am
```
或
```cmd
$ git config --global diff.tool dm
```


## 修改完了为什么不是直接提交，而是git add

git在 `git commit` 之前首先要 `git add`，从svn转移过来的同学会对这点有一些疑惑和质疑。

`git add` 将文件放入到暂存区（stage），并生成对象 —— 参见本文的 [git 的对象（object）](#git-object)

理解git需要理解文件的5种状态和3个区（area）：

5种状态：

1. 未跟踪态（untracked）
2. 未修改状态（unmodified）
3. 修改状态（modified），即：待暂存（staging）
4. 已暂存（staged）
5. 已提交（committed）

3个区：

1. 本地工作目录（working directory）
2. 暂存区（staging area，又叫做index）
3. git库（repository）

1、2、3状态在本地工作目录，4状态属于暂存区，5状态属于git库。

<embed src="img/git-state-and-area.svg" type="image/svg+xml" />

如果我修改了一下README.md，`git add`了一下，然后又修改了一下，用`git st`的打印是这样的：

```cmd
$ git st
On branch master
Your branch is up-to-date with 'origin/master'.
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

    modified:   README.md

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

    modified:   README.md
```

很多地方把暂存和stage混在一起，不查字典的话还以为stage的中文翻译就是暂存。其实 stage 就这个单词的本身的意思是：

1. 名词：舞台、讲台，比如：戏剧表演的舞台、国际政治的舞台；阶段，类似phase，比如：stage one/two意思是第一/二阶段，three-stage rocket意思是三级火箭
2. 动词：上演、举行、组织，类似play、organize，比如：stage a football match，举办足球赛

stage本身并没有暂存的意思，git中可以理解为把文件放到一个舞台上上演一下，进而文件进入到一个新的阶段。——用这个词可以说是一箭三雕。

你可以输入`git help stage` 看看

```cmd
GIT-STAGE(1)                                              Git Manual                                              GIT-STAGE(1)
NAME
       git-stage - Add file contents to the staging area
SYNOPSIS
       git stage args...
DESCRIPTION
       This is a synonym for git-add(1). Please refer to the documentation of that command.
```

`git stage` 是同义于 `git add` 的：将文件加入到 **staging area**（舞台区、阶段区、进而翻译为暂存区，下文我还是尽量不去翻译这个词汇，而直接用英文吧，或搞个缩写：SA —— 如果让我翻译，我会译为：检视区）。

把前面已经提到过暂存区像回收站，把文件放在回收站是给操作人一个检视的机会和反悔的机会，操作妥当后再彻底删除，彻底删除后再想反悔就要费劲了。git的staging area也是给用户一个**检视的机会**和**反悔的机会**，用户可以：

* 使用`git add`或`git stage`命令随时向SA增加文件，和回收站不同的是后进入SA的文件会覆盖前面进入的
* 使用`git checkout`命令随时从SA反悔，文件会从SA移除，是否覆盖


## 我用ubuntu，我要修改git commit时的默认编辑器

`git commit`会自动打开系统默认的编辑器来让你写log，如下修改：

```cmd
ubuntu$ update-alternatives --config editor
```

这个问题不属于git的范畴，而是linux的。

---

到这里，你应该能够优雅地使用git管理自己的日记本了：**log清清爽爽、命令简简单单、变更一目了然** —— 如果只是管理自己的日记项目，已然可以游刃有余了。

如果你是工程师或程序员，还会有多版本、多分支并行开发的需求，下面我们开始讨论分支、合并等操作。如果不是程序员，基本上可以刀枪入库、马放南山，结束阅读了。

第二局，Over!

# Round 3 : 并发

![](img/boy-buffaloes-india-sw.jpg)

并发：并行开发，将会涉及分支（创建、查询、删除……）、标签等。

## 我想使用个分支（branch），怎么做

好了，这里要提到一个非常重要的概念了，很多git书籍都会强调的一点：**git的branch只是个指针** —— 也常被称作“**git的必杀技**”。

下面这几步非常有必要：

* 看一下《Pro Git》中的[分支这一章](http://www.kancloud.cn/kancloud/progit/70182)
* 网文非常多，自行搜索一下 `git branch` 
* `$ git help branch`

我来概要的描述一些要点

* `git init`后会自动创建一个master分支，它并不是一个多么特殊的分支，跟其他分支没什么区别。
* git中的3个区：本地工作目录、索引区、库 —— 分支信息保存在库中，工作目录和索引区都对应库中的某个分支。《Pro Git》中的[分支这一章](http://www.kancloud.cn/kancloud/progit/70182)中的图大多都是画的库中的样子，请注意还有工作目录和索引区。
* git的库中保存单元是[git 的对象（object）](#git-object)，我们通常脑海中出现的像一颗树一样成长的分支树是由一个个commit对象连成的。
* HEAD指针比较特殊，可以将 HEAD 想象为当前分支的别名

## 如何在分支间来回切换


## 删除分支总是想用git branch delete

曾经我也愤怒过这个事情：

* 增加一个remote是：`git remote add ...`，增加一个branch却是：`git branch ...` —— 为啥不要add？
* 删除一个remote是：`git remote remove ...`，删除一个branch却是：`git branch -d ...` —— 为啥要用`-d`？
* 那些年闹过的笑话：
    - `git branch delete xyz`: 结果增加了两个分支：delete和xyz
    - `git branch remove delete xyz`: 以为用错了，再试remove，结果又增加了第3个分支：remove
    - 非常疑惑，再试：`git branch del remove delete xyz`: 结果可想而知
    - 最后还得： `git help branch`
    - `git branch -d del remove delete xyz`

在用参数还是用子命令的问题上，其实也不要纠结，子命令还能加参，所以子命令相当于对参数进行了一级分类，或者纯粹是开发者的个人偏好。

* git中使用子命令的不多：`git <command> <subcommand> <option>`
    - `git bisect       <subcommand>`
    - `git bundle       <subcommand>`
    - `git credential   <subcommand>`
    - `git notes        <subcommand>`
    - `git p4           <subcommand>`
    - `git remote       <subcommand>`
    - `git stash        <subcommand>`
    - `git subtree      <subcommand>`
    - `git svn          <subcommand>`
    - `git worktree     <subcommand>`
* 剩下的基本都是： `git <command> <option>`

## 分支的合并（git merge）有哪几种场景

`git merge` = `diff` + `patch`

假定：本地工作目录是b1(HEAD)的，希望从b2合并过来，b1和b2从同一个节点C3继承

初始状态：
```
              b1(HEAD)
              |
C1 --- C2 --- C3
              |
              b2
```

1. **我动了，队友没动**：b2自C3后没有提交，无论本地文件有无修改、有无暂存、b1有无新提交：`git merge b2`后，b1都**不发生任何变化**
```
                            b1(HEAD)
                            |
C1 --- C2 --- C3 --- C6 --- C7
              |
              b2
```
2. **我没动，队友动了**：C3后b1没有提交，b2有提交 —— **b1如果有本地修改或暂存未提交是禁止merge操作的**
    * merge前状态
    ```
                    b1(HEAD)
                    |
    C1 --- C2 --- C3
                    \
                    C4 --- C5
                            |
                            b2
    ```
    * `git merge b2`后，b1快速前移（fast-forward）到b2
    ```
                                b1(HEAD)
                                |
    C1 --- C2 --- C3 --- C4 --- C5
                                |
                                b2
    ```
    * `git merge --no-ff b2`后，b1即使可以快速前移（fast-forward），也会生成一个commit，就像b1有提交似得，其实C6里面没有任何文件的修改，只是为给自己和团队人员提个醒，此处做过一次合并 —— merge一个anotated tag的时候用此默认参数
    ```
                            b1(HEAD)
                            |
    C1 --- C2 --- C3 ------ C6
                    \       /
                    C4 --- C5
                            |
                            b2
    ```
3. **我和队友都动了**: b1、b2 在C3后有提交 —— **同样：b1如果有本地修改或暂存未提交是禁止merge操作的**
    * merge前状态
    ```
                        b1(HEAD)
                        |
    C1 --- C2 --- C3 -- C6
                    \       
                    C4 --- C5
                            |
                            b2
    ```
    * `git merge b2`后，
        - 如果没有冲突
            + 默认参数是： `--commit/`，`--edit/`，即：会产生一次commit，自动生成log但会弹出编辑器给用户编辑，并且`git log b1`的时候会列出C1/2/3/4/5/6/7所有的提交信息
            ```
                                        b1(HEAD)
                                        |
            C1 --- C2 --- C3 -- C6 -- C7
                            \         /
                            C4 --- C5
                                    |
                                    b2
            ```
            + `git merge --no-edit b2`可以不弹出编辑器给用户编辑log
            + `git merge --no-commit b2`可以避免自动生成commit，而只是把b2的差异合并到本地文件，并add到暂存区，后续由开发者自己提交。提交后的新节点C7仍是有两个父节点的（C5、C6）
            ```
                                   本地文件 -> 暂存区
                                   /     /           \
                                  /     /    手动commit  b1(HEAD)
                                 /     /               \ |
            C1 --- C2 --- C3 -- C6..../.................C7
                            \        /                 /
                            C4 --- C5  .............../
                                    |
                                    b2
            ```
            + `git merge -squash b2`：sqush单词的意思是挤压、压扁。此命令可以把b2中的差异提交合并成diff，patch到本地文件并add，用户commit后生成的新节点和b2没有任何关系（`git log`是看不到b2的所有提交的），可以理解为纯粹从b2拿差异过来，但又不和b2发生关系。—— 常用于在主干上合并一个没有完成的特性分支，或者两个相互依赖的分支不定时的互相合并。
            ```
                                   本地文件 -> 暂存区
                                   /     /           \
                                  /     /    手动commit  b1(HEAD)
                                 /     /               \ |
            C1 --- C2 --- C3 -- C6..../.................C7
                            \        /                 
                            C4 --- C5 
                                    |
                                    b2
            ```
        - 如果有冲突，则会分成2步：
            - 首先在本地文件中记录差异(diff)
            ```
                                    本地文件(diff文件)
                                        / /
                                b1(HEAD) /
                                |       /
            C1 --- C2 --- C3 -- C6     /
                            \         /
                            C4 --- C5
                                    |
                                    b2
            ```
            - 然后需要手工（使用vi、notepad++、sublimetext等删除诸如"==="和"***"）或`git mergetool confilctfile`两种方式之一修改冲突文件，手工修改完毕后还需`git add`，`git mergetool`退出时git默认会把冲突文件add到暂存区，最后`git commit`，此时会发现默认的log已经被自动加上了
            ```
                                本地文件(diff文件) -- "手工+git add"或"git mergetool" 
                                   /      /                                          \
                                  /      /                                   手动commit  b1(HEAD)
                                 /      /                                              \ |
            C1 --- C2 --- C3 -- C6 --- / -----------------------------------------------C7
                            \         /                                                /
                            C4 --- C5 ------------------------------------------------/
                                    |
                                    b2
            ```


## 合并时如何处理分支中的“垃圾”log

我想你所表达的所谓“垃圾”只是针对分支要合并到主干了，这些log显得琐碎而多余，针对主干来说是“垃圾”，在分支开发过程中这些肯定不是垃圾，而是有效的防护网，也是向领导汇报工作时的“烂笔头”。

我建议你在分支开发过程中可以适当的多提交一些、提交细一些，不但可以省去单独写“工作日志”，也利于回忆和追溯，如果领导在关注这个git库，也能让领导感觉每天都在努力，挣一些情感分。

但毕竟好又多的log信息合入主干的话还是要认真思考一下是不是要保留所有log

* **Yes**:那就直接`git merge featurebranch master`
* **No**:那还是悠着点`git merge --squash featurebranch master` —— 具体原理参考 [分支的合并（git merge）有哪几种场景](#git-merge) 已描述


## “把特性分支合入主干”和“把主干合入特性分支”有什么区别

这个问题问的好，很多一开始接触git的同学基本意识不到这个问题。这已经不是git本身的问题了，而是使用git的团队之间的工作流规范了。

* **把特性分支合入主干**：通常是特性分支开发完毕了，测试通过了，是时候在主干上构建版本了，才把分支合入主干
    - 此时通常会遇到前面讲的“处理分支中的垃圾log”问题，处理办法前文已述
    - 合入主干后分支通常会删除，留着特性分支不删除的习惯是不合适的，用句成语来形容就是：敝帚自珍
    - 删除后还想再继续，`git branch featurebranch`再开一个就是了，名字都可以相同
    - 通常我们的特性分支是根据用户故事/工单而来的，一个长期不删除的分支说明了任务分解的不合理或需求的不明确，一旦出现这样的问题还是尽快和用户讨论需求并合理的分解。
* **把主干合入特性分支**：通常是主干在不停的合入较稳定的代码，分支也想不定期/或定期的同步过来，以免和主干背离太远
    - 定期同步主干到特性分支是个好习惯，可以尽快的发现团队成员做了什么，是不是对我的当前分支有影响和冲突……有了冲突要今早发现、尽快处理才是敏捷，对冲突采取鸵鸟策略是不明智的。
    - 涉及的命令有：
        + `git rebase master`
        + `git pull --rebase` 如果有冲突会停住，然后`git mergetool`解决冲突，`git rebase --continue`继续

## git merge 有没有图形化的工具

和 `git difftool` 类似，也有 `git mergetool`，但mergetool不是用来merge的，而是用来处理merge后的冲突文件的。

* 通用配置
```cmd
$ git config --global mergetool.diffmerge.trustExitCode true
```
* **BeyondCompare**
    - macOS
    - Linux
    - Windows
    ```cmd
    $ git config --global merge.tool bc3
    $ git config --global mergetool.bc3.path "c:/program files/beyond compare 3/bcomp.exe"
    $ git mergetool
    ```
* **DiffMerge**
    - macOS
    - Linux
    - Windows
    ```cmd
    $ git config --global merge.tool diffmerge
    $ git config --global mergetool.diffmerge.cmd 'diffmerge --merge --result="$MERGED" "$LOCAL" "$(if test -f "$BASE"; then echo "$BASE"; else echo "$LOCAL"; fi)" "$REMOTE"'
    ```

## git分支之间的关系能否图示

```cmd
$ git log --pretty=oneline --graph

* 94688f21cc5d8bc85f1783b4c8b98b3288d712cb improve readme
*   693f2c48421d9218e057340bf29de75e0d5ba8d2 Merge pull request #377 from PhrozenByte/patch-1
|\
| * 9545a295cf4cfda6e728ebf0948a12bc5530e42d README.md: Add PHP 5.3+ requirement
| * 3d649081e58c9fed5ff11aeede1be2dd2e0ee153 Update composer.json requirements
|/
*   32de2cedcc98ffb3476f5a413f47bb482691c807 Merge pull request #373 from getgrav/master
|\
| * e7443a2bd868e78946ae6a01a1b07d477ce6f4cc Fixed really sorry spelling errors
| * 10a7ff776c3f16b1b3aa41c176c48150fc091065 Left as-is
| * 5ad15b87faa2ab10f7cda7593e2e92696fafadd2 Break out method_exists checks into extendable methods to allow for better pluggability
| * b166cab9a252f4093af1f33cb178a86f6047d08a Make `lines` protected to allow for extendability
|/
* 0f974bf34fdc420c3a7dc0a6c5c5fc620fa9dd89 improve readme
* 3d7cdeec5f90a16934a2cfd35a089c78aa0e4816 remove duplicate item in: who uses it
```

关于 git branch 之间的图示，有一些软件做出了不同的展示，[这里](https://pvigier.github.io/2019/05/06/commit-graph-drawing-algorithms.html) 有一篇文章对比展示了 gitk、gitkraken、smartgit、sourcetree……多个软件的效果，并且自己也开发了 gitamine 来图示。

## 分支名能否用中文

关于分支的命名，可以用一条git命令来检查： git check-ref-format —— 它的返回值为0表示git接受此命名，否则不接受。比如：

```cmd
kevin@T410:~$ git check-ref-format "refs/heads/zte" 
kevin@T410:~$ echo $?
0
kevin@T410:~$ git check-ref-format "refs/heads/z.t.e" 
kevin@T410:~$ echo $?
0
kevin@T410:~$ git check-ref-format "refs/heads/zt..e" 
kevin@T410:~$ echo $?
1
kevin@T410:~$ git check-ref-format "refs/heads/@zte" 
kevin@T410:~$ echo $?
0
kevin@T410:~$ git check-ref-format "refs/heads/z~t^e" 
kevin@T410:~$ echo $?
1
kevin@T410:~$ git check-ref-format "refs/heads/z:t?e" 
kevin@T410:~$ echo $?
1
```

先解释一下 ref/hedas ：分支和tag都是指针，ref就是指针的意思，所有branch和tag在.git/config中都是以 ref/... 命名的，如果不加 ref ， check-ref-format 命令将不能正确识别。

可以发现两个点 .. 、~、^、:、? 这些都是不允许的，斜杠允许但不允许在末尾。

最后，来看看你最关心的中文名：

```cmd
kevin@T410:~$ git check-ref-format "refs/heads/中兴" 
kevin@T410:~$ echo $?
0
```

是允许的。

那么branch/tag的命名到底规则如何呢？

看git帮助即可：

```cmd
$ git help check-ref-format
```

里面是这样解释的：

```
Git imposes the following rules on how references are named:

1. They can include slash / for hierarchical (directory) grouping, but no slash-separated component can begin with a dot .  or end with the sequence .lock.
2. They must contain at least one /. This enforces the presence of a category like heads/, tags/ etc. but the actual names are not restricted. If the --allow-oneleveloption is used, this rule is waived.
3. They cannot have two consecutive dots ..  anywhere.
4. They cannot have ASCII control characters (i.e. bytes whose values are lower than \040, or \177 DEL), space, tilde ~, caret ^, or colon : anywhere.
5. They cannot have question-mark ?, asterisk *, or open bracket [ anywhere. See the --refspec-pattern option below for an exception to this rule.
6. They cannot begin or end with a slash / or contain multiple consecutive slashes (see the --normalize option below for an exception to this rule)
7. They cannot end with a dot ..
8. They cannot contain a sequence @{.
9. They cannot be the single character @.
10. They cannot contain a \.
```

## 分支太多容易分不清咋办

```
$ vi ~/.bashrc
```

增加
```bash
function git-branch-prompt {
  local branch=`git symbolic-ref --short -q HEAD 2>/dev/null`
  if [ $branch ]; then printf " [%s]" $branch; fi
}
PS1="\u @ \[\033[0;36m\]\W\[\033[0m\]\[\033[0;32m\]\$(git-branch-prompt)\[\033[0m\] \$ "
```

---

学会了分支操作（创建、合并、冲突……）是与人合作的基础，你是否已经准备好了走出个人的宇宙，拥抱开源的大世界了！

第3局，Over！

# Round 4 : 协作

![](img/children-dam-bali-sw.jpg)

## 想看看别人的git库了

是不是已经不满足于只管理个本机的日记了？太好了，git天生就是为了程序猿合作用的，几条关键的命令要出场了：

* `git clone url [localname]`  
* `git fetch`
* `git pull`
* `git push`

一幅图说明问题：

![](img/git-pull-push.png)

最左边的remote和左边3个（repository、index、workspace)是同等地位的，意思是remote是远方某人的电脑，里面其实也包含了（repository、index、workspace)中的3个或2个，大家地位是平等的。

## 橡树与木棉

svn中每个人的本机是client，数据库在server上，离开server，你看不到log，无法做commit。但git没有server的概念，或者说server就在每个人的本机上，无非是保存了repo的哪些东东。

每两人之间互相分享、交换代码是通过： pull、push、fetch、clone 这几个命令来完成的，你是我的remote，我也是你的remote，大家彼此之间就像橡树与木棉，谁也不是攀援谁的凌霄花，谁也不是谁的痴情鸟儿，两个remote只是两颗近旁的橡树和木棉，根紧握在地下，叶相触在云里，仿佛永远分离，却又终身相依。

我可以独立的生长，我commit代码不必次次都跟你商量，你也是，我们之间的每次push和pull都建立的互相尊重、地位平等的前提下，你不必绑架我，我也不限制你。

## git与github

这个问题就像经典的C++与VC的区别，问了很多年了还是有刚出校门的同学在问，我后来一度觉得这不能怪同学们，谁叫他俩非要起这么相近的名字，让人傻傻分不清。

git和github更加淋漓尽致的体现这个现象，也是git入门的必问问题之一。谁让github这帮小伙起了个这样的名字，人家sourceforge、googlecode、codeplex都不以自己所用的版本管理软件的名字来标榜自己，唯独github，为了显摆自己用了git，起了个git转发器（hub）这个名字 —— 呵呵，开玩笑了，仔细琢磨，你会发现hub（转发器）这个词选的真是绝了，太贴切了。

git和github我用一句话就让你理解：就像BT和迅雷。——类似“迅雷使用BT协议，增加了权限、种子列表、热门榜单等”，github使用git协议，增加了权限、项目列表、热门榜单等。其他就不多解释了。

## github与他的小伙伴们（到哪里找开源项目）

开源项目托管网站（及其开始支持git的时间）有：

* [github](http://github.com)(2008.2)
* [sourceforge](http://sourceforge.net)(2009.3)
* [Google Code](http://code.google.com)(2011.7) —— 2015年底已关闭服务
* [CodePlex](http://www.codeplex.com)(2012.3)
* [CSDN Code](http://code.csdn.net)(2013.10)
* [OSChina git](http://git.oschina.net)(2013)
* [Coding](https://coding.net/)

这些网站之间有很多有趣的历史，也是互为竞争对手。2004年我第一次接触开源的时候，项目经理给我的任务是到sourceforge下载一个叫做rainbow的源码，当时还没有git，开源项目托管第一平台sourceforge已经独霸江湖10余年，它是在用cvs，作为一个还在学校的学生，真的是摸索了很久。

很多年过去了，看江湖风云，开源项目版本管理系统从cvs到svn，又从svn到git。开源项目托管网站从sourceforge逐步衰败，到群众寄予厚望的google code风光无限，但最终都还是和其他网站一起，败在了一个2008年创立、2011年才火起来的后起之秀手上，google code也于2015年底宣布关闭。此后起之秀就是当下无人匹敌的：github。

有个有趣的小插曲：CodePlex是微软家的，也开张好多年了，sourceforge时代就不愠不火，反正在大家眼里微软和开源本就是水火不容、盖茨/鲍尔默和托瓦茨也是井水不犯河水。但在2012年微软突然做出了一个有趣的决定：

![](img/codeplex.torvalds.png)

近几年，微软更是几乎放弃了自家的CodePlex，转投github，开源自己的.NET都在github上了。

2017年4月1日，愚人节这天微软宣布将关闭了codeplex，4月1日开始关闭新项目的创建，10月进入只读模式，12月15彻底over，结束codeplex 11年的生涯。回想当然用C# 和 ASP.NET 的时候，经常上codeplex上溜达，都将随风而逝，成为回忆。

## 为什么github成了程序员的麦加圣地

不解释，它就是那么酷！ -- 谁用谁知道

* [GitHub秘籍，为你解读Git与Github酷而少知的功能](http://www.xuanfengge.com/github-cheats.html)

## 公司内如何穿过Proxy访问github

git会使用“git confing配置”和“shell变量配置”两类：

<embed src="img/git-proxy.svg" />

### 使用 git config 配置
```cmd
$ git config --global http.proxy http://<proxyserver>:<port>
$ git config --global https.proxy http://<proxyserver>:<port>
```

实战：

* 没有配置proxy时，提示连不上github
```cmd
$ git clone https://github.com/wkevin/GitChat.git GC
Cloning into 'GC'...
fatal: unable to access 'https://github.com/wkevin/GitChat.git/': Failed to connect to github.com port 443: Timed out
```
* 配置proxy
```cmd
$ git config --global http.proxy http://proxysz.zte.com.cn:80
$ git config --global https.proxy http://proxysz.zte.com.cn:80
```
* 喝了杯茶，回来再试OK
```cmd
$ git clone https://github.com/wkevin/GitChat.git GC
Cloning into 'GC'...
remote: Counting objects: 64, done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 64 (delta 0), reused 0 (delta 0), pack-reused 59
Unpacking objects: 100% (64/64), done.
Checking connectivity... done.
```

### 使用 shell 环境变量配置

* 首先查看是否已经有了环境变量
```cmd
$ export |grep proxy
$
```
* 定义环境变量
```cmd
$ export http_proxy="http://proxysz.zte.com.cn:80/"
$ export https_proxy="https://proxysz.zte.com.cn:80/"
$ 
```
* 再次查询: OK
```cmd
$ export |grep proxy
declare -x http_proxy="http://proxysz.zte.com.cn:80/"
declare -x https_proxy="https://proxysz.zte.com.cn:80/"
$ 
```
* git应该以及可以链接外网了
* 临时想连接内网（临时不用proxy），咋办
```cmd
$ export -n http_proxy  //export -n 只是标记此变量不再是环境变量，但仍然是shell变量
$ set |grep http_proxy
http_proxy=http://proxysz.zte.com.cn:80/   //set命令仍然能够查看到
$ export http_proxy     //再次export即可
```

## 定义了外网和内网两个remote，proxy怎么同时支持

若你处在某个proxy之内，你的某个项目又有两个remote，分别在外网和公司内网，则会遇到这样的困扰：

* 为git配置了http.proxy后，外网OK，内网的就连不上
* 去掉http.proxy后，内网的remote OK，外网的又连不上

解决这个问题有几种方法：

1. 给不同的remote配专用的proxy： `git config --local --add remote.<name>.proxy ""`
    - 第一次 `git clone` 要麻烦一点
2. 一类remote用http.proxy，另一类remote用ssh
    - 如果想外网的remote用ssh，要给**ssh配置proxy**（[参考1](http://blog.csdn.net/qq634416025/article/details/42835409)、[参考2](http://iyuan.iteye.com/blog/1672982)）
3. shell中用`export http_proxy ...`来访问外网remote，另开一个shell则无此环境变量，可用于内网remote。

## SSH访问remote的通常步骤是啥

OK，书接上文。

```cmd
$ ssh-keygen -t rsa -C "wkevin27@gmail.com"
```
* 生成公钥和密钥
    - 得到两个文件：id_rsa和id_rsa.pub
    - **请确定两个文件的路径**：git for windows 有时候生成的文件会位于：`C:\ShellHome`，而`git push`等命令使用的是用户根目录，这两个目录未必一致，可能会被用户无意间修改。
* 拷贝公钥到github/gitlab
    - 可打开文件手工拷贝
    - 可 `clip < ~/.ssh/id_rsa.pub` 拷贝到粘贴板
* 添加密钥到ssh-agent（可选）
    - `$ eval "$(ssh-agent -s)"` 
    - `$ ssh-add ~/.ssh/id_rsa`
* 测试
    - `$ ssh -T git@github.com`
* 然后就可以使用ssh方式访问gitlab/github了
    - `git remote add xyz git@github.com:wkevin/GitChat.git`
    - `git push xyz master`

各个开源项目托管网站对ssh的要求可能还会有些许差别，但都会在显著位置进行说明，如果如上操作后仍不能访问，请仔细查阅。

## 如何与别人合作

当面沟通必不可少，svn和git并不能解决所有问题，每个团队都可以有自己的分支策略、日志模版、合并规则、标签原则……

## 如何在github上与别人合作

github的工作流： [Understanding the GitHub Flow](https://guides.github.com/introduction/flow/)

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
- macOS 平台
    + Gitifier：https://github.com/nschum/Gitifier

但经过我的试用，功能还都不完善，希望它们早日成熟、好用。

目前可以使用 github/gitlab 的 RSS Feed 功能：

针对个人的RSS Feed：
![](img/gitlab-rss-feed-user.png)

针对团队的RSS Feed：
![](img/gitlab-rss-feed-group.png)

使用 RSS Reader（图中使用的是Snafer）订阅的效果：
![](img/gitlab-rss-reader.png)

## 为什么说不要用git pull，而是用git fetch + git merge代替

git pull的问题是它把过程的细节都隐藏了起来，以至于你不用去了解git中各种类型分支的区别和使用方法。当然，多数时候这是没问题的，但一旦代码有问题，你很难找到出错的地方。看起来git pull的用法会使你吃惊，简单看一下git的使用文档应该就能说服你。

将下载（fetch）和合并（merge）放到一个命令里的另外一个弊端是，你的本地工作目录在未经确认的情况下就会被远程分支更新。当然，除非你关闭所有的安全选项，否则git pull在你本地工作目录还不至于造成不可挽回的损失，但很多时候我们宁愿做的慢一些，也不愿意返工重来。 


## 如何不clone/fetch到本地看remote repo的log?



## 程序猿如何频繁地commit，但又低调地push

SVN和git面对同样的一个问题：大部分程序猿是含蓄、内敛的，他既希望频繁的commit，让svn/git帮他记住每一步，但并不想把这些过程信息全都公诸于众，而只是把阶段性成果推送给大家或服务器。

具体情况还要分为两种：假定两名程序员A、B

1. A、B负责的代码耦合性不高，或A、B不相互依赖
    * [构造干净的 Git 历史线索](http://codecampo.com/topics/379?comment_id=1354#comment-1354)
2. A、B负责的代码耦合性高，或A、B相互依赖
    * 需求：协同开发：调试期间多人之间代码依赖，相互调用，使用头文件……
    * 设计：用SVN也可以协同开发，但会在服务器上留下大量无效的调试记录
    * 操作：git方式：**将本机库开放给同伴，合作开发完成后使用 git rebase -i 清理**
        - 准备
            + A君
                * .git目录下新建git-daemon-export-ok文件，表明该工程允许非授权访问
                    - cd /path/to/project.git
                    - touch git-daemon-export-ok
                * `git daemon --reuseaddr --base-path=/opt/git/ /opt/git/`
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

## 通过http push时每次都要求输入name/password，能否避开

* 配置是否需要 git 认证小助手把密码存储起来
```cmd
$ git config credential.helper store
```

以后 `git push` 再要求输入用户名、密码后，会保存在 ~/.git-credentials 文件中。

或者，也可以手工创建`.git-credentials`文件，替换其中的 name 和 password:
```cmd
$ echo "https://<name>:<password>@github.com" > ~/.git-credentials
```

注意几点：

1. ~/.git-credentials 打开可看到明文密码 ，**所以，千万不要在公用电脑上配置此项。**
2. 如果有多个 github 账号，保存/备份好 ~/.git-credentials 文件，不要搞混、搞丢失了。
3. 如果你打开了**两步验证**，则通常意义的password已经不能使用，网站会提供tocken给你替代password，请在 ~/.git-credentials 文件中用 tocken 替代之。

## 如何删除远程分支
    
* 删除本地分支是： `git branch remove <branchName>`
* 删除远程分支：
    - `git push origin :<branchName>`
    - `git push origin --delete <branchName>`

## 如何删除远程tag

* 删除本地tag
    - `git tag -d <tagname>`
* 删除远程tag
    - `git tag -d <tagname>`
    - `git push origin :refs/tags/<tagname>`
    - `git push origin --delete tag <tagname>`

## 别人把远程分支删除了，我本地的对应分支怎么还在

张三删除了某个branch并push到github，李四`git fetch/pull`之后该branch在李四本地库里是仍然存在的，如何删除之？

1. `git fetch -p`
2. `git remote prune origin`

## 维持树的整洁

[A successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/) 

方法就是：在git push之前，先git fetch，再git rebase

git rebase（衍合）

git rebase 一般自己一个人开发时使用，用来保持提交记录的整洁。一旦上传到github后，不应该使用git rebase,不然被骂死。

一旦分支中的提交对象发布到公共仓库，就千万不要对该分支进行衍合操作。
 如果你遵循这条金科玉律，就不会出差错。否则，人民群众会仇恨你，你的朋友和家人也会嘲笑你，唾弃你。

## Git多用户间协作还有什么引人入胜之处

* 集中式工作流
![](img/workflow.onecore.png)
* 集成管理员工作流
![](img/workflow.manager.png)
* 司令与副官流程（Linux）
![](img/workflow.many.layers.png)




# Round 5 : 整理

![](img/elephants-sand-river-sw.jpg)

## git从何而来

![](img/Torvalds.jpg)

这里有一篇git的创始人Torvalds（同时也是Linux的创始人）的接受中国媒体的一篇访谈录：

* [Linux创始人Linus Torvalds访谈，Git的十年之旅](http://www.wtoutiao.com/a/2287349.html) -- 如果网页链接失效，重新百度即可，Torvalds接受类似的访谈录很多，但大多是英文的。

## git去往何处

2005年7月26日开始，Torvalds把git托付给了一位日本人：[Junio Hamano](https://en.wikipedia.org/wiki/Junio_Hamano)。Torvalds也说过自己一生最大的成功之一就包括把git托付给Hamano。

Hamano现在google，他的github帐号为：[gitster](https://github.com/gitster)，头像中抱着个大熊猫，说不定比较喜欢China哦。
![](img/Hamano.jpg)

git源码的[提交统计](https://github.com/git/git/graphs/contributors)中可以发现Hamano是提交最踊跃的：

![](img/git-contributors.png)

github上有这样几个卓越的组织（Orgnization):

* [git](https://github.com/git):目前有[8位成员](https://github.com/orgs/git/people)，牵头人 [Scott Chacon](https://github.com/schacon)，他们充当管理者和传教士的角色，比较重要的贡献是：
    - 维护git源码
        + Hamano(gitster)并没有加入到这个Orgnization中，而只是fork到自己账号下，然后PR到 git/git，看来gitster只是想当程序员，不想当管理者和传教士——大概源于日本人和中国人类似，都比较低调。
    - 管理和维护 [git-scm.com](http://git-scm.com) 网站
* [progit](https://github.com/progit):目前有[15位成员](https://github.com/orgs/progit/people)，牵头人 [Scott Chacon](https://github.com/schacon) 和 [Ben Straub](https://github.com/ben)，两人目前都供职于github公司，其他人多是从事翻译工作。比较重要的贡献有
    - 写了《Pro git》这本书，此书被翻译成多种语言，被奉为经典。


## git有哪些好的入门的资料

读到这里是需要系统的了解、学习一下git的时候了，
当然，我明白你说的是中文资料。

**官方Specification**

* [Git Man Page](https://www.kernel.org/pub/software/scm/git/docs/): 即： git help 命令的输出
* [Git User Manual](https://www.kernel.org/pub/software/scm/git/docs/user-manual.html)
* Git Tutorial： [Part1](https://www.kernel.org/pub/software/scm/git/docs/gittutorial.html) -- 即 `man gittutorial`; [Part2](https://www.kernel.org/pub/software/scm/git/docs/gittutorial-2.html) -- 即 `man gittutorial-2`
* [How to](https://www.kernel.org/pub/software/scm/git/docs/howto/)

**Book**

* Pro Git:根正苗红的书
    - 第2版：[中文官方在线版](http://git-scm.com/book/zh/v2)、[中文国内在线版](http://www.kancloud.cn/kancloud/progit)、[英文官方在线版](http://git-scm.com/book/en/v2)
    - 第1版：[中文官方在线版](http://git-scm.com/book/zh/v1)、[中文国内在线版](http://git.oschina.net/progit/)
* [Git Community Book 中文版](http://gitbook.liuhui998.com/index.html)
* [git简明教程](http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)

**Website**

* [git 维基百科]: https://en.wikipedia.org/wiki/Git_(software)
* [git SCM wiki](http://git.wiki.kernel.org) -- 2011年已停止更新

## git命令我掌握的七七八八了，怎么整理一下

google 或 bing 上搜索图片：**git cheat sheet** —— 不要在baidu上搜索，结果你会很失望。

可以看到很多热心网友们整理的常用命令集，快选一幅打印出来或作为桌面吧！

比如（版权归作者所有，本文仅是转发）：

![](img/Git-Cheatsheet-1.png)
![](img/Git-Cheatsheet-3.jpg)
![](img/Git-Cheatsheet-4.png)
![](img/Git-Cheatsheet-5.png)

也有一些复杂到令人发指的：
![](img/Git-Cheatsheet-2.png)


## 重新梳理git的软件

是时候看一下git的 [维基百科][gitwiki] 了：

[gitwiki]: https://en.wikipedia.org/wiki/Git_(software)

>Git is a widely-used source code management system for software development. It is a distributed revision control system with an emphasis on speed,[6] data integrity,[7] and support for distributed, non-linear workflows.[8] Git was initially designed and developed in 2005 by Linux kernel developers (including Linus Torvalds) for Linux kernel development.[9]

>As with most other distributed version control systems, and unlike most client–server systems, every Git working directory is a full-fledged repository with complete history and full version-tracking capabilities, independent of network access or a central server.[10] Like the Linux kernel, Git is free software distributed under the terms of the GNU General Public License version 2.


- UI前端也有，比如github出品的 [github desktop](https://desktop.github.com)
+ [Git for Windows](https://github.com/git-for-windows/git)
        * 第一代的名字叫sysGit](https://github.com/msysgit/git)，基于 msys（属于 MinGW）—— 2015年底已废弃
        * 第二代重新建立了github项目[Git for Windows](https://github.com/git-for-windows/git)，基于 msys2（不再属于MinGW），英语有自信的可以读读它的[背景](https://github.com/git-for-windows/git/wiki)
    + [TortoiseGit](http://code.google.com/p/tortoisegit/)：类似TortoiseSVN，可以做图标重绘。


## 整理git的外网托管网站

git库的托管网站（git host）有很多，github并不是唯一的选择，github最困扰开发者的一点就是：它丫竟然不交钱不给创建私有库。

下面介绍几个其他的：

* [Bitbucket](https://bitbucket.org): 流行最广的给开免费私有库的网站，可以创建无限多个私有库，充分满足了不想开源、不敢开源、和羞于开源的广大程序员们。
* [开源中国oschina的git](http://git.oschina.net)：开源中国在2013年创建的，号称全面、永久开放私有库，立志做中国的github，不知道是哪一天，突然它自己改名字了，叫：码云，我勒个去。
* [CSDN Code](http://code.csdn.net)：

这里有一个表格，对比各个git host： https://git.wiki.kernel.org/index.php/GitHosting ，关注 **Free private repositories**，提供免费服务的也不老少，但大部分只是提供git的基本托管，并没有github的fork、PR、gist、gitbook……等服务。

如果你要开发一个开源的模块来扬名，请使用github；如果要开发一个秘密的、需要保密的大项目，请使用Bitbucket；如果只是玩一玩，请使用码云（毕竟速度要快一点）。

## linux中能否使用多个版本的git

那是必须可以的。

- 场景1：你受限与linux版本太古老，无论用 yum 还是 apt 安装的都是很古老的 git 
- 场景2：你希望测试自己多个 git 的兼容性

在 linux 上使用源码编译基本可以解决，步骤：

- 在 https://git-scm.com/ 上下载最新（或自己喜欢）的源码
- `tar xvf git-2.9.5.tar.xz`
- `cd git-2.9.5`
- `./configure --prefix=/home/kevin/.local/git295` : 这里根据需求指定分开的目录即可
- `make -j8 && make install`
- **风险提示：**：
    - 如果 make install 后手工挪动、重命名了 git295 目录，则执行git时会出现错误


# Round 6 : 奇技淫巧

![](img/resting-lions-tanzania-sw.jpg)

## 从当前库中快速导出一个节点(commit、tag)另作他用

比如：

* 导出某次提交或某个分支给他人看看，但checkout过去，看完再checkout回来是有成本的（当前工作要打断，要commit或stash）
* 导出多个标签进行对比查看，比如想比较一下 v1.0、v1.1、v1.3 三个版本之间的差异，则在一个目录下通过checkout就搞不定了

建议方案：

**方案1**： `git archive` 导出一份不受git管理的纯内容出去

```cmd
$ cd projectA.git
$ mkdir ../projectA-v1.2
$ git archive v1.2 | tar -x -C ../projectA-v1.2
```

**方案2**：`git worktree` 在另外一处创建一个分支 —— 这是git2.5新增的一个功能，相当有趣

* 原始状态：本地仅master分支
```cmd
$ git br
* master                cf4edda [origin/master] 修订proxy的使用方法
  remotes/origin/HEAD   -> origin/master
  remotes/origin/master cf4edda 修订proxy的使用方法
  remotes/zte/master    cf4edda 修订proxy的使用方法
```
* 首先看看现有哪些worktree
```cmd
$ git worktree list
E:/demo/GitChat.git  cf4edda aster]
```
* 在另外一个文件夹，用当前分支，创建一份新的工作拷贝
```cmd
$ git worktree add -b 4compare ../forCompare
Preparing ../forCompare (identifier forCompare)
HEAD is now at cf4edda 修订proxy的使用方法

$ ls ../
forCompare/  GitChat.git/
```
* `git branch`可以查看到新创建的分支
```cmd
$ git branch -vv
  4compare cf4edda 修订proxy的使用方法
* master   cf4edda [origin/master] 修订proxy的使用方法

$ git worktree list
E:/demo/GitChat.git  cf4edda aster]
E:/demo/forCompare   cf4edda [4compare]
```
* 进入新创建的文件夹中，可以查看到
```cmd
$ cd ../forCompare/
$ git branch -vv
* 4compare cf4edda 修订proxy的使用方法
  master   cf4edda [origin/master] 修订proxy的使用方法
```

OK，可以在 forCompare 目录下工作了

我们继续探讨一下`git worktree`的其他用法

* `git worktree`不但可以根据某个branch创建，也可以从某个tag创建
```cmd
$ git worktree add -b new2 ../new2 v0.1
Preparing ../new2 (identifier new2)
HEAD is now at 5d21d8b new file:   img/git-state-and-area.svg
```
* 还可以根据某个commit创建
```cmd
$ git worktree add -b new ../new 5d21d8b
Preparing ../new (identifier new)
HEAD is now at 5d21d8b new file:   img/git-state-and-area.svg
```
* 删除worktree：`git prune`能够删除目标文件已经被删除的worktree
```cmd
$ git worktree list
E:/demo/GitChat.git  cf4edda aster]
E:/demo/forCompare   cf4edda [4compare]
E:/demo/new          5d21d8b [new]
E:/demo/new1         12205fd [new1]
E:/demo/new2         5d21d8b [new2]

$ rm -rf ../new2

$ git worktree list
E:/demo/GitChat.git  cf4edda aster]
E:/demo/forCompare   cf4edda [4compare]
E:/demo/new          5d21d8b [new]
E:/demo/new1         12205fd [new1]
E:/demo/new2         5d21d8b [new2]

$ git worktree prune

$ git worktree list
E:/demo/GitChat.git  cf4edda aster]
E:/demo/forCompare   cf4edda [4compare]
E:/demo/new          5d21d8b [new]
E:/demo/new1         12205fd [new1]

$ rm -rf ../new ../new1 ../forCompare/

$ git worktree prune

$ git worktree list
E:/demo/GitChat.git  cf4edda aster]
```

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

## 分支2需改bug，但我正在分支1上编码并不想commit怎么办

使用git的时候，我们往往使用branch解决任务切换问题，例如，我们往往会建一个自己的分支去修改和调试代码, 如果别人或者自己发现原有的分支上有个不得不修改的bug，我们往往会把完成一半的代码 commit提交到本地仓库，然后切换分支去修改bug，改好之后再切换回来。这样的话往往log上会有大量不必要的记录。其实如果我们不想提交完成一半或者不完善的代码，但是却不得不去修改一个紧急Bug，那么使用'git stash'就可以将你当前未提交到本地（和服务器）的代码推入到Git的栈中，这时候你的工作区间和上一次提交的内容是完全一样的，所以你可以放心的修 Bug，等到修完Bug，提交到服务器上后，再使用'git stash apply'将以前一半的工作应用回来。也许有的人会说，那我可不可以多次将未提交的代码压入到栈中？答案是可以的。当你多次使用'git stash'命令后，你的栈里将充满了未提交的代码，这时候你会对将哪个版本应用回来有些困惑，'git stash list'命令可以将当前的Git栈信息打印出来，你只需要将找到对应的版本号，例如使用'git stash apply stash@{1}'就可以将你指定版本号为stash@{1}的工作取出来，当你将所有的栈都应用回来的时候，可以使用'git stash clear'来将栈清空。

* git stash: 备份当前的工作区的内容，从最近的一次提交中读取相关内容，让工作区保证和上次提交的内容一致。同时，将当前的工作区内容保存到Git栈中。
* git stash pop: 从Git栈中读取最近一次保存的内容，恢复工作区的相关内容。由于可能存在多个Stash的内容，所以用栈来管理，pop会从最近的一个stash中读取内容并恢复。
* git stash list: 显示Git栈内的所有备份，可以利用这个列表来决定从那个地方恢复。
* git stash clear: 清空Git栈。此时使用gitg等图形化工具会发现，原来stash的哪些节点都消失了。
* git stash apply：将以前一半的工作应用回来


## modify 错了，我要丢弃本地目录中的修改

* `git clean -df`：丢弃untracked的文件，不丢弃modified的文件
    * git clean -f: 删除 untracked files
    * git clean -fd: 连 untracked 的目录也一起删掉
    * git clean -xfd: 连 gitignore 的untrack 文件/目录也一起删掉 （慎用，一般这个是用来删掉编译出来的 .o之类的文件用的）
    * 在用上述 git clean 前，墙裂建议加上 -n 参数来先看看会删掉哪些文件，防止重要文件被误删
        * git clean -nxfd
        * git clean -nf
        * git clean -nfd
* `git checkout HEAD .`: 见下条
* `git reset --hard HEAD`: 见下条

## add 错了，我要丢弃暂存区的修改

**仅丢弃暂存区的修改，不丢弃本地目录的修改**

* `git reset [--soft] HEAD`: 用HEAD分支覆盖一下暂存区,不影响本地文件

**丢弃暂存区&本地目录的修改**

* `git checkout HEAD .` 或指定文件 `git checkout HEAD file`:用当前分支的库中文件覆盖暂存区和本地的
* `git reset --hard HEAD` 用HEAD覆盖一下暂存区和本地目录
    - git reset --hard HEAD
    - git reset --hard HEAD~1
    - git reset --hard HEAD~5

## commit 错了，我要丢弃某个commit节点

* `git reset commitHash~1`: 即可让HEAD指向commitHash前一个commit，即：丢弃commitHash

上面这3个丢弃都用到了 `git reset` 命令，这是个危险的命令，没有搞懂之前一定要慎重，否则丢了就可能找不回来了。

理解 `git reset` 请参考下文**git 原理**章节中的 **git reset 原理图**

## push 错了，我要丢弃remote上的某个节点

管理员： 胆子越来越大了啊，都push到server里了，还要删除，羞不羞啊 :)  
程序员： 给个机会吧，这几个commit确实不想push到server上。  
管理员： 有没有想过server上的这个分支已经被N多同学fetch过了，已经基于它做开发了，你reset了几个节点，别人会出错的！
程序员： 不会的，这个分支只有我一个人用
管理员： 哪个分支啊？
程序员： master
管理员： 啥？ master分支 O_O ，你有没有看gitlab的帮助文档，master分支被gitlab保护了，保护分支除了只允许Master角色有写权限外，还不允许任何人对其`git push --force`操作，也不允许任何人删除保护分支的。
程序员： 有这一说？我说 `git push --force origin master:master` 咋提示我失败呢

十几分钟后……

程序员： 我研究了gitlab的权限说明： https://about.gitlab.com/2014/11/26/keeping-your-code-protected/ ，保护分支是可以取消保护的
管理员： shit，这都被你找到了，好吧，我承认是可以，就在 project - seetings 里面，只给你这一次机会啊，快去吧。

终于可以霸王硬上弓了。上弓方法有三：

1. `git reset xxx` 先回退本地，然后 `git push --force origin master:master`
2. `git reset --soft hashcode remoteRepo`
3. 把本地的回退了，然后把远程branch删掉，然后push新的

## 暂存一个文件的部分改动

比如说，你对一个文件进行了多次修改并且想把他们分别提交。这种情况下，你可以在添加命令(add)中加上-p选项

`git add -p [file_name]`

会逐段（hunk）提示你是否add。

## 能否从不同的分支里选择某次提交并且把它合并到当前的分支

`git cherry-pick [commit_hash]`

这个命令会带来冲突，请谨慎使用

## `HEAD^`和`HEAD~`是啥

`^`和`~`是2个很有意思的字符，配合使用可表示祖宗十八代。任你给一个节点（HEAD 或 哈希值），都能顺藤摸瓜，找到其祖先是谁。

网友通常这么解释：

- `^`：表示第几个父/母亲 ——　git存在多个分支合并的情况，所以不只有1对父母亲
- `~`：表示向上找第几代，相当于连续几个 `^`

比如有这样一个库：

```
          b1(HEAD)
          |
C4 ------ C6
         /
   --- C5

自己: C6 = HEAD^0         = HEAD~0         = C6^0       = C6~0    
父亲: C4 = HEAD^1 = HEAD^ = HEAD~1 = HEAD~ = C6^1 = C6^ = C6~1 = C6~ 
母亲: C5 = HEAD^2                          = C6^2 

```

我经过反复琢磨，给出另外一种更形象的解释：

- `^x`：**抬头走**1步，入x号岔路口。
- `~y`：**低头走**y步，无视岔路口。

所以：`^^`: 抬头2步，都是1号口；`^2^`：抬头走2步，第1步入2号口；`^^3^`：抬头走3步，第2步入3号口；`~^~`：低头1步，抬头1步，再低头1步；`~2^~^2`：低头走2步，抬头1步如1号口，再低头1步，再抬头1步如2号口 …… 怎么样？用抬头走、低头走理论是不是一下就理解了？心情舒畅吧。

这样，我们就可以方便的得到：

```
爷爷：HEAD^^    = HEAD^~    = HEAD~2
奶奶：HEAD^^2
姥爷：HEAD^2^   = HEAD^2~
姥姥：HEAD^2^2
…… 
```

`^` 和 `~` 可用于git的多种操作：log、diff、show、checkout……

实际操作一下：

```
kevin@:linux.git$ git log --oneline -n20 --graph
*   c11fb13a117e (HEAD -> master, tuna/master, kernel/master, github/master) Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid
|\  
| * 3ed224e273ac HID: logitech-dj: Fix 064d:c52f receiver support
| * f9482dabfd16 Revert "HID: core: Call request_module before doing device_add"
| * e0b7f9bc0246 Revert "HID: core: Do not call request_module() in async context"
| * 15fc1b5c8612 Revert "HID: Increase maximum report size allowed by hid_field_extract()"
| * eb6964fa6509 HID: i2c-hid: add iBall Aer3 to descriptor override
* |   b076173a309e Merge tag 'selinux-pr-20190612' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux
|\ \  
| * | fec6375320c6 selinux: fix a missing-check bug in selinux_sb_eat_lsm_opts()
| * |  e2e0e09758a6 | 2019-06-12 21:28:21 +0800 |  Gen Zhang  selinux: fix a missing-check bug in selinux_add_mnt_opt( )
| * |  aff7ed485168 | 2019-06-11 10:07:19 +0200 |  Ondrej Mosnacek  selinux: log raw contexts as untrusted strings
* | |    35110e38e6c5 | 2019-06-12 05:57:05 -1000 |  Linus Torvalds  Merge tag 'media/v5.2-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media

```
自己：
```
kevin@:linux.git$ git log --oneline -n1 HEAD^0
c11fb13a117e (HEAD -> master, tuna/master, kernel/master, github/master) Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid
```
```
kevin@:linux.git$ git log --oneline -n1 HEAD~0
c11fb13a117e (HEAD -> master, tuna/master, kernel/master, github/master) Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid
```
父亲：
```
kevin@:linux.git$ git log --oneline -n1 HEAD^
b076173a309e Merge tag 'selinux-pr-20190612' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux
```
```
kevin@:linux.git$ git log --oneline -n1 HEAD^1
b076173a309e Merge tag 'selinux-pr-20190612' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux
```
```
kevin@:linux.git$ git log --oneline -n1 HEAD~
b076173a309e Merge tag 'selinux-pr-20190612' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux
```
```
kevin@:linux.git$ git log --oneline -n1 HEAD~1
b076173a309e Merge tag 'selinux-pr-20190612' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux
```
爷爷：
```
kevin@:linux.git$ git log --oneline -n1 HEAD^^
35110e38e6c5 Merge tag 'media/v5.2-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
```
```
kevin@:linux.git$ git log --oneline -n1 HEAD^~
35110e38e6c5 Merge tag 'media/v5.2-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
```
```
kevin@:linux.git$ git log --oneline -n1 HEAD~2
35110e38e6c5 Merge tag 'media/v5.2-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
```
奶奶
```
kevin@:linux.git$ git log --oneline -n1 HEAD^^2
fec6375320c6 selinux: fix a missing-check bug in selinux_sb_eat_lsm_opts()
```
母亲：
```
kevin@:linux.git$ git log --oneline -n1 HEAD^2
3ed224e273ac HID: logitech-dj: Fix 064d:c52f receiver support
```
姥爷：
```
kevin@:linux.git$ git log --oneline -n1 HEAD^2~
f9482dabfd16 Revert "HID: core: Call request_module before doing device_add"
```

**总体来说：找父亲一族要方便些，找母亲一族要麻烦些。**


## 如何统计一段时间文件（或文件夹）的修改次数

为了快速了解代码，有时候需要快速的查看代码的统计信息，做一些宏观的把握，上面这个需求可能会有些用处。

**先来复习一下 git 自身的  统计功能**：

- `--stat`：每个文件的修改的行数，并用+-符号展示
```
kevin@:linux.git$ git diff HEAD^ --stat
 drivers/hid/hid-a4tech.c                 | 11 ++++++++---
 drivers/hid/hid-core.c                   | 16 +++-------------
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c |  8 ++++++++
 10 files changed, 136 insertions(+), 54 deletions(-)
```
- `--numstat`：每个文件的修改的行数，并用数字展示
```
kevin@:linux.git$ git diff HEAD^ --numstat
8       3       drivers/hid/hid-a4tech.c
3       13      drivers/hid/hid-core.c
8       0       drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
```
- `--shortstat`：所有文件修改的行数汇总
```
kevin@:linux.git$ git diff HEAD^ --shortstat
 10 files changed, 136 insertions(+), 54 deletions(-)
```
- `--dirstat=[changes|lines|files]`：按文件夹统计和汇总下述数据
    - changes：变化的行数（新增文件不算）
    - lines：+和-的行数统一算（新增文件会被计算）
    - files：文件变化的数量夹

```
kevin@:linux.git$ git diff HEAD^ --dirstat=changes
 100.0% drivers/hid/
kevin@:linux.git$ git diff HEAD^ --dirstat=lines
   4.2% drivers/hid/i2c-hid/
  95.7% drivers/hid/
kevin@:linux.git$ git diff HEAD^ --dirstat=files
  10.0% drivers/hid/i2c-hid/
  90.0% drivers/hid/
```

另外，`--stat` 也能用于 `git log`，等价于每条commit都diff一下，即： `git log --stat` == `for (ci in commints) { git diff ci --stat }`

```
kevin@:linux.git$ git log --oneline --shortstat
c11fb13a117e (HEAD -> master, tuna/master, kernel/master, github/master) Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid
b076173a309e Merge tag 'selinux-pr-20190612' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux
fec6375320c6 selinux: fix a missing-check bug in selinux_sb_eat_lsm_opts()
 1 file changed, 14 insertions(+), 6 deletions(-)
35110e38e6c5 Merge tag 'media/v5.2-2' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
e2e0e09758a6 selinux: fix a missing-check bug in selinux_add_mnt_opt( )
 1 file changed, 14 insertions(+), 5 deletions(-)
aa7235483a83 Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
4d8f5f91b8a6 Merge branch 'stable/for-linus-5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb
c23b07125f8a Merge tag 'vfio-v5.2-rc5' of git://github.com/awilliam/linux-vfio
6fa425a26515 Merge tag 'for-5.2-rc4-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
aff7ed485168 selinux: log raw contexts as untrusted strings
 1 file changed, 8 insertions(+), 2 deletions(-)
```

大量没有file修改的merge挺碍眼的，使用 `--no-merges` 清理
```
kevin@:linux.git$ git log --oneline --shortstat --no-merges
fec6375320c6 selinux: fix a missing-check bug in selinux_sb_eat_lsm_opts()
 1 file changed, 14 insertions(+), 6 deletions(-)
e2e0e09758a6 selinux: fix a missing-check bug in selinux_add_mnt_opt( )
 1 file changed, 14 insertions(+), 5 deletions(-)
aff7ed485168 selinux: log raw contexts as untrusted strings
 1 file changed, 8 insertions(+), 2 deletions(-)
```

**OK，基础功能展示完毕，基于这些，我们来发挥一下：**

- **找到目标日期之后的提交**
    - `--no-pager`：git默认使用linux的less模式显示，即满屏后提示用户按一下按键才继续显示，加上此选项则可以一口气打印完毕
    - `%h`：此处我只需要hash值，所以其他都省略了
    - `--no-merges`: 虽然merge也是工作量，但和我们的统计任务无关
  
```
kevin@:linux.git$ git --no-pager log --format=format:'%h' --no-merges --since 2019-06-10
fec6375320c6
e2e0e09758a6
aff7ed485168
f6581f5b5514
```

- **找到每次提交的修改文件**
    - awk：逐行处理上面查出的hash值，用 system() 命令转给 git 去执行
    - `--stat-name-width=300`：git diff的输出默认会压缩到80列，使用`...`这种，这样会丢失我想要的信息，所以我加大到300，应该不会有丢弃了
    - `--name-only`：我只是想统计文件的个数，并没有计划汇总每次、每个文件内部变更的行数，所以只要名字即可
    - `"$1" "$1"~"`：最终会形成 `git diff xxx xxx~` ，为什么没用 `^`，效果一样么？留作思考题 ：）
    - 下面代码中可以看到 hooks.c 文件在4次提交中被修改过2次

```
kevin@:linux.git$ git --no-pager log --format=format:'%h' --no-merges --since 2019-06-10 | \
awk '{system(" git --no-pager diff  --stat-name-width=300 --name-only "$1" "$1"~") }'
security/selinux/hooks.c
security/selinux/hooks.c
security/selinux/avc.c
kernel/cred.c
kernel/ptrace.c
```

- **统计并数字显示**
    - `fs[$0]+=1`: 用文件名做key，value每次+1

```
kevin@:linux.git$ git --no-pager log --format=format:'%h' --no-merges --since 2019-06-10 | \
awk '{system(" git --no-pager diff  --stat-name-width=300 --name-only "$1" "$1"~") }'| \
awk '{fs[$0]+=1} END{for(f in fs) printf("%d\t%s\r\n",fs[f],f) }' | sort -k 2
1	kernel/cred.c
1	kernel/ptrace.c
1	security/selinux/avc.c
2	security/selinux/hooks.c
```

- **还可以统计到某一层文件夹，而不是具体到每个文件**
    - `-e 's/[^/]*$//'`：去掉文件名，只留路径
    - `-e 's#/#|#1'`：精确匹配第1个`/`更换成`|`，这里的1可以自己修改，统计不同level的文件夹深度
    - `-e 's/|.*//'`：把`|`以后的字符删除 —— 这样只留下我们想要的某个level深度的路径

```
kevin@:linux.git$ git --no-pager log --format=format:'%h' --no-merges --since 2019-06-1 | \
awk '{system(" git --no-pager diff  --stat-name-width=300 --name-only "$1" "$1"~") }'| \
sed -e 's/[^/]*$//' -e 's#/#|#1' -e 's/|.*//' | \
awk '{fs[$0]+=1} END{for(f in fs) printf("%10d\t%s\r\n",fs[f],f) }'|sort -k 2
       676	arch
         9	block
        10	crypto
         2	Documentation
      2027	drivers
       128	fs
       286	include
         2	ipc
        43	kernel
        21	lib
        16	mm
       103	net
         9	samples
        17	scripts
        93	security
       304	sound
       114	tools
         5	virt
```

上面是6.1至今（6.14），半个月来 Linux 的修改，仍然是 drivers 中的文件最多，达到 2027 件次（类比“人次”这个单位，哈哈），kernel前几天已经发布5.1了，其实kernel半个月才更新了43个件次，还是超级稳定的。

BTW：上面思考题的答案：用`^` 和 `~` 是一样的。

# Round 7 : 原理拾趣

![](img/black-trevally-sardines-sw.jpg)

## git和SVN在元数据存储上有什么区别

svn是基于增量存储的，两次提交对于repo来说只保存变化量，git不使用svn的增量方式保存数据，而是使用快照。因为git的分布式特性，并没有一颗树一样成长的repo，repo更像是一张网式的成长，节点与节点之间可能会绕很远才能找到亲戚关系，所以增量无从谈起。

来看下面这个过程：

* A、B两个git clone
* A的commit 时间比 B 晚
* A先push
* B在push时失败，先pull，再次commit
* A一次ci，B两次ci —— 比svn多了一次ci，因为svn中B是先merge后ci，git中是先ci后merge再ci
* B再push
* git log：ci的顺序是：B的ci、A的ci、B的merge后ci —— **B的ci会插入到A的ci前面**

如果用增量存储，将很难把整个过程记录下来，根本原因是：**开发者提交前是不需要同步别人代码的**。


## git 的对象（object）

[GIT对象模型](http://gitbook.liuhui998.com/1_2.html)

* git的指针（branch是指针）指向某个对象（object）
* git的object包含4个部分：
    - 对象名：40bit的HASH
    - 类型：有4种：
        1. blob
        2. tree
        3. commit
        4. tag
    - 大小：
    - 内容：
* 可以使用 `git show <对象名>` 来查看一个object的内容

4类object的图示：

|blob|tree|commit|tag|
|---|---|---|---|
|![](img/object-blob.png)|![](img/object-tree.png)|![](img/object-commit.png)|![](img/object-tag.png)|

我的粗浅认识是：

* blob对象封装了具体的文件，[blob的百度百科](http://baike.baidu.com/link?url=uwTulBgFwwZkFIksfXQHzCFT1Nrm1U7Eo_3LY-1uZJwl6JYrDETOitmBdJeYKVwVOCLwUnF_0RozRyPHDTvSKK)，blob单词的意思是一疙瘩、一坨。
* tree类似目录、文件夹，包含了tree和blob
* commit：包含了一个tree的指针（对象名），和父级commit对象，还有`git commit`时的相关信息。
* tag：指向一个commit对象

来实际操作一把：

* `git log` 找一条commit
```cmd
$ git lg
 e3426a5 | 2016-02-16 11:20:22 +0800 | 2016-02-16 11:20:22 +0800 |  Kevin Wang  调整章节，内容基本没变
 a15f695 | 2016-02-16 10:28:16 +0800 | 2016-02-16 10:28:16 +0800 |  Kevin Wang  增加 git cheat sheet 小节
 c242093 | 2016-02-04 11:30:21 +0800 | 2016-02-04 11:30:21 +0800 |  wkevin  笔误
 48eda25 | 2016-02-04 11:21:57 +0800 | 2016-02-04 11:21:57 +0800 |  wkevin  笔误: 缺少一个反括号
```
* `git show <object-name>` 可以查看各类object的细节
* `git show <commit-object-name>` 可以查看 commit 类型的细节，其中包括了diff（即：和parrent父级commit对象相比的差异：tree及其blob的差异）
```cmd
$ git show  e3426a5
commit e3426a51534d97f5c73369a98fd38d6fb2f83f0a
Author: Kevin Wang <wkevin27@gmail.com>
Date:   Tue Feb 16 11:20:22 2016 +0800

    调整章节，内容基本没变

diff --git a/README.md b/README.md
index 17944e2..a0be055 100644
--- a/README.md
+++ b/README.md
@@ -31,21 +31,24 @@ git 有自己的 [user manunal](https://www.kernel.org/pub/software/scm/git/docs
     - erge是怎么玩儿的](#merge)
 - [Round 4](#round4)
```
* `git show --pretty=raw <commit-object-name>` 还能更多的查看 commit 对象所指向的tree对象
```cmd
$ git show --pretty=raw e3426a5
commit e3426a51534d97f5c73369a98fd38d6fb2f83f0a
tree 65e1673d28da6cf7554cc0bed020673f68276112
parent a15f6954d609da2bebc243a52a8dd1094e6e2fd6
author Kevin Wang <wkevin27@gmail.com> 1455592822 +0800
committer Kevin Wang <wkevin27@gmail.com> 1455592822 +0800

    调整章节，内容基本没变

diff --git a/README.md b/README.md
index 17944e2..a0be055 100644
--- a/README.md
+++ b/README.md
```
* `git show <tree-object-name>` 或 `git ls-tree <tree-object-name>` 或 `git ls-tree <commit-object-name>` 都能够看到 tree 对象更多的细节
```cmd
$ git show 65e1673
tree 65e1673

.gitignore
README.md
img/

$ git ls-tree 65e1673
100644 blob 40f51b88ea8b90ff1c9db36ffc45cfd71f71c078    .gitignore
100644 blob a0be0555eeeb50e4702e137a7837ad9970be7755    README.md
040000 tree 5aec0814a9b43d040a1a3388aaf2c4ae60e296f4    img

$ git ls-tree e3426a5
100644 blob 40f51b88ea8b90ff1c9db36ffc45cfd71f71c078    .gitignore
100644 blob a0be0555eeeb50e4702e137a7837ad9970be7755    README.md
040000 tree 5aec0814a9b43d040a1a3388aaf2c4ae60e296f4    img
```
* `git show <blob-object-name>` 查看一个blob对象的细节，如果是文本文件就等同于`$cat file`了
```cmd
$ git show 40f51b
*.html
.vim.*
```


## git 的快照存储有点不可思议，如何做到好又多的

* 继续前面的话题，我们往前查几个commit对象，试图发现的更多一些
```cmd
$ git show --pretty=raw 48eda25
commit 48eda255c3f727e57f1462592a8cd8fd8d16839a
tree f1683d3e377fcbb99cca10c481d0070375e1bf23
parent 12205fd2616a0af5ebe8243f6e5c16a64e9e9127
author wkevin <wkevin@users.noreply.github.com> 1454556117 +0800
committer wkevin <wkevin@users.noreply.github.com> 1454556117 +0800

    笔误: 缺少一个反括号
```
* 看看这个tree对象包含的内容
```cmd
$ git ls-tree f1683d3e
100644 blob 40f51b88ea8b90ff1c9db36ffc45cfd71f71c078    .gitignore
100644 blob 5211c0dae2ab042cf0cf2edff08809af510e358a    README.md
040000 tree 4867a64660a9d90a8a5a966c9fac1187861762f3    img
```

可以发现两次commit所指向的tree对象中：

* .gitignore的HASH相同
* README.md的HASH不同

因此说明：**每次提交仅会把有改动的file重新计算HASH并封装为对象进行存储**

* 整个文件存储那不是很浪费空间？—— Yes！
* 那为什么还比svn的增量存储更快呢？ —— 这个问题要这么看：
    - `svn commit`的时候是提交到网络服务器的，存在网络时延的问题，`git commit`只有本地操作
    - `svn commit`的时候要实时计算diff，`git add/commit`不存在diff计算，`git add`时会做对象的生成，但git对象的生成是执行压缩算法 —— 执行diff计算和执行压缩算法在当前水平的CPU能力下已不分伯仲
    - git虽然耗损更多的磁盘空间，但现在最不值钱的就是磁盘空间了

## git add/commit 原理图

<embed src="img/git-add.svg" type="image/svg+xml" />

## git checkout 原理图

<embed src="img/git-checkout.svg" type="image/svg+xml" />


* `git checkout file`：用暂存区的file覆盖工作区的file
* `git checkout branch`：HEAD指向branch，然后去覆盖暂存区和工作区
* `git checkout --detach branch`：游离指向branch，然后去覆盖暂存区和工作区
* `git checkout commithash`：游离指针指向某次commit，，然后去覆盖暂存区和工作区
* `git checkout branch/commithash file`：拿指针指向的file去覆盖暂存区和工作区的file，所以暂存区会有待提交内容

详细：

* `git checkout <./file>`
    - HEAD 不会切换
    - 用暂存区的file覆盖工作区中对应的文件，暂存区的不变
        + **如果没有未提交的修改，暂存区和HEAD是相同的**
        + 如果暂存区刚才有未提交的修改，后续仍可commit
    - 覆盖：意味着所有修改会丢失；但新增的文件不丢失。
* `git checkout <branch>`
    - HEAD 会被切换
    - 用 <branch> 中的文件覆盖工作区中对应的文件
    - 切换的当前branch时：本地修改不会丢失，也不必提交
    - 切换的其他branch时：本地修改要先提交，-f 强切修改会丢失
* `git checkout --detach [<branch>]`
    - HEAD 不变
        + `git checkout --detach`：会从当前 HEAD 创建游离指针
        + `git checkout --detach anotherBranch`：会从 anotherBranch 指针创建游离指针
    - 从<branch>处创建一个**游离**的branch，并覆盖到本地工作区
    - 从当前branch创建游离分支时：本地修改不会丢失，也不必提交
    - 从其他branch创建游离分支时：本地修改要先提交，-f 强切修改会丢失
* `git checkout [--detach] <commit>`
    - 游离一个branch
* `git checkout [[-b|-B|--orphan] <new_branch>] [<start_point>]`

## git fetch/pull 原理图

<embed src="img/git-remote.svg" type="image/svg+xml" />

## git reset 原理图

<embed src="img/git-reset.svg" type="image/svg+xml" />


`git reset [-q] [<tree-ish>] [--] <paths>…`
`git reset (--patch | -p) [<tree-ish>] [--] [<paths>…]`
`git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]`


* 图中3个动作：
    1. 替换引用的指向。引用指向新的提交ID。
    2. 替换暂存区。替换后，暂存区的内容和引用指向的目录树一致。
    3. 替换工作区。替换后，工作区的内容变得和暂存区一致，也和HEAD所指向的目录树内容相同。
* 3个参数：
    * --hard: 执行上图中的全部动作1、2、3
    * --soft: 执行上图中的全部动作1
    * --mixed:执行上图中的全部动作1、2，—— 默认操作
* 举例：
    - `git reset`==`git reset HEAD`：用HEAD重置暂存区，工作区不受影响，相当于回滚/撤销 `git add`
    - `git reset -- filename` == `git reset HEAD filename`：仅将文件的改动撤出暂存区，暂存区中其他文件不改变。
    - `git reset --soft HEAD^`：工作区和暂存区不改变，但是HEAD和当前分支引用向前回退一次
        + 用途：提交了之后，你又发现代码没有提交完整，或者你想重新编辑一下再提交
    - `git reset --hard` == `git reset --hard HEAD`: 用HEAD覆盖暂存区和工作区，即：丢弃所有本地修改
* 重置可以朝前，也可以朝后
```cmd
$ git br
* master ecfc106 2
  new    ab3fa01 3
$ git reset --soft new
$ git br
* master ab3fa01 3
  new    ab3fa01 3
```

# Round 8 : git与phabricator

## arc 为何物

* arc 全称是 arcanist，百度给出的中文翻译是：巧匠。  
* arc 是Facebook的Phabricator系统中用户端的命令行工具，配合pha提交变更评审的。
* arc 的安装还有点折腾，要先在本机安装PHP，和一个php的工具集：libphutil
    - windows的安装后，目录下包括下面3个主要部件：
    ```
    Phabricator/--arc/--arcanist
                |     |-libphutil
                |-xampplite-win32-1.7.3
    ```
        + arcantist是arc的主程序：https://github.com/phacility/arcanist.git
        + libphutil是php的工具集：https://github.com/phacility/libphutil.git
        + xampplite是apache+php+mysql+perl的一个打包，160+M，要知道phabricator整个才180+M。
* arc 包含很多子命令，
    - `arc help`：列出来子命令看看
    - `arc diff`：调用`svn diff`或`git diff`生成差异并发送给phabricator生成评审单
    - `arc list`：列出当前peding的revision —— revision要说明一下：pha生产的每个评审单都对应一个revision，可以理解为svn/git的一次提交，但又不在用户的svn/git上体现，可以理解为pha上也驻留这一个svn/git，来存储评审单信息，每单对应一个revision。
    - `arc patch`：将pha上的revision变更patch到本地工作拷贝上
    - `arc amend`：更新git commit的message，即：可以把pha上某个revision的message应用到本地git的某个commit上
    - `arc commit`：svn专用，pha上评审完毕后，将本地的变更做`svn commit`
    - `arc land`：git专用，pha上评审完毕后，将本地分支做`git push`，所以需要有 origin
    - `arc lint`：静态代码分析，不要以为arc只是生成评审单的，它还内嵌了一堆的lint工具，python的、java的、js的……五花八门，在 `Phabricator\arc\arcanist\src\lint\linter\__tests__` 这个目录下列出了这些lint工具
    - `arc unit`：执行单元测试，这个就需要用户自己来指定单元测试工具了
    - `arc close-revision`：使用arc关闭某个revision，而不必上pha上鼠标点点点啦
    - …… 还有n多，不一一列举了，头晕
* arc 的 configuration
    - 和git类似，git有`git config --[global/system/local] xxx ...`，arc也有`arc set-config --[user/local] xxx ...`
    - 和git类似，git查看config有`git config -l`，arc也有`arc get-config`

## arc的安装和配置

**Windows下的安装**
略

**Ubuntu下的安装**

* 安装
    * `sudo apt-get install php5 php5-curl`
    * `cd somewhere` //arc的安装目录
    * `git clone https://github.com/phacility/libphutil.git `
    * `git clone https://github.com/phacility/arcanist.git `
    * `sudo ln -s arcanist/bin/arc /usr/local/bin/arc`
    * `vi ~/.bashrc`
        - `source $somewhere/arcanist/resources/shell/bash-completion`
* 配置
    - `arc set-config $pha-server` //eg: `arc set-config http://pha.etz.com.cn`
    - `arc install-certificate`
        + 到 $pha-server 上查找帮助，找到tocken，填到这里
        + 注意proxy的屏蔽

## arc diff 初步

* SVN中，`arc diff`会把未提交的本地工作拷贝中的变更生成评审单，执行`arc diff`之前不需要也不能执行`svn commit`，最终评审完，用`arc commit`来代替`svn commit`
* git中则完全不一样，`arc diff <startCommit>`之前需要首先`git add`&`git commit`，**如果本地工作拷贝中有变更，arc diff会自动替你add和commit**，因为`arc diff`是把git中两个commit之间（即：一个range）的变更提交到pha上生成评审单，所以问题来了：两个commit节点是如何指定的？
    - **两个commit节点是：startCommit 和 HEAD**
    - startCommit如果缺失，则默认使用 `git merge-base origin/master HEAD`
        + 这又是个啥东东？`git help merge-base`，意思是找到 origin/master 和 HEAD 之间的最近祖先节点。
        + `git help merge-base`中有几个例子，其中一个是：
        ```
             o---o---o---B
            /
        ---o---1---o---o---o---A
        ```
            * `git merge-base A B `将返回节点1，好好体会一下，呵呵。
        + 所以为了不出乱子，最好自己指定 startCommit
* `arc diff`需要填写一些信息，所以执行过程中会跳入到一个编辑器中，windows版的arc会打开一个简陋的窗口，ubuntu版的arc就直接打开默认的编辑器（如vi）了。需要填写的信息有：
    - Test Plan - 必填，详细说明你的测试计划；
    - Reviewers - 必填，审查人的账户，多个使用","隔开；
        + 在ubuntu下，用vi编辑此信息时，不会自动不全人名，则需要到phabricator网站上的搜索窗口，找到需要的人，把TA的账号写在此处
    - Subscribers - 非必填订阅人，多个使用","隔开。

实战一下：

* 创建一个temp的git repo
```
10036143@A20939270 MINGW32 /f/temp (master)
$ git log
*  75c616b | 2016-06-08 15:55:19 +0800 |  wkevin  hah
*  7584e84 | 2016-06-08 15:55:01 +0800 |  wkevin  create
```
* `arc diff`
    - 会提示错误，没有指定 origin/master，因为默认startComiit是`git merge-base origin/master HEAD`嘛
* `arc diff 7584`
    - 可以创建评审单的，因为是拿 HEAD（即75c6）与7584比较
    - `git show HEAD` 可以查看 HEAD 指向哪个节点
* `arc diff 7584 --preview`
    - 可以在pha上创建评审单，但跳过指定评委等步骤，单子已经在pha上有了，可以先看看，后续在pha上慢慢指定评委等
    - 这是专门给处女座准备的啊
* 有一点需要说明：
    - `arc diff`会根据工作拷贝的相关信息（比如 path, branch name, local commit hashes, and local tree hashes）来自动创建和关联一个pha上的revision，这让一些掌控欲比较强的人可能有些恼火，可以手工指定
        + `arc diff --create <startCommit>`:在pha上创建一个新的revision
        + `arc diff --update Dxxxx <startCommit>`：在pha上一个已有的revision（编号Dxxxx）上做增量


## arc diff 为什么把我已有的commit log修改了

在上面的步骤中有一个奇怪的地方：执行完`arc diff xxxx`后，**原有的HEAD节点被arc重新创建的一个节点所替代**

* 执行`arc diff 7584`后，75c6被替代为了26c0
```
$ git l
*  26c0efc | 2016-06-08 15:55:19 +0800 |  wkevin  hah
*  7584e84 | 2016-06-08 15:55:01 +0800 |  wkevin  create
```
* 再次执行`arc diff 7584`后，26c0被替代为了e6db
```
$ git l
*  e6db93c | 2016-06-08 15:55:19 +0800 |  wkevin  hah
*  7584e84 | 2016-06-08 15:55:01 +0800 |  wkevin  create
```
* 再次执行`arc diff 7584`后，e6db被替代为了7c29
```
$ git l
*  7c29204 | 2016-06-08 15:55:19 +0800 |  wkevin  hah
*  7584e84 | 2016-06-08 15:55:01 +0800 |  wkevin  create
```
* 但其实75c6、26c0、e6db都还是存在的，`git show`可以看到
```
$ git show 75c6
commit 75c616b3a6de15e7004c231486a91e338ae023a6
Author: wkevin <wkevin27@gmail.com>
Date:   Wed Jun 8 15:55:19 2016 +0800

    hah
```

事情变得很蹊跷，arc为什么要新建一个commit呢？

下面再来验证一下：如果本地有modified（待add）或stagging（待commit）文件的话，`arc diff`是不是也会新建一个commit呢？

* 当前状态
```
$ git l
*  1cce5be | 2016-06-08 16:05:27 +0800 |  wkevin  neww
*  7c29204 | 2016-06-08 15:55:19 +0800 |  wkevin  hah
*  7584e84 | 2016-06-08 15:55:01 +0800 |  wkevin  create
```
* 做一些有本地修改，但不 `git commit -a`
* `arc diff HEAD^`，会首先把未提交的变更进行提交，并且更新（amend）当前commit的message，然后向已有的revision进行update
```
$ arc diff HEAD^
You have uncommitted changes in this working copy.

  Working copy: F:\temp\

  Unstaged changes in working copy:
    README.md

    Do you want to amend this change to the current commit? [y/N] y

Linting...
No lint engine configured for this project.
Running unit tests...
No unit test engine is configured for this project.
SKIP STAGING Unable to determine repository for this change.
Updated an existing Differential revision:
        Revision URI: http://pha.zte.com.cn/D30449

Included changes:
  M       README.md
```
* 1cce5be 又被 20ae4c5 替代了，而不是在 1cce5be 的基础上新建一个commit
```
$ git l
*  20ae4c5 | 2016-06-08 16:05:27 +0800 |  wkevin  neww
*  7c29204 | 2016-06-08 15:55:19 +0800 |  wkevin  hah
*  7584e84 | 2016-06-08 15:55:01 +0800 |  wkevin  create
```

为了解开这个谜团，我们来跟踪一下`arc diff`的操作

`arc diff --trace <startCommit>`

摘录一部分打印：

```
>>> [1] <http> http://pha.zte.com.cn/api/user.whoami
>>> [2] <exec> $ git diff --no-ext-diff --no-textconv --raw 'HEAD' --
>>> [3] <exec> $ git ls-files --others --exclude-standard
>>> [4] <exec> $ git diff-files --name-only
>>> [6] <exec> $ git rev-parse 'HEAD'
>>> [7] <exec> $ git merge-base 'f8c1' 'd6efce6e8804ecb027762e0151ed071bc7d63b6d'
>>> [8] <exec> $ git log --first-parent --format=medium 'f8c101daaf75121dd4f1f1380b4dc5c1ed85cea0'..'d6efce6e8804ecb027762e0151ed071bc7d63b6d'
```
首先到phabricator服务器上验证tocken，并根据 startCommit 做出一些判断

```
>>> [16] <event> diff.willBuildMessage <listeners = 0>
>>> [17] <conduit> differential.getcommitmessage() <bytes = 295>
>>> [18] <http> http://pha.zte.com.cn/api/differential.getcommitmessage
>>> [19] <exec> $ git symbolic-ref --quiet HEAD
>>> [20] <exec> $ which 'editor'
>>> [21] <exec> $ editor  '/tmp/edit.cjol8q3bi1sg0kwk/new-commit'
```

然后到phabricator服务器上创建一个单，并根据pha的请求，打开editor，编辑评审单的信息

```
>>> [22] <exec> $ git commit --amend --allow-empty -F '/tmp/8qihi3x4l2ww4o8w/10039-Vbjrxm'
```

关键是这里了，无条件的更新了当前 HEAD 节点的 message。

其实 `git commit --amend` 的官方help中是这样解释的： Replace the tip of the current branch by creating a new commit. 

这样`arc diff <startCommit>`步骤就明朗了：

1. 提示用户填写评审单信息（Test Plans、Reviewers、Subscribers……），然后使用这些信息 `git commit --amend` 到当前分支的 HEAD 节点
2. 新的节点（即：新的HEAD） 成为 endCommit
3. 再拿 HEAD（即endCommit）与 startCommit 执行 `git diff`，输出的内容提交到 pha

arc 为什么要这么做？为什么要“玷污”我的现有节点？如果这个节点是其他分支的基础节点怎么办？…… —— 这个事情可以这么看：`arc diff`只是新建了一个commit，用来存储评审单的相关信息，并且把当前分支的HEAD指向了新建的commit，想好了这一点，事情其实很好办，下一节我们来规避它。

## 如何避免arc diff玷污现有节点

创建专用于评审的分支

* `git branch review`
* `git checkout review`
* `arc diff <xxx>` 或 `arc diff --preview <xxx>` //创建评审单或预审单（到pha网站上进行下一步的操作，可用于ubuntu下不能自动补全人名的环境）
* `git checkout master`
* `git branch -D review`  //评审单一旦创建，review分支就没有存在的必要性了

## 如何创建只包含部分文件的评审单

可能只希望评审方案文件（假设： design.md），但commit中包含相关的图片、svg、等文件，不需要提交到pha，如下处理：


* `git branch review <oneOldCommit>` //从 design.md 创建或修改前的节点创建一个分支
* `git checkout review`
* `git checkout master design.md`    //将master分支上的 design.md check 到 review 分支
* `git commit -am "review for design.md"`
* `arc diff HEAD^` 或 `arc diff --preview HEAD^` 
* `git checkout master`
* `git branch -D review`  

---

**跋**

本文本来只是我个人使用git多年来的学习笔记和备忘录，2015年底陆续有一些项目上的要求同事朋友们开始使用git，我当然乐于答疑释惑。和大家互动了之后，发现直接拿笔记给别人看是不妥当的，因为笔记从头到尾没有难度梯度，大家更希望我分享的是一篇由简入难的文章。—— 听取用户需求，重新编排文章，并且查漏补缺……终于在2016年春节假期中成文。

* 感谢中国的高铁，给了我从深圳到宁波的8+小时没有网络、没有打扰的书写时间，又在节后给了我8+小时从宁波回深圳的时间，本文骨架基本在这16+小时中完成。
* 感谢岳父和家里的好酒，白天喝酒打牌，晚上笔耕时并不上头、反胃。但文中也会屡见突兀的行文，大概就是喝过量时候写就的了。
* 感谢markdown和git，让我沉浸写作、畅快diff、任性提交，如果使用word，我猜是绝对写不出来的。
* 感谢问我git问题的同事朋友，灵感都源于你们。
