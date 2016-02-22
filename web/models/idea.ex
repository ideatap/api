defmodule Ideatap.Idea do
  use Ideatap.Web, :model

  schema "ideas" do
    field :title, :string
    field :description, :string
    field :slug, :string

    belongs_to :user, Ideatap.User

    timestamps
  end

  @required_fields ~w(title description slug)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:slug)
  end
end
