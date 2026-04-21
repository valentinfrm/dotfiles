# ~/.bashrc

[[ $- != *i* ]] && return

# bash completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /opt/homebrew/etc/profile.d/bash_completion.sh ]; then
  . /opt/homebrew/etc/profile.d/bash_completion.sh
elif [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

case ":$PATH:" in
  *:"$HOME/.local/bin":*) ;;
  *) export PATH="$HOME/.local/bin:$PATH" ;;
esac

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='\W ❄︎ → '

if [[ "$(uname)" == "Darwin" ]]; then
    export SSH_AUTH_SOCK=~/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock
else
    export SSH_AUTH_SOCK=~/.bitwarden-ssh-agent.sock
fi
