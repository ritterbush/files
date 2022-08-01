#!/bin/sh

#Running a terminal command such as htop/nvim with a terminal (st, alacritty) does not, for whatever reason, source the rc file when using zsh, even though of course it does if you open up the terminal and then run the command as normal. Before understanding this was the issue, I entered the specifics of the rc file into the command (namely pywal), but now I just source the rc file and it's all good.Included below are further commands that work and didn't work, if I need to troubleshoot in the future.

case $BUTTON in 
    1) alacritty -e sudo -S pacman -Sy;;
    2) alacritty -e nvim $HOME/Programs/dwm/config.def.h;;
    3) alacritty -e nvim $HOME/.local/bin/dwm-scripts/pacman-updates.sh;;
esac

#3) alacritty -e zsh -c 'nvim $HOME/.local/bin/dwm-scripts/cpu.sh && zsh';;
#3) alacritty -e zsh -c '(zsh & exit) && sleep 3 && nvim $HOME/.local/bin/dwm-scripts/cpu.sh';;
#3) alacritty -e zsh -c '(zsh & wal -R & sleep 3) && (exit & zsh) && nvim $HOME/.local/bin/dwm-scripts/cpu.sh';;
#3) alacritty -e zsh -c '(zsh & wal -R & sleep 3) & nvim $HOME/.local/bin/dwm-scripts/cpu.sh';;
#3) alacritty -e zsh -c '(zsh & wal -R & sleep 3) && nvim $HOME/.local/bin/dwm-scripts/cpu.sh';;
#3) alacritty -e zsh -c '(zsh & wal -R) && nvim $HOME/.local/bin/dwm-scripts/cpu.sh';;
#3) alacritty -e $SHELL -c '($SHELL & (cat $HOME/.cache/wal/sequences &) 2>/dev/null) && nvim $HOME/.local/bin/dwm-scripts/cpu.sh';;
#2) alacritty $($HOME/.local/bin/alacritty-opacity.sh 90);;
#1) alacritty -e $SHELL -c 'cd $HOME/.local/bin && $SHELL';;
