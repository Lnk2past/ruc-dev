FROM debian:latest

LABEL "repository"="https://github.com/Lnk2past/turtleshell"
LABEL "homepage"="https://github.com/Lnk2past/turtleshell"
LABEL "maintainer"="Lnk2past <Lnk2past@gmail.com>"

RUN echo "deb http://http.us.debian.org/debian/ testing non-free contrib main" >> /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y curl git make gcc-10 g++-10 python3.8 python3.8-dev python3-pip \
    libjpeg-dev zlib1g-dev libssl-dev libncurses5-dev libgdbm-dev libnss3-dev libsqlite3-dev libreadline-dev libffi-dev libbz2-dev

RUN python3.8 -m pip install bokeh contest PyGithub

RUN curl -L https://github.com/cli/cli/releases/download/v0.11.1/gh_0.11.1_linux_amd64.deb -o gh_latest.deb && \
    apt-get install ./gh_latest.deb

RUN ln -s /usr/bin/python3.8 /usr/bin/python
RUN ln -s /usr/bin/python3.8-config /usr/bin/python-config
RUN ln -s /usr/lib/python3.8/config-3.8-x86_64-linux-gnu/libpython3.8.so /usr/lib/python3.8/config-3.8-x86_64-linux-gnu/libpython.so

COPY docker-entrypoint.sh /bin/docker-entrypoint.sh
RUN chmod +x /bin/docker-entrypoint.sh
ENTRYPOINT ["/bin/docker-entrypoint.sh"]
