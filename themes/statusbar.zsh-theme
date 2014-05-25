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

# Colors
local col_sha='yellow'
local col_branch='blue'
local col_remote='magenta'

local return_char='↵' # ↳
local return_code="%(?.%{$fg[green]%}$return_char.%{$fg[red]%}%? $return_char)%{$reset_color%}"

local prompt_char="%(#.%{$fg[red]%}.%{$fg[green]%})%#%{$reset_color%}"
local prompt_user="%(#.%{$fg[red]%}.%{$fg[green]%})%n%{$reset_color%}"
local prompt_host="%{$fg[magenta]%}%m%{$reset_color%}"
local prompt_path="%{$fg[blue]%}%~%{$reset_color%}"

function git_prompt {
  sha=$(git rev-parse --short HEAD 2>/dev/null) || return
  echo -n "git: "
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [ -z "$ref" ]; then
  echo -n "%{$fg[$col_sha]%}$sha%{$reset_color%}"
  return
  fi
  branch=${ref#refs/heads/}
  echo -n "%{$fg[$col_branch]%}$branch%{$reset_color%} (%{$fg[$col_sha]%}$sha%{$reset_color%})"
  remote=$(git config --get "branch.$branch.remote") || return
  echo -n " -> %{$fg[$col_remote]%}$remote%{$reset_color%}"
}

function prompt_footer {
  FOOTER="\e[$LINES;0f# ${prompt_user} @ ${prompt_host} : ${prompt_path}"
  FEET=1
  for FOOT ($@); do
    if [ -z "$FOOT" ]; then
      continue;
    fi
    FOOTER="\e[$[$LINES-$FEET];0f# $FOOT$FOOTER"
    FEET=$[$FEET+1]
  done
  echo -ne "\e[s" # Save Cursor
  echo -ne "\e[0;$[$LINES-$FEET]r"
  echo -ne "$FOOTER"
  echo -ne "\e[u" # Restore Cursor
}

preexec() {
  feet=("$(git_prompt)")
  FOOTER="\e[$LINES;0f# ${prompt_user} @ ${prompt_host} : ${prompt_path}"
  FEET=1
  for FOOT ($feet); do
    if [ -z "$FOOT" ]; then
      continue;
    fi
    FOOTER="\e[$[$LINES-$FEET];0f# $FOOT$FOOTER"
    FEET=$[$FEET+1]
  done

  echo -ne "\e[s" # Save Cursor
  echo -ne "\e[0;$[$LINES-$FEET]r"
  echo -ne "${(%)FOOTER}"
  echo -ne "\e[u" # Restore Cursor
}

local footer_git='$(git_prompt)'
local footer="$(prompt_footer $footer_git)"

PROMPT="%{$footer%}${prompt_char} " # %{$footer%}

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
