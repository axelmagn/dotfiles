BROWSERS=("google-chrome-stable" "google-chrome" "firefox")

for b in $BROWSERS; do
    which $b > /dev/null
    if [ $? -eq 0 ]; then
        export BROWSER=$(which $b)
        break
    fi
done

