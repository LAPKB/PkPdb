defmodule Core.Dataset.Metadata do
  @moduledoc """
  Dataset Data Layer
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Core.Pmetrics

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "metadata" do
    field :name, :string
    field :description, :string
    field :citation, :string
    field :share, :string
    field :original_type, :string
    field :warnings, :map
    field :errors, :map
    has_many(:pm_events, Pmetrics.Event)

    # events
    # owner
    # tags

    timestamps()
  end

  @doc false
  def changeset(dataset, attrs) do
    dataset
    |> cast(attrs, [
      :name,
      :description,
      :citation,
      :share,
      :original_type,
      :warnings,
      :errors
    ])
    |> validate_required([:name, :share, :original_type])
  end

  def get(id) do
    Core.Repo.get(__MODULE__, id)
    |> Core.Repo.preload([:pm_events])
  end
end