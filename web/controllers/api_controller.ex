defmodule Lottery.ApiController do
  use Lottery.Web, :controller
  alias Lottery.Lottery

  def campaigns(conn, params) do
    conn
    |> render("campaigns.json", campaigns: Lottery.campaigns)
  end

  def campaign(conn, %{"id" => id}) do
    do_campaign conn, id, fn(campaign) ->
      render(conn, "campaign.json", campaign: campaign)
    end
  end

  def choose(conn, %{"id" => id}) do
    do_campaign conn, id, fn(campaign) ->
      case Lottery.choose(campaign.id) do
        {:ok, person} ->
          render(conn, "person.json", person: person)
        {:error, message} ->
          render(conn, "error.json", message: message)
      end
    end
  end

  defp do_campaign(conn, id_string, happy_path) do
    id_string
    |> String.to_integer
    |> Lottery.campaign
    |> case do
      nil ->
        render(conn, "notfound.json")
      campaign ->
        happy_path.(campaign)
    end
  end
end
