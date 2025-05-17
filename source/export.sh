# general
export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"

# for Apple Silicon
export DOCKER_DEFAULT_PLATFORM="linux/amd64"

# Android SDK
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export PATH="$ANDROID_SDK_ROOT/emulator:$PATH"
export PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"
export PATH="$HOME/Library/Android/sdk/build-tools/35.0.0:$PATH"

# brew
export PATH="/opt/homebrew/bin/:$PATH"

# bin
export PATH="/opt/homebrew/opt/binutils/bin:$PATH"
export PATH="/opt/homebrew/opt/findutils/bin:$PATH"
export PATH="/opt/homebrew/opt/coreutils/bin:$PATH"

# OpenJDK
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# Rancher
export PATH="$HOME/.rd/bin:$PATH"

# Chrome
export PATH="$HOME/.depot_tools:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/naoya/Documents/tools/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/naoya/Documents/tools/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/naoya/Documents/tools/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/naoya/Documents/tools/google-cloud-sdk/completion.zsh.inc'; fi
