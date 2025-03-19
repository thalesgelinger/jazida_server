defmodule JazidaServer.Repo do
  use Ecto.Repo,
    otp_app: :jazida_server,
    adapter: Ecto.Adapters.Postgres
end
