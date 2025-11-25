#!/bin/bash

export DISPLAY=:11 XAUTHORITY=~/.Xauthority
/usr/lib/xorg/Xorg :11 \
  -config xrdp/xorg-xdummy.conf \
  -noreset \
  -nolisten tcp &

until xdpyinfo -display :11 >/dev/null 2>&1; do
    sleep 0.5
done

x11vnc -display :11 -rfbport 5911 -forever -loop -repeat &

if test -r /etc/profile; then
        . /etc/profile
fi

if test -r ~/.profile; then
        . ~/.profile
fi

export DISPLAY=:11 XAUTHORITY=~/.Xauthority
eval "$(dbus-launch --sh-syntax --exit-with-session)"
test -x /etc/X11/Xsession && exec /etc/X11/Xsession
exec /bin/sh /etc/X11/Xsessio