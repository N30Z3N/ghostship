#!/bin/bash

sed -i "s/messagebus/`whoami`/g"  /usr/share/dbus-1/system.conf
mkdir -p /var/run/dbus
dbus-uuidgen > /var/lib/dbus/machine-id
dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address

vncpasswd << EOF
${VNC_PASSWORD}
${VNC_PASSWORD}
n
EOF

cat > ${HOME}/.vnc/xstartup <<EOF
#!/bin/sh
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r ${HOME}/.Xresources ] && xrdb ${HOME}/.Xresources
export XMODIFIERS=@im=fcitx
xsetroot -solid black
(while true; do chromium-browser --no-sandbox --disable-dev-shm-usage --incognito; done)
EOF

chmod 755 ${HOME}/.vnc/xstartup

vncserver -geometry ${SCREEN_WIDTH}x${SCREEN_HEIGHT}

export DISPLAY=:1
export XMODIFIERS=@im=fcitx

fcitx
(while true; do w=`xwininfo -root -tree | grep Chromium-browser | head -n 1 | awk '{print $1}'`; xdotool windowmove ${w} 0 0 windowsize ${w} ${SCREEN_WIDTH} ${SCREEN_HEIGHT}; sleep 10; done) &

cd /opt/noVNC-master/utils/
./launch.sh --vnc localhost:5901 --listen ${PORT}
