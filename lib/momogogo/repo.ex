defmodule Momogogo.Repo do
  use Ecto.Repo,
    otp_app: :momogogo,
    adapter: Ecto.Adapters.Postgres
end
