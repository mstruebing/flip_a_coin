defmodule FlipACoin.Flip do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias FlipACoin.Repo
  alias FlipACoin.Flip

  schema "flips" do
    field :result, :string

    timestamps()
  end

  @doc false
  def changeset(flip, attrs) do
    flip
    |> cast(attrs, [:result])
    |> validate_required([:result])
  end

  def get_flips() do
    Repo.aggregate(Flip, :count, :result)
  end

  def get_heads() do
    query = from f in Flip, where: like(f.result, "Head")
    Repo.aggregate(query, :count, :result)
  end

  def get_tails() do
    query = from f in Flip, where: like(f.result, "Tails")
    Repo.aggregate(query, :count, :result)
  end
end
