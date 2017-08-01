FROM buildpack-deps:jessie-curl
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qqy \
  && apt-get -qqy install \
       wget ca-certificates apt-transport-https \
       ttf-wqy-zenhei ttf-unfonts-core \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install google-chrome-unstable \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# chrome tmpdir
RUN mkdir /data

EXPOSE 80

CMD ["/usr/bin/google-chrome-unstable","--no-sandbox","--disable-gpu","--headless","--remote-debugging-address","0.0.0.0","--remote-debugging-port","80","--user-data-dir","/data"]
