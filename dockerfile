from elixir:1.7.1-alpine


######################
# Start elixir stuff #
######################

COPY . /app 
WORKDIR /app

RUN set -xe \
	&& mix local.hex --force \
    && mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new-1.3.3.ez \
    && mix deps.get --only-prod \
    && mix local.rebar --force

