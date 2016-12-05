defmodule Lottery.Lottery do
  import Ecto.Query
  alias Lottery.{Repo, Campaign, Person}
  alias Ecto.DateTime

  def campaigns do
    Campaign |> Repo.all
  end

  def campaign(id) do
    with c when not is_nil(c) <- Repo.get(Campaign, id) do
      Repo.preload(c, :persons)
    end
  end

  def choose(campaign_id) do
    chosen =
      Person
      |> where([p], p.campaign_id == ^campaign_id)
      |> where([p], is_nil p.chosen_at)
      |> Repo.all
      |> Enum.take_random(1)

    case chosen do
      [] ->
        {:error, "Nobody found"}
      [person] ->
        person
        |> Person.changeset(%{"chosen_at" => DateTime.utc})
        |> Repo.update!
        |> fn person ->
          {:ok, person}
        end.()
    end
  end
end
