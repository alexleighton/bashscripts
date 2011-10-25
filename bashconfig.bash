
######################################################################
#   BASH CONFIG
export HISTFILESIZE=1000000
export HISTSIZE=1000000

######################################################################
#   ALIASES

alias la='ls -lAhG'
alias l='ls -l'
alias ls='ls -G'
alias py='python'
alias cd..='cd ..'

alias gs='git status'
alias ga='git add'
alias gr='git rm'
alias gc='git commit'
alias gpull='git pull'
alias gpush='git push'

######################################################################
#   BASH PROMPT

RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
BLUE=`tput setaf 4`
MAGENTA=`tput setaf 5`
CYAN=`tput setaf 6`
WHITE=`tput setaf 7`
OFF=`tput sgr0`

function str_repeat() {
   [ $# -eq 2 ] || return 1;
   local _cnt _ret="";
   while ((_cnt < $2 )); do
       _ret+="$1"
       ((_cnt++));
   done;
   echo "$_ret";
   return 0;
}

function setPS1 {
   EXIT_STATUS="$?" # Must be up here or you get exit status of other commands

   TERMLEN=`tput cols`
   INTRO=┌─
   DIR=${PWD}

   GIT=$(__git_ps1 "%s")

   if [[ "${#GIT}" -eq "0" ]]
   then
       let "CONTENTLEN = ${#INTRO} + ${#DIR}"
   else
       let "CONTENTLEN = ${#INTRO} + ${#DIR} + ${#GIT}"
       ((CONTENTLEN += 2))
       GIT=[${BLUE}$GIT${OFF}]
   fi

   ((CONTENTLEN += 3))
   let "REST = $TERMLEN - $CONTENTLEN"
   LINE=$(str_repeat "─" $REST)

   if [[ "${EXIT_STATUS}" -ne "0" ]]
   then
       ESTATUS="[${RED}${EXIT_STATUS}${OFF}]"
   else
       ESTATUS=""
   fi

   export PS1='$INTRO[${GREEN}${DIR}${OFF}]$LINE${GIT}─\n└─${ESTATUS}$ '

   #history -a
   #history -n
}
PROMPT_COMMAND='setPS1'
