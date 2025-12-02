#!/bin/bash

VNC_PORT=5950

export DISPLAY=:20

if test -r /etc/profile; then
        . /etc/profile
fi

if test -r ~/.profile; then
        . ~/.profile
fi

/usr/lib/xorg/Xorg ${DISPLAY} \
  -config xrdp/xorg-xdummy.conf \
  -noreset \
  -nolisten tcp &

until xdpyinfo -display ${DISPLAY} >/dev/null 2>&1; do
    sleep 0.5
done

x11vnc -display ${DISPLAY} -rfbport ${VNC_PORT} -forever -repeat &

eval "$(dbus-launch --sh-syntax --exit-with-session)"

test -x /etc/X11/Xsession && exec /etc/X11/Xsession
exec /bin/sh /etc/X11/Xsessio
