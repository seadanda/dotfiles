# vim:fenc=utf-8:nu:ai:si:et:ts=4:sw=4:ft=sh:

if [ $# -gt 0 ]; then
  $*
else
  # set resolution
  DPNAME=$(xrandr | grep -v disconnected | grep DP | grep -v eDP)
  eDPNAME=$(xrandr | grep -v disconnected | grep eDP)
  HDMINAME=$(xrandr | grep -v disconnected | grep HDMI)
  DPNAME=${DPNAME%% *}
  eDPNAME=${eDPNAME%% *}
  HDMINAME=${HDMINAME%% *}

  if [[ -n $DPNAME && -n $HDMINAME ]]; then
    xrandr --output $eDPNAME --mode 1920x1080 --output $HDMINAME --auto --right-of $eDPNAME  --output $DPNAME --auto --right-of $HDMINAME
  elif [[ -n $DPNAME ]]; then
    xrandr --output $eDPNAME --mode 1920x1080 --output $DPNAME --auto --right-of $eDPNAME
  elif [[ -n $HDMINAME ]]; then
    xrandr --output $eDPNAME --mode 1920x1080 --output $HDMINAME --auto --right-of $eDPNAME
  else
    xrandr --output $eDPNAME --mode 1920x1080
  fi

  # set keyboard layout
  setxkbmap -layout ie

  # unlock secrets
  eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
  export SSH_AUTH_SOCK

#  # statusbar
#  while xsetroot -name "$(statusbar)"
#  do
#    sleep 1
#  done &

  # Fix misbehaving java windows
  export AWT_TOOLKIT=MToolkit

  # wm
  exec $HOME/.scripts/startdwm

  # Fix misbehaving java windows - must be below dwm
  wmname compiz
fi




