source source/lib.sh

# For Linux
rm -f ~/.ideavimrc
safe_ln $(pwd)/app/intellij/files/ideavimrc ~/.ideavimrc

# For Windows (WSL)
if [ -d "/mnt/c/Users" ]; then
  username=$(whoami.exe | cut -d "\\" -f2 | tr -d "\\r")
  cp $(pwd)/app/intellij/files/ideavimrc /mnt/c/Users/${username}/.ideavimrc
fi
