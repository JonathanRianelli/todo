import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :todo, TodoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "roc9dW0Kka4hP3M2wCgWmAOavCw5LWb63MF+IBdm+GFZkzC0D0LXqBAVbeVexLbo",
  server: false

# In test we don't send emails.
config :todo, Todo.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
