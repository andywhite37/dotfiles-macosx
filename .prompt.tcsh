#!/bin/tcsh -f

# Font Decorations
# 0 - normal
# 1 - bold
# 2 - normal again
# 3 - background color
# 4 - underline the text
# 5 - blinking

# Foreground/Background colors
# 30/40 - black
# 31/41 - brick red
# 32/42 - green
# 33/43 - yellow ochre
# 34/44 - dark blue
# 35/45 - magenta
# 36/46 - cyan
# 37/47 - white/gray

# Doesn't work in cygwin
#set red =    '%{\033[31;1m%]}'
#set yellow = '%{\033[33;1m%]}'
#set blue =   '%{\033[34;1m%]}'
#set none =   '%{\033[0m%]}'

set temp = `sh -c '/usr/local/git/bin/git branch --no-color' |& grep '^\*' | sed 's/^\* //' | sed 's/[\(\)]//g'`

if ( $?temp && "${temp}" != "" ) then
    setenv GIT_BRANCH "${temp}"
else
    setenv GIT_BRANCH "not git"
endif

if ($?tcsh) then

    #set prompt="%B[%{\033[31;1m%}%n%{\033[0m%}][%{\033[36;1m%}%~%{\033[0m%}][%{\033[31;1m%}%p%{\033[0m%}][%{\033[33;1m%}%h%{\033[0m%}][%{\033[32;1m%}${GIT_BRANCH}%{\033[0m%}]>%b "

    set prompt="[%{\033[31;1m%}%n%{\033[0m%}][%{\033[36;1m%}%~%{\033[0m%}][%{\033[32;1m%}${GIT_BRANCH}%{\033[0m%}][%{\033[33;1m%}%h%{\033[0m%}]> "

else
    set prompt=\[`id -un`@`hostname`\]\$
endif

