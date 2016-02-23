defmodule Ideatap.User do
  use Ideatap.Web, :model
  alias Ideatap.{Repo, User, Idea}
  alias Comeonin.Bcrypt

  schema "users" do
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :email_address, :string
    field :bio, :string
    field :image_url, :string
    field :authentication_tokens, {:array, :string}

    has_many :ideas, Idea

    timestamps
  end

  @required_fields ~w(username)
  @optional_fields ~w(first_name last_name bio email_address image_url)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.

  TODO: validate format...
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:username)
    |> unique_constraint(:email_address)
  end

  def find_by_username(username) do
    case Repo.get_by(User, username: username) do
      nil -> nil
      user -> {:ok, user}
    end
  end
end
