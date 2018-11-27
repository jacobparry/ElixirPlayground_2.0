defmodule ElvenhearthPhxWeb.Resolvers.CharacterResolver do
  alias Elvenhearth.Characters.CharacterQueries
  alias Elvenhearth.Characters.Character

  def list_characters(_, _, _) do
    {:ok, CharacterQueries.get_all()}
  end

  def get_characters_for_user(user, _, _) do
    {:ok, CharacterQueries.get_all_for_user(user)}
  end

  def create_character(_parent, %{input: params} = args, %{context: context} = _resolution) do
    case context do
      %{current_user: %{role: "DM"}} ->
        character = Character.changeset(%Character{}, params)
        with {:ok, character} <- CharacterQueries.create(character) do
            {:ok, %{character: character}}
        end
      _ ->
        {:error, "unauthorized"}
    end
  end

  def update_character(_parent, %{input: params} = args, _resolution) do
    character = CharacterQueries.get_by_id(params[:id])
    updated_character = Character.changeset(character, params)
    with {:ok, character} <- CharacterQueries.update(updated_character) do
      {:ok, %{character: character}}
    end
  end
end
