defmodule Lottery.Person do
  use Lottery.Web, :model

  @required ~w(common_id first_name last_name team title)a
  @fields   @required ++ ~w(chosen_at)a

  @derive {Poison.Encoder, only: @fields}

  schema "persons" do
    field :common_id, :string
    field :first_name, :string
    field :last_name, :string
    field :team, :string
    field :title, :string
    field :chosen_at, Ecto.DateTime

    belongs_to :campaign, Lottery.Campaign
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required)
  end
end
