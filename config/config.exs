import Config

config :polls,
  port: String.to_integer(System.get_env("PORT", "8000"))

config :polls, Users.Repo,
  database: System.get_env("DB_NAME", "polls"),
  username: System.get_env("DB_USER", "polls"),
  password: System.get_env("DB_PASS", "polls_pass"),
  hostname: System.get_env("DB_HOST", "localhost")

config :polls, ecto_repos: [Users.Repo]
