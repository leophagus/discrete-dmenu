# discrete-dmenu - free the menu-items and place them wherever 
[dmenu](https://tools.suckless.org/dmenu/) is an efficient dynamic menu for X.
discrete-dmenu extends it by allowing the menu items to be placed any where,
each in a seperate fully specifiable location on the screen. Arrange them in a
circle, sine curve, box, anything.

![Screenshot](../master/docs/discrete_dmenu_circ.png)
![Screenshot](../master/docs/discrete_dmenu_cosine.png)
![Screenshot](../master/docs/discrete_dmenu_sine.png)
![Screenshot](../master/docs/discrete_dmenu_sine.gif)

## Why discrete-dmenu?
Just eye-candy :)

## How to use?
Prepend the menu-items with a newline terminated list of on-screen locations.
Each entry is a tuple (x, y, width, height). This is followed by the menu-items
to be displayed.
```bash
echo -e "0,500,250,80\n960,100,250,80\n1635,500,250,80\nfirefox \n xterm \n xcalc" | discrete_dmenu
```

Alternately, create a file with the locations and cat it before the menu items.
Here `~/.cache/dmenu_run` is a cache of all applications and `locs_box` has the
menu-item locations.
```bash
cat locs_box ~/.cache/dmenu_run  | discrete_dmenu -fnc monospace:size=20 -nb "#222233" -nf white
```

To use with i3, customize `discrete_dmenu_run`, and modify i3 config file (~/.config/i3/config).
```
bindsym $mod+d exec --no-startup-id ~/bin/discrete_dmenu_run
```

## Requirements
To build, you will need X11 development libraries. On Ubuntu Bionic, I had to
install the following: libxcb1-dev, libx11-dev, libxext-dev, libxinerama-dev
and libxft-dev.

