# run in all login shells

# source scripts from .profile.d directory
for i in ${HOME}/.profile.d/*.sh ; do
    if [ -r "$i" ]; then
         if [ "${-#*i}" != "$-" ]; then
            source "$i"
        else
            source "$i" >/dev/null 2>&1
        fi
    fi
done
unset i

export PATH="$HOME/.cargo/bin:$PATH"
