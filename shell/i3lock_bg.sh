if hash import 2>/dev/null; then
    if hash convert 2>/dev/null; then
        alias i3lock="import -window root $HOME/.i3lockbg.png; convert --scale 10% --scale 1000% $HOME/.i3lockbg $HOME/.i3lockbg"
    fi
fi