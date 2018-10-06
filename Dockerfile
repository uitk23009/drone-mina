FROM ruby:2.5-alpine

WORKDIR /mina

ADD Gemfile /mina

RUN apk --no-cache add curl ca-certificates bash git openssh
RUN bundle install
RUN mkdir -p /root/.ssh

COPY deploy.sh /mina/deploy.sh
COPY ssh_config /mina/ssh_config

ENTRYPOINT ["/bin/bash"]
CMD ["/mina/deploy.sh"]
