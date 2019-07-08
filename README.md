# Manual Installation
Dotfiles are managed with [gnu stow](http://www.gnu.org/software/stow/), a symlink farm manager. It's available in most linux distributions.

- `sudo apt install stow`
- `sudo dnf install stow`
- `sudo yum install stow`
- `sudo pacman install stow`
- `brew install stow`

If the dotfiles directory is located in the users home directory, symlinks to the dotfiles are created using stow

- cd ~/dotfiles
- stow vim
- stow i3

