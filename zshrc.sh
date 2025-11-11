########## Fancy Powerline-Style Zsh Prompt ##########

# Allow $(...) inside the prompt
setopt PROMPT_SUBST

# Enable color names like %F{blue}
autoload -Uz colors && colors

########## Helper functions ##########

parse_git_bg() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    if [[ -n "$(git status -s 2>/dev/null)" ]]; then
      print -nr -- "%K{yellow}%F{black}"   # dirty repo
    else
      print -nr -- "%K{green}%F{black}"    # clean repo
    fi
  fi
}

parse_git_fg() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    if [[ -n "$(git status -s 2>/dev/null)" ]]; then
      print -nr -- "%F{yellow}"
    else
      print -nr -- "%F{green}"
    fi
  fi
}

count_dirs()  { find . -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l | tr -d ' '; }
count_files() { find . -mindepth 1 -maxdepth 1 -type f 2>/dev/null | wc -l | tr -d ' '; }
count_links() { find . -mindepth 1 -maxdepth 1 -type l 2>/dev/null | wc -l | tr -d ' '; }

git_segment() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local BRANCH
    BRANCH=$(git symbolic-ref --quiet --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    if [[ -n "$BRANCH" ]]; then
      print -nr -- "$(parse_git_bg) %F{black}🌿 BRANCH ${BRANCH} %f%k$(parse_git_fg)"
    fi
  fi
}

########## Prompt Definition ##########

PROMPT=$'\n'"%F{blue}╭─"                                   # begin arrow
PROMPT+="%F{magenta}<%K{magenta}%F{cyan}%B ☕ %F{white}%n%b %F{magenta}%K{blue}> "
PROMPT+="%F{247}%~ %F{blue}%K{cyan}> %F{0}📁 \$(count_dirs) 📇 \$(count_files) 🔗 \$(count_links) %f%k"
PROMPT+="%F{cyan}\$(git_segment)"
PROMPT+=$'\n'"%F{blue}╰> %F{cyan}%# %f%k"

########## Completions ##########

autoload -Uz compinit && compinit

# kubectl (or kubecolor) completion
if command -v kubecolor >/dev/null 2>&1; then
  source <(kubecolor completion zsh)
elif command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

########## Aliases (optional convenience) ##########

alias k="kubectl"
alias tgi="terragrunt init"
alias tgp="terragrunt plan"
alias tga="terragrunt apply"
alias dsp="echo y | docker system prune"

########## End of Prompt ##########
