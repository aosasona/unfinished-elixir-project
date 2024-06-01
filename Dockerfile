FROM elixir:1.16.3-alpine AS build

ARG PORT=8000
ENV PORT=${PORT}
ENV MIX_ENV="prod"

RUN apk add git build-essential inotify-tools postgresql-client

WORKDIR /app

COPY mix.exs mix.lock /app/

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get

COPY . /app/

RUN mix compile && \
    mix release


FROM elixir:1.16.3-alpine

RUN apk add git build-essential inotify-tools postgresql-client

COPY --from=build /app/_build/prod/rel/polls /opt/polls

EXPOSE ${PORT}

CMD ["/opt/polls/bin/polls", "start"]
