export EDITOR='nvim'

if [[ "$(uname)" == "Darwin" ]]; then
  export ANDROID_HOME="/Users/bahnasawy/.android/sdk"
  export ANDROID_SDK_ROOT="/Users/bahnasawy/.android/sdk"
else
  export ANDROID_HOME="/home/bahnasawy/Android/sdk"
  export ANDROID_SDK_ROOT="/home/bahnasawy/Android/sdk"
fi

export CROSS_CONTAINER_ENGINE='podman'
export CROSS_CONTAINER_OPTS='--platform=linux/amd64'

export NIX_PATH='/Users/bahnasawy/.nix-defexpr/channels:nixpkgs=flake:nixpkgs:/nix/var/nix/profiles/per-user/root/channels'
