function safe_rm() {
  mkdir -p ~/.backup-dotfiles
  [ -d $1 ] && cp -r $1 ~/.backup-dotfiles/$(basename $1)-$(date +"%Y-%m-%d-%T")
  rm -rf $1
}

function safe_ln() {
  mkdir -p $(dirname $2)
  safe_rm $2
  ln -s $1 $2
}
