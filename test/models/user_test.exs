defmodule Ideatap.UserTest do
  use Ideatap.ModelCase

  alias Ideatap.User

  @valid_attrs %{auth_tokens: [], emailAddress: "some content", firstName: "some content", hashed_password: "some content", lastName: "some content", username: "some content"}
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
