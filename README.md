# My Dotfiles

![Screenshot](image/desktop_screenshot_0.png)

These are my dotfiles deployed by [GNU Stow](https://www.gnu.org/software/stow/)
Stow symlinks the contents of this Repository to the path relativ from the Deploy Directory.

- Settings for:
	- bspwm
	- sxhkd
	- vim
	- nvim
	- Xorg

For a single configuration you can use i.e. `stow -vt ~ vim` to deploy the contents of the `/vim` folder to the Home Directory.
To deploy everything just use `stow -vt ~ *`

## Lemonbar
![Lemonbar](image/desktop_lemonbar_0.gif)
On my lemonbar i am somewhat proud.
It works very well with bspwm but feel free to cherry-pick individual parts and modify it.  
My focus was on minimalistic but also verbose icons an information. For example the exact brightness and volume-levels are not relevant in everyday use and are displayed as symbols. But if you click on the icons the exact percentage is displayed for 10 seconds and then hides itself again.


