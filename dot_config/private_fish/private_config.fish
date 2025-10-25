set -g fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
    khal calendar
    starship init fish | source
end

zoxide init fish --cmd cd | source
