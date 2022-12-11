if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g SHELL "fish"
    pyenv init - | source
    starship init fish | source
    pfetch
end
