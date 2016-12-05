defmodule Lottery.Campaign do
  use Lottery.Web, :model

  @fields ~w(name)a
  @required @fields

  # @derive {Poison.Encoder, only: @fields}

  schema "campaigns" do
    field :name, :string

    has_many :persons, Lottery.Person
    timestamps
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required)
  end
end
