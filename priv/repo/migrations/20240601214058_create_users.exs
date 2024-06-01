defmodule Users.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password_hash, :string
      add :inserted_at, :utc_datetime
      add :updated_at, :utc_datetime

      timestamps()
    end
  end
end
