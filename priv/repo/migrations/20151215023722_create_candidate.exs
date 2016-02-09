defmodule Candid.Repo.Migrations.CreateCandidate do
  use Ecto.Migration

  def change do
    create table(:candidate) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :phone, :string
      add :city, :string
      add :comments, :string, size: 500
      add :owner, :string

      add :tech_stack, {:array, :string}
      add :profiles, :map
      add :work, :map
      add :experience, :map

      timestamps
    end
  end
end
