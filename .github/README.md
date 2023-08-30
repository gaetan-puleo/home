# Dotfiles

```
sudo apt install git
sudo apt install git kitty tmux
echo 'alias dot="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"' >> $HOME/.bashrc
source ~/.bashrc
echo ".dotfiles.git" >> .gitignore
git clone --bare https://www.github.com/username/repo.git $HOME/.dotfiles.git
dot checkout
dot config --local status.showUntrackedFiles no
```

Warning : You might need to Backup current files or remove them to checkout the repo


** Tested on Ubuntu 22.04 LTS only **
