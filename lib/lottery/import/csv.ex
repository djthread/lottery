defmodule Lottery.Import.Csv do
  import Ecto.Query
  alias Lottery.{Repo, Campaign, Person}
  alias Ecto.Changeset

  @fixture_path Path.join ~w(#{File.cwd!} test fixtures)
  @csv_options  separator: ?,, headers: true, strip_cells: true
  @csv_mapping  %{
    "commonId"  => :common_id,
    "firstName" => :first_name,
    "lastName"  => :last_name,
    "team"      => :team,
    "title"     => :title
  }

  @doc """
  Import a campaign by a CSV data filename

    * `filename` can be absolute. If not, it will be relative to the fixtures path.
    * `campaign` can be the name of the new campaign or a %Campaign{}

  Return will be `{:ok, [%{...}, %{...}]}` on success and `{:error, message}` on fail.
  """
  def from_file(filename, campaign) when is_binary(campaign) do
    from_file(filename, %Campaign{name: campaign})
  end
  def from_file(filename, campaign = %Campaign{}) do
    filename
    |> Path.expand(@fixture_path)
    |> from_stream(campaign)
    |> case do
      {:ok, stream} ->
        stream |> Stream.run
        IO.puts "Done."
      {:error, message} ->
        raise "Error: #{message}"
    end
  end

  def from_stream(stream, campaign = %Campaign{name: name}) do
    changesets =
      stream |> stream_to_changesets

    bad_changesets =
      changesets |> Enum.filter(fn cs -> not cs.valid? end)

    case bad_changesets do
      [] ->
        campaign = campaign |> Repo.insert!

        changesets
        |> Stream.map(fn record ->
          record |> save_record(campaign)
        end)
        |> fn stream ->
          {:ok, stream}
        end.()
      bad_changesets ->
        {:error, inspect bad_changesets}
    end
  end

  defp stream_to_changesets(stream) do
    stream
    |> File.stream!
    |> CSV.decode(@csv_options)
    |> Stream.map(fn record ->
      Person.changeset(%Person{}, record |> map_record)
    end)
  end

  defp save_record(changeset, campaign) do
    changeset =
      changeset
      |> Changeset.cast(%{campaign_id: campaign.id}, [:campaign_id])
      |> Repo.insert!
  end

  defp map_record(record) do
    Enum.reduce(record, %{}, fn {k, v}, acc ->
      case Map.get(@csv_mapping, k) do
        nil ->
          acc
        target_key ->
          Map.put(acc, target_key, v)
      end
    end)
  end
end
