function dotfiles --description 'Redirects to a git command ready to manage my dotfiles'
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv
end
