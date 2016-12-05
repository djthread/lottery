defmodule Lottery.Repo.Migrations.AddInitialTables do
  use Ecto.Migration

  def change do
    create table(:campaigns) do
      add :name, :string

      timestamps
    end

    create table(:persons) do
      add :common_id, :string
      add :first_name, :string
      add :last_name, :string
      add :team, :string
      add :title, :string
      add :chosen_at, :datetime
      add :campaign_id, :integer
    end
  end
end
