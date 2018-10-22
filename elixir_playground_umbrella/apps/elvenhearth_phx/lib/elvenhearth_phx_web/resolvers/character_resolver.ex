defmodule ElvenhearthPhxWeb.Resolvers.CharacterResolver do
  alias Elvenhearth.Characters.CharacterQueries
  alias Elvenhearth.Characters.Character

  def list_characters(_, _, _) do
    {:ok, CharacterQueries.get_all()}
  end

  def get_characters_for_user(user, _, _) do
    {:ok, CharacterQueries.get_all_for_user(user)}
  end

  def create_character(_parent, %{input: params} = args, _resolution) do
    character = Character.changeset(%Character{}, params)

    CharacterQueries.create(character)
  end
end
