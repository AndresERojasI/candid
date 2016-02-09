defmodule Candid.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :uid, :string
      add :oauth_token, :string
      add :oauth_expires_at, :datetime

      timestamps
    end

  end
end
