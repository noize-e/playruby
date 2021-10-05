FROM ubuntu:latest
RUN ["/bin/bash", "-c", "mkdir /usr/app"]
WORKDIR /usr/app
COPY bin /usr/app/bin
COPY lib /usr/app/lib
COPY spec /usr/app/spec
COPY Gemfile /usr/app/
ENV TZ=America/Mexico_City
RUN cd /usr/app
RUN ["/bin/bash", "-c", "ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone"]
RUN ["/bin/bash", "-c", "apt-get -o Acquire::Max-FutureTime=86400 update"]
RUN ["/bin/bash", "-c", "apt-get install git -y"]
RUN ["/bin/bash", "-c", "apt install rbenv -y"]
RUN ["/bin/bash", "-c", "echo 'export PATH=\"$HOME/.rbenv/bin:$PATH\"' >> ~/.bashrc"]
RUN ["/bin/bash", "-c", "source ~/.bashrc"]
RUN ["/bin/bash", "-c", "mkdir -p \"$(rbenv root)\"/plugins"]
RUN ["/bin/bash", "-c", "git clone https://github.com/rbenv/ruby-build.git \"$(rbenv root)\"/plugins/ruby-build"]
RUN ["/bin/bash", "-c", "echo 'eval \"$(rbenv init -)\"' >> ~/.bashrc"]
RUN ["/bin/bash", "-c", "source ~/.bashrc"]
RUN ["/bin/bash", "-c", "rbenv install 2.6.5"]
RUN ["/bin/bash", "-c", "gem env home && gem install bundler"]
RUN ["/bin/bash", "-c", "bundle install"]