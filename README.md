# My Dotfiles

![Screenshot](image/desktop_screenshot_0.png)

These are my dotfiles deployed by [GNU Stow](https://www.gnu.org/software/stow/)
Stow symlinks the contents of this Repository to the path relativ from the Deploy Directory.

- Settings for:
	- bspwm
	- sxhkd
	- glow
	- vim
	- rofi
	- nvim
	- Xorg
	- zsh

For a single configuration you can use i.e. `stow --no-folding --verbose --target ~ lemonbar` to deploy the contents of the `/lemonbar` folder to the Home Directory.

## nvim

I also use this repo to synch my Spellchecking-Word-List. Spell generates a binary file with the `.spl` extension which can have compatibility issues between versions and forks of vim.
To generate the `.spl`-file execute in vim:
```
mkspell! ~/.config/nvim/spell/de.utf-8.add
mkspell! ~/.config/nvim/spell/en.utf-8.add
```

## ZSH

I use [ZSH](https://archlinux.org/packages/extra/x86_64/zsh/) and focus on using it without the great work of big Plugin-Manager like [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh).
### Dependencies
- [ZSH](https://archlinux.org/packages/extra/x86_64/zsh/)
- [zsh-syntax-highlighting](https://archlinux.org/packages/community/any/zsh-syntax-highlighting/)
- [zsh-autosuggestions](https://archlinux.org/packages/community/any/zsh-autosuggestions/)
- [zsh-vi-mode](https://aur.archlinux.org/packages/zsh-vi-mode)
- [autojump](https://aur.archlinux.org/packages/autojump/) (AUR)

At this time i use the [pure promt](https://github.com/sindresorhus/pure) follow the instructions there for installation. Note i don't have a `~/.zsh` directory instead i have the repo in my `~/code` directory. Tweak this in your deployment in the `~/.zshrc`.
My Aliases and Funktions are in `~/.config/zsh/aliasrc'.

## Lemonbar
![Lemonbar](image/desktop_lemonbar_0.gif)
On my lemonbar i am somewhat proud.
It works very well with bspwm but feel free to cherry-pick individual parts and modify it.  
My focus was on minimalistic but also verbose icons an information. For example the exact brightness and volume-levels are not relevant in everyday use and are displayed as symbols. But if you click on the icons the exact percentage is displayed for 10 seconds and then hides itself again.

## Rofi
[Rofi](https://github.com/davatorium/rofi) is my Application launcher.
I almost completely used [this](https://github.com/amayer5125/nord-rofi) configuration, made it a litle bit darker and added a yellow border to match my bspwm windows.


