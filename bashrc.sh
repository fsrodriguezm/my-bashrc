# git prompt
if [ ! -f ~/.git-prompt.sh ]; then
    curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
fi

source ~/.git-prompt.sh

FMT_BOLD="\[\e[1m\]"
FMT_DIM="\[\e[2m\]"
FMT_RESET="\[\e[0m\]"
FMT_UNBOLD="\[\e[22m\]"
FMT_UNDIM="\[\e[22m\]"
FG_BLACK="\[\e[30m\]"
FG_BLUE="\[\e[34m\]"
FG_CYAN="\[\e[36m\]"
FG_GREEN="\[\e[32m\]"
FG_GREY="\[\e[37m\]"
FG_MAGENTA="\[\e[35m\]"
FG_RED="\[\e[31m\]"
FG_WHITE="\[\e[97m\]"
BG_BLACK="\[\e[40m\]"
BG_BLUE="\[\e[44m\]"
BG_CYAN="\[\e[46m\]"
BG_GREEN="\[\e[42m\]"
BG_MAGENTA="\[\e[45m\]"
BG_RED="\[\e[41m\]"

parse_git_bg() {
        [[ $(git status -s 2> /dev/null) ]] && echo -e "\e[43m" || echo -e "\e[42m"
}

parse_git_fg() {
        [[ $(git status -s 2> /dev/null) ]] && echo -e "\e[33m" || echo -e "\e[32m"
}

PS1="\n${FG_BLUE}╭─" # begin arrow to prompt
PS1+="${FG_MAGENTA}" # begin USERNAME container
PS1+="${BG_MAGENTA}${FG_CYAN}${FMT_BOLD} ☕ " # print OS icon
PS1+="${FG_WHITE}\u" # print username
PS1+="${FMT_UNBOLD} ${FG_MAGENTA}${BG_BLUE} " # end USERNAME container / begin DIRECTORY container
PS1+="${FG_GREY}\w " # print directory
PS1+="${FG_BLUE}${BG_CYAN} " # end DIRECTORY container / begin FILES container
PS1+="${FG_BLACK}"
PS1+="📁 \$(find . -mindepth 1 -maxdepth 1 -type d | wc -l) " # print number of folders
PS1+="📇 \$(find . -mindepth 1 -maxdepth 1 -type f | wc -l) " # print number of files
PS1+="🔗 \$(find . -mindepth 1 -maxdepth 1 -type l | wc -l) " # print number of symlinks
PS1+="${FMT_RESET}${FG_CYAN}"
PS1+="\$(git branch 2> /dev/null | grep '^*' | colrm 1 2 | xargs -I BRANCH echo -n \"" # check if git branch exists
PS1+="\$(parse_git_bg) " # end FILES container / begin BRANCH container
PS1+="${FG_BLACK}🌿 BRANCH " # print current git branch
PS1+="${FMT_RESET}\$(parse_git_fg)\")\n" # end last container (either FILES or BRANCH)
PS1+="${FG_BLUE}╰> " # end arrow to prompt
PS1+="${FG_CYAN}\\$ " # print prompt
PS1+="${FMT_RESET}"
export PS1

source <(kubectl completion bash)

# aliases
alias k="kubectl"
alias tgi="terragrunt init"
alias tgp="terragrunt plan"
alias tga="terragrunt apply"
alias dsp="echo y | docker system prune"