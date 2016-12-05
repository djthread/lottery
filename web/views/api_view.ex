defmodule Lottery.ApiView do
  def render("campaigns.json", %{campaigns: campaigns}) do
    %{
      campaigns: Enum.map(campaigns, &campaign/1)
    }
  end

  def render("campaign.json", %{campaign: campaign}) do
    %{campaign: campaign(campaign)}
  end

  def render("person.json", %{person: person}) do
    %{person: person}
  end

  def render("error.json", %{message: message}) do
    %{error: message}
  end

  def render("notfound.json", _params) do
    %{error: "Not Found"}
  end

  defp campaign(campaign) do
    extra =
      case campaign.persons do
        %Ecto.Association.NotLoaded{} ->
          %{}
        persons ->
          %{persons: persons}
      end

    %{
      id:   campaign.id,
      name: campaign.name
    }
    |> Map.merge(extra)
  end
end
