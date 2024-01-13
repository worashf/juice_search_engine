# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.1.2
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

WORKDIR /search-engine


# Install libvips for Active Storage preview support
RUN apt-get update -qq && \
    apt-get install -y build-essential libvips bash bash-completion libffi-dev tzdata postgresql postgresql-contrib libpq-dev nodejs npm yarn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

# SRUN mkdir /search-engine

COPY Gemfile /search-engine/Gemfile
COPY Gemfile.lock /search-engine/Gemfile.lock
RUN bundle install

EXPOSE 3000
