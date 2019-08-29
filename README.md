# Git 聊天入门

**给初学者入门用的章回体指南**

* Article: [Git 聊天入门](http://wkevin.github.io/GitChat/gitchat.html)
* Slides: [GitChat Slides](http://wkevin.github.io/GitChat/slides.html)

**How to build html and slides**:

* Prepare
    - `sudo apt-get install pandoc` // need pandoc version > 2.0
    - `cd GitChat/`
    - `git submodule update --init --recursive`
* Build Html & Slides
    * `./build-html.sh [-c]`
        * `-c`  clean first and then build
* Other
    - pandoc has many Markdown syntax Extension and usage is `pandoc -f markdown+xxextension`:
        + `escaped_line_breaks`
        + `blank_before_header`
        + more: http://www.pandoc.org/README.html#pandocs-markdown
    - pandoc can deal with some Markdown syntax Model, and every Model is a set of extensions:
        - John Gruber's Markdown syntax: `pandoc -f markdown`
        - GFM(Github Flavored markdown): `pandoc -f markdown_github`
        - PHP Markdown Extra: `pandoc -f markdon_phpextra`
