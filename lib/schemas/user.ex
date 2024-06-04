defmodule Schemas.User do
  import Ecto.Changeset

  use Ecto.Schema

  schema "users" do
    field(:email, :string)
    field(:password_hash, :string)
    field(:inserted_at, :utc_datetime)
    field(:updated_at, :utc_datetime)
  end

  # def changeset(user, params \\ %{}) do
  #   user
  #   |> cast(params, [:email, :password_hash])
  #   |> validate_required([:email, :password_hash])
  # end
end
