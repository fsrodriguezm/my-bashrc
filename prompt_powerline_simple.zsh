# ========= prompt_powerline_simple.zsh =========
# Minimal two-line zsh prompt with Powerline glyphs (or ASCII fallback)

export LANG=${LANG:-en_US.UTF-8}
export LC_ALL=${LC_ALL:-en_US.UTF-8}
: "${USE_POWERLINE:=true}"

# Icons
: "${ICON_COFFEE:=☕}"
: "${ICON_DIR:=🗂️}"
: "${ICON_FILE:=📇}"
: "${ICON_LINK:=🔗}"
: "${ICON_BRANCH:=🌿 BRANCH}"

# --- Zsh setup ---
setopt PROMPT_SUBST
autoload -Uz colors && colors

# --- Separators ---
if $USE_POWERLINE; then
  SEP_L=$''   # left-facing
  SEP_R=$''   # right-facing
else
  SEP_L='<'
  SEP_R='>'
fi

# --- Counters ---
count_dirs()  { find . -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l | tr -d ' '; }
count_files() { find . -mindepth 1 -maxdepth 1 -type f 2>/dev/null | wc -l | tr -d ' '; }
count_links() { find . -mindepth 1 -maxdepth 1 -type l 2>/dev/null | wc -l | tr -d ' '; }

# --- Git helpers ---
_git_bg_color() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    [[ -n "$(git status -s 2>/dev/null)" ]] && echo yellow || echo green
  else
    echo cyan
  fi
}

git_segment() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local C BRANCH
    C=$(_git_bg_color)
    BRANCH=$(git symbolic-ref --quiet --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    # Bridge from cyan → git color
    print -nr -- "%F{cyan}%K{$C}${SEP_R}%F{black} ${ICON_BRANCH} ${BRANCH} %f%k"
  fi
}

# --- Final right chevron color logic ---
final_arrow() {
  local C=$(_git_bg_color)
  print -nr -- "%F{$C}${SEP_R}%f"
}

# --- Prompt ---
PROMPT=$'\n'\
"%F{blue}╭─%F{magenta}${SEP_L}%K{magenta}%F{white} ${ICON_COFFEE} %n %f%k"\
"%F{magenta}%K{blue}${SEP_R}%F{white} %~ %f%k"\
"%F{blue}%K{cyan}${SEP_R}%F{black} ${ICON_DIR} \$(count_dirs) ${ICON_FILE} \$(count_files) ${ICON_LINK} \$(count_links) %f%k"\
"\$(git_segment)\$(final_arrow)"\
$'\n'"%F{blue}╰> %F{cyan}%# %f%k"

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
alias ls='ls -G'
# ========= end file =========
