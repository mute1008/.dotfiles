#!/bin/bash

# install kubectl
arch="linux"
machine="amd64"
if [[ `uname` == 'Darwin' ]]; then
  arch="darwin"
  machine="arm64"
fi
kubectl_version=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
mkdir -p $HOME/.local/bin
[ ! -f $HOME/.local/bin/kubectl ] && \
  curl -o $HOME/.local/bin/kubectl -LO "https://storage.googleapis.com/kubernetes-release/release/$kubectl_version/bin/$arch/$machine/kubectl"
chmod +x $HOME/.local/bin/kubectl

# install krew
[ ! -d $HOME/.krew ] && \
  (
    set -x; cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    KREW="krew-${OS}_${ARCH}" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
    tar zxvf "${KREW}.tar.gz" &&
    ./"${KREW}" install krew
  )

# プラグインのインストール
kubectl krew list | grep ctx
[ $? -ne 0 ] && \
  kubectl krew install ctx

kubectl krew list | grep ns
[ $? -ne 0 ] && \
  kubectl krew install ns

# kustomizeのインストール
which kustomize
[ $? -ne 0 ] && \
  curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash && \
  mv kustomize $HOME/.local/bin/

exit 0
