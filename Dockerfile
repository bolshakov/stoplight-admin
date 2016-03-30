FROM quay.io/orgsync/ruby:2.2.3
WORKDIR /code
COPY Gemfile /code/Gemfile
COPY stoplight-admin.gemspec /code/stoplight-admin.gemspec
RUN bundle install
COPY . /code/
CMD bundle exec ruby example-app.rb
