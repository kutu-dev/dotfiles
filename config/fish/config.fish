if status is-interactive
    # Commands to run in interactive sessions can go here
    neofetch
    starship init fish | source
    pyenv init - | source
end
