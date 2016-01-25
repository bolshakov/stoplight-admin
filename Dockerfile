FROM ruby:2.3

ENV STOPLIGHT_REDIS_URL redis://localhost:6379

ADD ./example /opt/code
WORKDIR /opt/code

RUN  bundle install 

CMD /usr/local/bundle/bin/bundle exec ruby example.rb
