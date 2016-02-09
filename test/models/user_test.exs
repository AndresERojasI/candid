defmodule Candid.UserTest do
  use Candid.ModelCase

  alias Candid.User

  @valid_attrs %{email: "some content", name: "some content", oauth_expires_at: "2010-04-17 14:00:00", oauth_token: "some content", uid: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
