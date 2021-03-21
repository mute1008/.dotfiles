if [ $(uname) = 'Linux' ]; then
  # font
  if [ ! -d /usr/share/licenses/ttf-font-awesome ]; then
    sudo pacman -S ttf-hack ttf-font-awesome noto-fonts noto-fonts-emoji --noconfirm;
  fi

  # japanese input

  if [[ ! -e `which fcitx` ]]; then
    sudo pacman -S fcitx fcitx-mozc fcitx-configtool --noconfirm;
  fi
fi
