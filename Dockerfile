FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

COPY run.sh /usr/local/bin/run.sh
COPY .config /.config

RUN \
  apt update && \
  apt install -y \
    curl \
    wget \
    unzip \
    python \
    git \
    tigervnc-standalone-server \
    fonts-takao \
    xdotool \
    dbus-x11 \
    fcitx \
    fcitx-anthy \
    chromium-browser && \
  apt clean && \
  rm -rf /var/lib/apt/lists/ && \
  cd /opt && \
  wget https://github.com/novnc/noVNC/archive/master.zip && \
  unzip master.zip && \
  sed -i "s/<\/head>/    <script>\n        var skeepalive = function() {fetch(window.location.protocol + '\/\/' + window.location.host, {cache: 'no-cache'});};\n        setInterval(skeepalive, 300000);\n    <\/script>\n<\/head>/g" /opt/noVNC-master/vnc.html && \
  sed -i "s/<\/head>/    <script>\n        var skeepalive = function() {fetch(window.location.protocol + '\/\/' + window.location.host, {cache: 'no-cache'});};\n        setInterval(skeepalive, 300000);\n    <\/script>\n<\/head>/g" /opt/noVNC-master/vnc_lite.html && \
  cd /opt/noVNC-master/utils/ && \
  bash -c "./launch.sh --vnc localhost:5901 &" && \
  sleep 5 && \
  mkdir -p /.config/google-chrome/ && \
  touch "/.config/google-chrome/First Run" && \
  chmod +x /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]

