FROM ruby:2.5.3

# see update.sh for why all "apt-get install"s have to stay as one long line
RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

# see http://guides.rubyonrails.org/command_line.html#rails-dbconsole
RUN apt-get update && apt-get install -y mysql-client postgresql-client sqlite3 --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV RAILS_VERSION 5.2.2

RUN gem install rails --version "$RAILS_VERSION"

EXPOSE 3000

RUN mkdir /crypto_wallet
WORKDIR /crypto_wallet
COPY Gemfile /crypto_wallet/Gemfile
COPY Gemfile.lock /crypto_wallet/Gemfile.lock
RUN bundle install
COPY . /crypto_wallet