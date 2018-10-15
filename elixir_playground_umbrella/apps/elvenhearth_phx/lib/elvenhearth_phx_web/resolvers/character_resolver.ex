defmodule ElvenhearthPhxWeb.Resolvers.CharacterResolver do
  alias Elvenhearth.Characters.CharacterQueries

  def list_characters(_, _, _) do
    {:ok, CharacterQueries.get_all()}
  end

  def get_characters_for_user(user, _, _) do
    {:ok, CharacterQueries.get_all_for_user(user)}
  end

  def create_character(here, what, same) do
    IO.inspect(what)

    {:ok, %Elvenhearth.Characters.Character{name: "test", race: "test", user_id: 1}}
    # {:ok, "string"}
  end
end
