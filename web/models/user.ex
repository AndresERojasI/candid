defmodule Candid.User do
  use Candid.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :uid, :string
    field :oauth_token, :string
    field :oauth_expires_at, Ecto.DateTime

    timestamps
  end

  @required_fields ~w(name email uid oauth_token oauth_expires_at)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
