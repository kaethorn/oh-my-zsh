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

RPROMPT=%{$POWERLINE_COLOR_FG_WHITE%}$' \u2b82%{$reset_color%}%{$POWERLINE_COLOR_BG_WHITE%} %{$POWERLINE_COLOR_FG_GRAY%}%D{%T %d %b}% %(?.. %{$reset_color%}%{$FG[208]%}%{$POWERLINE_COLOR_BG_WHITE%}\u2b82%{$BG[208]%}%{$POWERLINE_COLOR_FG_GRAY%} %?) %{$reset_color%}'
#

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

# PROMPT2 <S>
# The secondary prompt, printed when the shell needs more information to complete a command. It is expanded in the same way as PS1. The default is ‘%_> ’, which displays any shell constructs or quotation marks which are currently being processed.
#PROMPT2="%{$footer%}%{$fg[yellow]%}>%{$reset_color%} "


# SPROMPT <S>
# The prompt used for spelling correction. The sequence ‘%R’ expands to the string which presumably needs spelling correction, and ‘%r’ expands to the proposed correction. All other prompt escapes are also allowed.
#
#local sprompt_no="%{$fg[red]%}n%{$reset_color%}o"
#local sprompt_yes="%{$fg[green]%}y%{$reset_color%}es"
#local sprompt_edit="%{$fg[yellow]%}e%{$reset_color%}dit"
#local sprompt_abort="%{$fg[yellow]%}a%{$reset_color%}bort"
#local sprompt_options="[$sprompt_no $sprompt_yes $sprompt_edit $sprompt_abort]"
#local sprompt_char="%{$fg[yellow]%}?%{$reset_color%}"
#local sprompt_from="%{$fg[red]%}%R%{$reset_color%}"
#local sprompt_to="%{$fg[green]%}%r%{$reset_color%}"
#SPROMPT="$sprompt_char $sprompt_from -> $sprompt_to $sprompt_options "


# RPROMPT <S>
# This prompt is displayed on the right-hand side of the screen when the primary prompt is being displayed on the left. This does not work if the SINGLE_LINE_ZLE option is set. It is expanded in the same way as PS1.
RPROMPT="${return_code}"


# RPROMPT2 <S>
# This prompt is displayed on the right-hand side of the screen when the secondary prompt is being displayed on the left. This does not work if the SINGLE_LINE_ZLE option is set. It is expanded in the same way as PS2.
#RPROMPT2="%_"
