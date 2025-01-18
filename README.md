# dotfiles

This is a thin wrapper around GNU stow which manages my dotfiles.

Be warned: here be lazy dragons.

```
                \||/
                |  @___oo
      /\  /\   / (__,,,,|
     ) /^\) ^\/ _)
     )   /^\/   _)
     )   _ /  / _)
 /\  )/\/ ||  | )_)
<  >      |(,,) )__)
 ||      /    \)___)\
 | \____(      )___) )___
  \______(_______;;; __;;;
```

## Requirements

I've done my best to shave this down to a small, dumb non-package. It does
however rely on GNU stow to do the actual work, and is stored in a git repo, so
you will need:

- git
- stow

Additionally, you will need to do the usual git setup with `ssh-keygen` if you
intend to clone via git for easy editing.

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

## Usage

### First-time install

```sh
# from HOME
git clone git@github.com:axelmagn/dotfiles.git
cd dotfiles
stow .
```

### Reinstall after changing dotfiles

```sh
# from ~/dotfiles
stow -R .
```

### Pull in changes to managed files

```sh
# from ~/dotfiles
stow --adopt .
```

## Post-install

- [Doom Emacs](https://github.com/doomemacs/doomemacs#install)
