# Replaced with ~/.ssh/config, but keeping it here for posterity
# alias ssh-lotte="ssh -p 2211 d300342@lotte.edvz.uni-linz.ac.at"
alias ssh-lotte="ssh lotte"
alias gh='history|grep'
alias cd..='cd ..'
alias wetter_alt="curl http://wttr.in/salzburg"
alias wetter="curl v2d.wttr.in/Salzburg"
alias resetkbd="sudo modprobe -r i8042 && sudo modprobe i8042"
alias vi="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"
alias ls="exa"

alias :q="exit"
alias lsa='exa -lah --icons'
alias l='exa -lah --icons'
alias ls='exa --icons'
alias ll='exa -lh --icons'
alias la='exa -lah --icons'

alias ch='chezmoi'

alias open='open_command'

alias systempane="tmux new-session -d -s workspace \; split-window -h -p 50 \; select-pane -t 0 \; split-window -v -p 25 \; select-pane -t 2 \; split-window -v -p 55 \; select-pane -t 0 \; send-keys 'mocp -T yellow_red_theme' C-m \; select-pane -t 1 \; send-keys 'cava' C-m \; send-keys o f f f \; select-pane -t 2 \; send-keys 'yazi' C-m \; select-pane -t 3 \; send-keys 'btop' C-m \; select-pane -t 0 \; attach -t workspace"

# For presentations, we want to have a light background for projectors
alias zathura-presentation='zathura --config-dir ~/.config/zathura-presentation/zathurarc.light'
