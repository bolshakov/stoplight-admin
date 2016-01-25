FROM ruby:2.3

ENV STOPLIGHT_REDIS_URL redis://localhost:6379
ENV STOPLIGHT_PORT 4567

ADD ./example /opt/code
WORKDIR /opt/code

RUN  bundle install 

EXPOSE 4567

CMD /usr/local/bundle/bin/bundle exec ruby example.rb
