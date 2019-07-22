### terminal section

#bold='\['`tput bold`'\]'        ; [ $bold = '\[\]' ] && bold=
#PS1='\e[1;32m[\t]\e[m - $(tput bold)\w$(tput sgr0)\n\W'
#PS1='\e[4;36m[\t]\e[m - \e[1;79m\w\e[m \n\e[1;32m\W\e[m \$ '





# function parse_git_dirty {
#   [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
# }
# function parse_git_branch {
# #   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
#     # git branch 2>/dev/null | sed -n -e 's/^\* \(.*\)/\1/p'
#     git_branch="$(git branch 2>/dev/null | grep '^*' | colrm 1 2)"
#     branch_name="${git_branch}"
#     # BRANCH_COLOR="\033[1;91m"
#     if [ "$branch_name" != "" ];
#     then
#         # if [[ "$branch_name" = *"master"* ]];
#         # then
#         #     BRANCH_COLOR="\033[5;1;91m"
#         # fi
#         branch_name="($branch_name) "
        
#     fi
    
#     echo "$branch_name"
# }

# # function get_color_by_branch {
# #     git_branch="$(git branch 2>/dev/null | grep '^*' | colrm 1 2)"
# #     branch_name="${git_branch}"
# #     BRANCH_COLOR="\033[1;91m"
# #     if [ "$branch_name" != "" ];
# #     then
# #         if [[ "$branch_name" = *"master"* ]];
# #         then
# #             BRANCH_COLOR="\033[5;1;91m"
# #         fi
# #         branch_name="($branch_name) "
        
# #     fi
    
# #     echo "$BRANCH_COLOR"
# # }

# # echo $git_branch

# # # COLOR_RESET="\033[0m"
# # # BRANCH_COLOR="\033[5;1;91m"
# # normal_color='$(tput sgr0)'
# # pwd_basefolder='$(tput sgr 0 1)$(tput setaf 002 1)'

# # PS1="\[\e[4;36m\][\t]\[\e[m\] - \[$(tput setaf 243)\]\w\[$normal_color\]\n\$(get_color_by_branch)\$(parse_git_branch)\[$COLOR_RESET\]\[$pwd_basefolder\]\W\[$normal_color\]\[\e[m\] \$ "
# # BRANCH_COLOR="\033[5;1;91m"
# # function set_prompt_vars {
# #     bn="$(git branch 2>/dev/null | grep '^*' | colrm 1 2)"
# #     bn="${bn}"
# #     if [ "$bn" != "" ];
# #     then
# #         if [[ "$bn" = *"master"* ]];
# #         then
# #             BRANCH_COLOR="\033[5;1;91m"
# #         else
# #             BRANCH_COLOR="\033[1;91m"
# #         fi
# #         bn="($bn) "
# #     fi
# # }
# # PROMPT_COMMAND=set_prompt_vars
# # PS1="\[\e[4;36m\][\t]\[\e[m\] - \[$(tput setaf 243)\]\w\[$normal_color\]\n${bn:+ $bn}\[$COLOR_RESET\]\[$pwd_basefolder\]\W\[$normal_color\]\[\e[m\] \$ "

set_prompt_vars() {
    gb=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
    if [ "$gb" != "" ];
    then
        if [[ "$gb" = *"master"* ]];
        then
            BRANCH_COLOR='\033[3;5;1;91m'
        elif [[ "$gb" = *"release"* ]];
        then
            BRANCH_COLOR='\033[1;31m'
        else
            BRANCH_COLOR='\033[1;1;32m'
        fi
        gb="($gb)"
    fi
    #eb env
    # ebEnv=$(eb list 2>/dev/null | grep '^*' | colrm 1 2)
    # if [ "$ebEnv" != "" ];
    # then
    #     if [[ "$ebEnv" = "desiredEbEnv" ]];
    #     then
    #         EB_COLOR='\033[3;5;1;91m'
    #     else
    #         EB_COLOR='\033[1;1;32m'
    #     fi
    #     ebEnv="($ebEnv)"
    # fi
}
PROMPT_COMMAND=set_prompt_vars

COLOR_RESET='\033[0m'
COLOR_CLOCK='\e[4;36m'
COLOR_PWD='\e[0;2m'
COLOR_FOLDER='\e[0;32m'

normal_color='$(tput sgr0)'
pwd_basefolder='$(tput sgr 0 1)$(tput setaf 002 1)'

#when 'ls' is used, the folders will be displayed in green (97)
LS_COLORS=$LS_COLORS:'di=0;32'; export LS_COLORS

# PS1='┌─\[$(echo -e $COLOR_CLOCK)\][\t]\[$(echo -e $COLOR_RESET)\]─[\[$(echo -e $COLOR_PWD)\]\w\[$(echo -e $COLOR_RESET)\]]\n├${gb:+\[$(echo -e $BRANCH_COLOR)\]$gb\[$(echo -e $COLOR_RESET)\]─}\[$(echo -e $COLOR_FOLDER)\][\W]\[$(echo -e $COLOR_RESET)\]\n└╼\$ '
# PS1='\[$(echo -e $COLOR_CLOCK)\][\t]\[$(echo -e $COLOR_RESET)\] - \[$(echo -e $COLOR_PWD)\]\w\[$(echo -e $COLOR_RESET)\]\n${gb:+\[$(echo -e $BRANCH_COLOR)\]$gb}\[$(echo -e $COLOR_RESET)\]\[$(echo -e $COLOR_FOLDER)\][\W]\[$(echo -e $COLOR_RESET)\] \$ '

#only git branch
PS1='┌─\[$(echo -e $COLOR_CLOCK)\][\t]\[$(echo -e $COLOR_RESET)\]─[\[$(echo -e $COLOR_PWD)\]\w\[$(echo -e $COLOR_RESET)\]]\n├${gb:+\[$(echo -e $BRANCH_COLOR)\]$gb\[$(echo -e $COLOR_RESET)\]─}\[$(echo -e $COLOR_FOLDER)\][\W]\[$(echo -e $COLOR_RESET)\]\n└▶\$ '

# git branch and eb environment
# PS1='┌─\[$(echo -e $COLOR_CLOCK)\][\t]\[$(echo -e $COLOR_RESET)\]─[\[$(echo -e $COLOR_PWD)\]\w\[$(echo -e $COLOR_RESET)\]]\n├${gb:+\[$(echo -e $BRANCH_COLOR)\]$gb\[$(echo -e $COLOR_RESET)\]─}\[$(echo -e $COLOR_FOLDER)\][\W]\[$(echo -e $COLOR_RESET)\]${ebEnv:+─\[$(echo -e $EB_COLOR)\]$ebEnv\[$(echo -e $COLOR_RESET)\]}\n└▶\$ '

PS2='╼▶ '


### git section

# This functions do checkout on branch $1 and after that update local branch
function gcp() {
    git checkout $1 && git pull
}

#This function opens java file with vim to quick edit, based on git diff
function ed() {
    vim $(find . -name "$1.java")
}

# our handler that returns choices by populating Bash array COMPREPLY
# (filtered by the currently entered word ($2) via compgen builtin)
_gcp_complete() {
    branches=$(git branch -l | cut -c3-)
    COMPREPLY=($(compgen -W "$branches" -- "$2"))
}

# we now register our handler to provide completion hints for the "gitpull" command
complete -F _gcp_complete gcp




