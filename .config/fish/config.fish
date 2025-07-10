fish_add_path -P \
    # Global NPM packages.
    $NPM_CONFIG_PREFIX/bin \
    # uv - Python package and project manager.
    $HOME/.local/bin

mise activate fish | source
