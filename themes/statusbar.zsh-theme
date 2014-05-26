# A status bar style prompt.
#
# Places a powerline-themed sticky status bar with the content of a command
# prompt in order to avoid cluttering the history with command prompt lines.
#
# Original idea:
# https://github.com/betawaffle/oh-my-zsh/blob/a6c0febb8518eff44edc49304cf4809c96471748/themes/betawaffle.zsh-theme
#
# Powerline theme:
# https://github.com/carlcarl/powerline-zsh
#
# TODO:
# * Place the bar at the bottom when the window size changes

# POWERLINE
POWERLINE_COLOR_BG_GRAY=$BG[240]
POWERLINE_COLOR_BG_LIGHT_GRAY=$BG[240]
POWERLINE_COLOR_BG_WHITE=$BG[255]

POWERLINE_COLOR_FG_GRAY=$FG[240]
POWERLINE_COLOR_FG_LIGHT_GRAY=$FG[240]
POWERLINE_COLOR_FG_WHITE=$FG[255]

GIT_DIRTY_COLOR=$FG[133]
GIT_CLEAN_COLOR=$FG[118]
GIT_PROMPT_INFO=$FG[012]

ZSH_THEME_GIT_PROMPT_PREFIX=" \u2b60 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$GIT_PROMPT_INFO%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$GIT_DIRTY_COLOR%}✘"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$GIT_CLEAN_COLOR%}✔"

ZSH_THEME_GIT_PROMPT_ADDED="%{$FG[082]%}✚%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$FG[166]%}✹%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$FG[160]%}✖%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$FG[220]%}➜%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$FG[082]%}═%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$FG[190]%}✭%{$reset_color%}"

PL_PROMPT='
'%{$bg[green]%}%{$fg[black]%}' '%n' '%{$reset_color%}%{$fg[green]%}%{$bg[blue]%}$'\u2b80'%{$reset_color%}%{$fg[white]%}%{$bg[blue]%}' '%1~$'$(git_prompt_info) '%{$reset_color%}%{$fg[blue]%}$'\u2b80%{$reset_color%} '

local return_char='↵'
local return_code="%(?.%{$fg[green]%}$return_char.%{$fg[red]%}%? $return_char)%{$reset_color%}"

# FIXME remove red color (seems to be overwritten).
local prompt_char="%(#.%{$fg[red]%}.%{$fg[green]%})%#%{$reset_color%}"

function prompt_footer {
  echo -ne "\e[$LINES;0f$PL_PROMPT"
  echo -ne "\e[$[LINES-1];0f"
}

local footer="$(prompt_footer)"

PROMPT="%{$footer%}${prompt_char} "

RPROMPT=%{$POWERLINE_COLOR_FG_WHITE%}$' \u2b82%{$reset_color%}%{$POWERLINE_COLOR_BG_WHITE%} %{$POWERLINE_COLOR_FG_GRAY%}%D{%T %d %b}% %(?.. %{$reset_color%}%{$FG[208]%}%{$POWERLINE_COLOR_BG_WHITE%}\u2b82%{$BG[208]%}%{$POWERLINE_COLOR_FG_GRAY%} %?) %{$reset_color%}'
