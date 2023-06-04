FROM ruby:3.2-alpine as build

ARG STOPLIGHT_ADMIN_VERSION
RUN apk --update --no-cache add build-base
COPY docker/Gemfile Gemfile
RUN bundle install

FROM ruby:3.2-alpine

ARG STOPLIGHT_ADMIN_VERSION
ENV STOPLIGHT_ADMIN_VERSION=${STOPLIGHT_ADMIN_VERSION}

EXPOSE 4567

CMD bundle exec ruby stoplight-admin -s Puma

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY docker/Gemfile ./
COPY docker/stoplight-admin ./

