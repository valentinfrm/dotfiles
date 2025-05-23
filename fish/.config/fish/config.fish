# aliases

alias treelist "tree -a -I '.git'"

# prevents apps from closing when closing terminal
# usage: stay <command>
function stay
  nohup $argv > /dev/null 2>&1 < /dev/null & disown
end

set -gx PATH /opt/homebrew/bin $PATH

# custom greeting
set KERNEL (uname -r)
set fish_greeting (set_color --bold efcf40)">"(set_color ef9540)"<"(set_color ea3838)">" \
  (set_color normal)"fish $FISH_VERSION" \
  (set_color normal)"| $KERNEL"

function fish_user_key_bindings
  fish_vi_key_bindings

function runc; gcc $argv[1] -o /tmp/a.out && /tmp/a.out; end

  # set kj to <Esc>
  bind -M insert -m default kj backward-char force-repaint
end


# start ssh agent
function start-ssh-agent
	if set -q SSH_AUTO_SOCK
		echo "ssh already running"
	else
		eval (ssh-agent -c)
	end

	# add keys
	set ssh_keys ~/.ssh/id_ed25519 ~/.ssh/id_ed25519_github ~/.ssh/keys\ rechnerhalle

	# load keys
	for key in $ssh_keys
		if test -f $key
			ssh-add -l | grep -q (basename $key)
			or ssh-add $key
		end
	end
end

# indicator for vi
function fish_mode_prompt
  switch "$fish_bind_mode"
    case "default"
      echo -n (set_color --bold f43f5e)"N"
    case "insert"
      echo -n (set_color --bold 84cc16)"I"
    case "visual"
      echo -n (set_color --bold 8b5cf6)"V"
    case "*"
      echo -n (set_color --bold)"?"
  end

  echo -n " "
end

# always use block caret (vimode)
set -U fish_cursor_default block

# custom prompt
function fish_prompt
  set_color --bold 4086ef

  set transformed_pwd (prompt_pwd | string replace -r "^~" (set_color --bold 06b6d4)"~"(set_color --bold 3b82f6))

  echo -n $transformed_pwd

  # git branch  
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1
    #space
    echo -n " "

    echo -n (set_color --bold 4338ca)"("

    set_color f0abfc
    echo -n (git branch --show-current)

    echo -n (set_color --bold 4338ca)")"
    set_color normal
  end

  # space
  echo -n " "

  # arrows
  # echo -n (set_color --bold efcf40)"❱"
  # echo -n (set_color --bold ef9540)"❱"
  # echo -n (set_color --bold ea3838)"❱"
  
  echo -n (set_color --bold 14b8a6)"→"
  
  #space
  echo -n " "

  set_color normal
end

# set environment variables
fish_add_path /usr/local/bin
fish_add_path /opt/bin

# set editor
set -x EDITOR "vim"

set QT_QPA_PLATFORM xcb

# TokyoNight Color Palette from https://github.com/folke/tokyonight.nvim/blob/main/extras/fish/tokyonight_storm.fish
set -l foreground c0caf5
# changed from default
set -l selection 6366f1
# changed from default
set -l comment 737373
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$selection

