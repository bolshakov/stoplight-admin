FROM ruby:3.2-alpine as build

ARG STOPLIGHT_ADMIN_VERSION
RUN apk --update --no-cache add build-base
COPY Gemfile Gemfile.lock ./
RUN bundle install

FROM ruby:3.2.1-alpine

COPY --from=build /usr/local/bundle /usr/local/bundle

ENTRYPOINT ["stoplight-admin"]
