let [plugins, ftplugin] = dein#load_cache_raw(['/home/mute/.config/nvim/init.vim'], 1)
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/home/mute/.vim/dein'
let g:dein#_runtime_path = '/home/mute/.vim/dein/.dein'
let &runtimepath = '/home/mute/.vim/dein/.dein,/home/mute/.config/nvim,/etc/xdg/xdg-cinnamon/nvim,/etc/xdg/nvim,/home/mute/.local/share/nvim/site,/usr/share/cinnamon/nvim/site,/usr/share/gnome/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/usr/share/mdm/nvim/site,/home/mute/.linuxbrew/Cellar/neovim/0.1.4/share/nvim/runtime,/usr/share/mdm/nvim/site/after,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/usr/share/gnome/nvim/site/after,/usr/share/cinnamon/nvim/site/after,/home/mute/.local/share/nvim/site/after,/etc/xdg/nvim/after,/etc/xdg/xdg-cinnamon/nvim/after,/home/mute/.config/nvim/after,/home/mute/.vim/dein/repos/github.com/Shougo/dein.vim,/home/mute/.vim/dein/.dein/after'
filetype off
