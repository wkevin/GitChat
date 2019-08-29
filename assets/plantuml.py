#!/usr/bin/env python3
import os
import sys
import re
from subprocess import call

from pandocfilters import toJSONFilter, Para, Image, Link, elt, get_filename4code, get_caption, get_extension

def plantuml(key, value, format, _):
    if key == 'CodeBlock':
        [[ident, classes, keyvals], code] = value

        if "plantuml" in classes:
            sys.stderr.write('>>>>> Dealwith plantuml code in '+ os.path.abspath(os.path.curdir) +'\n')
            sys.stderr.write('value[ident,[classes],[[keyvals]]],format == ' + ident + str(classes) + str(keyvals) + format + '\n')

            caption, typef, keyvals = get_caption(keyvals)
            filename = get_filename4code("plantuml", code)
            for k,v in keyvals:
                if 'title' == k:
                    filename = "plantuml-images/" + v
            filetype = get_extension(format, "png", html="svg", revealjs="svg", latex="eps")
            sys.stderr.write('filename: ' + filename + '\n')
            sys.stderr.write('filetype: ' + filetype + '\n')

            src = filename + '.uml'
            dest = filename + '.' + filetype

            if os.path.isfile(dest):
                os.remove(dest)

            sys.stderr.write('Creating .uml file: ' + src + '\n')

            if (sys.version.startswith('2')):
                txt = code.encode(sys.getfilesystemencoding())
                # python2:type(code)=unicode; type(txt)=str
            if (sys.version.startswith('3')):
                # txt = code.encode(sys.getfilesystemencoding())
                # python3:type(code)=str;     type(txt)=bytes
                txt = code
            # sys.stderr.write(str(type(code)) + " " + str(type(txt)))

            # Remove any char untile @,
            # because there are some characters like space, 0x10(backspace)... in txt
            txtx=re.sub('^[^@]','',txt) 
            if not txtx.startswith('@start'):
                txt = "@startuml\n" + txt + "\n@enduml\n"
            with open(src, "w") as f:
                f.write(txt)

            sys.stderr.write('Creating image: ' + dest + '\n')
            rootpath=os.path.dirname(os.path.abspath(__file__))
            call(["java", "-jar", rootpath+"/plantuml.jar", "-t"+filetype, src])
            sys.stderr.write('Created image ' + dest + '\n')

            ret = Para([Image([ident, [], keyvals], caption, [dest, typef])])
            sys.stderr.write('Ret: ' + str(ret) + '\n')
            return ret


if __name__ == "__main__":
    toJSONFilter(plantuml)
