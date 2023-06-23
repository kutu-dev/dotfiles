function ssh -w ssh --description "Change the default 'ssh' to 'kitty +kitten ssh' for kitty terminals"
    command kitty +kitten ssh $argv
end
