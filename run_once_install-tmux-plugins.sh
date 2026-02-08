#!/bin/bash
# TPMインストール
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    echo "TPM installed. Press prefix + I in tmux to install plugins."
fi
