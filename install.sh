set -u
DOT_CONFIG_DIRECTORY="${HOME}/work/settings"
DOT_DIRECTORY="dotfiles"

echo "link .config directory dotfiles"
cd ${DOT_CONFIG_DIRECTORY}/${DOT_DIRECTORY}/
for f in .??*
do
    #無視したいファイルやディレクトリ
    [ "$f" = ".git" ] && continue
    [ "$f" = ".config" ] && continue
    ln -snfv ${DOT_CONFIG_DIRECTORY}/${DOT_DIRECTORY}/${f} ${HOME}/${f}
done

echo "linked dotfiles complete!"
