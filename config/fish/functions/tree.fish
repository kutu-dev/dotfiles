function tree -w exa --description "Change the default 'ls' with a configured 'exa' in tree mode"
    command exa --icons --git --tree $argv
end
