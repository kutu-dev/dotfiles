# Amazing Kutu's Dotfiles
My configuration files and workflow for MacOS

## Install
> **Note:** It's **not** recommended to just install my dotfiles without understanding it (just clone this repository and start patiently adding and editing my config to ajust it to your workflow).

This installation scrips has been made with macOS in mind so it will use `brew` and some MacOS only apps, please have this in mind.

If you anyway want to install my full configuration do this:
```bash
> alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
> git clone --bare  https://github.com/kutu-dev/dotfiles.git $HOME/.dotfiles
> dotfiles checkout
# After this maybe you need to fix some conflicts, fix them and rerun the command
> ~/.config-scripts/install.sh 
```

## Author

Created with :heart: by [Kutu](https://kutu-dev.github.io/)
> - GitHub - [kutu-dev](https://github.com/kutu-dev)
> - Twitter - [@kutu_dev](https://twitter.com/kutu_dev)
