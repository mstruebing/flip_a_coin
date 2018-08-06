defmodule FlipACoin.Repo.Migrations.CreateFlips do
  use Ecto.Migration

  def change do
    create table(:flips) do
      add :result, :string

      timestamps()
    end

  end
end
