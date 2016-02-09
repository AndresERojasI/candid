defmodule Candid.Candidate do
  use Candid.Web, :model

  schema "candidate" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :phone, :string
    field :city, :string
    field :comments, :string
    field :owner, :string

    field :profiles, :map
    field :tech_stack, {:array, :string}
    field :work, :map
    field :experience, :map

    timestamps
  end

  @required_fields ~w(first_name last_name email)
  @optional_fields ~w(phone city comments profiles tech_stack work experience owner)

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
